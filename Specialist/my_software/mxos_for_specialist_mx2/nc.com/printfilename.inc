;----------------------------------------------------------------------------
; MXOS NC.COM
; ����� ����� �����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

printFileName:	push	b
		mvi	b, 6
		call	printString2
		mvi	c, 20h ; ' '
		call	printChar
		mvi	b, 3
		call	printString2
		lxi	b, 7
		dad	b
		pop	b
		ret
