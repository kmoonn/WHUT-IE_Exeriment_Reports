#include <reg52.h>

sbit ADDR0=P1^0;	//位地址声明
sbit ADDR1=P1^1;
sbit ADDR2=P1^2;
sbit ADDR3=P1^3;
sbit ENLED=P1^4;

void change(unsigned char *c,unsigned char *s,unsigned char *d){
			if(*c>=10){	//溢出达到10次 
				*c=0;
				if(*d==0){
					*s=*s<<1;
					if(*s==0x80){
						*d=1;
					}
				}
				else{
					*s=*s>>1;
					if(*s==0x01){
						*d=0;
					}
				}
		}
}

void main(){
	unsigned char shift=0x01;
	unsigned char dir=0;
	unsigned char cnt=0;
	
	ENLED=0;	//74HC138使能
	ADDR3=1;
	
	ADDR2=1;	//74HC138输入A2A1A0
	ADDR1=1;
	ADDR0=0;
	
	TMOD=0x01; //模式
	TH0=0XB8;		//初值
	TL0=0X00;
	TR0=1;	//启动
	
	while(1){
		P0=~shift;
		while(TF0==0);
		TF0=0;
		TH0=0XB8;
		TL0=0X00;
		cnt++;
		change(&cnt,&shift,&dir);
	}
}