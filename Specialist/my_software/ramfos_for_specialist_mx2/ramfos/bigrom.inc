;+---------------------------------------------------------------------------
; RAMFOS
; ������ ��� ����������� MX
;
; 2013-11-01 ����������� vinxru
;----------------------------------------------------------------------------

#if BIG_ROM
bigRom:		push	psw

		; ���� � HL ���� ����� < 8000h, �� ��������� � ������ ��� MX
		mov	a, h
		xri	80h
		jm	bigRom_0

		; ��������� HL � �������� �� ���� 8000h
		push	h
		 mov	h, a		 
		 ; ������ 4 ����� � ��� ��� ��� ��������� ������������
		 inx	h
		 inx	h
		 inx	h
		 inx	h
		 ; �������� ��� ���
		 sta	IO_PAGE_STD
		 xra	a
		 sta	IO_COLOR-800h
		 ; ������ �����
		 mov	c, m
		 ; ��������� ��� MX � �������������� �����
		 sta	IO_PAGE_RAM-800h
		 lda	v_color
		 sta	IO_COLOR
		pop	h
		; ��������������� � A ��������
		pop	psw
		ret
		
bigRom_0:	; ��������� ��� MX
		sta	IO_PAGE_ROM
		; ������ �����
		mov	c, m
		; ��������� ��� MX
		sta	IO_PAGE_RAM
		; ��������������� � A ��������
		pop	psw
		ret      
#endif