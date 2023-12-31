;+---------------------------------------------------------------------------
; MXOS
; ���� ������
;
; �� �����
;  hl - ������ ������
;  de - ����� ������
;
; �� ������
;  bc, de, hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

input:		; ��������� ��������
		push	h
		push	b
		push	psw

		; ��������� ��������
		shld	v_input_start
		xchg
		shld	v_input_end

		; �������� � ����� ������ 0
		mov	h, d
		mov	l, e
		mvi	m, 0

input_loop:	; ���� ��������
		call	j_getch
		mov	c, a

		; ������ ��������� �������
		cpi	20h
		jc	input_spec

		; ������ ������� Back space
		cpi	7Fh
		jz	input_bkspc

		; ...
		nop
		nop
		nop

		; ��� ����� ������
		push	h
		lhld	v_input_end
		call	cmp_hl_de_2
		pop	h
		jnz	loc_C8DE		
		call	cmp_hl_de_2
		jz	input_loop
		ldax	d
		dcx	d
		stax	d
loc_C8DE:	push	b
		mov	b, h
		mov	c, l
		inx	b
		call	memmove_bc_hl
		pop	b
		mov	m, c		; *hl++	= c;
		call	j_printChar	; �����	�������	�� �����
		inx	h
		inx	d		
loc_C8EC:	push	h
		lhld	v_cursorY
		xthl
		push	h
		call	j_printString
		mvi	c, ' '
		call	j_printChar
		pop	h
		xthl
		shld	v_cursorY
		pop	h

		; �����������
		jmp	input_loop

; ---------------------------------------------------------------------------

input_bkspc:	; ���� ������ � ������ ������ ������ �� �������
		call	cmp_hl_de_2
		jz	input_loop

		; �������� ������
		mov	b, h
		mov	c, l
		inx	h
		call	memmove_bc_hl

		; ��������� ��������� �������
		dcx	h

		dcx	d
		jmp	loc_C8EC

; ---------------------------------------------------------------------------

input_spec:	; ������ �����
		cpi	8
		jz	input_left

		; ������ ������
		cpi	18h
		jz	input_right

		; ����� �� ����
		cpi	0Dh
		jnz	input_loop

		; ����� ����

		; ��������� � ����� ����� 0D
		stax	d

		; ��������������� �������� � �������
		pop	psw
		pop	b
		pop	h
		ret

; ---------------------------------------------------------------------------

input_left:	; ���� ������ � ������ ������ (hl==v_input_start) �� ���������� ������
		xchg
		push	h		
		lhld	v_input_start
		call	cmp_hl_de_2
		pop	h
		xchg
		jz	input_loop

		; ��������� ��������� �������
		dcx	h

input_lr:	; ���������� ������ ������/�����
		call	j_printChar

		; ���������� ����
		jmp	input_loop

; ---------------------------------------------------------------------------

input_right:	; ���� ������ � ����� ����� (hl==de) �� ���������� ������
		call	cmp_hl_de_2
		jz	input_loop

		; ����������� ��������� �������
		inx	h

		; ����� �����������
		jmp	input_lr