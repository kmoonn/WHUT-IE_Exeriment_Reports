DATA  SEGMENT
A  DB 3
B  DB ?
DATA   ENDS
CODE   SEGMENT
ASSUME  CS:CODE, DS:DATA
START: MOV  AX, DATA
        MOV  DS,AX
        MOV  AL,A
        TEST  AL,0FFh
        jp  ST1
        MOV  AL,0
        MOV  [SI],AL
        JMP   ST2
ST1:  MOV  AL,1
ST2:  MOV  B,AL
      MOV  DL,B
      ADD  DL,30H
      MOV  AH,02H
      INT  21H
      MOV  AH,4CH
      INT 21H 
CODE ENDS 
END START

