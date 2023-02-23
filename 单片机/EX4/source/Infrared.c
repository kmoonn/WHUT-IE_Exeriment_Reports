#define  _INFRARED_C
#include "config.h"
#include "Infrared.h"
#include "Time.h"

const uint8 code IrCodeMap[][2] = {  //红外键码到标准PC键码的映射表
    {0x45,0x00}, {0x46,0x00}, {0x47,0x1B}, //开关->无  Mode->无   静音->ESC
    {0x44,0x00}, {0x40,0x25}, {0x43,0x27}, //播放->无  后退->向左 前进->向右
    {0x07,0x00}, {0x15,0x28}, {0x09,0x26}, // EQ->无   减号->向下 加号->向上
    {0x16, '0'}, {0x19,0x1B}, {0x0D,0x0D}, //'0'->'0'  箭头->ESC  U/SD->回车
    {0x0C, '1'}, {0x18, '2'}, {0x5E, '3'}, //'1'->'1'  '2'->'2'   '3'->'3'
    {0x08, '4'}, {0x1C, '5'}, {0x5A, '6'}, //'4'->'4'  '5'->'5'   '6'->'6'
    {0x42, '7'}, {0x52, '8'}, {0x4A, '9'}, //'7'->'7'  '6'->'8'   '9'->'9'
};

bit irflag = 0;   //红外接收标志，收到一帧正确数据后置1
uint8 ircode[4];  //红外代码接收缓冲区

/* 红外接收驱动，检测接收到的键码，调度相应动作函数 */
void InfraredDriver()
{
    uint8 i;
    
    if (irflag)
    {
        irflag = 0;
        for (i=0; i<sizeof(IrCodeMap)/sizeof(IrCodeMap[0]); i++) //遍历映射表
        {
            if (ircode[2] == IrCodeMap[i][0])  //在表中找到当前接收的键码后，
            {                                  //用对应的映射码执行函数调度，
                KeyAction(IrCodeMap[i][1]);    //直接调用按键动作函数即可。
                break;
            }
        }
    }
}
/* 初始化红外接收功能 */
void InitInfrared()
{
    IR_INPUT = 1;  //确保红外接收引脚被释放
    TMOD &= 0x0F;  //清零T1的控制位
    TMOD |= 0x10;  //配置T1为模式1
    TR1 = 0;       //停止T1计数
    ET1 = 0;       //禁止T1中断
    IT1 = 1;       //设置INT1为负边沿触发
    EX1 = 1;       //使能INT1中断
}
/* 获取当前高电平的持续时间 */
uint16 GetHighTime()
{
    TH1 = 0;  //清零T1计数初值
    TL1 = 0;
    TR1 = 1;  //启动T1计数
    while (IR_INPUT)  //红外输入引脚为1时循环检测等待，变为0时则结束本循环
    {
        if (TH1 >= 0x40)
        {            //当T1计数值大于0x4000，即高电平持续时间超过约18ms时，
            break;   //强制退出循环，是为了避免信号异常时，程序假死在这里。
        }
    }
    TR1 = 0;  //停止T1计数

    return (TH1*256 + TL1);  //T1计数值合成为16bit整型数，并返回该数
}
/* 获取当前低电平的持续时间 */
uint16 GetLowTime()
{
    TH1 = 0;  //清零T1计数初值
    TL1 = 0;
    TR1 = 1;  //启动T1计数
    while (!IR_INPUT)  //红外输入引脚为0时循环检测等待，变为1时则结束本循环
    {
        if (TH1 >= 0x40)
        {            //当T1计数值大于0x4000，即低电平持续时间超过约18ms时，
            break;   //强制退出循环，是为了避免信号异常时，程序假死在这里。
        }
    }
    TR1 = 0;  //停止T1计数

    return (TH1*256 + TL1);  //T1计数值合成为16bit整型数，并返回该数
}
/* INT1中断服务函数，执行红外接收及解码 */
void EXINT1_ISR() interrupt 2
{
    uint8 i, j;
    uint8 byt;
    uint16 time;
    
    //接收并判定引导码的9ms低电平
    time = GetLowTime();
    if ((time<7833) || (time>8755))  //时间判定范围为8.5～9.5ms，
    {                                //超过此范围则说明为误码，直接退出
        IE1 = 0;   //退出前清零INT1中断标志
        return;
    }
    //接收并判定引导码的4.5ms高电平
    time = GetHighTime();
    if ((time<3686) || (time>4608))  //时间判定范围为4.0～5.0ms，
    {                                //超过此范围则说明为误码，直接退出
        IE1 = 0;
        return;
    }
    //接收并判定后续的4字节数据
    for (i=0; i<4; i++)  //循环接收4个字节
    {
        for (j=0; j<8; j++)  //循环接收判定每字节的8个bit
        {
            //接收判定每bit的560us低电平
            time = GetLowTime();
            if ((time<313) || (time>718)) //时间判定范围为340～780us，
            {                             //超过此范围则说明为误码，直接退出
                IE1 = 0;
                return;
            }
            //接收每bit高电平时间，判定该bit的值
            time = GetHighTime();
            if ((time>313) && (time<718)) //时间判定范围为340～780us，
            {                             //在此范围内说明该bit值为0
                byt >>= 1;   //因低位在先，所以数据右移，高位为0
            }
            else if ((time>1345) && (time<1751)) //时间判定范围为1460～1900us，
            {                                    //在此范围内说明该bit值为1
                byt >>= 1;   //因低位在先，所以数据右移，
                byt |= 0x80; //高位置1
            }
            else  //不在上述范围内则说明为误码，直接退出
            {
                IE1 = 0;
                return;
            }
        }
        ircode[i] = byt;  //接收完一个字节后保存到缓冲区
    }
    irflag = 1;  //接收完毕后设置标志
    IE1 = 0;     //退出前清零INT1中断标志
}
