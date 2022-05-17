.MODEL SMALL
.STACK 100H

.DATA


MSG DB 60 DUP("$")
NEWLINE DB 0AH,0DH,'$'
POSITION DW 0
.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV SI,0
    MOV DI,0
    MOV CX,0
    MOV AH,1
    SCAN:
        INT 21H
        CMP AL,0DH
        JE END_SCAN
        
        CMP AL,'A'
        JL RESET
        CMP AL,'Z'
        JG RESET
        INC CX
        JMP BOTTOM
        
        RESET:
        MOV CX,0
        
        BOTTOM:
        CMP DI,CX
        JGE LAST      
        
        MOV DI,CX
        MOV POSITION,SI
        
        LAST:
        MOV MSG[SI],AL
        INC SI
        JMP SCAN     
    END_SCAN:        
    
    
    MOV CX,DI
    MOV SI,POSITION
    SUB SI,CX
    INC SI
    
    CALL PRINTLINE
    MOV AH,2
    ITERATE:
        MOV DL,MSG[SI]
        INT 21H
        INC SI
        LOOP ITERATE
        
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