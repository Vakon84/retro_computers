;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� C842
; ������ 16-������� ����� �� ��������
;
; �� �����
;  A - �����
;
; ��� �������� �����������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if NO_PRINTER==0

printerHex:	push	psw
		 rrc
		 rrc
		 rrc
		 rrc
		 call	printerHex_1
		pop	psw
printerHex_1:	push	psw
		 ani	0Fh
		 cpi	10
		 jm	printerHex_2
		  adi	'A'-'0'-10		  
printerHex_2:	 adi	'0'
		 push	b
		  mov	c, a
		  call	printer
		 pop	b
		pop	psw
		ret

#endif