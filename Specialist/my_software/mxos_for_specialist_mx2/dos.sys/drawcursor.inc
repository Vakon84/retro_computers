;+---------------------------------------------------------------------------
; MXOS
; ��������� ������� �� ������
;
; �� ������
;  bc,de,hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

drawCursor:	; ���� ���������� 7-�� ��� v_cursorCfg & 0x80, �������
		lda	v_cursorCfg
		ana	a
		rm

drawCursor2:	; ������ ���������/�����
		inr	c
		
drawCursor3:	; ��������� ��������
		push	h
		push	b
		push	d

		; ������������ ����� �� ������
		call	calcCursorAddr
		mov	d, a

		; ��������� ������� �� +2 �� -5 (��� ����� 654 �� 0 �� 7)
		; b = v_cursorCfg
		; e = ~((v_cursorCfg / 16) % 8 - 3) + l
		lda	v_cursorCfg
		mov	b, a
		rrc
		rrc
		rrc
		rrc
		ani	7
		sui	3
		cma
		add	l
		mov	e, a

		; ����������� ����� �������
		;  hl = 011111100b << (((~h) % 4 +1)*2)
		mov	a, h
		cma
		ani	3
		lxi	h, 011111100b ; FCh
		inr	a
drawCursor_0:	dad	h
		dad	h
		jmp	drawCursor_1