;----------------------------------------------------------------------------
; RAMFOS
; �������� �����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

clearScreen:	
#if COLOR_SUPPORT
		; ���� �� ���������
		mvi	a, INIT_SCREEN_COLOR
		call	setColor
#endif
clearScreen2:
		; ��������� SP
		lxi	h, 0
		dad	sp
		shld	v_oldSP

		; �������
		mvi	b, 48

		; ���� ��� ������� ������
		lda	v_inverse
		mov	d, a
		mov	e, a

		; �������� �����. �������� � 383,240.
		lxi	h, 0BFF0h
loc_CE1B:	 sphl
		 mvi	c, 23		; 230 �����
loc_CE1E:	  push	d
		  push	d
		  push	d
		  push	d
		  push	d
		  dcr	c
		 jnz	loc_CE1E
		dcr	h
		dcr	b
		jnz	loc_CE1B

		; �������������� SP
		lhld	v_oldSP
		sphl

		; ������ ����� � ����������� � �������� ���������

		; ��� ������ �������� ������� 1F �������� ������ ������
		lxi	h, v_dblClear
		mvi	a, 1Fh
		cmp	m
		cz	bottomLineHide	; ���� �������, �� �� ������ A=0		
		sta	v_dblClear

		lda	v_topLineHeight
		ora	a
		cz	clearTopLine2

		lda	v_screenHeight
		cpi	250
		cz	sub_CE57

loc_CE4B:	; cursorX = 0
		mvi	h, 0

		; cursorY = byte_D231 - 2
		lda	v_topLineHeight+1
		dcr	a
		dcr	a
		mov	l, a
		
saveCursorPos:	; ��������� ��������� �������
		shld	v_cursorPos
		ret

; ---------------------------------------------------------------------------

sub_CE57:	lxi	d, 10h
		jmp	clearLine	; d - ������, e	- ������

; ---------------------------------------------------------------------------
