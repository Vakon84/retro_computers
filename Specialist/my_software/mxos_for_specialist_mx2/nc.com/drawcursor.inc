;----------------------------------------------------------------------------
; MXOS NC.COM
; ��������� �������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

drawCursor:	; ���� �������������� ����� �������

		; ���� ������ ���, �������
		lxi	h, panelA_filesCnt
		call	readBytePanel
		ana	a
#if ENABLE_COLOR
		rz
#else
		jz	drawCursor_0
#endif
		; ����� ���������� �����
		lxi	h, panelA_curFile
		call	readBytePanel

		; ������������ ���������� X (h = a < 18 ? 0x91 : 0x9D)
		mvi	h, 91h
		cpi	18
		jc	drawCursor_1
		sui	18
		mvi	h, 9Dh

drawCursor_1:	; ������������ ���������� Y (l = a * 10 + 18h)
		add	a
		mov	c, a
		add	a
		add	a
		add	c
		adi	24
		mov	l, a

		; ������
		mvi	b, 10

		; ���� ������ ������, �������� ������ �� ��� ������
drawCursor_2:	lda	activePanel
		ana	a
		jz	drawCursor_3
		mvi	a, 18h
drawCursor_3:	add	h
		mov	h, a

		; ������ ������ (hl - �����, b - ������, ������ 9)
		call	inverseRect
		ret

; ---------------------------------------------------------------------------

#if ENABLE_COLOR==0
drawCursor_0:	lxi	h, 92D6h
		mvi	b, 2
		jmp	drawCursor_2
#endif