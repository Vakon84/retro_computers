;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� TAB - ����� �������� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

Tab:		; �������� ��������� ������
		lxi	h, panelA_info
		lda	activePanel
		ana	a
		jnz	loc_D6C7
		inx	h
loc_D6C7:	mov	c, a
		mov	a, m

		; ������ �� ������, �������
		ana	a
		jnz	mainDriveChanged

		; ������ �������� ������ �� ���������������
		mov	a, c
		xri	1                   	
		sta	activePanel

		; ������������� ����� ������
		lxi	h, panelA_drive
		call	readBytePanel
		call	loadFiles	; �� ����� ����� a=����������

		jmp	loc_D603