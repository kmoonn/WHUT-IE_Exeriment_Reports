/*
*实现半双工通信。
*PC首先发送信息，然后C51才能通过按键给PC发送信息。
*C51发送信息后若需要再次发送，需等待PC发送信息，后按ESC键重置LCD的C51显示区
 接着可再次使用按键发送信息。
*/
#include <reg52.h>
unsigned char T0RH=0;
unsigned char T0RL=0;
unsigned char step=0;
unsigned long num=0;

void ConfigTimer0(unsigned int ms);
extern unsigned char UartDriver();
extern unsigned char KeyDriver();
extern void KeyScan();
extern void ConfigUART(unsigned int baud);
extern void UartRxMonitor(unsigned char ms);
extern void UartWrite(unsigned char *buf,unsigned char len);
extern void InitLcd1602();
extern void LcdShowStr(unsigned char x,unsigned char y,unsigned char *str);
extern void LcdAreaClear(unsigned char x,unsigned char y,unsigned char len);

void main()
{
	EA=1;
	ConfigTimer0(1);
	ConfigUART(9600);
	InitLcd1602();
	while(1)
	{
		if(step==0)
		{
			step=UartDriver();
		}
		else if(step==1)
		{
			step=KeyDriver();
		}
	}
}
void UartAction(unsigned char *buf,unsigned char len)
{
	buf[len]='\0';
	LcdShowStr(0,0,buf);
	if(len<16)
	{
		LcdAreaClear(len,0,16-len);
	}
	UartWrite("GetMessage",sizeof("GetMessage"));
}
void Reset()
{
	num=0;
	LcdAreaClear(0,1,16);
}
unsigned char LongToString(unsigned char *str,unsigned long dat)
{
	unsigned char i=0;
	unsigned char len=0;
	unsigned char buf[16];
	do
	{
		buf[i++]=dat%10;
		dat/=10;
	}while(dat>0);
	len+=i;
	while(i-->0)
	{
		*str++=buf[i]+'0';
	}
	*str++='\r';
	*str='\n';
	len=len+2;
	return len;
}
void NumKeyAction(unsigned char n)
{
	unsigned char len;
	unsigned char str[16];
	num=num*10+n;
	len=LongToString(str,num);
	len=len-2;
	LcdShowStr(16-len,1,str);
}
unsigned char KeyAction(unsigned char keycode)
{
	unsigned char flag;
	if((keycode>='0')&&(keycode<='9'))
	{
		NumKeyAction(keycode-'0');
		flag=1;
	}
	else if(keycode==0x0D)
	{
		unsigned char len;
		unsigned char str[16];
		len=LongToString(str,num);
		UartWrite(str,len);
		Reset();
		LcdShowStr(16-sizeof("Sented"),1,"Sented");
		flag=0;
	}
	else if(keycode==0x1B)
	{
		Reset();
		LcdShowStr(15,1,"0");
		flag=1;
	}
	else{flag=1;}
	return flag;
}
void ConfigTimer0(unsigned int ms)
{
	unsigned long tmp;
	tmp=11059200/12;
	tmp=(tmp*ms)/1000;
	tmp=65536-tmp;
	tmp=tmp+33;
	T0RH=(unsigned char)(tmp>>8);
	T0RL=(unsigned char)tmp;
	TMOD&=0xF0;
	TMOD|=0x01;
	TH0=T0RH;
	TL0=T0RL;
	ET0=1;
	TR0=1;
}
void InterruptTimer0() interrupt 1
{
	TH0=T0RH;
	TL0=T0RL;
	UartRxMonitor(1);
	KeyScan();
}