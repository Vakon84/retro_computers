;----------------------------------------------------------------------------
; RAMFOS
; ������������ ����������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

keyScan:		; ��������� �������� BC, DE, HL
		push	h
		push	d
		push	b
		 call	keyScan_0
		pop	b
		pop	d
		pop	h

		; ���� Z
		ora	a
		
keyMode82:	; �������������� ��������� ���/LAT
		; ���������� �� biosinit.inc

		; ��������� ���������
		push	psw
		 ; ����� ������������ ����� ���������� 82h
		 mvi	a, 82h
		 sta	IO_KEYB_MODE
		 ; ������������ ��������� ���/���
		 lda	v_rusLat
		 ani	1
		 ori	0Ch
		 sta	IO_KEYB_MODE
		pop	psw

		ret

; ---------------------------------------------------------------------------

keyScan_0:	; �������� ����� ���� ������� ������� � B
		call	keyMode82
		lda	IO_KEYB_B
		mov	b, a

		; ���� �� ���� ������� �� ������, �������
		ori	3
		cpi	0FFh
		rz

		; �������� ����� ������� ������� ������� � HL
		mvi	a, 91h
		sta	IO_KEYB_MODE
		lda	IO_KEYB_A
		mov	l, a		
		lda	IO_KEYB_C
		ori	0F0h
		mov	h, a

		; ���� ������� �� ������ ��� ������ ������ ����������, �������.
		; ��� ���� ����� ���� ���������� ������!
		cmp	l
		rz
		
		; �������� � L ����� ������� �������� ���� �� HL
		mvi	a, 0FBh
keyScan_1:	 inr	a
		 dad	h
		 jc	keyScan_1
		mov	l, a

		; �������� � � ����� ������� �������� ���� �� B
		mov	a, b
		ori	3
		stc
		mvi	c, 0FDh
keyScan_2:	 inr	c
		 rar
		jc	keyScan_2

		; ���� ������ ����� ����� ������
		inr	a
		jnz	specialKeysRet

		; b = !b & 2
		mov	a, b
		cma
		ani	2
		mov	b, a

		mov	a, c
		rlc
		rlc
		rlc
		rlc
		ora	l

		; a = keybMap[a]
		mov	e, a		
		mvi	d, 0
		lhld	v_keybMap
		dad	d
		mov	a, m

		; ��������� �� �������
		mov	c, a		; c = a

		; if(a < 0x21) return;
		cpi	21h
		rc

		; ����������� �������
		cpi	8Bh
		jz	j_tapeMode
		cpi	8Ch
		jz	j_printerEchoMode

		lhld	v_koi8

		cpi	81h
		jz	capsLock
		cpi	8Ah
		jz	inverseVideo
		cpi	40h
		jc	pressed40

		lda	v_capsLock
		xra	b
		mov	b, a
		mov	a, c
		inr	h
		jz	loc_CFA3
		dcr	b
		rm
		adi	20h ; ' '
		inr	l
		rnz
		adi	0A0h ; '�'
		cpi	8
		rnc
		adi	7Fh ; ''
		ret

; ---------------------------------------------------------------------------

loc_CFA3:	adi	20h ; ' '
		inr	l
		rz
		adi	60h ; '`'
		dcr	b
		rp
		adi	20h ; ' '
		ret

; ---------------------------------------------------------------------------

pressed40:	dcr	b
		rm
		sui	10h
		cpi	20h ; ' '
		rnc
		adi	20h ; ' '
		ret

; ---------------------------------------------------------------------------

c_koi8:					; CODE XREF: ROM:CCD3j
		mov	a, l
		cma
		jmp	loc_CFBE
; ---------------------------------------------------------------------------

c_koi7:					; CODE XREF: ROM:CCCFj
		mov	a, l

loc_CFBE:	ora	a
		rnz

inverseVideo:	mov	a, l		; l = ~l;
		cma
		mov	l, a

capsLockRet:    shld	v_koi8

specialKeysRet:	; ���� �� �� ������� � ������ �������, �������� �
		lda	v_cursorPos
		cpi	8
		cnz	printIndicators

		; �������
		lxi	h, 4000h	
keyScan_delay:	 dcx	h
		 mov	a, h
		 ora	l
		jnz	keyScan_delay

		; ������� �� keySound
