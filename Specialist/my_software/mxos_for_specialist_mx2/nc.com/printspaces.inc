;----------------------------------------------------------------------------
; MXOS NC.COM
; ����� ��������
;
; b - ���-�� ��������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

printSpaces:	mvi	c, ' '
printSpaces_1:	call	printChar
		dcr	b
		jnz	printSpaces_1
		ret
