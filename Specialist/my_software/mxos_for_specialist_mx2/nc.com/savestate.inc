;----------------------------------------------------------------------------
; MXOS NC.COM
; ���������� ��������� � ����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

saveState:	call	swapDriver
		lxi	h, 0FF00h
		lxi	d, initState
		mvi	c, 10

saveState_1:	ldax	d
		call	0FFC0h+DriverW-Driver
		inx	h
		inx	d
		dcr	c
		jnz	saveState_1
		call	swapDriver
		ret