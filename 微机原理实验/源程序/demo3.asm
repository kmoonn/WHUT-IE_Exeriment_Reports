DATA  SEGMENT
A  DB  53H
B  DB  24H
string  DB  '53+24=   $'
DATA   ENDS
CODE   SEGMENT
ASSUME CS:CODE, DS:DATA
START:  MOV  AX, DATA
          MOV  DS,AX
          MOV  SI,OFFSET string
          MOV  AL,A
          ADD  AL,B
          MOV  AH,AL
          AND  AL,0FH
          ADD  AL,30H
          AND  AH,0F0H
          MOV  CL,4
          SHR  AH,CL                      
          ADD  AH,30H
          MOV  [SI+6],AH
          MOV  [SI+7],AL
          MOV DX,OFFSET string
          MOV AH,09H
          INT 21H
          MOV  AH,4CH
          INT   21H
    CODE ENDS
    END START

