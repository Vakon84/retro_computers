;+---------------------------------------------------------------------------
; MXOS
; ����������� ��������������� ������ ������ (� �������)
;
; �� �����
;  hl - ������
;  de - ������, �������� ����� �� �������
;  bc - ���� BC � ����������� �������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

memmove_bc_hl:	; ��������� ��������
		push	h
		push	b
		push	d

		; ���� b<h ��� c<l, ��
		mov	a, b
		cmp	h
		jc	memcpy_bc_hl2
		; ��� �� ������� jnz
		mov	a, c
		cmp	l
		jc	memcpy_bc_hl2

		; bc = bc + de - hl
		push	h		
		call	sbb_de_hl_to_hl
		dad	b
		mov	b, h
		mov	c, l
		pop	h

memcpyb_bc_de:	; �������� �� DE � BC � ����������� �������, ���� HL �� ����� DE
		ldax	d
		stax	b
		call	cmp_hl_de_2
		dcx	d
		dcx	b
		jnz	memcpyb_bc_de

		; �������������� ��������� � �����
		jmp	pop_dbh_ret2

; ---------------------------------------------------------------------------

memcpy_bc_hl2:	; �������� �� HL � BC � ����������� �������, ���� HL �� ����� DE
		mov	a, m
		stax	b
		call	cmp_hl_de_2
		inx	h
		inx	b
		jnz	memcpy_bc_hl2

pop_dbh_ret2:	; �������������� ��������� � �����
		pop	d
		pop	b
		pop	h
		ret