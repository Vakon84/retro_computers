;----------------------------------------------------------------------------
; MXOS NC.COM
; ����� ������ ������ �� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

printFilePanel:	COLOR(COLOR_BORDER)

		lxi	h, g_filePanel
		call	draw

		COLOR(COLOR_PANELNAME)

		; ����� NAME
		lxi	h, 1110h
		call	setCursorPosPanel
		lxi	h, aNameName
		call	printString

		COLOR(COLOR_INFOLINE)

		; ����� ����� �����
		lxi	h, panelA_drive
		call	readBytePanel
		lxi	h, 9DEh
		call	setCursorPosPanel
		call	printDrive

		COLOR(COLOR_FILE)

		; ����� ���� ������
		lxi	h, files
		lxi	d, 0A20h
		mvi	c, 0		

		
loc_D92E:	; ��������� ��������� �������
		xchg
		call	setCursorPosPanel
		xchg

		; ���� ����������?
		mov	a, m
		inr	a
		jz	loc_D94E

		; ����� �����
		call	printFileName

		; �������
		inr	c

		; ��������� �������
		mov	a, e
		adi	10
		mov	e, a

		; ��������� �������
		cpi	0D0h
		jc	loc_D92E
		mov	a, d
		lxi	d, 3920h
		cpi	14h
		jc	loc_D92E

loc_D94E:	; ���������� ���-�� ������
		lxi	h, panelA_filesCnt
		mov	a, c
		call	writeBytePanel

		; ���� ������ ������ ���������
		lxi	h, panelA_curFile
		call	readBytePanel
		cmp	c
		rc

		; �� �������� �� ��������
		dcr	a
		rm
		jmp	writeBytePanel
