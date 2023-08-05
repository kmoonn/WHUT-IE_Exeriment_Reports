DATAS SEGMENT
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

    ; 输出排序后的数组
    MOV CX, n               ; 将元素个数存入CX
    MOV SI, 0               ; 重置循环计数器

output_loop:
    PUSH CX
    MOV AX, ary[SI]
    CALL WriteDec           ; 输出无符号数
    MOV DL, ' '
    CALL WriteChar          ; 输出空格
    POP CX
    INC SI
    CMP SI, n               ; 检查是否输出完所有元素
    JB output_loop

    CALL Crlf               ; 换行

    ; 退出程序
    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START

