;+---------------------------------------------------------------------------
; MXOS
; ������� ����� � ����, ���. ���������� ��� ����� �����.
;
; 2013-12-12 ����������������� � ���������� vinxru
;----------------------------------------------------------------------------

		; C�������� A � E
		mov	e, a

		; ������������ ����������� �������.
		; ���� ��� ���� 0 - �� �������� � ���, ����� � ����.
		ana	a
#if START_FROM_RAM
		mvi	a, IO_RAM & 0FFh	; STA IO_RAM
#else
		mvi	a, IO_ROM & 0FFh	; STA IO_ROM
#endif
		mvi	l, 0C9h			; RET

		jz	disableRom_2
#if BIG_MEM
		 mvi	l, 46h			; MOV B, M
#else
		 mvi	l, 7Eh			; MOV A, M
#endif
		 mvi	a, IO_ARAM & 0FFh	; STA IO_ARAM
disableRom_2:	sta	0FFC0h + (driverR - driverStart) + 1
		mov	a, l
		sta	0FFC0h + (driverW - driverStart)

		; ��������������� A �� E
		mov	a, e