;----------------------------------------------------------------------------
; MXOS NC.COM
; ����� ���������� � ����� ����� ����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

printInfoLine:	; ���� ������ ���, �������
		lxi	h, panelA_filesCnt
		call	readBytePanel
		ana	a
		rz

		COLOR(COLOR_INFOLINE)		

		lxi	h, 12DEh
		call	setCursorPosPanel

		call	getSelectedFile
		call	printFileName
		mvi	b, 3
		call	printSpaces	; b - ���-�� ��������

		dcx	h
		dcx	h
		dcx	h
		mov	d, m
		dcx	h
		mov	e, m

		push	d

		dcx	h
		mov	a, m
		call	printHexByte
		dcx	h
		mov	a, m
		call	printHexByte

		mvi	c, ' '
		call	printChar

		pop	d

		jmp	printDec
