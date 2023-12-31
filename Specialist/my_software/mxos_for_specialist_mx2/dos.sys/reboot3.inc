;+---------------------------------------------------------------------------
; MXOS
; ���������� �������� �� ������ 0FFC0h � ������ NC.COM
;
; � ��� �� ����������� ������ AUTOEX.BAT, ���� �� ������ �������.
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

reboot3:	; ������������� �����
		lxi	sp, STACK_ADDR

		; �������� ������� � ���������� ��� ���� �����
		lxi	h, driverStart
		lxi	d, driverEnd
		lxi	b, 0FFC0h
		call	memmove_bc_hl

		; ��������� ����������
		lxi	h, j_reboot3
		shld	v_tapeError

		; ��� ���� ����� �������� ���� ���� ��� ����� �������� ������������.
		; �� ���� ��� ������ ������������ �� �� ����������.
reboot3_0:	jmp	reboot3_1
reboot3_1:	lxi	h, reboot3_2
		shld	reboot3_0+1

		; � ���� ����� ����� ������ ������� ���������� A:
#if START_FROM_RAM
		lxi	h, aDriver
		call	fileExec		
#endif

		; ���� ������ �������, ���������� ������ B:AUTOEX.BAT
		lda	IO_KEYB_B	
		ani	2
		jz	reboot3_2

		; ������ ����� B:AUTOEX.BAT
		lxi	h, aBAutoex_bat
		call	fileExec

reboot3_2:	; ������ ����� NC.COM
		lxi	h, aANc_com
		call	fileExec

		; ������ ������������
		jmp	j_reboot3