#include <reg51.h>
typedef unsigned char uint8;
typedef unsigned int uint16;

unsigned char buf;

sbit ADDR0=P1^0;	//位地址声明
sbit ADDR1=P1^1;
sbit ADDR2=P1^2;
sbit ADDR3=P1^3;
sbit ENLED=P1^4;
 
uint8 Buf[]="hello hushan\n";

void delay(uint16 n)
{
	while (n--);
}
 
//串行中断服务函数
void serial() interrupt 4
	{
	ES=0;		//暂时关闭串口中断
	RI=0;
	buf=SBUF;	//把收到的信息从SBUF放到buf中。
	switch(buf)
	{
	case 0x31: P0=0xfe;break;   //二进制 0011 0001  十进制 49 控制字符 1  16进制 0X31
	case 0x32: P0=0xfd;break;	 //1111 1101
	case 0x33: P0=0xfb;break;
	case 0x34: P0=0xf7;break;
	case 0x35: P0=0xef;break;   
	case 0x36: P0=0xdf;break;	
	case 0x37: P0=0xbf;break;
	case 0x38: P0=0x7f;break;
	}
	ES=1;		//重新开启串口中断
 
}

/*波特率为9600*/
void UART_init(void)
{
    SCON = 0x50;        //串口方式1
 
    TMOD = 0x20;        // 定时器使用方式2自动重载
    TH1 = 0xFD;         //9600波特率对应的预设数，定时器方式2下，TH1=TL1
    TL1 = 0xFD;
 
    TR1 = 1;						//开启定时器，开始产生波特率
}
 
/*发送一个字符*/
void UART_send_byte(uint8 dat){
	SBUF = dat;       		//把数据放到SBUF中
	while (TI == 0);			//未发送完毕就等待
		TI = 0;    					//发送完毕后，要把TI重新置0
}
 
/*发送一个字符串*/
void UART_send_string(uint8 *buf)
{
	while (*buf != '\0')
	{
		UART_send_byte(*buf++);
	}
}
 
main()
{
	UART_init();
	
	while (1)
	{
		//UART_send_byte('1');
		UART_send_string(Buf);
		delay(20000);
	}
}