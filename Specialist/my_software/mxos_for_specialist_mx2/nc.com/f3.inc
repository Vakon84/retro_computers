;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� F3 - ���������� ���������� � ����������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

F3:		; ��������� ����� ��������������� ������
		lda	activePanel
		push	psw
		xri	1
		sta	activePanel

		; ������ ��������� ������
		lxi	h, panelA_info
		call	readBytePanel
		xri	1
		call	writeBytePanel

		; �������������� �������� ������
		pop	psw
		sta	activePanel
		ana	a
		jz	loc_D701

		; �������������� ������
		call	loadAndPrintA

		jmp	loc_D603

; ---------------------------------------------------------------------------

loc_D701:	call	loadAndPrintB
		jmp	loc_D603		        