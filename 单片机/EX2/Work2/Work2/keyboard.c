#include <reg52.h>

sbit KEY_IN_1=P2^4;
sbit KEY_IN_2=P2^5;
sbit KEY_IN_3=P2^6;
sbit KEY_OUT_1=P2^3;
sbit KEY_OUT_2=P2^2;
sbit KEY_OUT_3=P2^1;
sbit KEY_OUT_4=P2^0;

unsigned char code KeyCodeMap[4][3]={
	{'1','2','3'},
	{'4','5','6'},
	{'7','8','9'},
	{'0',0x1B,0x0D}
};
unsigned char pdata KeySta[4][3]={
	{1,1,1},{1,1,1},{1,1,1},{1,1,1}
};
extern unsigned char KeyAction(unsigned char keycode);
unsigned char KeyDriver()
{
	unsigned char i,j;
	unsigned char step;
	static unsigned char pdata backup[4][3]={
		{1,1,1},{1,1,1},{1,1,1},{1,1,1}
	};
	for(i=0;i<4;i++)
	{
		for(j=0;j<3;j++)
		{
			if(backup[i][j]!=KeySta[i][j])
			{
				if(backup[i][j]!=0)
				{
					step=KeyAction(KeyCodeMap[i][j]);
				}
				else{step=1;}
				backup[i][j]=KeySta[i][j];
			}
			else{step=1;}
		}
	}
	return step;
}
void KeyScan()
{
	unsigned char i;
	static unsigned char keyout=0;
	static unsigned char keybuf[4][3]={
		{0xFF,0xFF,0xFF},{0xFF,0xFF,0xFF},
		{0xFF,0xFF,0xFF},{0xFF,0xFF,0xFF}
	};
	keybuf[keyout][0]=(keybuf[keyout][0]<<1)|KEY_IN_1;
	keybuf[keyout][1]=(keybuf[keyout][1]<<1)|KEY_IN_2;
	keybuf[keyout][2]=(keybuf[keyout][2]<<1)|KEY_IN_3;
	for(i=0;i<3;i++)
	{
		if((keybuf[keyout][i]&0x0F)==0x00)
		{
			KeySta[keyout][i]=0;
		}
		else if((keybuf[keyout][i]&0x0F)==0x0F)
		{
			KeySta[keyout][i]=1;
		}
	}
	keyout++;
	keyout&=0x03;
	switch(keyout)
	{
		case 0:KEY_OUT_4=1;KEY_OUT_1=0;break;
		case 1:KEY_OUT_1=1;KEY_OUT_2=0;break;
		case 2:KEY_OUT_2=1;KEY_OUT_3=0;break;
		case 3:KEY_OUT_3=1;KEY_OUT_4=0;break;
		default: break;
	}
}