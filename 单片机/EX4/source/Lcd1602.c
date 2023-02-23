#define  _LCD1602_C
#include "config.h"
#include "Lcd1602.h"

bit tmpADDR0;  //暂存LED位选译码地址0的值
bit tmpADDR1;  //暂存LED位选译码地址1的值

/* 暂停LED动态扫描，暂存相关引脚的值 */
void LedScanPause()
{
    ENLED = 1;
    tmpADDR0 = ADDR0;
    tmpADDR1 = ADDR1;
}
/* 恢复LED动态扫描，恢复相关引脚的值 */
void LedScanContinue()
{
    ADDR0 = tmpADDR0;
    ADDR1 = tmpADDR1;
    ENLED = 0;
}
/* 等待液晶准备好 */
void LcdWaitReady()
{
    uint8 sta;
    
    LCD1602_DB = 0xFF;
    LCD1602_RS = 0;
    LCD1602_RW = 1;
    do {
        LCD1602_E = 1;
        sta = LCD1602_DB; //读取状态字
        LCD1602_E = 0;
    } while (sta & 0x80); //bit7等于1表示液晶正忙，重复检测直到其等于0为止
}
/* 向LCD1602液晶写入一字节命令，cmd-待写入命令值 */
void LcdWriteCmd(uint8 cmd)
{
    LedScanPause();
    LcdWaitReady();
    LCD1602_RS = 0;
    LCD1602_RW = 0;
    LCD1602_DB = cmd;
    LCD1602_E  = 1;
    LCD1602_E  = 0;
    LedScanContinue();
}
/* 向LCD1602液晶写入一字节数据，dat-待写入数据值 */
void LcdWriteDat(uint8 dat)
{
    LedScanPause();
    LcdWaitReady();
    LCD1602_RS = 1;
    LCD1602_RW = 0;
    LCD1602_DB = dat;
    LCD1602_E  = 1;
    LCD1602_E  = 0;
    LedScanContinue();
}
/* 清屏 */
void LcdClearScreen()
{
	LcdWriteCmd(0x01);
}
/* 打开光标的闪烁效果 */
void LcdOpenCursor()
{
	LcdWriteCmd(0x0F);
}
/* 关闭光标显示 */
void LcdCloseCursor()
{
	LcdWriteCmd(0x0C);
}
/* 设置显示RAM起始地址，亦即光标位置，(x,y)-对应屏幕上的字符坐标 */
void LcdSetCursor(uint8 x, uint8 y)
{
    uint8 addr;
    
    if (y == 0)  //由输入的屏幕坐标计算显示RAM的地址
        addr = 0x00 + x;  //第一行字符地址从0x00起始
    else
        addr = 0x40 + x;  //第二行字符地址从0x40起始
    LcdWriteCmd(addr | 0x80);  //设置RAM地址
}
/* 在液晶上显示字符串，(x,y)-对应屏幕上的起始坐标，str-字符串指针 */
void LcdShowStr(uint8 x, uint8 y, uint8 *str)
{
    LcdSetCursor(x, y);   //设置起始地址
    while (*str != '\0')  //连续写入字符串数据，直到检测到结束符
    {
        LcdWriteDat(*str++);
    }
}
/* 在液晶上显示一个字符，(x,y)-对应屏幕上的起始坐标，chr-字符ASCII码 */
void LcdShowChar(uint8 x, uint8 y, uint8 chr)
{
    LcdSetCursor(x, y);  //设置起始地址
    LcdWriteDat(chr);    //写入ASCII字符
}
/* 初始化1602液晶 */
void InitLcd1602()
{
    LcdWriteCmd(0x38);  //16*2显示，5*7点阵，8位数据接口
    LcdWriteCmd(0x0C);  //显示器开，光标关闭
    LcdWriteCmd(0x06);  //文字不动，地址自动+1
    LcdWriteCmd(0x01);  //清屏
}
