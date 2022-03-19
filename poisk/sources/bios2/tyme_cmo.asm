;------------------------------------------------------------------
;	 THIS ROUTINE INITIALIZES THE TIMER DATA AREA IN THE
;	 ROM BIOS DATA AREA. IT IS CALLED BY THE POWER ON ROUTINES.
;	 IT CONVERTS HR:MIN:SEC FROM CMOS TO TIMER TICS.
;	 IF CMOS IS INVALID, TIMER DATA IS SET TO ZERO
; INPUT  NONE PASSED TO ROUTINE BY CALLER
; CMOS BYTES USED FOR SETUP
;	 00 SECONDS
;	 02 MINUTES
;	 04 HOURS
;	 0A REGISTER A (UPDATE IN PROGRESS)
;	 0E CMOS VALID IF ZERO
; OUTPUT
;	 TIMER_LOW
;	 TIMER_HIGH
;	 TIMER_OFL
;	 ALL REGISTERS UNCHANGED
;-----------------------------------------------------------------------
	org	0f8ceh
COUNTS_SEC	EQU	18
COUNTS_MIN	EQU	1092
COUNTS_HOUR	EQU	7
CMOS_ADR	EQU	70H
CMOS_DATA	EQU	71H
CMOS_VALID	EQU	0EH
CMOS_SECONDS	EQU	00H
CMOS_MINUTES	EQU	02H
CMOS_HOURS	EQU	04H
CMOS_REGA	EQU	0AH
UPDATE_TIMER	EQU	80H

SET_TOD  PROC  NEAR
  PUSH	 AX
  PUSH	 BX
  PUSH	 CX
  PUSH	 DX
ASSUME	 DS:DATA
  MOV	 AX,DATA		;ESTABLISH SEGMENT
  MOV	 DS,AX
  SUB	 AX,AX
  MOV	 TIMER_OFL,AL		;RESET TIMER ROLL OVER INDICATOR
  MOV	 TIMER_LOW,AX		; AND TIMER COUNT
  MOV	 TIMER_HIGH,AX
  MOV	 AL,CMOS_VALID
  OUT	 CMOS_ADR,AL		;CHECK CMOS VALIDITY
  IN	 AL,CMOS_DATA
  AND	 AL,0C4H		;BAD BATTERY, CHKSUM ERROR OR CLOCK ERROR
  SUB	 CX,CX
tUIP:
  MOV	 AL,CMOS_REGA
  OUT	 CMOS_ADR,AL		;ACCESS REGISTER A
  IN	 AL,CMOS_DATA
  TEST	 AL,UPDATE_TIMER
  JZ	 READ_SEC
  LOOP	 tUIP
  JMP    short I_POD_DONE
READ_SEC:
  MOV	 AL,CMOS_SECONDS
  OUT	 CMOS_ADR,AL		;ACCESS SECONDS VALUE IN CMOS
  IN	 AL,CMOS_DATA
  CMP	 AL,59H 		;ARE THE SECONDS WITHIN LIMITS?
  JA	 TOD_ERROR		;GO IF NOT
  CALL	 CVT_BINARY		;CONVERT IT TO BINARY
  MOV	 BL,COUNTS_SEC
  MUL	 BL			;COUNT FOR SECONDS
  MOV	 CX,AX
  MOV	 AL,CMOS_MINUTES
  OUT	 CMOS_ADR,AL		;ACCESS MINUTES VALUE IN CMOS
  IN	 AL,CMOS_DATA
  CMP	 AL,59H 		;ARE THE MINUTES WITHIN LIMITS?
  JA	 TOD_ERROR		;GO IF NOT
  CALL	 CVT_BINARY		;CONVERT IT TO BINARY
  MOV	 BX,COUNTS_MIN
  MUL	 BX			;COUNT FOR MINUTES
  ADD	 AX,CX
  MOV	 CX,AX
  MOV	 AL,CMOS_HOURS
  OUT	 CMOS_ADR,AL		;ACCESS HOURS VALUE IN CMOS
  IN	 AL,CMOS_DATA
  CMP	 AL,23H 		;ARE THE HOURS WITHIN LIMITS?
  JA	 TOD_ERROR		;GO IF NOT
  CALL	 CVT_BINARY		;CONVERT IT TO BINARY
  MOV	 DX,AX
  MOV	 BL,COUNTS_HOUR
  MUL	 BL			;COUNT FOR HOURS
  ADD	 AX,CX
  ADC	 DX,0000H
  MOV	 TIMER_HIGH,DX
  MOV	 TIMER_LOW,AX
I_POD_DONE:
  CLI				;**IO DELAY NOT REQUIRED**
  IN	 AL,021H		;BE SURE TIMER IS ENABLED
  AND	 AL,0FEH
  OUT	 021H,AL
  STI
TOD_ERROR:
  POP	 DX
  POP	 CX
  POP    BX
  POP    AX
  RET
SET_TOD  ENDP

CVT_BINARY  PROC  NEAR
  MOV	 AH,AL			;UNPACK 2 BCD DIGITS IN AL
  SHR	 AH,1
  SHR	 AH,1
  SHR	 AH,1
  SHR	 AH,1
  AND	 AL,0FH 		;RESULT IS IN AX
  AAD				;CONVERT UNPACKED BCD TO BINARY
  RET
CVT_BINARY  ENDP

;-------------------------------------------------------------------
;    INT 4A
;       ALARM CMOS
;       , 
;       
;  INT 4A      
;-------------------------------------------------------------------
ALARM	PROC	NEAR
	PUSH	BX
	PUSH	CX
	PUSH	AX
	MOV	CX,5
HJ_1N:	MOV	BX,100fH
	PUSH	CX
	CALL	BEEPER
	mov	cx,1
	call	pauza
	POP	CX
	dec	CX
	JNZ	HJ_1N
	POP	AX
	POP	CX
	POP	BX
	IRET
ALARM	ENDP


;-------INT 70 (LEVEL 8)--------------------------------------------
;	THIS ROUTINE HANDLES THE PERIODIC AND ALARM INTERRUPTS FROM
;	THE NON-VOLATILE TIMER. INPUT FREQUENCY IS 1024 KHZ OR
;	APPROXIMATELY 1024 INTERRUPTS EVERY SECOND FOR THE PERIODIC
;	INTERRUPT. FOR THE ALARM FUNCTION, AN INTERRUPT WILL OCCUR
;	AT THE DESIGNATED TIME.
;
;	THE INTERRUPT IS ENABLED ONLY WHEN EVENT OR ALARM FUNCTIONS
;	ARE ACTIVE.
;	FOR THE EVENT INTERRUPT, THE HANDLER WILL DECREMENT THE WAIT
;	COUNTER AND WHEN IT EXPIRES WILL TURN ON THE HIGH ORDER BIT
;	OF THE DESIGNATED FLAG.
;	FOR THE ALARM INTERRUPT, THE USER ROUTINE WILL BE INVOKED
;	THROUGH INT 4AH. THE USER MUST CODE A ROUTINE AND PLACE THE
;	CORRECT ADDRESS IN THE VECTOR TABLE.
;-------------------------------------------------------------------
RTC_INT  PROC  FAR
;	assume	cs:code,ds:data
  STI				;INTERRUPTS BACK ON
  PUSH	 DS			;SAVE REGISTERS
  PUSH	 AX
  PUSH	 DX
  PUSH	 DI
  MOV	 DL,0AH 		;GET ENABLES
  CALL	 PORT_INC
  IN	 AL,CMOS_PORT+1
  MOV	 AH,AL			;SAVE
  CALL	 PORT_INC		;GET SOURCE
  IN	 AL,CMOS_PORT+1
  AND	 AL,AH
  PUSH	 AX			;SAVE
  TEST	 AL,40H 		;CHECK FOR PERIODIC INTERRUPT
  JZ	 RTC_INT_9		;NO - GO AROUND
  CALL	 DDS			;ESTABLISH ADDRESSABILITY
  SUB	 RTC_LOW,0976		;DECREMENT COUNT
  SBB	 RTC_HIGH,0
  JA	 RTC_INT_9
  MOV	 DL,0AH 		;TURN OFF PIE
  CALL	 PORT_INC
  IN	 AL,CMOS_PORT+1
  AND	 AL,0BFH
  PUSH	 AX
  MOV	 DL,0AH
  CALL	 PORT_INC
  POP	 AX
  OUT	 CMOS_PORT+1,AL
  MOV	 RTC_WAIT_FLAG,0	;SET FUNCTION ACTIVE FLAG OFF
  LDS	 DI,DWORD PTR USER_FLAG ;SET UP DS,DI TO POINT TO USER FLAG
  MOV	 BYTE PTR[DI],80H	;TURN ON USERS FLAG
RTC_INT_9:
  POP	 AX			;GET INTERRUPT SOURCE BACK
  TEST	 AL,20H 		;TEST FOR ALARM INTERRUPT
  JZ	 RTC_INT_10		;NO - GO AROUND
  INT	 4AH			;TRANSFER TO USER ROUTINE
RTC_INT_10:
  MOV	 AL,EOI 		;END OF INTERRUPT TO 8259 - 2
  OUT	 020H,AL		;AND TO 8259 - 1
  POP	 DI			;RESTORE REGISTERS
  POP	 DX
  POP	 AX
  POP	 DS
  IRET				;END OF INTERRUPT
RTC_INT  ENDP


SET_BAYT_DEV PROC NEAR	
;--ãáâ ­ŪĒŠ  Ą Đâ  ŪĄŪāãĪŪĒ ­Ļï
	XOR	BL,BL
	MOV	AL,10H
	OUT	70H,AL
	IN	AL,71H
	TEST	AL,0FFH
	JZ	KLOP_3
	dec	bl
	TEST	AL,0FH
	JZ	KLOP_1
	INC	BL
KLOP_1:	TEST	AL,0F0H
	JZ	KLOP_2
	INC	BL
KLOP_2: mov	cl,6
	shl	bl,cl
	INC	BL
KLOP_3:
	MOV	AL,14H
	OUT	70H,AL
	IN	AL,71H
	AND	AL,00111110B
	OR	BL,AL
	MOV	AL,14H
	OUT	70H,AL
	XCHG	AL,BL
	OUT	71H,AL
KLOP_4:
        RET
SET_BAYT_DEV ENDP
