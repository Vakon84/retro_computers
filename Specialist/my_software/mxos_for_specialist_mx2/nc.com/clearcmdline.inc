;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� ��� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

clearCmdLine:	lxi	h, 7F3h
		shld	v_cursorY
	
		mvi	h, 10
		shld	v_cmdLinePos

		COLOR(COLOR_CMDLINE)
		
		mvi	c, 92 ; '\'
		call	printChar

		lxi	h, v_cmdLine
		shld	v_cmdLineEnd
		                   
		mvi	b, 60

		; ����������� �� printSpaces