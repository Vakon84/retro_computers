;+---------------------------------------------------------------------------
; RAMFOS
; ������� ����������� �������
;
; �� ����� � ������ ������� HL ������ ��������� v_cursorPos
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

cursorRight:	; ���� v_cursorX >= 190, �� ������� �� ����� ������
		mov	a, h
		cpi	190
		jnc	cursorCrLf

		; v_cursorX += 3
		adi	3
		mov	h, a

		; ��������� ����� ��������� ������� (shld v_cursorPos, ret)
		jmp	saveCursorPos

; ---------------------------------------------------------------------------

cursorCrLf:	; v_cursorX = 0
		mvi	h, 0

cursorDown:	; ���� v_cursorY > screenHeight+10, �������� ����� �����
		lda	v_screenHeight+1
		cmp	l
		jc	scrollUp

		; cursorY += 10
		mov	a, l
		adi	10
		mov	l, a

		; ��������� ����� ��������� ������� (shld v_cursorPos, ret)
		jmp	saveCursorPos

; ---------------------------------------------------------------------------

cursorLeft:	; ���� ������ � ������ ���� ������, ������ �� ������
		mov	a, h
		cpi	2
		jc	saveCursorPos

		; v_cursorX -= 3
		sui	3
		mov	h, a

		; ��������� ����� ��������� ������� (shld v_cursorPos, ret)
		jmp	saveCursorPos

; ---------------------------------------------------------------------------

cursorUp:	; ���� ������ �� �� ������� ��������� ������, �� �������� ����� �����
		lda	v_topLineHeight+1
		cmp	l
		jnc	scrollDownX0

		; v_cursorY -= 10
		mov	a, l
		sui	10
		mov	l, a

		; ��������� ����� ��������� ������� (shld v_cursorPos, ret)
		jmp	saveCursorPos