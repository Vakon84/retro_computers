;----------------------------------------------------------------------------
; MXOS NC.COM
; ��������� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

drawWindowIfSel:; �������� ���-�� ������
		lxi	h, panelA_filesCnt
		call	readBytePanel

		; ���� ������ ���, �������
		ana	a
		pop	h ; ����� ��������
		jz	mainDriveChanged
		push	h
		

; ---------------------------------------------------------------------------

drawWindow1:	COLOR(COLOR_DIALOG)

		; ������ ����
		lxi	h, g_window1
		call	draw
	
		; ������ �������������
		lxi	h, 9F66h	; x=120 y=102
		mvi	b, 18		; w=144 h=9
		jmp	inverseRect

; ---------------------------------------------------------------------------

drawWindow2:	COLOR(COLOR_DIALOG)

		; ������ ����
		lxi	h, g_window2
		call	draw

		; ������ �������������
		lxi	h, 9E88h	; x=112 y=136
		mvi	b, 20		; w=160 h=9
		jmp	inverseRect

