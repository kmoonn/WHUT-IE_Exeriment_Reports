#ifndef _LCD1602_H
#define _LCD1602_H


#ifndef _LCD1602_C

#endif

void InitLcd1602();
void LcdClearScreen();
void LcdOpenCursor();
void LcdCloseCursor();
void LcdSetCursor(uint8 x, uint8 y);
void LcdShowStr(uint8 x, uint8 y, uint8 *str);
void LcdShowChar(uint8 x, uint8 y, uint8 chr);

#endif
