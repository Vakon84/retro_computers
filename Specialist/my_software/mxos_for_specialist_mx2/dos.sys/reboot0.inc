;+---------------------------------------------------------------------------
; MXOS
; ������������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

reboot:		lxi	sp, STACK_ADDR
		jmp	reboot1