;----------------------------------------------------------------------------
; MXOS NC.COM
; ���� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

input:		; ����� ������
		push	h
		lxi	h, v_input
		call	printStringInv
		pop	h

		; �������� ��������
		mvi	a, 1
		sta	v_inverse

input_loop:	; ���� �������
		call	getch

		; Enter ��� ESC
		cpi	0Dh
		jz	input_exit
		cpi	1Bh
		jz	input_exit

		; ���� ��������� ������� ��� ������, �� ����������
		cpi	21h
		jc	input_loop

		; ��������� ��� ������
		mov	c, a

		; �������� ������ � �����
		stax	d

		; ��������
		cpi	7Fh
		jz	input_bkspc

		; ���� ������������
		mvi	a, (v_input+23) & 0FFh
		cmp	e
		jz	input_loop

		; ����� ������� �� �����		
		call	printChar

		; ���������� ����� ������
		inx	d

		jmp	input_loop

; ---------------------------------------------------------------------------

input_bkspc:	; ���� ��� ������ ������, �������
		mvi	a, v_input & 0FFh
		cmp	e
		jz	input_loop

		; ��������� ����� ������
		dcr	e

		; ������� ������ � ������
		push	h
		lxi	h, asc_DC17
		call	printString
		pop	h

		jmp	input_loop

; ---------------------------------------------------------------------------

input_exit:	; ��������� ESC ��� Enter ��� ������ 
		mov	c, a

		; ���������� � ����� ������ 0Dh, 0
		xchg
		mvi	m, 0Dh
		inx	h
		xra	a
		mov	m, a

		; ��������������� ��������
		sta	v_inverse

		; �����		
		mov	a, c
		ret