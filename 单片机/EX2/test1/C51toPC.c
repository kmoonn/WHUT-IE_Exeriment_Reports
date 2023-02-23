#include <reg51.h>
 
typedef unsigned char uint8;
typedef unsigned int uint16;
 
uint8 Buf[]="hello hushan\n";

void delay(uint16 n)
{
	while (n--);
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