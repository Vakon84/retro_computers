;+---------------------------------------------------------------------------
; MXOS
; ��������� ������� �� ������ (�����������)
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

drawCursor_1:	; ����
		dcr	a
		jnz	drawCursor_0

		; b = v_cursorCfg & 0xF
		mov	a, b
		ani	0Fh
		mov	b, a

		; ����� ������� (b - ������, de - ����� �� ������, hl - ������)

drawCursor_2:	; ��������� ��� ���� B ���
		dcr	b
		jm	popa_ret_2

		; *de--	^= hl;
		ldax	d
		xra	h
		stax	d
		inr	d
		ldax	d
		xra	l
		stax	d
		dcr	d
		dcr	e
		jmp	drawCursor_2		