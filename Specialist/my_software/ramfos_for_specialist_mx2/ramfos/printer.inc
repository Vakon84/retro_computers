;+---------------------------------------------------------------------------
; RAMFOS
; ������ �� ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if NO_PRINTER==0

printerXlat:	; c = v_printerXlat[c % 64];
		mov	a, c		
		ani	63
		lxi	h, v_printerXlat
		mov	c, a
		mvi	b, 0
		dad	b
		mov	c, m

printer:	push	psw

		; ����� ��580��55
		mvi	a, 90h
		sta	IO_EXT_MODE

		; ����������� � ���������� ������
		mov	a, c
		cma
		sta	IO_EXT_B

printer_0:	 ; ������������ ����� �������� ��������
		 lda	IO_KEYB_B		
		 ani	2
		 jz	printer_break

		 ; ���� ���� 6-�� ��� �� �������
		 lda	IO_EXT_A
		 ani	40h
		jnz	printer_0

		; �����
		mvi	a, 3
		sta	IO_EXT_C

		; �����
		nop
		nop
		nop
		nop
		nop
		nop
		nop

		; �����
		xra	a
		sta	IO_EXT_C

printer_break:	pop	psw
		ret

		.db    0
#else

printer:
printerHex:
printerEchoMode: 
doPrinterEcho:
		ret
#endif