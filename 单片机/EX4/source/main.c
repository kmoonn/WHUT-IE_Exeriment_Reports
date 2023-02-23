#define  _MAIN_C
#include "config.h"
#include "Lcd1602.h"
#include "LedBuzzer.h"
#include "keyboard.h"
#include "DS1302.h"
#include "DS18B20.h"
#include "Infrared.h"
#include "Time.h"
#include "main.h"

bit flag2s = 0;    //2s定时标志位
bit flag200ms = 0; //200ms定时标志
uint8 T0RH = 0;    //T0重载值的高字节
uint8 T0RL = 0;    //T0重载值的低字节
enum eStaSystem staSystem = E_NORMAL;  //系统运行状态

void main()
{
    EA = 1;           //开总中断
    ConfigTimer0(1);  //配置T0定时1ms
    InitLed();        //初始化LED模块
    InitDS1302();     //初始化实时时钟模块
    InitInfrared();   //初始化红外接收模块
    InitLcd1602();    //初始化液晶模块
    Start18B20();     //启动首次温度转换
    
    while (!flag2s);  //上电后延时2秒
    flag2s = 0;
    RefreshTime();    //刷新当前时间
    RefreshDate(1);   //立即刷新日期显示
    RefreshTemp(1);   //立即刷新温度显示
    RefreshAlarm();   //闹钟设定值显示
    
    while (1)  //进入主循环
    {
        KeyDriver();      //执行按键驱动
        InfraredDriver(); //执行红外接收驱动
        if (flag200ms)    //每隔200ms执行以下分支
        {
            flag200ms = 0;
            FlowingLight();  //流水灯效果实现
            RefreshTime();   //刷新当前时间
            AlarmMonitor();  //监控闹钟
            if (staSystem == E_NORMAL)  //正常运行时刷新日期显示
            {
                RefreshDate(0);
            }
        }
        if (flag2s)  //每隔2s执行以下分支
        {
            flag2s = 0;
            if (staSystem == E_NORMAL)  //正常运行时刷新温度显示
            {
                RefreshTemp(0);
            }
        }
    }
}
/* 温度刷新函数，读取当前温度并根据需要刷新液晶显示，
** ops-刷新选项：为0时只当温度变化才刷新，非0则立即刷新 */
void RefreshTemp(uint8 ops)
{
    int16 temp;
    uint8 pdata str[8];
    static int16 backup = 0;
    
    Get18B20Temp(&temp); //获取当前温度值
    Start18B20();        //启动下一次转换
    temp >>= 4;          //舍弃4bit小数位
    if ((backup!=temp) || (ops!=0)) //按需要刷新液晶显示
    {
        str[0] = (temp/10) + '0';  //十位转为ASCII码
        str[1] = (temp%10) + '0';  //个位转为ASCII码
        str[2] = '\'';             //用'C代替℃
        str[3] = 'C';
        str[4] = '\0';             //字符串结束符
        LcdShowStr(12, 0, str);    //显示到液晶上
        backup = temp;             //刷新上次温度值
    }
}
/* 配置并启动T0，ms-T0定时时间 */
void ConfigTimer0(uint16 ms)
{
    uint32 tmp;
    
    tmp = (SYS_MCLK*ms)/1000; //计算所需的计数值
    tmp = 65536 - tmp;        //计算定时器重载值
    tmp = tmp + 33;           //补偿中断响应延时造成的误差   
    T0RH = (uint8)(tmp>>8);   //定时器重载值拆分为高低字节
    T0RL = (uint8)tmp;
    TMOD &= 0xF0;   //清零T0的控制位
    TMOD |= 0x01;   //配置T0为模式1
    TH0 = T0RH;     //加载T0重载值
    TL0 = T0RL;
    ET0 = 1;        //使能T0中断
    TR0 = 1;        //启动T0
}
/* T0中断服务函数，实现系统定时和按键扫描 */
void InterruptTimer0() interrupt 1
{
    static uint8 tmr2s = 0;
    static uint8 tmr200ms = 0;
    
    TH0 = T0RH;  //重新加载重载值
    TL0 = T0RL;
    tmr200ms++;  //定时200ms
    if (tmr200ms >= 200)
    {
        tmr200ms = 0;
        flag200ms = 1;
        tmr2s++;  //定时2s
        if (tmr2s >= 10)
        {
            tmr2s = 0;
            flag2s = 1;
        }
    }
    KeyScan();   //执行按键扫描
}
