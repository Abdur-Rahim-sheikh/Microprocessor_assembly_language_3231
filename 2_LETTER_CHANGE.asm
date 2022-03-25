.MODEL SMALL

.STACK 100H

.DATA

VAR1 DB 40 DUP('$')

.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,1
    XOR SI,SI
    READ:
       INT 21H
       CMP AL,0DH
       JE END_READ
       
       MOV VAR1+SI, AL
       INC SI
       JMP READ
       
    END_READ:
    
    XOR DI,DI
    CASE_CHANGE:
        MOV DL,VAR1[DI]
        CMP DL,'$'
        JE END_CASE_CHANGE
        
        CMP DL,'A'
        JL NEXT
        CMP DL,'Z'
        JG CHECK_LOWER
        OR DL,32
        JMP NEXT
        
        CHECK_LOWER:
            CMP DL,'a'
            JL NEXT
            CMP DL,'z'
            JG NEXT
            AND DL,95
        
        
        NEXT:
        MOV VAR1[DI],DL
        INC DI
        JMP CASE_CHANGE
        
        
     END_CASE_CHANGE:
     
     LEA DX,VAR1
     MOV AH,9
     INT 21H                                                                                                         
     
     MOV AH,4CH
     INT 21H
     MAIN ENDP
END MAIN
            