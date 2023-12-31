;----------------------------------------------------------------------------
; MXOS
; �������� ����� � ����������
;
; �� ������
;  ? - ���
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

getch2:		; ��������� ��������
		push	h
		push	b
		push	d

		; �������� ��� ������� ������� � ��������� ��� � v_lastKey
		call	keyScan2
		sta	v_lastKey

getch_retry:	; ��� ����� �������, ��������� ������ ��� ���
		mvi	c, 1

loc_C227:	; ������ ������
		call	drawCursor2

		; ��������
		lda	v_cursorDelay
loc_C22D:	mvi	b, 40h
		call	delay_l_0
		dcr	a
		jnz	loc_C22D

loc_C236:	; ������/������� ������
		call	drawCursor
		
		; �������� �������� �������
		lxi	d, 500h

loc_C23C:	; �������� ��� ������� �������
		call	keyScan2
		cpi	80h		; �.�.
		cpi	0FFh
		jnz	getch2_pressed

		; ���������� v_lastKey=0FFh
		sta	v_lastKey

		; ��������� 500h ���
		dcx	d
		mov	a, d
		ora	e
		jnz	loc_C23C

		; ������ �����
		jmp	loc_C236

; ---------------------------------------------------------------------------

.db 0FFh, 0FFh

; ---------------------------------------------------------------------------

setKeybMode82:	mvi	a, 82h
		sta	IO_KEYB_MODE
		ret

; ---------------------------------------------------------------------------

setKeybMode91:	mvi	a, 91h
		sta	IO_KEYB_MODE
		ret

; ---------------------------------------------------------------------------
; ���� ������ �������

getch2_pressed:	; ��������� ���
		mov	b, a

		; ���� ��������� ������, ������� ���
		mov	a, c
		rrc
		jc	loc_C269
		call	drawCursor2
loc_C269:	
		lhld	unk_8FEF	; h = v_lastKey
		mov	a, b		; a = b = ��� ������� �������
		cmp	h
		jnz	loc_C28D	; ��� ������� ������� ���������
		cmp	l
		jz	loc_C295

		; ������ ������
		call	drawCursor

		; ����, ���� �������� �������
		lda	byte_8FF5
		mov	d, a
loc_C27C:	call	keyScan2
		cmp	h
		jnz	loc_C227	; ������ ������ ������ �������
		dcr	d
		jnz	loc_C27C

		; ����� �������

		; ������� ������
		call	drawCursor

		jmp	loc_C290
; ---------------------------------------------------------------------------

loc_C28D:	; �������� ������
		call	beep

loc_C290:	;
		mov	l, h
		mov	h, b	; ��� ������� ������� ��������� � v_lastKey
		shld	unk_8FEF

loc_C295:	; �� ���������� ������� CAPS LOCK, SHIFT � ���/LAT �� ������
		mov	a, b
		cpi	21h
		jc	getch_noShift   
                ; �� ������� c ������ 21h-3Fh ������ SHIFT
		cpi	40h
		jc	getch_shift 
                ; �� ���������� ������� (40h-7Eh) ������ CAPS LOCK, SHIFT � ���/LAT
		cpi	7Fh
		jc	getch_chars
                ; �� ���������� ������� (7Fh+) CAPS LOCK, SHIFT � ���/LAT �� ������
		jz	getch_noShift

		; ...
		nop
		nop

                ; ���������, ���� ��� ������� �� 81h
		cpi	81h
		jnz	getch_noShift

                ; ��� ������� 81h

		; ���� ���� �� �����
		lda	IO_KEYB_B
		ani	2
		jnz	loc_C55C

                ; ��� ������� 81h � ������

		; �������� ������
		call	beep

		; CAPS LOCK ��� KOI-7 ��� ���/LAT ��� KOI-8
		jmp	getch_rc

; ---------------------------------------------------------------------------
; ������ ���������� ���/LAT

getch_rusLat:	; �� ����� a = v_keyLocks
		xri	81h
		sta	v_keyLocks

		; ������ �������� ������
		lda	v_beep
		push	psw
		mvi	a, 4Fh
		sta	v_beep
		call	beep
		mvi	a, 5Fh
		sta	v_beep
		call	beep
		pop	psw
		sta	v_beep

		; ...
		nop

		jmp	getch_retry

; ---------------------------------------------------------------------------
; �������� �������� ��� �������� �����

getch_chars:	; ���� �� ����� CAPS LOCK, ���������� ��� ����
		lda	v_keyLocks
		mov	c, a
		ana	a
		jm	loc_C2EA	; CAPS LOCK

		; ���������� ��������� � ��������
		mov	a, b
		xri	20h
		mov	b, a

loc_C2EA:	; ���� ������������ �� ���/���, �������� � C=1
		mov	a, c
		ani	1
		mov	c, a

		; ���� ���� �����, �������� � A=0
		lda	IO_KEYB_B
		ani	2
		rrc				;! ��� �� ���� ����� C ?

		; ���������� ���������� ������� � ������� ���� A^C==0
		xra	c
		mov	a, b
		jnz	loc_C5A8
		adi	80h
		jmp	loc_C5A8

; ---------------------------------------------------------------------------
; ������ ����� �� �������

getch_shift:	; ���� �� ����� ����, ���������� ��� ����
		lda	IO_KEYB_B
		ani	2
		mov	a, b
		jnz	loc_C5A8

		; ������ ����� �� �������
		xri	10h

		; ���� ���������� 30h ������ �������� �� 5Fh
		cpi	20h
		jnz	getch_noShift
		mvi	a, 5Fh

		; ����������� getch_noShift

; ---------------------------------------------------------------------------
; ������� ��� ���������

getch_noShift:  ; ��������� ��� ������� ������� � B     
		mov	b, a

loc_C311:	call	setKeybMode83
		mvi	a, 0F7h
		sta	IO_KEYB_A
		lda	IO_KEYB_B
		cma
		rrc
		rrc
		rrc
		call	setKeybMode82
		nop

		; �������������� ��� ������� �������
		mov	a, b

popa_ret_2:	; �������������� �������� � �������
		pop	d
		pop	b
		pop	h
		ret