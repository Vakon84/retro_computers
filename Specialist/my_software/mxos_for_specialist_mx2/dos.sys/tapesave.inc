;+---------------------------------------------------------------------------
; MXOS
; ������ ��������� �� �����
;
; �� �����
;  hl - ��������� �����
;  de - �������� �����
;
; �� ������
;  bc - ����������� �����
;  de,hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

tapeSave:	; ����������� CRC
		push	h
		call	calcCS
		pop	h

		push	h
		push	b

		; �����-��� (256 �����)
		mvi	b, 0
loc_C9A4:	xra	a
		call	j_tapeWrite
		dcr	b
		jnz	loc_C9A4

		; ��������� ���� 0E6h
		mvi	a, 0E6h
		call	j_tapeWrite

		; ������ ������ ������� �����
		call	tapeWriteWord
		xchg

		; ������ ������ ���������� �����
		call	tapeWriteWord
		xchg
		
loc_C9B9:	; ������ ����� ������ �� HL �� DE
		mov	a, m
		call	j_tapeWrite
		call	cmp_hl_de_2
		inx	h
		jnz	loc_C9B9

		; ������ CRC
		pop	h
		call	tapeWriteWord

		; ���������� CRC � �������� BC
		mov	b, h
		mov	c, l

		; ��������������� �������� � �������
		pop	h
		ret