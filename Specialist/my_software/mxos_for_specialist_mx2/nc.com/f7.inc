;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� F7. �������� ����� � ����� �� ����������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

; ���������� SP	� ��������� ���	������.

prepareTapeLoad:lxi	h, 0
		dad	sp
		inx	h
		inx	h
		shld	v_savedSP

		lxi	h, tapeErrorHandler
		shld	v_tapeError

		mvi	a, 0Fh
		sta	IO_KEYB_C
		mvi	a, 0FEh
		sta	IO_KEYB_A
		ret

; ---------------------------------------------------------------------------

F7:		; ������ ����
		call	drawWindow1

		; ������� "LOADING TAPE TO A:"
		lxi	h, 445Eh
		shld	v_cursorY
		lxi	h, aLoadingTapeTo
		call	printString		
		call	printSelDrive
		
		; ���������� SP	� ��������� ���	������.
		call	prepareTapeLoad	

loc_D2AA:	; ���� ����� � D9 D9 D9
		mvi	a, 0FFh		
		mvi	c, 3
		jmp	loc_D2B3
loc_D2B1:	 mvi	a, 8
loc_D2B3:	 call	tapeRead
		 cpi	0D9h 
		 jnz	loc_D2AA
		 dcr	c
		jnz	loc_D2B1

		; ������ ���
		lxi	h, files2
		mov	d, h
		mov	e, l
		mvi	c, 9		
loc_D2C6:	 mvi	a, 8
		 call	tapeRead
		 cpi	' '
		 jc	loc_D370
		 mov	m, a
		 inx	h
		 dcr	c
		jnz	loc_D2C6

loc_D2D6:	mvi	m, 0

		call	printInvFile

		; ���� ����� � ������ �����
		mvi	a, 0FFh
		call	tapeReadWord2		
		shld	word_DDA0

		; ��� ���� �����
		xchg
		call	tapeReadWord

		; ��������� ��������
		mov	a, l
		sub	e
		mov	l, a
		mov	a, h
		sbb	d
		mov	h, a
		shld	v_file_length

		; ������ ������ �� ������ 0000
		inx	h
		xchg
		lxi	h, 0
		shld	v_file_addr		
loc_D2F8:	mvi	a, 8
		call	tapeRead
		mov	m, a
		inx	h
		dcx	d
		mov	a, d
		ora	e
		jnz	loc_D2F8

		; ����� CRC
		call	tapeReadWord
		shld	v_tapeSaveCRC

		; ������� CRC
		lhld	v_file_length
		xchg
		lxi	h, 0
		dad	d
		xchg
		lxi	h, 0
		call	calcCS
		lhld	v_tapeSaveCRC

		; ���� ��������� CRC �� ����� ���������, �������
		mov	a, b
		cmp	h
		jnz	F7_crcError
		mov	a, c
		cmp	l
		jnz	F7_crcError

		call	sub_D333

		; �������������� ����� � ���������� ��������
		call	loadAndPrintA
		call	loadAndPrintB
		jmp	F7

; ---------------------------------------------------------------------------

sub_D333:	lhld	word_DDA0
		push	h
		lxi	h, files2
		jmp	loc_D4E4

; ---------------------------------------------------------------------------

F7_crcError:	call	drawWindow2

		; ����� "ERROR LOADING TAPE"
		lxi	h, 4680h
		shld	v_cursorY
		lxi	h, aErrorLoadingTa
		call	printString

		; ����� ������ �� v_input
		lxi	h, 5090h
		shld	v_cursorY
		lxi	h, v_input
		call	printStringInv

loc_D358:	; ���� ������� ESC
		call	keyScan
		cpi	1Bh
		jnz	loc_D358

		jmp	mainReload

;----------------------------------------------------------------------------
; ������ ����� � �����
;----------------------------------------------------------------------------

tapeReadWord:	mvi	a, 8
tapeReadWord2:	call	tapeRead
		mov	l, a
		mvi	a, 8
		call	tapeRead
		mov	h, a
		ret


; ---------------------------------------------------------------------------

loc_D370:	mvi	m, ' '
		inx	h
		dcr	c
		jnz	loc_D370
		jmp	loc_D2D6
