;+---------------------------------------------------------------------------
; RAMFOS
; �������� ������� ������� � ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

keyCursor:	; ������ ������ XOR-��
		call	keyCursor1
		; ������� ������ XOR-��
		call	keyCursor1
		; ���� ���� ������ ��������, �������
		rnz
		; ����������� ��������
		jmp	keyCursor

;----------------------------------------------------------------------------

keyCursor1:	
#if FAST_PRINT != 1
		; ��� ������� �������
		mvi	c, 17h

		; ��������� ������� � �������� 		
		lhld	v_cursorPos
		xchg

		; ��������� ����������� ������� hl � ������ � ����������� de
		call	calcCharAddr2

		; ������������� ������
		mov	a, e
		sui	7
		mov	e, a

		; ��������� �������
		call	drawChar
#else ;----------------------------------------------------------------------
		; ��������� ������� � �������� 		
		lhld	v_cursorPos
		xchg

		; ��������� ������ � ����������� de
		call calcCharAddr

		; �������� ������
		lxi	h, 3Fh		 

		; ��������
		mov	a, c		
drawCursor_0:	 dad	h
		 dad	h
		 dcr	a
		jnz	drawCursor_0

		; ���� b
		mvi	b, 8
drawCursor_1:	 ; *de++ ^= hl
		 ldax	d
		 xra	h
		 stax	d		 
		 inr	d		 
		 ldax	d
		 xra	l
		 stax	d
		 dcr	d
		 dcr	e		
		 ; ����
		 dcr	b
		jnz	drawCursor_1
#endif ;---------------------------------------------------------------------
		; ���� ������� �������
		lxi	h, CURSOR_BLINK_SPEED
keyCursor1_0:	 call	keyCheck
		 rnz
		 dcx	h
		 mov	a, h
		 ora	l
		jnz	keyCursor1_0
		ret