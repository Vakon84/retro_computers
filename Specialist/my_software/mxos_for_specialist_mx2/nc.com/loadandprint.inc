;----------------------------------------------------------------------------
; MXOS NC.COM
; ��������� ����� � ����������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

loadAndPrintB:	; ������� ������ �������� ������ �� ������
		lda	activePanel
		push	psw
		mvi	a, 1
		sta	activePanel

		; ��������� � ������ ����
		lda	panelB_info
		jmp	loadAndPrint

; ---------------------------------------------------------------------------

loadAndPrintA:	; ������� ������ �������� ������ �� �����
		lda	activePanel
		push	psw
		mvi	a, 0
		sta	activePanel

		; ������ ������?
		lda	panelA_info
loadAndPrint:	ana	a
		jnz	loadAndPrint_2

		; ��������� ������ ������
		lxi	h, panelA_drive
		call	readBytePanel
		call	loadFiles	; �� ����� a ������ ��������� ����� ����������

		; ������� ������ ������
		call	printFilePanel

		jmp	loadAndPrint_3

; ---------------------------------------------------------------------------

loadAndPrint_2:	; ������ ����������������
		call	printInfoPanel

loadAndPrint_3:	; ��������������� �������� ������
		pop	psw
		sta	activePanel

		; ��������� ������ ������
		lxi	h, panelA_drive
		call	readBytePanel
		call	loadFiles	; �� ����� a ������ ��������� ����� ����������
		ret

