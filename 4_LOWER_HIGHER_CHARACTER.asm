; SMALLEST AND LARGEST ALHPABETIC CHARACTERS

.MODEL SMALL
.STACK 100H
.DATA

NEWLINE DB 0AH,0DH,'$'
STR DB 40 DUP('$')
LOWER DB 100
HIGHER DB 0
.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,1
    MOV SI,0
    SCAN:
        INT 21H
        CMP AL,0DH
        JE END_SCAN
        MOV STR[SI],AL
        INC SI
        JMP SCAN
    END_SCAN:
    
    MOV CX,SI
    XOR SI,SI
    ITERATE:
        MOV DL,STR[SI]
        CMP DL,' '
        JE LAST_STEP
       CMP LOWER,DL
       JLE NEXT_STEP
       MOV LOWER,DL
       NEXT_STEP:
       CMP HIGHER,DL
       JGE LAST_STEP
       MOV HIGHER,DL
       LAST_STEP:
       INC SI
       LOOP ITERATE
       
    CALL PRINTLINE
    MOV AH,02H
    MOV DL,LOWER
    INT 21H
    
    CALL PRINTLINE
    MOV DL,HIGHER
    INT 21H
    
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

END MAIN