;----------------------------------------------------------------------------
; RAMFOS
; ����� ������� �� �����
;
; �� �����:
;  � - ������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

printChar:	push	h
		push	d
		push	b
		push	psw
		 call	printChar_int
		pop	psw
popa_ret:	pop	b
		pop	d
		pop	h
		ret

; ---------------------------------------------------------------------------

printChar_int:	; ��������� ESC-������������������
		lda	v_escMode
		ora	a
		jnz	printChar_esc

		; de - ��������� ������� � ��������
		lhld	v_cursorPos
		xchg

		; ��������� � ������������ ������� ������� �� ����� ������
		push	b
		call	keyScanWhilePrint
		pop	b

		; ������
		mov	a, c

		; hl - ��������� ������� � ��������
		xchg

		; ���� �������
		cpi	1Fh
		jz	clearScreen
		cpi	18h
		jz	cursorRight
		cpi	8
		jz	cursorLeft
		cpi	19h
		jz	cursorUp
		cpi	1Ah
		jz	cursorDown
		cpi	0Ch
		jz	loc_CE4B
		cpi	0Ah
		jz	cursorCrLf
		cpi	1Bh
		jz	setEscMode1
		cpi	7
		jz	keySound
		cpi	0Dh
		jz	saveCursorPosX0

		; ������� ������ 0x80 
		cpi	80h
		jc	printChar_high

		; ���������� C0-FF ������������� � 80-BF
		sui	40h
		jm	printChar_1
		sui	3Fh

		; ������ � A=1-40

		; if(a >= 8) goto loc_CC87;
		cpi	8
		jnc	printChar2
		
printChar_high:	; ���� ������� ������ 0x60
		cpi	60h
		jc	printChar_1

		; ����������� KOI-7 � KOI-8
		lda	v_koi8
		ora	a
		mov	a, c
		jz	printChar_1
		 adi	40h
printChar_1:	mov	c, a

printChar_0:	mov	a, h
		cpi	0BEh ; '-'

		push	b
		cnc	cursorCrLf
		pop	b

		mov	a, h
		adi	3
		sta	v_cursorPos+1	; ��������� ������� � ��������
		xchg

		call	calcCharAddr2	; �������� ����� �������

		push	h
		 ; �������� ������
		 lxi	h, 3Fh		 
		 ; hl <<= c*2
		 mov	a, c		
loc_CC09:	  dad	h
		  dad	h
		  dcr	a
		 jnz	loc_CC09		 
		 ; ����� �� �����
		 push	b
		  mvi	b, 8
		  call	clearChar
		 pop	b		 
		pop	h

		; if(a == 0x7F) return;
		mov	a, b
		cpi	7Fh
		rz

		; if(a == 0x20) return;
		cpi	20h
		rz

		; e++;
		inr	e

		; ����������� �� drawChar
; �����	�������
; hl - ������
; de - ����� � �����������
; �  - �������� � ������� ��������

drawChar:	; ������ �������
		mvi	b, 8
drawChar_0:	push	h

		; ��������� ���� �� HL � HL
		mov	l, m
		mvi	h, 0

		; �������� HL �� C*2 ���
		mov	a, c
drawChar_1:	dad	h
		dad	h
		dcr	a
		jnz	drawChar_1

		; ����������� ������ (*de++ ^= hl)
		ldax	d
		xra	h
		stax	d
		inr	d
		ldax	d
		xra	l
		stax	d
		dcr	d		
		inr	e

                ; hl++
		pop	h
		inx	h

		; ����� �����
		dcr	b
		jnz	drawChar_0

		ret

; ---------------------------------------------------------------------------
; ������� ����������.
;
; �� �����
;  de - ����� � �����������
;  hl - ������ 
;  b - ������
; ---------------------------------------------------------------------------

clearChar:	; ���� �������� ��������������, �� ��������� ���������� �����
		lda	v_inverse
		ora	a
		jnz	clearChar_1

		; ����������� HL
		mov	a, h
		cma
		mov	h, a
		mov	a, l
		cma
		mov	l, a		

		; ���� b
clearChar_0:	 ; *de++ &= hl
		 ldax	d
		 ana	h
		 stax	d		 
		 inr	d		 
		 ldax	d
		 ana	l
		 stax	d
		 dcr	d
		 dcr	e		
		 ; ����
		 dcr	b
		jnz	clearChar_0
		ret

; ---------------------------------------------------------------------------

clearChar_1:	 ; *de++ |= hl
		 ldax	d
		 ora	h
		 stax	d
		 inr	d
		 ldax	d
		 ora	l
		 stax	d
		 dcr	d
		 dcr	e		
		 ; ����
		 dcr	b
		jnz	clearChar_1
		ret