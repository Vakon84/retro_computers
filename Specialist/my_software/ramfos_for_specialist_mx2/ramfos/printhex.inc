;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� C815
; ����� 16-������� ����� �� ������
;
; �� �����
;  A - �����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

printHex:	push	psw
		rrc
		rrc
		rrc
		rrc
		call	printHex_1
		pop	psw
printHex_1:	push	psw
		ani	0Fh
		cpi	10
		jm	printHex_2
		 adi	7
printHex_2:	adi	'0'
printCharA_popret:
		call	printCharA
pop_psw_ret:	pop	psw
		ret
