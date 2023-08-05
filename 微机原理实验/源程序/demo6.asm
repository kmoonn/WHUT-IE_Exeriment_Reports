DATAS SEGMENT
	string_5 DB ' ','$'
    ary DW 5, 3, 9, 1, 7     ; 示例输入数据
    n DW 5                   ; 示例元素个数
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS
START:
    MOV AX, DATAS
    MOV DS, AX

    ;此处输入代码段代码
    MOV CX, n               ; 将元素个数存入CX
    MOV SI, 0               ; 外部循环计数器初始化为0

outer_loop:
    MOV DI, SI              ; 内部循环计数器初始化为外部循环计数器

inner_loop:
    ADD DI, 2               ; DI = SI + 1
    MOV BX, SI              ; BX = 外部循环计数器
    MOV AX, ary[BX]         ; AX = 外部循环元素

    CMP AX, ary[DI]         ; 比较内外循环元素大小
    JNL next_inner_loop      ; 如果内部元素 >= 外部元素，则跳过交换

    ; 交换内外循环元素
    MOV DX, ary[DI]
    MOV ary[DI], AX
    MOV ary[BX], DX

next_inner_loop:
    LOOP inner_loop         ; 继续内部循环

    INC SI                  ; 增加外部循环计数器
    CMP SI, n               ; 检查是否完成所有循环
    JB outer_loop
    
    ; 保存CX和SI的值
    PUSH CX
    PUSH SI

    ; 输出排序后的数组
    MOV CX, n               ; 将元素个数存入CX
    MOV SI, 0               ; 重置循环计数器

output_loop:
    PUSH CX
    MOV AX, ary[SI]
    
    CALL WriteDec           ; 输出无符号数
    MOV DL, ' '
    CALL SPACE          ; 输出空格
    POP CX
    INC SI
    CMP SI, n               ; 检查是否输出完所有元素
    JB output_loop
    
    ; 恢复CX和SI的值
    POP SI
    POP CX

    CALL CRLF               ; 换行

    ; 退出程序
    MOV AH, 4CH
    INT 21H

CRLF PROC Near
  push AX
  push DX
  MOV DL, 0ah
  MOV AH, 2
  INT 21H
  pop DX
  pop AX
  RET
  CRLF ENDP
  

SPACE PROC Near
  push AX
  push DX
  MOV DX, OFFSET string_5 ;' '
  MOV AH, 9
  INT 21H
  pop DX
  pop AX
  RET 
  SPACE ENDP
  
WriteDec PROC NEAR
  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX

  XOR BX, BX  ; 用于存储除法的余数
  MOV CX, 10  ; 除数

  ; 将AX的值保存到DX:BX中，用于除法操作
  MOV DX, 0
  MOV BX, AX

  ; 判断是否为0，如果为0则直接输出'0'
  CMP AX, 0
  JNZ not_zero
  MOV DL, '0'
  MOV AH, 2
  INT 21H
  JMP end_proc

not_zero:
  ; 循环除法操作，将每一位的数字存储在栈中
  convert_loop:
    XOR DX, DX  ; 清除DX的值

    DIV CX  ; AX = BX / CX，DX = BX % CX，商保存在AX，余数保存在DX

    ADD DL, '0'  ; 将余数转换为字符

    ; 将转换后的字符输出
    MOV AH, 2
    INT 21H

    ; 判断商是否为0，如果为0则跳出循环
    CMP AX, 0
    JNZ convert_loop

  end_proc:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WriteDec ENDP

CODES ENDS
    END START

