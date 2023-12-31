;+---------------------------------------------------------------------------
; RAMFOS
; ��������� �� ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if NO_PRINTER==0

printerEcho_crLf:
		; � ����� ��� ���� �������� 0A ��� 0D �� ���� 0A, 0D. 
		; �� � ������ "0A ����� ������� 0D", �������� �� �����������

		; ������ 0A, �� �������� ���� �������� 0A, 0D.
		lxi	h, v_printerCrLf
		cpi	0Ah
		jz	printerEcho_0

		; ������ 0D, �� �������� ���� �������� 0A, 0D, ������ ���� ������� ������� ��� 0D.
		; ����� ������� 0D ��� ����, ��� ������� ������.
		cpi	0Dh
		jnz	printerEcho_spc
		cmp	m

printerEcho_0:	mvi	c, 0Ah
		cz	printer
		mvi	c, 0Dh
		mov	m, a
		jmp	printer

; ---------------------------------------------------------------------------

loc_D0B1:	; ���� ������ >= 0x87
		cpi	87h ; '�'
		jnc	printerEcho_1

printerEcho_spc:; �������� ������ �� ������
		mvi	c, ' '

doPrinterEcho:	; ���� ��� ��������, �������
		mov	a, c
		cpi	8
		rz
		; ������� ������� � ������ ������ - �������
		cpi	0Ch
		rz
		; ���� <= 0x18
		cpi	18h
		jc	printerEcho_crLf
		; ���� <= 0x1C �������
		cpi	1Ch
		rc
		; ���� ������� ������ - �������
		cpi	1Fh
		rz
		; ��������� ��������� ���� �������� �� ������
		jc	printerEcho_spc
		; ���� <= 0x60, ��������
		cpi	60h
		jc	printer
		; ?
		lhld	v_koi8
		cpi	7Fh
		jnc	 loc_D0B1 ;+
		inr	l
		jnz	printer
		ori	80h
		mov	c, a

printerEcho_1:  ; ���� ������ ������ 0xC0, �������
		cpi	0C0h
		rc

		; ���� v_tapeMode = '0', ������� ������ ��� ���������
		lda	v_tapeMode
		sui	'0'
		jz	printer

		; ���� v_tapeMode = '1', ������� � ��������������
		dcr	a
		jnz	printerXlat

		; ����� ����� ������� ������� �������� ������� 27, 82, 1
		; �� ������������� � ��������� Epson
		; Select International character set France
		lxi	h, 1B52h
		mvi	a, 1
		call	printerEsc

		; ����� C �� �������
		call	printer		; �����	����� �� �������

		; ������� 27, 82, 0
		; Select International character set USA
		xra	a

printerEsc:	push	b
		 mov	c, h
		 call	printer		; �����	����� �� �������
		 mov	c, l
		 call	printer		; �����	����� �� �������
		 mov	c, a
		 call	printer		; �����	����� �� �������
		pop	b
		ret

#endif