#define  _TIME_C
#include "config.h"
#include "DS1302.h"
#include "LedBuzzer.h"
#include "Lcd1602.h"
#include "Time.h"
#include "main.h"

uint8 code WeekMod[] = {  //星期X字符图片表
    0xFF,0x81,0xBD,0xBD,0x81,0xBD,0xBD,0x81,  //星期日
    0xFF,0xFF,0xFF,0x00,0xFF,0xFF,0xFF,0xFF,  //星期一
    0xFF,0xFF,0xC3,0xFF,0xFF,0x81,0xFF,0xFF,  //星期二
    0xFF,0xC3,0xFF,0xC3,0xFF,0x81,0xFF,0xFF,  //星期三
    0xFF,0x00,0x5A,0x5A,0x5A,0x7E,0x00,0xFF,  //星期四
    0xFF,0x81,0xF7,0xC1,0xD7,0xD7,0x81,0xFF,  //星期五
    0xFF,0xF7,0xFF,0x81,0xFF,0xDB,0xBD,0xFF,  //星期六
};

bit staMute = 0;  //静音标志位
uint8 AlarmHour = 0x07;  //闹钟时间的小时数
uint8 AlarmMin  = 0x30;  //闹钟时间的分钟数
struct sTime CurTime;    //当前日期时间

uint8 SetIndex = 0;  //设置位索引
uint8 pdata SetAlarmHour;    //闹钟小时数设置缓冲
uint8 pdata SetAlarmMin;     //闹钟分钟数设置缓冲
struct sTime pdata SetTime;  //日期时间设置缓冲区

/* 获取当前日期时间，并刷新时间和星期的显示 */
void RefreshTime()
{
    GetRealTime(&CurTime);                  //获取当前日期时间
    ShowLedNumber(5, CurTime.hour>>4, 0);   //时
    ShowLedNumber(4, CurTime.hour&0xF,1);
    ShowLedNumber(3, CurTime.min>>4,  0);   //分
    ShowLedNumber(2, CurTime.min&0xF, 1);
    ShowLedNumber(1, CurTime.sec>>4,  0);   //秒
    ShowLedNumber(0, CurTime.sec&0xF, 0);
    ShowLedArray(WeekMod + CurTime.week*8); //星期
}
/* 日期刷新函数，ops-刷新选项：为0时只当日期变化才刷新，非0则立即刷新 */
void RefreshDate(uint8 ops)
{
    uint8 pdata str[12];
    static uint8 backup = 0;
    
    if ((backup!=CurTime.day) || (ops!=0))
    {
        str[0] = ((CurTime.year>>12) & 0xF) + '0';  //4位数年份
        str[1] = ((CurTime.year>>8) & 0xF) + '0';
        str[2] = ((CurTime.year>>4) & 0xF) + '0';
        str[3] = (CurTime.year & 0xF) + '0';
        str[4] = '-';                        //分隔符
        str[5] = (CurTime.mon >> 4) + '0';   //月份
        str[6] = (CurTime.mon & 0xF) + '0';
        str[7] = '-';                        //分隔符
        str[8] = (CurTime.day >> 4) + '0';   //日期
        str[9] = (CurTime.day & 0xF) + '0';
        str[10] = '\0';         //字符串结束符
        LcdShowStr(0, 0, str);  //显示到液晶上
        backup = CurTime.day;   //刷新上次日期值
    }
}
/* 刷新闹钟时间的显示 */
void RefreshAlarm()
{
    uint8 pdata str[8];
    
    LcdShowStr(0, 1, "Alarm at ");     //显示提示标题
    str[0] = (AlarmHour >> 4) + '0';   //闹钟小时数
    str[1] = (AlarmHour & 0xF) + '0';
    str[2] = ':';                      //分隔符
    str[3] = (AlarmMin >> 4) + '0';    //闹钟分钟数
    str[4] = (AlarmMin & 0xF) + '0';
    str[5] = '\0';                     //字符串结束符
    LcdShowStr(9, 1, str);             //显示到液晶上
}
/* 闹钟监控函数，抵达设定的闹钟时间时执行闹铃 */
void AlarmMonitor()
{
    if ((CurTime.hour==AlarmHour) && (CurTime.min==AlarmMin)) //检查时间匹配
    {
        if (!staMute)  //检查是否静音
            staBuzzer = ~staBuzzer;  //实现蜂鸣器断续鸣叫
        else
            staBuzzer = 0;
    }
    else
    {
        staMute = 0;
        staBuzzer = 0;
    }
}
/* 将设置时间及标题提示显示到液晶上 */
void ShowSetTime()
{
    uint8 pdata str[18];
    
    str[0]  = ((SetTime.year>>4) & 0xF) + '0';  //2位数年份
    str[1]  = (SetTime.year & 0xF) + '0';
    str[2]  = '-';
    str[3]  = (SetTime.mon >> 4) + '0';   //月份
    str[4]  = (SetTime.mon & 0xF) + '0';
    str[5]  = '-';
    str[6]  = (SetTime.day >> 4) + '0';   //日期
    str[7]  = (SetTime.day & 0xF) + '0';
    str[8]  = '-';
    str[9]  = (SetTime.week & 0xF) + '0'; //星期
    str[10] = ' ';
    str[11] = (SetTime.hour >> 4) + '0';  //小时
    str[12] = (SetTime.hour & 0xF) + '0';
    str[13] = ':';
    str[14] = (SetTime.min >> 4) + '0';   //分钟
    str[15] = (SetTime.min & 0xF) + '0';
    str[16] = '\0';
    LcdShowStr(0, 0, "Please Set Time");  //显示提示标题
    LcdShowStr(0, 1, str);              //显示设置时间值
}
/* 将设置闹钟及标题提示显示到液晶上 */
void ShowSetAlarm()
{
    uint8 pdata str[8];
    
    str[0] = (SetAlarmHour >> 4) + '0';   //小时
    str[1] = (SetAlarmHour & 0xF) + '0';
    str[2] = ':';
    str[3] = (SetAlarmMin >> 4) + '0';    //分钟
    str[4] = (SetAlarmMin & 0xF) + '0';
    str[5] = '\0';
    LcdShowStr(0, 0, "Set Alarm");  //显示提示标题
    LcdShowStr(0, 1, str);          //显示设定闹钟值
}
/* 取消当前设置，返回正常运行状态 */
void CancelCurSet()
{
    staSystem = E_NORMAL;
    LcdCloseCursor();  //关闭光标
    LcdClearScreen();  //液晶清屏
    RefreshTime();   //刷新当前时间
    RefreshDate(1);  //立即刷新日期显示
    RefreshTemp(1);  //立即刷新温度显示
    RefreshAlarm();  //闹钟设定值显示
}
/* 时间或闹钟设置时，设置位右移一位，到头后折回 */
void SetRightShift()
{
    if (staSystem == E_SET_TIME)
    {
        switch (SetIndex)
        {
            case 0: SetIndex=1;  LcdSetCursor(1, 1); break;
            case 1: SetIndex=2;  LcdSetCursor(3, 1); break;
            case 2: SetIndex=3;  LcdSetCursor(4, 1); break;
            case 3: SetIndex=4;  LcdSetCursor(6, 1); break;
            case 4: SetIndex=5;  LcdSetCursor(7, 1); break;
            case 5: SetIndex=6;  LcdSetCursor(9, 1); break;
            case 6: SetIndex=7;  LcdSetCursor(11,1); break;
            case 7: SetIndex=8;  LcdSetCursor(12,1); break;
            case 8: SetIndex=9;  LcdSetCursor(14,1); break;
            case 9: SetIndex=10; LcdSetCursor(15,1); break;
            default: SetIndex=0; LcdSetCursor(0, 1); break;
        }
    }
    else if (staSystem == E_SET_ALARM)
    {
        switch (SetIndex)
        {
            case 0: SetIndex=1;  LcdSetCursor(1,1); break;
            case 1: SetIndex=2;  LcdSetCursor(3,1); break;
            case 2: SetIndex=3;  LcdSetCursor(4,1); break;
            default: SetIndex=0; LcdSetCursor(0,1); break;
        }
    }
}
/* 时间或闹钟设置时，设置位左移一位，到头后折回 */
void SetLeftShift()
{
    if (staSystem == E_SET_TIME)
    {
        switch (SetIndex)
        {
            case 0: SetIndex=10; LcdSetCursor(15,1); break;
            case 1: SetIndex=0;  LcdSetCursor(0, 1); break;
            case 2: SetIndex=1;  LcdSetCursor(1, 1); break;
            case 3: SetIndex=2;  LcdSetCursor(3, 1); break;
            case 4: SetIndex=3;  LcdSetCursor(4, 1); break;
            case 5: SetIndex=4;  LcdSetCursor(6, 1); break;
            case 6: SetIndex=5;  LcdSetCursor(7, 1); break;
            case 7: SetIndex=6;  LcdSetCursor(9, 1); break;
            case 8: SetIndex=7;  LcdSetCursor(11,1); break;
            case 9: SetIndex=8;  LcdSetCursor(12,1); break;
            default: SetIndex=9; LcdSetCursor(14,1); break;
        }
    }
    else if (staSystem == E_SET_ALARM)
    {
        switch (SetIndex)
        {
            case 0: SetIndex=3;  LcdSetCursor(4,1); break;
            case 1: SetIndex=0;  LcdSetCursor(0,1); break;
            case 2: SetIndex=1;  LcdSetCursor(1,1); break;
            default: SetIndex=2; LcdSetCursor(3,1); break;
        }
    }
}
/* 输入设置数字，修改对应的设置位，并显示该数字，ascii-输入数字的ASCII码 */
void InputSetNumber(uint8 ascii)
{
    uint8 num;
    
    num = ascii - '0';
    if (num <= 9)  //只响应0～9的数字
    {
        if (staSystem == E_SET_TIME)
        {
            switch (SetIndex)
            {
                case 0: SetTime.year = (SetTime.year&0xFF0F)|(num<<4);
                        LcdShowChar(0, 1, ascii);  break;      //年份高位数字
                case 1: SetTime.year = (SetTime.year&0xFFF0)|(num);
                        LcdShowChar(1, 1, ascii);  break;      //年份低位数字
                case 2: SetTime.mon = (SetTime.mon&0x0F)|(num<<4);
                        LcdShowChar(3, 1, ascii);  break;      //月份高位数字
                case 3: SetTime.mon = (SetTime.mon&0xF0)|(num);
                        LcdShowChar(4, 1, ascii);  break;      //月份低位数字
                case 4: SetTime.day = (SetTime.day&0x0F)|(num<<4);
                        LcdShowChar(6, 1, ascii);  break;      //日期高位数字
                case 5: SetTime.day = (SetTime.day&0xF0)|(num);
                        LcdShowChar(7, 1, ascii);  break;      //日期低位数字
                case 6: SetTime.week = (SetTime.week&0xF0)|(num);
                        LcdShowChar(9, 1, ascii);  break;      //星期数字
                case 7: SetTime.hour = (SetTime.hour&0x0F)|(num<<4);
                        LcdShowChar(11,1, ascii);  break;      //小时高位数字
                case 8: SetTime.hour = (SetTime.hour&0xF0)|(num);
                        LcdShowChar(12,1, ascii);  break;      //小时低位数字
                case 9: SetTime.min = (SetTime.min&0x0F)|(num<<4);
                        LcdShowChar(14,1, ascii);  break;      //分钟高位数字
                default:SetTime.min = (SetTime.min&0xF0)|(num);
                        LcdShowChar(15,1, ascii);  break;      //分钟低位数字
            }
            SetRightShift();  //完成该位设置后自动右移
        }
        else if (staSystem == E_SET_ALARM)
        {
            switch (SetIndex)
            {
                case 0: SetAlarmHour = (SetAlarmHour&0x0F) | (num<<4);
                        LcdShowChar(0,1, ascii); break;      //小时高位数字
                case 1: SetAlarmHour = (SetAlarmHour&0xF0) | (num);
                        LcdShowChar(1,1, ascii); break;      //小时低位数字
                case 2: SetAlarmMin = (SetAlarmMin&0x0F) | (num<<4);
                        LcdShowChar(3,1, ascii); break;      //分钟高位数字
                default:SetAlarmMin = (SetAlarmMin&0xF0) | (num);
                        LcdShowChar(4,1, ascii); break;      //分钟低位数字
            }
            SetRightShift();  //完成该位设置后自动右移
        }
    }
}
/* 切换系统运行状态 */
void SwitchSystemSta()
{
    if (staSystem == E_NORMAL)  //正常运行切换到时间设置
    {
        staSystem = E_SET_TIME;
        SetTime.year = CurTime.year;  //当前时间拷贝到时间设置缓冲区中
        SetTime.mon  = CurTime.mon;
        SetTime.day  = CurTime.day;
        SetTime.hour = CurTime.hour;
        SetTime.min  = CurTime.min;
        SetTime.sec  = CurTime.sec;
        SetTime.week = CurTime.week;
        LcdClearScreen();  //液晶清屏
        ShowSetTime();     //显示设置时间
        SetIndex = 255;    //与接下来的右移一起将光标设在最左边的位置上
        SetRightShift();
        LcdOpenCursor();   //开启光标
    }
    else if (staSystem == E_SET_TIME)  //时间设置切换到闹钟设置
    {
        staSystem = E_SET_ALARM;
        SetTime.sec = 0;          //秒清零，即当设置时间后从0秒开始走时
        SetRealTime(&SetTime);    //设定时间写入实时时钟
        SetAlarmHour = AlarmHour; //当前闹钟值拷贝到设置缓冲区
        SetAlarmMin  = AlarmMin;
        LcdClearScreen();  //液晶清屏
        ShowSetAlarm();    //显示设置闹钟
        SetIndex = 255;    //与接下来的右移一起将光标设在最左边的位置上
        SetRightShift();
    }
    else  //闹钟设置切换会正常运行
    {
        staSystem = E_NORMAL;
        AlarmHour = SetAlarmHour;  //设定的闹钟值写入闹钟时间
        AlarmMin  = SetAlarmMin;
        LcdCloseCursor();  //关闭光标
        LcdClearScreen();  //液晶清屏
        RefreshTime();   //刷新当前时间
        RefreshDate(1);  //立即刷新日期显示
        RefreshTemp(1);  //立即刷新温度显示
        RefreshAlarm();  //闹钟设定值显示
    }
}
/* 按键动作函数，根据键码执行相应的操作，keycode-按键键码 */
void KeyAction(uint8 keycode)
{
    if  ((keycode>='0') && (keycode<='9'))  //数字键输入当前位设定值
    {
        InputSetNumber(keycode);
    }
    else if (keycode == 0x25)  //向左键，向左切换设置位
    {
        SetLeftShift();
    }
    else if (keycode == 0x27)  //向右键，向右切换设置位
    {
        SetRightShift();
    }
    else if (keycode == 0x0D)  //回车键，切换运行状态/保存设置
    {
        SwitchSystemSta();
    }
    else if (keycode == 0x1B)  //Esc键，静音/取消当前设置
    {
        if (staSystem == E_NORMAL) //处于正常运行状态时闹铃静音
        {
            staMute = 1;
        }
        else                       //处于设置状态时退出设置
        {
            CancelCurSet();
        }
    }
}
