;+---------------------------------------------------------------------------
; RAMFOS
; ������ RKS �����
;
; 2013-11-01 ����������� vinxru
;----------------------------------------------------------------------------

#if RKS_LOADER
		; ��� RKS ����
		lxi	h, a_rks
		call	memcmp_ext
		jnz	defExec2
		
		; ��������� ��� � ������
		call	fileLoad2
		jnz	dlg_error

		; ����� �������
		push	h
#if RKS_SHIFT_LOADER
		; ���� ����� HP
		lda	IO_KEYB_B		
		ani	2
		rz
#endif
		; ����� ���� Monitor2.sys
		lxi	h, a_monitor2_sys
		call	exec1

		; ����� �������
		pop	h

		jnz	dlg_error
		
		; ��� �������� �������� ����������� ���� ����� ���������
		lxi	sp, 8FFFh

		; ����� ���������
		push	h
		jmp	exec2

a_rks:		.db "RKS"
a_monitor2_sys:	.db "Monitor2 SYS"

defExec2:
#endif