;----------------------------------------------------------------------------
; MXOS NC.COM
; ��������� ����� ����� ���������� �����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

printInvSelFile:
		call	getSelectedFile
		xchg
printInvFile:	lxi	h, 506Eh
		shld	v_cursorY
		xchg
		lxi	d, v_input
		call	compactName
		lxi	h, v_input
		jmp	printStringInv
