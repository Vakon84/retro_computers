;----------------------------------------------------------------------------
; MXOS NC.COM
; ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

Start:		; ��������� ��������
		lxi	h, 0
		shld	v_inverse

		; *** ���������� �������� FORMAT ***

		; ������������� ���� �������
		call	swapDriver
		lxi	h, 0FF00h

		; ���� � ������ ���� ����������� �����, ������ ��� ���������
		call	0FFC0h
		cpi	5Ah
		jz	formatCalled

		; ��������������� �������
		call	swapDriver

		; ��������� ���������
		call	saveState

		; ������ A:FORMAT.COM B:
		lxi	h, aFormatB
		jmp	fileExec

; ---------------------------------------------------------------------------

formatCalled:	; �������� ��������� �� ���� � ���
		inx	h
		lxi	d, activePanel
		mvi	c, 9
loc_D026:	 call	0FFC0h
		 stax	d
		 inx	h
		 inx	d
		 dcr	c
		jnz	loc_D026

		; ��������������� �������
		call	swapDriver
		mvi	c, 1Fh		; ������� ������

		; �����	���������
		COLOR(COLOR_HELP_F)
		call	printChar
		lxi	h, 1FFh
		shld	v_cursorY
		lxi	h, aF1LeftF2RighF3		
		call	printString

		; ������������ ���������
		COLOR(COLOR_HELP_TEXT)
		lxi	h, 92F7h
		mvi	d, 8		
loc_D049:	 mvi	b, 4
		 call	inverseRect	; hl - �����, b	- ������, ������ 9
		 inr	h
		 inr	h
		 dcr	d
		jnz	loc_D049

		; ������� ��� ������
		call	clearCmdLine