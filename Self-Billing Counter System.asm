; SELF BILLING COUNTER - SUPER SHOP

.MODEL SMALL
.STACK 300h

NEWLINE MACRO               ; NEWLINE print carriage return + line feed
    MOV  AH, 02h
    MOV  DL, 13
    INT  21h
    MOV  DL, 10
    INT  21h
ENDM

PRINT_STR MACRO MSG         ; PRINT_STR print $-terminated string at label MSG
    LEA  DX, MSG
    MOV  AH, 09h
    INT  21h
ENDM

; ONE_KEY -- read 1 key with echo, save to BL immediately.
; Use BL for all comparisons after this macro.

ONE_KEY MACRO
    MOV  AH, 01h
    INT  21h            ; AL = key pressed  (AH now corrupted by DOS)
    MOV  BL, AL         ; save immediately before AH corruption spreads
ENDM


; FOUR_DIG_IN -- read exactly 4 digit keys
; Result stored in DEST (word variable)

FOUR_DIG_IN MACRO DEST
    MOV  DEST, 0

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL        
    SUB  BL, 30h       
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1000
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h       
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 100
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 10
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1
    MUL  CX
    ADD  DEST, AX
ENDM

; THREE_DIG_IN -- read exactly 3 digit keys -> DEST (word).

THREE_DIG_IN MACRO DEST
    MOV  DEST, 0

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 100
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 10
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h       
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1
    MUL  CX
    ADD  DEST, AX
ENDM

; TWO_DIG_IN -- read exactly 2 digit keys -> DEST (word).

TWO_DIG_IN MACRO DEST
    MOV  DEST, 0

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 10
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1
    MUL  CX
    ADD  DEST, AX
ENDM


; FIVE_DIG_IN -- read exactly 5 digit keys -> DEST (word).

FIVE_DIG_IN MACRO DEST
    MOV  DEST, 0

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 10000
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1000
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 100
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h        
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 10
    MUL  CX
    ADD  DEST, AX

    MOV  AH, 01h      
    INT  21h
    MOV  BL, AL
    SUB  BL, 30h
    MOV  CL, BL
    MOV  CH, 0
    MOV  AX, 1
    MUL  CX
    ADD  DEST, AX
ENDM


.DATA

S_TITLE  DB 13,10,"           ================================================",13,10
         DB "                     SELF BILLING COUNTER - SUPER SHOP",13,10
         DB "           ================================================",13,10,"$"
S_MAIN   DB 13,10," 1. Member Login",13,10
         DB " 2. Register Member",13,10
         DB " 3. Non-Member Shopping",13,10
         DB " 4. Admin Login",13,10
         DB " 5. Exit",13,10
         DB "Choice (1-5): $"
S_INV    DB 13,10," Invalid. Try again.",13,10,"$"
S_BYE    DB 13,10," Goodbye!",13,10,"$"
S_PRESS  DB 13,10," Press any key...$"
S_SEP    DB " | $"

S_RGNM   DB 13,10," Name (max 12, press Enter): $"
S_RGPH   DB 13,10," Phone (type all 10 digits, auto): $"
S_RGOK   DB 13,10," Registered! Use phone to login.",13,10,"$"
S_RGFL   DB 13,10," Member list full!",13,10,"$"
S_RGDP   DB 13,10," Phone already registered!",13,10,"$"
S_LGPH   DB 13,10," Member ID - type all 10 digits: $"
S_LGOK   DB 13,10," Login OK! Welcome, $"
S_LGNO   DB 13,10," Member not found.",13,10,"$"
S_PTSH   DB 13,10," Your Points: $"
S_PTUSE  DB 13,10," Use points as discount? Available: $"
S_PTYN   DB "  Y=yes, other=skip: $"

S_ADPW   DB 13,10," Admin Password (4 digits, auto): $"
S_ADMNU  DB 13,10," 1.Update Stock  2.Add Product  3.History  4.Back",13,10
         DB "Choice (1-4): $"
S_ADPID  DB 13,10," Product ID (3 digits, auto): $"
S_ADQTY  DB 13,10," Stock qty (2 digits, auto): $"
S_ADPNM  DB 13,10," Product name (max 10, press Enter): $"
S_ADPPR  DB 13,10," Price (5 digits multiple of 5, auto): $"
S_ADOK   DB 13,10," Done.",13,10,"$"
S_ADER   DB 13,10," Product not found!",13,10,"$"
S_ADFL   DB 13,10," Product list full.",13,10,"$"
S_ADPER  DB 13,10," Price must be multiple of 50!",13,10,"$"
S_ADPWE  DB 13,10," Wrong password!",13,10,"$"
S_ADIDE  DB 13,10," ID must be 100-999 and unique!",13,10,"$"

S_PHDR   DB 13,10," ID  | Name       | Price | Stock | Status",13,10
         DB " ----+-----------+-------+-------+-------",13,10,"$"
S_INST   DB " OK  $"
S_OUTST  DB " OUT $"
S_NOPRD  DB 13,10," No products in system.",13,10,"$"

S_SCAN   DB 13,10," Scan Product ID (3 digits, 000=done): $"
S_QTY    DB 13,10," Quantity (2 digits, auto): $"
S_ADDED  DB 13,10," Added to cart.",13,10,"$"
S_NF     DB 13,10," Product ID not found!",13,10,"$"
S_NOSTK  DB 13,10," Not enough stock!",13,10,"$"
S_EMPT   DB 13,10," Cart is empty.",13,10,"$"

S_BILLH  DB 13,10,"============= BILL =============",13,10,"$"
S_BLIT   DB " Item : $"
S_BLX    DB " Qty  : $"
S_BLEQ   DB " Line : BDT $"
S_BTOT   DB 13,10," Total          : BDT $"
S_BDIS   DB 13,10," Points Discount: BDT $"
S_BNET   DB 13,10," Net Payable    : BDT $"
S_BCASH  DB 13,10," Pay cash (5 digits x100): $"
S_BCHG   DB 13,10," Change         : BDT $"
S_BCERR  DB 13,10," Must be multiple of 100!",13,10,"$"
S_BCLOW  DB 13,10," Cash less than payable!",13,10,"$"
S_BPTE   DB 13,10," Points Earned  : $"
S_BPTT   DB 13,10," Points Balance : $"

S_HSTH   DB 13,10,"===== PURCHASE HISTORY =====",13,10,"$"
S_HSTME  DB " Member : $"
S_HSTAM  DB "  Amt   : BDT $"
S_HSTNE  DB 13,10," No history yet.",13,10,"$"
S_NMSF   DB 13,10," Non_Member_$"

; Item-line components (product name + qty + amount on one line):
S_BITX   DB " x$"                           
S_BIBDT  DB "   BDT $"                   
 
S_BSEP   DB 13,10," -----------------------------------",13,10,"$"
 
S_BPAID  DB 13,10," Paid            : BDT $" 
S_BDIS0  DB 13,10," Discount        :       0",13,10,"$" ; zero-discount line
S_BTHNK  DB 13,10," Thank you for shopping!",13,10,"$"


PROD_CNT DW 5
PROD_ID  DW 101,102,103,104,105,0,0,0,0,0
PROD_NM  DB "Rice      ",0,"Oil       ",0,"Sugar     ",0,"Salt      ",0,"Flour     ",0,"          ",0,"          ",0,"          ",0,"          ",0,"          ",0
PROD_PR  DW 100,150,100,50,200,0,0,0,0,0
PROD_ST  DW 50,30,40,100,20,0,0,0,0,0

MEM_CNT  DW 5
MEM_ID   DB "0171234567",0,"0181234567",0,"0191234567",0,"0155555555",0,"0166666666",0,"          ",0,"          ",0,"          ",0,"          ",0,"          ",0
MEM_NM   DB "Sadia       ",0,"Jakia         ",0,"Mun       ",0,"Takim       ",0,"Kader         ",0,"            ",0,"            ",0,"            ",0,"            ",0,"            ",0
MEM_PTS  DW 50,20,0,100,30,0,0,0,0,0

; Non-Member purchase history
NM_CNT   DW 0
NM_AMT   DW 0,0,0,0,0,0,0,0,0,0

; Member purchase history
HIST_CNT DW 0
HIST_MEM DW 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
HIST_AMT DW 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; Cart stack
CART_CNT DW 0
CART_PI  DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
CART_QY  DW 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; TMP_TOT running bill total
; TMP_VAR general scratch for digit macros
CUR_MEM  DW 255
TMP_NUM  DW 0
TMP_TOT  DW 0
TMP_VAR  DW 0
IN_BUF   DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0   
PH_BUF   DB 0,0,0,0,0,0,0,0,0,0,0,0       
ADM_PW   DW 1234

TMP_IDX  DW 0           ; temp index/value save across macro calls 
 
 
.CODE

; Pushes digits reversed onto stack, pops to print in order.

PROC_PRINT_NUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV  BX, 0              ; BX = digit counter
    CMP  AX, 0
    JNE  PPN_GO
    MOV  AH, 02h
    MOV  DL, 48             ; print '0' for zero value
    INT  21h
    JMP  PPN_EXIT
PPN_GO:
    MOV  CX, 10             ; divisor = 10
PPN_PUSH:
    CMP  AX, 0
    JE   PPN_POP
    MOV  DX, 0             
    DIV  CX                 
    ADD  DL, 48             
    PUSH DX                 ; push digit (reversed order)
    INC  BX
    JMP  PPN_PUSH
PPN_POP:
    CMP  BX, 0
    JE   PPN_EXIT
    POP  DX                 ; pop digit (now correct order)
    MOV  AH, 02h
    INT  21h
    DEC  BX
    JMP  PPN_POP
PPN_EXIT:
    POP  DX
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_PRINT_NUM ENDP


PROC_PUTS PROC NEAR
    PUSH AX
    PUSH DX
    PUSH SI
PUTS_LP:
    MOV  AL, [SI]
    CMP  AL, 0              ; stop at null terminator
    JE   PUTS_DN
    MOV  AH, 02h
    MOV  DL, AL
    INT  21h
    INC  SI
    JMP  PUTS_LP
PUTS_DN:
    POP  SI
    POP  DX
    POP  AX
    RET
PROC_PUTS ENDP


PROC_CMP10 PROC NEAR
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    MOV  CX, 10             ; compare 10 bytes (phone digits)
CMP10_LP:
    MOV  AL, [SI]
    MOV  BL, [DI]           ; BL used so AH stays clean
    CMP  AL, BL
    JNE  CMP10_NE           ; mismatch -> not equal
    INC  SI
    INC  DI
    LOOP CMP10_LP
    POP  DI
    POP  SI
    POP  CX
    POP  BX
    MOV  AX, 1              ; all 10 matched
    RET
CMP10_NE:
    POP  DI
    POP  SI
    POP  CX
    POP  BX
    MOV  AX, 0              ; mismatch found
    RET
PROC_CMP10 ENDP


PROC_READ_NAME PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI                 
    MOV  DI, 0              
    MOV  CX, 12
RDNM_LP:
    MOV  AH, 01h
    INT  21h
    MOV  BL, AL             
    CMP  BL, 13             ; Enter = end of name input
    JE   RDNM_DN
    MOV  IN_BUF[DI], BL    
    INC  DI                 
    LOOP RDNM_LP
RDNM_DN:
    MOV  IN_BUF[DI], 0     
    NEWLINE
    POP  DI                 
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_READ_NAME ENDP


PROC_READ_PNME PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI                 
    MOV  DI, 0              
    MOV  CX, 10
RDPN_LP:
    MOV  AH, 01h
    INT  21h
    MOV  BL, AL             
    CMP  BL, 13             ; Enter stops input
    JE   RDPN_PAD
    MOV  IN_BUF[DI], BL    
    INC  DI                 
    LOOP RDPN_LP
    JMP  RDPN_NUL
RDPN_PAD:
    CMP  DI, 10             
    JGE  RDPN_NUL
    MOV  IN_BUF[DI], 32    
    INC  DI                 
    JMP  RDPN_PAD
RDPN_NUL:
    MOV  IN_BUF[DI], 0     
    NEWLINE
    POP  DI                 
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_READ_PNME ENDP


PROC_READ_PHONE PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI                 
RPHON_RETRY:
    MOV  DI, 0             
    MOV  CX, 10             ; must collect exactly 10 digits
RPHON_LP:
    MOV  AH, 01h
    INT  21h
    MOV  BL, AL           
    CMP  BL, 13             ; Enter before 10 digits?
    JE   RPHON_CHK
    CMP  BL, 48             
    JB   RPHON_BAD
    CMP  BL, 57             
    JA   RPHON_BAD
    MOV  PH_BUF[DI], BL   
    INC  DI                 
    LOOP RPHON_LP
    MOV  AH, 01h            
    INT  21h
    JMP  RPHON_OK
RPHON_CHK:
    CMP  DI, 10             
    JE   RPHON_OK
RPHON_BAD:
    NEWLINE
    PRINT_STR S_INV         ; bad input -> retry whole phone
    JMP  RPHON_RETRY
RPHON_OK:
    MOV  PH_BUF[DI], 0     
    NEWLINE
    POP  DI                 
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_READ_PHONE ENDP


PROC_CPY_MEMID PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    MOV  BX, 0
    MOV  CX, 11
CPYID_LP:
    MOV  AL, PH_BUF[BX]
    MOV  MEM_ID[DI], AL
    CMP  AL, 0              
    JE   CPYID_DN
    INC  BX
    INC  DI
    LOOP CPYID_LP
CPYID_DN:
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_CPY_MEMID ENDP


PROC_CPY_MEMNM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    MOV  BX, 0
    MOV  CX, 13
CPYMN_LP:
    MOV  AL, IN_BUF[BX]
    MOV  MEM_NM[DI], AL
    CMP  AL, 0
    JE   CPYMN_DN
    INC  BX
    INC  DI
    LOOP CPYMN_LP
CPYMN_DN:
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_CPY_MEMNM ENDP


PROC_CPY_PRNM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    MOV  BX, 0
    MOV  CX, 11
CPYPN_LP:
    MOV  AL, IN_BUF[BX]
    MOV  PROD_NM[DI], AL
    CMP  AL, 0
    JE   CPYPN_DN
    INC  BX
    INC  DI
    LOOP CPYPN_LP
CPYPN_DN:
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_CPY_PRNM ENDP


PROC_FIND_PROD PROC NEAR
    PUSH BX
    PUSH CX
    PUSH SI
    MOV  CX, PROD_CNT
    CMP  CX, 0
    JE   FNDPR_FAIL
    MOV  BX, 0              ; BX = current index
FNDPR_LP:
    MOV  AX, BX
    ADD  AX, AX             ; word offset = index * 2
    MOV  SI, AX
    MOV  AX, PROD_ID[SI]    ; load ID from array
    MOV  DX, AX             ; DX = loaded ID (save before CMP)
    CMP  DX, TMP_NUM        ; compare saved value with target
    JE   FNDPR_OK
    INC  BX
    LOOP FNDPR_LP
FNDPR_FAIL:
    MOV  AX, 255            ; not found
    POP  SI
    POP  CX
    POP  BX
    RET
FNDPR_OK:
    MOV  AX, BX             ; return found index
    POP  SI
    POP  CX
    POP  BX
    RET
PROC_FIND_PROD ENDP


PROC_FIND_MEM PROC NEAR
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    MOV  CX, MEM_CNT
    CMP  CX, 0
    JE   FNDM_FAIL
    MOV  BX, 0              ; BX = current member slot index
FNDM_LP:
    PUSH BX
    PUSH CX
    MOV  AX, BX
    MOV  CX, 11
    MOV  DX, 0
    MUL  CX                 ; AX = BX * 11 
    LEA  SI, MEM_ID
    ADD  SI, AX             ; SI -> MEM_ID[BX*11]
    LEA  DI, PH_BUF         ; DI -> phone input to match against
    CALL PROC_CMP10         ; AX = 1 if matched, 0 if not
    MOV  TMP_VAR, AX        ; save match result to memory BEFORE POP
    POP  CX                 ; restore loop counter
    POP  BX                 ; restore slot index (BX now clean)
    MOV  AX, TMP_VAR        ; reload match result from memory
    CMP  AX, 1              ; was it a match?
    JNE  FNDM_NEXT
    MOV  AX, BX             ; yes: return member index in AX
    POP  DI
    POP  SI
    POP  CX
    POP  BX
    RET
FNDM_NEXT:
    INC  BX
    LOOP FNDM_LP
FNDM_FAIL:
    MOV  AX, 255            ; not found
    POP  DI
    POP  SI
    POP  CX
    POP  BX
    RET
PROC_FIND_MEM ENDP


PROC_SHOW_PROD PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    MOV  AX, PROD_CNT
    CMP  AX, 0
    JG   SHPR_OK
    PRINT_STR S_NOPRD
    POP  SI
    POP  CX
    POP  BX
    POP  AX
    RET
SHPR_OK:
    PRINT_STR S_PHDR
    MOV  BX, 0              ; BX = product index
    MOV  CX, PROD_CNT
SHPR_LP:
    PUSH BX
    PUSH CX
    ; -- ID --
    MOV  AX, BX
    ADD  AX, AX             ; word offset
    MOV  SI, AX
    MOV  AX, PROD_ID[SI]
    CALL PROC_PRINT_NUM
    PRINT_STR S_SEP
    ; -- Name --
    MOV  AX, BX
    MOV  CX, 11
    MOV  DX, 0
    MUL  CX                 ; byte offset = index * 11
    LEA  SI, PROD_NM
    ADD  SI, AX
    CALL PROC_PUTS
    PRINT_STR S_SEP
    POP  CX
    POP  BX
    PUSH BX
    PUSH CX
    ; -- Price --
    MOV  AX, BX
    ADD  AX, AX
    MOV  SI, AX
    MOV  AX, PROD_PR[SI]
    CALL PROC_PRINT_NUM
    PRINT_STR S_SEP
    ; -- Stock --
    MOV  AX, BX
    ADD  AX, AX
    MOV  SI, AX
    MOV  AX, PROD_ST[SI]
    MOV  TMP_VAR, AX        
    CALL PROC_PRINT_NUM
    PRINT_STR S_SEP         
                            ; reload stock from TMP_VAR (DX was clobbered by PRINT_STR above) --
    MOV  AX, TMP_VAR        
    CMP  AX, 0              
    JE   SHPR_OUT
    PRINT_STR S_INST        ; stock > 0
    JMP  SHPR_NL
SHPR_OUT:
    PRINT_STR S_OUTST       ; stock = 0
SHPR_NL:
    NEWLINE
    POP  CX
    POP  BX
    INC  BX
    LOOP SHPR_LP
    POP  SI
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_SHOW_PROD ENDP


; FEATURE -- PROC_REGISTER
; Read name (Enter) + 10-digit phone (auto). Duplicate check.
; Store in member arrays. Init points=0.

PROC_REGISTER PROC NEAR
    PUSH AX
    PUSH BX
    PUSH DI
    MOV  AX, MEM_CNT
    CMP  AX, 10
    JL   RG_SPACE
    PRINT_STR S_RGFL        ; list full
    POP  DI
    POP  BX
    POP  AX
    RET
RG_SPACE:
    PRINT_STR S_RGNM
    CALL PROC_READ_NAME     
    PRINT_STR S_RGPH
    CALL PROC_READ_PHONE    
    CALL PROC_FIND_MEM      ; check duplicate
    MOV  BX, AX             ; save result in BX before CMP
    CMP  BX, 255
    JE   RG_NEW             
    PRINT_STR S_RGDP        ; duplicate phone found
    POP  DI
    POP  BX
    POP  AX
    RET
RG_NEW:
    ; store phone 
    MOV  AX, MEM_CNT
    MOV  CX, 11
    MOV  DX, 0
    MUL  CX
    MOV  DI, AX
    CALL PROC_CPY_MEMID
    ; store name 
    MOV  AX, MEM_CNT
    MOV  CX, 13
    MOV  DX, 0
    MUL  CX
    MOV  DI, AX
    CALL PROC_CPY_MEMNM

    MOV  AX, MEM_CNT
    ADD  AX, AX
    MOV  SI, AX
    MOV  MEM_PTS[SI], 0
    INC  MEM_CNT
    PRINT_STR S_RGOK
    POP  DI
    POP  BX
    POP  AX
    RET
PROC_REGISTER ENDP

; FEATURE -- PROC_MEM_LOGIN

PROC_MEM_LOGIN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH SI
    PRINT_STR S_LGPH
    CALL PROC_READ_PHONE    
    CALL PROC_FIND_MEM      
    MOV  BX, AX             ; save result in BX immediately
    CMP  BX, 255
    JNE  MLOG_FOUND
    PRINT_STR S_LGNO        ; not found
    POP  SI
    POP  BX
    POP  AX
    RET
MLOG_FOUND:
    MOV  CUR_MEM, BX        ; save session member index
    PRINT_STR S_LGOK
    MOV  AX, BX
    MOV  CX, 13
    MOV  DX, 0
    MUL  CX                 ; AX = BX * 13
    LEA  SI, MEM_NM
    ADD  SI, AX
    CALL PROC_PUTS
    NEWLINE
    PRINT_STR S_PTSH
    MOV  AX, BX
    ADD  AX, AX             ; AX = BX * 2
    MOV  SI, AX
    MOV  AX, MEM_PTS[SI]
    CALL PROC_PRINT_NUM
    NEWLINE
    CALL PROC_SHOPPING
    POP  SI
    POP  BX
    POP  AX
    RET
PROC_MEM_LOGIN ENDP

; FEATURE -- PROC_ADMIN


PROC_ADMIN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH SI
    PRINT_STR S_ADPW
    FOUR_DIG_IN TMP_VAR     ; read 4 digits 
    NEWLINE
    MOV  AX, TMP_VAR
    MOV  BX, AX             ; save in BX before CMP
    CMP  BX, ADM_PW         ; compare with stored password word
    JE   ADM_MENU
    PRINT_STR S_ADPWE       ; wrong password
    POP  SI
    POP  BX
    POP  AX
    RET

ADM_MENU:
    PRINT_STR S_ADMNU
    ONE_KEY                 ; BL = key pressed (saved inside macro)
    NEWLINE
    CMP  BL, 49             ; '1' = update stock
    JE   ADM_UPD
    CMP  BL, 50             ; '2' = add product
    JE   ADM_ADD
    CMP  BL, 51             ; '3' = view history
    JE   ADM_HIST
    CMP  BL, 52             ; '4' = back to main menu
    JE   ADM_BACK
    PRINT_STR S_INV
    JMP  ADM_MENU

ADM_BACK:
    POP  SI
    POP  BX
    POP  AX
    RET

; Update Stock
ADM_UPD:
    CALL PROC_SHOW_PROD
    PRINT_STR S_ADPID
    THREE_DIG_IN TMP_NUM    ; 3-digit ID 
    NEWLINE
    CALL PROC_FIND_PROD     ; AX = product index or 255
    MOV  BX, AX             ; BX = product index
    CMP  BX, 255
    JNE  ADUPD_OK
    PRINT_STR S_ADER        ; not found
    JMP  ADM_MENU
ADUPD_OK:
    ; TWO_DIG_IN 
    MOV  TMP_IDX, BX        
 
    PRINT_STR S_ADQTY
    TWO_DIG_IN TMP_VAR      ; 2-digit new stock -> TMP_VAR  (BX corrupted here)
    NEWLINE
 
    MOV  BX, TMP_IDX        
 
    MOV  AX, BX             
    ADD  AX, AX             ; word offset = index * 2
    MOV  SI, AX             
    MOV  AX, TMP_VAR
    MOV  PROD_ST[SI], AX   
    PRINT_STR S_ADOK
    JMP  ADM_MENU

; Add New Product
ADM_ADD:
    MOV  AX, PROD_CNT
    MOV  BX, AX             ; save count in BX before CMP
    CMP  BX, 10
    JL   ADADD_SP
    PRINT_STR S_ADFL        ; list full
    JMP  ADM_MENU
ADADD_SP:
    PRINT_STR S_ADPID
    THREE_DIG_IN TMP_NUM    ; 3-digit product ID -> TMP_NUM
    NEWLINE
    MOV  AX, TMP_NUM
    MOV  BX, AX             ; BX = ID for range check
    CMP  BX, 100
    JL   ADADD_BADI
    CMP  BX, 999
    JG   ADADD_BADI
    CALL PROC_FIND_PROD     ; check duplicate
    MOV  BX, AX             ; save result in BX
    CMP  BX, 255
    JE   ADADD_NEWID        
ADADD_BADI:
    PRINT_STR S_ADIDE
    JMP  ADM_MENU
ADADD_NEWID:
    ; store ID
    MOV  AX, PROD_CNT
    ADD  AX, AX
    MOV  SI, AX
    MOV  AX, TMP_NUM
    MOV  PROD_ID[SI], AX
    ; read and store name
    PRINT_STR S_ADPNM
    CALL PROC_READ_PNME     
    MOV  AX, PROD_CNT
    MOV  CX, 11
    MOV  DX, 0
    MUL  CX                 ; byte offset = PROD_CNT * 11
    MOV  DI, AX
    CALL PROC_CPY_PRNM

; Price validation
ADPR_RETRY:
    PRINT_STR S_ADPPR
    FIVE_DIG_IN TMP_VAR     ; 5-digit price 
    NEWLINE
    MOV  AX, TMP_VAR
    MOV  BX, AX             
    MOV  DX, 0              ; clear DX before DIV
    MOV  CX, 5
    DIV  CX                 ; DX = price mod 50
    CMP  DX, 0
    JNE  ADPR_BAD           ; remainder != 0 -> not multiple of 50
    MOV  AX, PROD_CNT
    ADD  AX, AX
    MOV  SI, AX
    MOV  PROD_PR[SI], BX   ; store original price (BX saved it)
    JMP  ADPR_DONE
ADPR_BAD:
    PRINT_STR S_ADPER
    JMP  ADPR_RETRY
ADPR_DONE:
    ; stock
    PRINT_STR S_ADQTY
    TWO_DIG_IN TMP_VAR      ; 2-digit stock 
    NEWLINE
    MOV  AX, PROD_CNT
    ADD  AX, AX
    MOV  SI, AX
    MOV  AX, TMP_VAR
    MOV  PROD_ST[SI], AX
    INC  PROD_CNT
    PRINT_STR S_ADOK
    JMP  ADM_MENU

; History
ADM_HIST:
    PRINT_STR S_HSTH
    MOV  CX, HIST_CNT
    CMP  CX, 0
    JG   ADHST_LP
    JMP  ADHST_NM           ; no member history, check non-member
ADHST_LP:
    PUSH CX
    MOV  AX, HIST_CNT
    SUB  AX, CX             ; forward index i
    ADD  AX, AX             ; word offset
    MOV  SI, AX
    PRINT_STR S_HSTME
    MOV  AX, HIST_MEM[SI]  ; member index stored at slot i
    MOV  BX, AX             
    PUSH SI                 ; save history offset
    MOV  AX, BX
    MOV  CX, 11
    MOV  DX, 0
    MUL  CX                 ; AX = member index * 11 (phone offset)
    LEA  SI, MEM_ID
    ADD  SI, AX
    CALL PROC_PUTS           ; print member phone
    POP  SI                 ; restore history offset
    NEWLINE
    PRINT_STR S_HSTAM
    MOV  AX, HIST_AMT[SI]
    CALL PROC_PRINT_NUM
    NEWLINE
    POP  CX
    LOOP ADHST_LP
ADHST_NM:
    MOV  CX, NM_CNT
    CMP  CX, 0
    JG   ADNM_LP
    CMP  HIST_CNT, 0
    JG   ADHST_DONE
    PRINT_STR S_HSTNE       ; nothing recorded at all
    JMP  ADHST_DONE
ADNM_LP:
    PUSH CX
    MOV  AX, NM_CNT
    SUB  AX, CX             ; forward index i
    MOV  BX, AX             ; BX = index (save before ADD)
    ADD  AX, AX             ; word offset
    MOV  SI, AX
    PRINT_STR S_NMSF        ; "Non_Member_"
    MOV  AX, BX
    INC  AX                 ; 1-based serial number
    CALL PROC_PRINT_NUM
    NEWLINE
    PRINT_STR S_HSTAM
    MOV  AX, NM_AMT[SI]
    CALL PROC_PRINT_NUM
    NEWLINE
    POP  CX
    LOOP ADNM_LP
ADHST_DONE:
    POP  SI
    POP  BX
    POP  AX
    RET
PROC_ADMIN ENDP

; Cart is a stack: CART_PI (byte) + CART_QY (word) per slot.

PROC_SHOPPING PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
 
    MOV  CART_CNT, 0        ; reset stack top (clear cart)
    CALL PROC_SHOW_PROD     ; display product table first
 
SCAN_LP:
    PRINT_STR S_SCAN
    THREE_DIG_IN TMP_NUM    ; read 3 digits 
    NEWLINE
    MOV  AX, TMP_NUM
    MOV  BX, AX             ; BX = scanned ID (save before CMP)
    CMP  BX, 0              ; 000 entered -> stop scanning
    JE   SCAN_DONE
 
    CALL PROC_FIND_PROD     ; search PROD_ID[] 
    MOV  BX, AX             
    CMP  BX, 255
    JNE  SCAN_FOUND
    PRINT_STR S_NF          ; product ID not found
    JMP  SCAN_LP
 
SCAN_FOUND:
    MOV  AX, BX
    ADD  AX, AX             ; word offset = index * 2
    MOV  SI, AX
    MOV  DX, PROD_ST[SI]   ; DX = current stock
 
    CMP  DX, 0
    JG   SCAN_HAS_STK
    PRINT_STR S_NOSTK       ; stock is zero -> out of stock
    JMP  SCAN_LP
 
SCAN_HAS_STK:
    
    MOV  TMP_IDX, DX        
 
    ; TWO_DIG_IN 
    MOV  TMP_NUM, BX        
 
    PRINT_STR S_QTY         
    TWO_DIG_IN TMP_VAR      ; read 2-digit qty 
    NEWLINE
 
    
    MOV  BX, TMP_NUM        
 
    MOV  AX, TMP_VAR
    MOV  CX, AX             ; CX = requested qty
    CMP  CX, 0
    JE   SCAN_LP            ; qty = 0 -> ignore
 
    
    MOV  AX, TMP_IDX        
    CMP  CX, AX             
    JA   SCAN_INSUF         ; qty > stock -> refuse
 
    MOV  AX, CART_CNT
    MOV  DX, AX             ; DX = cart count (save before CMP)
    CMP  DX, 15             ; cart full?
    JGE  SCAN_LP
 
    ;  STACK PUSH: store product index byte and qty word 

    MOV  SI, CART_CNT
    MOV  CART_PI[SI], BL   
 
    MOV  AX, CART_CNT
    ADD  AX, AX             ; word offset into CART_QY
    MOV  SI, AX
    MOV  CART_QY[SI], CX   ; store qty at this slot
 
    INC  CART_CNT           ; advance stack top
 
    ; Deduct qty from live stock: PROD_ST[BX*2] -= CX

    MOV  AX, BX            
    ADD  AX, AX
    MOV  SI, AX
    MOV  AX, PROD_ST[SI]
    SUB  AX, CX
    MOV  PROD_ST[SI], AX   
 
    PRINT_STR S_ADDED
    JMP  SCAN_LP
 
SCAN_INSUF:
    PRINT_STR S_NOSTK       ; requested qty exceeds available stock
    JMP  SCAN_LP
 
SCAN_DONE:
    MOV  AX, CART_CNT
    MOV  BX, AX             ; BX = cart count (save before CMP)
    CMP  BX, 0
    JG   SCAN_BILL
    PRINT_STR S_EMPT        ; cart still empty after scanning
    POP  SI
    POP  DX
    POP  CX
    POP  BX
    POP  AX
    RET
 
SCAN_BILL:
    CALL PROC_BILL          ; generate bill for filled cart
    POP  SI
    POP  DX
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_SHOPPING ENDP

; FEATURE -- PROC_BILL

PROC_BILL PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
 
    PRINT_STR S_BILLH           ; "============= BILL ============="
    MOV  TMP_TOT, 0             ; reset grand total accumulator
    MOV  BX, 0
    MOV  CX, CART_CNT           ; CX = number of cart items (loop counter)
 
; BILL ITEM LOOP: one line per cart item  " Name  xQty   BDT amount"

BILL_LP:
    PUSH CX
    PUSH BX
 
    ; get product index from CART_PI[BX]
    MOV  SI, BX
    MOV  AL, CART_PI[SI]       ; AL = product index byte (0-9)
    MOV  AH, 0                 ; zero-extend to word
    MOV  DX, AX                ; DX = product index (save before MUL)
 
    ;print product name: PROD_NM[DX * 11]
    
    MOV  AX, DX                ; AX = product index
    MOV  CX, 11
    MOV  DX, 0                 ; clear DX before MUL
    MUL  CX                    ; AX = index * 11 (byte offset into PROD_NM)
    LEA  SI, PROD_NM
    ADD  SI, AX
    CALL PROC_PUTS             
 
    POP  BX                    ; BX = cart slot index
    PUSH BX
    MOV  SI, BX
    MOV  AL, CART_PI[SI]      ; reload product index byte
    MOV  AH, 0
    MOV  DX, AX                ; DX = product index (fresh save)
 
    ; get price: PROD_PR[DX * 2]
    MOV  AX, DX
    ADD  AX, AX                ; word offset = index * 2
    MOV  SI, AX
    MOV  CX, PROD_PR[SI]      ; CX = unit price (preserved through qty section below)
 
    ;get qty: CART_QY[BX * 2]
    MOV  AX, BX
    ADD  AX, AX                ; word offset = slot * 2
    MOV  SI, AX
    MOV  AX, CART_QY[SI]      ; AX = quantity
    MOV  TMP_VAR, AX           ; save qty to TMP_VAR before PRINT_STR corrupts DX and AX
 
    PRINT_STR S_BITX           
    MOV  AX, TMP_VAR           
    CALL PROC_PRINT_NUM        
 
    MOV  AX, CX                ; AX = price  
    MOV  CX, TMP_VAR           ; CX = qty    )
    MOV  DX, 0                 
    MUL  CX                    ; AX = price * qty 
    MOV  TMP_VAR, AX           
 
    PRINT_STR S_BIBDT          ; "   BDT "  (amount prefix)
    MOV  AX, TMP_VAR           
    CALL PROC_PRINT_NUM        
 
    ADD  TMP_TOT, AX           
    NEWLINE                    
 
    POP  BX
    POP  CX
    INC  BX                    ; next cart slot
    LOOP BILL_LP
 

    PRINT_STR S_BSEP           ; "-----------------------------------"
 
    ; Total
    PRINT_STR S_BTOT           ; " Total          : BDT "
    MOV  AX, TMP_TOT           ; AX loaded AFTER PRINT_STR -- no corruption
    CALL PROC_PRINT_NUM
    NEWLINE
 
    ; Points discount (members only)
    MOV  AX, CUR_MEM
    MOV  BX, AX                ; BX = CUR_MEM (save before CMP)
    CMP  BX, 255
    JE   BILL_NO_PTS           ; guest -> show 0 discount, skip prompt
 
    MOV  AX, BX
    ADD  AX, AX                ; word offset = member index * 2
    MOV  SI, AX
    MOV  AX, MEM_PTS[SI]      ; AX = available points
    MOV  DX, AX                ; DX = points (save before CMP)
    CMP  DX, 0
    JE   BILL_NO_PTS           ; no points -> show 0 discount
 
    PRINT_STR S_PTUSE          ; "Use points? Available: "
                               
    MOV  AX, BX
    ADD  AX, AX             ; AX = BX * 2
    MOV  SI, AX
    MOV  AX, MEM_PTS[SI]
    CALL PROC_PRINT_NUM
    ; show available points count 
    PRINT_STR S_PTSH
    PRINT_STR S_PTYN           ; "y=yes, other=skip: "
    ONE_KEY                    ; BL = key pressed
    NEWLINE
    CMP  BL, 89                ; 'Y'
    JE   BILL_USE_PTS
    CMP  BL, 121               ; 'y'
    JE   BILL_USE_PTS
    JMP  BILL_NO_PTS
 
BILL_USE_PTS:
   
    MOV  AX, MEM_PTS[SI]      ; reload points fresh from array
   
    MOV  TMP_IDX, AX           ; save points to memory 
 
    PRINT_STR S_BDIS           ; " Discount        : BDT "
    MOV  AX, TMP_IDX           ; reload points (DX = string address, unusable)
    CALL PROC_PRINT_NUM        ; print discount amount
    NEWLINE
    ; Use TMP_IDX for comparison and subtraction
    MOV  AX, TMP_IDX           ; reload points for comparison
    CMP  TMP_TOT, AX           ; total >= points?
    JGE  BILL_SUB_OK
    MOV  TMP_TOT, 0            
    JMP  BILL_ZERO_PTS
BILL_SUB_OK:
    MOV  AX, TMP_IDX           
    SUB  TMP_TOT, AX           
BILL_ZERO_PTS:
    MOV  MEM_PTS[SI], 0        ; clear used points from member balance
    JMP  BILL_PAYABLE
 
BILL_NO_PTS:
    ; Guest, or non- member  show discount = 0
    PRINT_STR S_BDIS0          ; " Discount        :              0"
 
BILL_PAYABLE:
    PRINT_STR S_BSEP           ; "-----------------------------------"
 
    ; Net payable
    PRINT_STR S_BNET           ; " Net Payable     : BDT "
    MOV  AX, TMP_TOT           ; AX loaded AFTER PRINT_STR -- no corruption
    CALL PROC_PRINT_NUM
    NEWLINE
 

; CASH PAYMENT: must be multiple of 100 and >= payable

PAY_LP:
    PRINT_STR S_BCASH          ; "Pay cash (5 digits x100): "
    FIVE_DIG_IN TMP_VAR        ; read 5 digits -> TMP_VAR (no Enter)
    NEWLINE
    MOV  AX, TMP_VAR
    MOV  BX, AX                ; BX = cash entered (save original)
    MOV  DX, 0                 ; clear DX before DIV
    MOV  CX, 100
    DIV  CX                    ; DX = cash mod 100
    CMP  DX, 0
    JNE  PAY_BADM              ; not multiple of 100
    MOV  AX, TMP_TOT
    MOV  CX, AX                ; CX = net payable (save before CMP)
    CMP  BX, CX                ; cash >= payable?
    JL   PAY_LOW
 
    SUB  BX, CX                ; BX = change = cash - payable
 
    PRINT_STR S_BPAID          ; " Paid            : BDT "
    MOV  AX, TMP_VAR           
    CALL PROC_PRINT_NUM        ; print cash paid
    NEWLINE
 
    PRINT_STR S_BCHG           ; " Change          : BDT "
    MOV  AX, BX                ; AX = change (loaded AFTER PRINT_STR -- OK)
    CALL PROC_PRINT_NUM        ; print change
    NEWLINE
    JMP  PAY_DONE
 
PAY_BADM:
    PRINT_STR S_BCERR          ; "Must be multiple of 100!"
    JMP  PAY_LP
PAY_LOW:
    PRINT_STR S_BCLOW          ; "Cash less than payable!"
    JMP  PAY_LP
 
PAY_DONE:
    PRINT_STR S_BSEP           ; "-----------------------------------"
 
; points earned = net payable // 100

    MOV  AX, CUR_MEM
    MOV  BX, AX                ; BX = CUR_MEM 
    CMP  BX, 255
    JE   BILL_NO_AWD           ; guest -> skip points, go to thank-you
 
    MOV  AX, TMP_TOT           ; AX = net payable 
    MOV  DX, 0                 ; clear DX before DIV
    MOV  CX, 100
    DIV  CX                    ; AX = earned = net // 100
    MOV  CX, AX                ; CX = earned points 
 
    PRINT_STR S_BPTE           ; " Points Earned   : "
    MOV  AX, CX                ; reload earned 
    CALL PROC_PRINT_NUM        ; print points earned
    NEWLINE
 
    MOV  AX, BX                ; AX = member index
    ADD  AX, AX                ; word offset
    MOV  SI, AX
    MOV  AX, MEM_PTS[SI]      ; AX = current points balance
    ADD  AX, CX                ; new balance = old balance + earned
    MOV  MEM_PTS[SI], AX       ; write updated balance back
    MOV  TMP_IDX, AX           ; save new balance before PRINT_STR corrupts AX
 
    PRINT_STR S_BPTT           ; " Total Points    : "
    MOV  AX, TMP_IDX           ; reload new balance (PRINT_STR corrupted AX)
    CALL PROC_PRINT_NUM        ; print total points balance
    NEWLINE
 
    PRINT_STR S_BSEP           ; "-----------------------------------"
 
BILL_NO_AWD:
    PRINT_STR S_BTHNK          ; " Thank you for shopping!"
 
; SAVE TO HISTORY ARRAYS

    MOV  AX, CUR_MEM
    MOV  BX, AX                ; BX = CUR_MEM
    CMP  BX, 255
    JE   SAVE_NM               ; guest path
 
    MOV  AX, HIST_CNT
    MOV  DX, AX                ; DX = HIST_CNT 
    CMP  DX, 20
    JGE  HIST_SKIP             ; array full
    MOV  AX, DX
    ADD  AX, AX                ; word offset = HIST_CNT * 2
    MOV  SI, AX
    MOV  HIST_MEM[SI], BX     ; store member index
    MOV  AX, TMP_TOT
    MOV  HIST_AMT[SI], AX     ; store bill net amount
    INC  HIST_CNT
    JMP  HIST_SKIP
 
SAVE_NM:
    MOV  AX, NM_CNT
    MOV  DX, AX                
    CMP  DX, 10
    JGE  HIST_SKIP             ; array full
    MOV  AX, DX
    ADD  AX, AX                ; word offset = NM_CNT * 2
    MOV  SI, AX
    MOV  AX, TMP_TOT
    MOV  NM_AMT[SI], AX       ; store non-member net amount
    INC  NM_CNT
 
HIST_SKIP:

; SHOW MEMBER'S OWN HISTORY 

    MOV  AX, CUR_MEM
    MOV  BX, AX                ; BX = CUR_MEM
    CMP  BX, 255
    JE   BILL_FINAL            ; guest -> skip
    CALL PROC_MEM_HIST
 
BILL_FINAL:
    PRINT_STR S_PRESS          ; "Press any key..."
    ONE_KEY                    ; BL = any key
    NEWLINE
 
    POP  SI
    POP  DX
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_BILL ENDP

; FEATURE -- PROC_MEM_HIST

PROC_MEM_HIST PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI

    PRINT_STR S_HSTH
    MOV  CX, HIST_CNT
    CMP  CX, 0
    JG   MHST_LP
    PRINT_STR S_HSTNE      ; no history entries at all
    POP  SI
    POP  CX
    POP  BX
    POP  AX
    RET

MHST_LP:
    PUSH CX
    MOV  AX, HIST_CNT
    SUB  AX, CX            ; forward index i = HIST_CNT - CX
    ADD  AX, AX            ; word offset
    MOV  SI, AX
    MOV  AX, HIST_MEM[SI] ; member index stored at slot i
    MOV  BX, AX            ; BX = stored member index 
    CMP  BX, CUR_MEM       ; does this slot belong to current member?
    JNE  MHST_SKIP
    PRINT_STR S_HSTAM
    MOV  AX, HIST_AMT[SI] ; AX loaded AFTER PRINT_STR -- no bug here
    CALL PROC_PRINT_NUM    ; print this bill amount
    NEWLINE
MHST_SKIP:
    POP  CX
    LOOP MHST_LP

    POP  SI
    POP  CX
    POP  BX
    POP  AX
    RET
PROC_MEM_HIST ENDP

; MAIN ENTRY POINT


MAIN PROC
    MOV  AX, @DATA
    MOV  DS, AX            ; initialize data segment

MAIN_LOOP:
    PRINT_STR S_TITLE      ; banner
    PRINT_STR S_MAIN       ; menu
    ONE_KEY                ; BL = key pressed (saved inside ONE_KEY macro)
    NEWLINE

    CMP  BL, 49            ; '1' = Member Login
    JE   GO_ML
    CMP  BL, 50            ; '2' = Register Member
    JE   GO_RG
    CMP  BL, 51            ; '3' = Non-Member Shopping
    JE   GO_NM
    CMP  BL, 52            ; '4' = Admin Login
    JE   GO_AD
    CMP  BL, 53            ; '5' = Exit
    JE   GO_EX
    PRINT_STR S_INV        ; invalid key
    JMP  MAIN_LOOP

GO_ML:
    CALL PROC_MEM_LOGIN    ; member login session
    JMP  MAIN_LOOP

GO_RG:
    CALL PROC_REGISTER     ; register new member
    JMP  MAIN_LOOP

GO_NM:
    MOV  CUR_MEM, 255      ; flag as guest/non-member
    CALL PROC_SHOPPING     ; shopping without login
    JMP  MAIN_LOOP

GO_AD:
    CALL PROC_ADMIN        ; admin login + admin panel
    JMP  MAIN_LOOP

GO_EX:
    PRINT_STR S_BYE
    MOV  AX, 4C00h
    INT  21h               ; exit to DOS

MAIN ENDP
END MAIN