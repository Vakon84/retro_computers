;+---------------------------------------------------------------------------
; MXOS
; ������������ (�����������)
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

reboot1:	; ��� ���������� �����
		mvi	a, 36h

		; �������� ���
		sta	IO_RAM

		; ��������� ����		
		sta	IO_TIMER+3

		; ������������� ����������
		lxi	h, initVars	; ������
		lxi	d, initVarsEnd	; �����
		lxi	b, vars		; ����
		call	memcpy_bc_hl

		; ��������� �����
#if DISABLE_COLOR_BUG
		mvi	a, INIT_COLOR
		sta	IO_COLOR
#else
		mvi	a, 0Fh  
		sta	IO_KEYB_MODE 
#endif

#if LOAD_FONT
onceInitFont:
		jmp	initFont
#else
		jmp	reboot2
#endif