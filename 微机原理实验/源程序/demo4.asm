S0  SEGMENT STACK
    DW  20 DUP(?)
TOP LABEL   WORD
S0  ENDS

S1  SEGMENT
TIP DB  "Input ten number and separate the numbers with space:", 0DH, 0AH, 24H
ARY DW  20 DUP(0)
CRLF DB  0DH, 0AH, 24H
N   DW  0
S1  ENDS

S2  SEGMENT
    ASSUME  SS:S0, DS:S1, CS:S2, ES:S1
P   PROC    FAR
    MOV AX, S0
    MOV SS, AX
    LEA SP, TOP

    MOV AX, S1
    MOV DS, AX

    MOV AX, S1
    MOV ES, AX

    LEA DX, TIP
    MOV AH, 9
    INT 21H

    LEA SI, ARY

    XOR DX, DX
    MOV BL, 10
    MOV CX, 10

INPUT:  MOV AH, 1
    INT 21H
    CMP AL, 20H ;空格分隔字符
    JE  SAVE
    ;输入十进制数，将数存入SI对应的内存单元
    MOV DL, AL 
    MOV AX, [SI]
    MUL BL
    SUB DL, 30H
    ADD AL, DL
    MOV [SI], AX
    JMP INPUT
SAVE:   
    ADD SI, 2 
    LOOP    INPUT
    ;数组保存完毕

    LEA SI, ARY

    MOV DI, SI
    ADD DI, 2 ;DI位于数组的第二元素的位置

    MOV BP, 9 ;SI移动的次数和每一次比较的次数，第一次为9

GO: MOV CX, BP ;每一次比较的循环次数
    MOV BX, [SI] ;第一个数
CMPA:   CMP BX, [DI] ;比较后面的数是否比当前的小
    JBE CON ;大于就比较下一个
    MOV BX, [DI] ;将寄存器中的值替换为最小的值
    MOV AX, DI ;AX存放最小值的偏移地址
CON:    ADD DI, 2
    LOOP    CMPA

    CMP AX, 0 ;如果AX为0，则表示后面的值没有比当前值小
    JE  NO ;此时SI加一，移动到第二个数  下一次循环比较开始
CHANGE: MOV DX, [SI] ;78-83行替换当前值与最小值
    PUSH    DX
    MOV [SI], BX
    POP DX
    MOV DI, AX
    MOV [DI], DX
NO: ADD SI, 2
    MOV DI, SI
    ADD DI, 2
    CALL    PRINT
    DEC BP ;循环的次数减一
    XOR AX, AX ;清除AX的内容，以便76行判断
    CMP BP, 1
    JNE GO

EXIT:   MOV AH, 4CH
    INT 21H

P   ENDP

PRINT   PROC    NEAR
    PUSH    SI
    PUSH    CX
    PUSH    AX
    PUSH    DX
    LEA DX, CRLF
    MOV AH, 9
    INT 21H

    LEA SI, ARY
    MOV CX, 10
L1: MOV AX, [SI]
    MOV N, AX
    CALL    OUTPUT
    ADD SI, 2
    MOV DX, 20H
    MOV AH, 2
    INT 21H
    LOOP    L1
    POP DX
    POP AX
    POP CX
    POP SI
    RET

PRINT   ENDP

OUTPUT  PROC    NEAR
    PUSH    AX
    PUSH    BX
    PUSH    CX
    PUSH    DX

    XOR CX, CX 
    MOV AX, N
    MOV BX, 10
L2: XOR DX, DX
    DIV BX
    PUSH    DX
    INC CX
    CMP AX, 0
    JNE L2

L3: POP DX
    ADD DX, 30H
    MOV AH, 2
    INT 21H
    LOOP    L3

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTPUT  ENDP

S2  ENDS
    END P
