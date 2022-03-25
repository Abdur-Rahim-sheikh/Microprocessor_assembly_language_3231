; Number of words
; Number of vowels
; Number of consonants
; Number of digits

.MODEL SMALL
.STACK 100H

.DATA
STR DB 40 DUP('$')
WORDS DB '1'
VOWELS DB '0'
CONSONANTS DB '0'
DIGITS DB '0'
NEWLINE DB 0AH,0DH,'$'

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
        MOV STR+SI,AL
        INC SI
        JMP READ
    END_READ:
    
    CALL PRINTLINE
    
    MOV CX,SI
    MOV DI,0
    
    MOV AH,2
    ; count words
    ITERATE:
        MOV AH, STR[DI]    
        CMP AH,' '
        JE WORD_CNT
        
        CMP AH,'A'
        JE VOWEL_CNT
        CMP AH,'E'
        JE VOWEL_CNT
        CMP AH, 'I'
        JE VOWEL_CNT
        CMP AH,'O'
        JE VOWEL_CNT
        CMP AH,'U'
        JZ VOWEL_CNT
        
        CMP AH,'0'
        JL NEXT
        CMP AH,'9'
        JG NEXT
        JMP DIGIT_CNT
        
        NEXT:
        CMP AH,'A'
        JL BOTTOM
        CMP AH,'Z'
        JG BOTTOM
        INC CONSONANTS
        
        
        JMP BOTTOM  
        DIGIT_CNT:
            INC DIGITS 
            JMP BOTTOM
            
        VOWEL_CNT:
            INC VOWELS
            JMP BOTTOM
        WORD_CNT:
            INC WORDS
            JMP BOTTOM
                           
                  
        BOTTOM:
        INC DI
        
    LOOP ITERATE
    
    MOV DL,VOWELS
    MOV AH,2
    INT 21H
    CALL PRINTLINE
    
    MOV DL,CONSONANTS
    INT 21H
    CALL PRINTLINE
    
    MOV DL,DIGITS
    INT 21H
    CALL PRINTLINE
    
    MOV DL,WORDS
    INT 21H
    CALL PRINTLINE
    
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
    
    
    
    