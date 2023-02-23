#define  _LED_BUZZER_C
#include "config.h"
#include "LedBuzzer.h"

uint8 code LedChar[] = {  //数码管显示字符转换表
    0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8,
    0x80, 0x90, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E
};

bit staBuzzer = 0; //蜂鸣器状态控制位，1-鸣叫、0-关闭
struct sLedBuff ledBuff; //LED显示缓冲区，默认初值全0，正好达到上电全亮的效果

/* LED初始化函数，初始化IO、配置定时器 */
void InitLed()
{
    //初始化IO口
    P0 = 0xFF;
    ENLED = 0;
    //配置T2作为动态扫描定时
    T2CON = 0x00;  //配置T2工作在16位自动重载定时器模式
    RCAP2H = ((65536-SYS_MCLK/1500)>>8);  //配置重载值，每秒产生1500次中断，
    RCAP2L = (65536-SYS_MCLK/1500);       //以使刷新率达到100Hz无闪烁的效果
    TH2 = RCAP2H;  //设置初值等于重载值
    TL2 = RCAP2L;
    ET2 = 1;       //使能T2中断
    PT2 = 1;       //设置T2中断为高优先级
    TR2 = 1;       //启动T2
}
/* 流水灯实现函数，间隔调用实现流动效果 */
void FlowingLight()
{
    static uint8 i = 0;
    const uint8 code tab[] = {  //流动表
        0x7F, 0x3F, 0x1F, 0x0F, 0x87, 0xC3, 0xE1, 0xF0, 0xF8, 0xFC, 0xFE, 0xFF
    };
    
    ledBuff.alone = tab[i];   //表中对应值送到独立LED的显示缓冲区
    if (i < (sizeof(tab)-1))  //索引递增循环，遍历整个流动表
        i++;
    else
        i = 0;
}
/* 数码管上显示一位数字，index-数码管位索引(从右到左对应0～5)，
**     num-待显示的数字，point-代表是否显示此位上的小数点 */
void ShowLedNumber(uint8 index, uint8 num, uint8 point)
{
    ledBuff.number[index] = LedChar[num];  //输入数字转换为数码管字符0～F
    if (point != 0)
    {
        ledBuff.number[index] &= 0x7F;  //point不为0时点亮当前位的小数点
    }
}
/* 点阵上显示一帧图片，ptr-待显示图片指针 */
void ShowLedArray(uint8 *ptr)
{
    uint8 i;
    
    for (i=0; i<sizeof(ledBuff.array); i++)
    {
        ledBuff.array[i] = *ptr++;
    }
}
/* T2中断服务函数，LED动态扫描、蜂鸣器控制 */
void InterruptTimer2() interrupt 5
{
    static uint8 i = 0;  //LED位选索引
    
    TF2 = 0;  //清零T2中断标志
    //全部LED动态扫描显示
    if (ENLED == 0)  //LED使能时才进行动态扫描
    {
        P0 = 0xFF;                       //关闭所有段选位，显示消隐
        P1 = (P1 & 0xF0) | i;            //位选索引值赋值到P1口低4位
        P0 = *((uint8 data*)&ledBuff+i); //缓冲区中索引位置的数据送到P0口
        if (i < (sizeof(ledBuff)-1))     //索引递增循环，遍历整个缓冲区
            i++;
        else
            i = 0;
    }
    //由蜂鸣器状态位控制蜂鸣器
    if (staBuzzer == 1)
        BUZZER = ~BUZZER;  //蜂鸣器鸣叫
    else
        BUZZER = 1;        //蜂鸣器静音
}
