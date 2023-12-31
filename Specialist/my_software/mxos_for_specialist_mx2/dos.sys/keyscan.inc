;+---------------------------------------------------------------------------
; MXOS
; �������� ��� ������� �������
;
; �� ������
;  a - ���
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

setKeybMode83:	mvi	a, 83h
		sta	IO_KEYB_MODE
		ret

; ---------------------------------------------------------------------------

keyScan2:	; ����� ������ ����
		call	setKeybMode82

		; ����� ������� ��������� ��� �������
		lda	IO_KEYB_B	

		; ��� ���� �� ������������ � ������������
		ori	3

		; �� ���� ������� �� ������
		cpi	0FFh
		rz

		; ��������� ��������
		push	h
		push	b
		push	d
		
		; ���������� 12 �������� ������
		lxi	h, 0FFEh
		lxi	d, v_keybTbl + 11
		mvi	b, 0FFh
loc_C1DD:	mov	a, h
		sta	IO_KEYB_C
		mov	a, l
		sta	IO_KEYB_A
		rrc
		cma
		ani	4
		mov	c, a
		lda	IO_KEYB_B
		ora	c

		; ���������� 6 ������ � �������
		mvi	c, 6
		rrc
		rrc
loc_C1F2:	rrc
		cnc	keybScan3
		dcr	c
		jnz	loc_C1F2

		; ����
		dcx	d
		dad	h
		inx	h
		mov	a, h
		adi	0F0h
		mov	h, a
		jc	loc_C1DD

		; ����� ��55 �� ���������
		call	setKeybMode82

		; ���������
		mov	a, b

		; �������������� ��������
		pop	d
		pop	b
		pop	h
		ret

;----------------------------------------------------------------------------

keybScan3:	push	d
		push	psw
		mvi	a, 6		; e += (6 - c) * 16
		sub	c
		add	a
		add	a
		add	a
		add	a
		add	e
		mov	e, a
		ldax	d		; b = *de;
		mov	b, a
		pop	psw
		pop	d
		ret