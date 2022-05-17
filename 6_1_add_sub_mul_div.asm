; addition subtraction multiplication division

.MODEL SMALL
.STACK 100H
.DATA


A DB ?
B DB ?
NEWLINE DB 0AH,0DH,'$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,1
    INT 21H
    SUB AL,'0'
    MOV A,AL
    INT 21H
    SUB AL,'0'
    MOV B,AL
    
    ;MOV AH,2
    ;MOV DL,A
    ;ADD DL,B
    ;ADD DL,'0'
    ADD AL,A
    CALL PRINTAX
    
    MOV AL,A
    SUB AL,B
    CALL PRINTAX 
    
    MOV AL,A
    MUL B
    CALL PRINTAX
    
    MOV AH,0
    MOV AL,A
    DIV B
    CALL PRINTAX
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
PRINTLINE PROC
    PUSH DX
    PUSH AX
    LEA DX,NEWLINE
    MOV AH,9
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
    MOV BL,AH
    MOV DL,AL
    ADD DL,'0'
    MOV AH,2
    INT 21H
    MOV DL,BL
    ADD DL,'0'
    INT 21H
    POP BX
    POP AX
    POP DX
    RET
    PRINTAX ENDP

END MAIN