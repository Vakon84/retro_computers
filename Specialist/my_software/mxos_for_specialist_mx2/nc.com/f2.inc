;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� F1, F2. ����� ���������� ��� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

F2:		; �������� ������������� activePanel=1
		lda	activePanel
		push	psw
		mvi	a, 1
		sta	activePanel

		; ������
		call	chooseDrive

		; ���� ������� ����������, �� ��������� ���.
		cpi	0FFh
		jz	loc_D5C3		
		sta	panelB_drive

		; � ��� �� ������ ������ ������� � ���������� ������ � ������
		xra	a
		sta	panelB_info
		sta	panelB_curFile

loc_D5C3:	; ��������������� activePanel
		pop	psw
		sta	activePanel

		; ������������� � �������������� ������ ������
		call	loadAndPrintB

		; ������������� � �������������� ������ ������, ������ ���� ��� ������������
		lda	panelA_info
		ana	a
		jz	loc_D603
		call	loadAndPrintA

		; ��������� ��������� � �������
		jmp	loc_D603

; ---------------------------------------------------------------------------

F1:		; �������� ������������� activePanel=02
		lda	activePanel
		push	psw
		mvi	a, 0
		sta	activePanel

		; ������
		call	chooseDrive

		; ���� ������� ����������, �� ��������� ���.
		cpi	0FFh
		jz	loc_D5F2
		sta	panelA_drive

		; � ��� �� ������ ������ ������� � ���������� ������ � ������
		xra	a
		sta	panelA_info
		sta	panelA_curFile

loc_D5F2:	; ��������������� activePanel
		pop	psw
		sta	activePanel

		; ������������� � �������������� ������ ������
		call	loadAndPrintA

		; ������������� � �������������� ������ ������, ������ ���� ��� ������������
		lda	panelB_info
		ana	a
		jz	loc_D603
		call	loadAndPrintB
		
loc_D603:	; ��������� ��������� � �������
		call	saveState
		jmp	mainDriveChanged

; ---------------------------------------------------------------------------

chooseDrive:	COLOR(COLOR_DIALOG)

		lxi	h, g_chooseDrive
		call	draw

		; ������� ����� "CHOOSE DRIVE:"
		lxi	h, 1E63h
		call	setCursorPosPanel
		lxi	h, aChooseDrive
		call	printString

		; ������� ����� "A   B   C   D"
		lxi	h, 1C74h
		call	setCursorPosPanel
		lxi	h, aABCD
		call	printString

		; ������� ����� "E   F   G   H"
		lxi	h, 1C7Fh
		call	setCursorPosPanel
		lxi	h, aEFGH	
		call	printString

		; ������ ��� �������
		lda	v_cursorCfg
		push	psw
		xra	a
		sta	v_cursorCfg

		; ��������� ������� ����������
		lxi	h, panelA_drive
		call	readBytePanel
		sta	v_chooseDrive

loc_D644:	; ������ ������
		call	chooseDrive_draw

		; ���� ������� �������
		call	getch

		; ������� ������
		push	psw
		call	chooseDrive_draw
		pop	psw

		mvi	c, 1
		cpi	18h
		jz	loc_D690
		mvi	c, 7
		cpi	8
		jz	loc_D690
		mvi	c, 4
		cpi	1Ah
		jz	loc_D690
		cpi	19h
		jz	loc_D690
		cpi	0Dh
		jz	loc_D688
		cpi	1Bh
		jz	loc_D681

		; ����� ����� �������� �� A-H
		sui	41h
		cpi	8
		jnc	loc_D644
		mov	c, a

		; ��������������� ��� �������
		pop	psw
		sta	v_cursorCfg
		mov	a, c
		ret

; ---------------------------------------------------------------------------

loc_D681:	; ��������������� ��� �������
		pop	psw
		sta	v_cursorCfg

		; ������ �� �������
		mvi	a, 0FFh
		ret

; ---------------------------------------------------------------------------

loc_D688:	; ��������������� ��� �������
		pop	psw
		sta	v_cursorCfg
		; �������
		lda	v_chooseDrive
		ret

; ---------------------------------------------------------------------------

loc_D690:	lda	v_chooseDrive
		add	c
		ani	7
		sta	v_chooseDrive
		jmp	loc_D644

; ---------------------------------------------------------------------------

chooseDrive_draw:
		; ��������� ����������
		lda	v_chooseDrive

		; ���������� �������
		lxi	h, 976Ch

		; ������ ������
		cpi	4
		jc	chooseDrive_draw2
		 sui	4
		 mov	c, a
		 mov	a, l
		 adi	0Bh
		 mov	l, a
		 mov	a, c
chooseDrive_draw2:	
                ; ������
		mov	c, a
		add	a
		add	c
		add	h
		mov	h, a
		call	activePanelPos
		mvi	b, 1		; ������ 8 ��������
		jmp	inverseRect	; hl - �����
		