;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� C851
; ������������� �������� ������ ����� ��55
;
; ������� �������� � v_oldBeep
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

oldBeep:	push	psw
		push	b
		push	h
		 lhld	v_oldBeep
oldBeep_0:	 mvi	a, 0Bh
		  sta	IO_KEYB_MODE
		  call	delay_l
		  mvi	a, 0Ah
		  sta	IO_KEYB_MODE
		  call	delay_l
		  dcr	h
		 jnz	oldBeep_0
		pop	h
		pop	b
		pop	psw
		ret
