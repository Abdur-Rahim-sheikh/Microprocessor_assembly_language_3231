; FACTORIAL OF N

.MODEL SMALL
.STACK 100H
.DATA

NUMBER DB 0
NEWLINE DB 0AH,0DH,'$'
.CODE 
MAIN PROC
     MOV DX,@DATA
     MOV DS,DX
     
     MOV AH,1
     INT 21H 
     MOV AH,0
     SUB AL,'0'
     MOV CX,AX
     MOV AX,1
     SUMMATION:
        MUL CL
        LOOP SUMMATION
     CALL PRINTAX
           
     MOV AH,4CH
     INT 21H
    
    
    
    
    MAIN ENDP

PRINTLINE PROC
    PUSH DX
    PUSH AX
    LEA DX,NEWLINE
    MOV AH,09H
    INT 21H
    POP AX
    POP DX
    RET
    PRINTLINE ENDP

PRINTAX PROC
    PUSH DX
    PUSH AX
    PUSH BX
    CALL PRINTLINE
    MOV AH,0
    MOV BL,10
    DIV BL
    MOV BH,AH
    MOV AH,2
    
    MOV DL,AL
    ADD DL,'0'
    INT 21H
    MOV DL,BH
    ADD DL,'0'
    INT 21H
    POP BX
    POP AX
    POP DX
    RET
    PRINTAX ENDP



END MAIN