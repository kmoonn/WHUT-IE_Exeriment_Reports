#ifndef _LED_BUZZER_H
#define _LED_BUZZER_H

struct sLedBuff {  //LED显示缓冲区结构
    uint8 array[8];   //点阵缓冲区
    uint8 number[6];  //数码管缓冲区
    uint8 alone;      //独立LED缓冲区
};

#ifndef _LED_BUZZER_C
extern bit staBuzzer;
extern struct sLedBuff ledBuff;
#endif

void InitLed();
void FlowingLight();
void ShowLedNumber(uint8 index, uint8 num, uint8 point);
void ShowLedArray(uint8 *ptr);

#endif
