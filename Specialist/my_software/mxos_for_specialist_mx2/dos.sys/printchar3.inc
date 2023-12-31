;+---------------------------------------------------------------------------
; MXOS
; ��������� ��������� ����� ��� ������ �������
;
; �� �����
;  a - ������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

printChar3:	; ��� 7
		sui	7
		jz	beep
		; ��� 8
		dcr	a
		jz	printChar_c08
		; ��� 10
		sui	2
		jz	printChar_c0A
		; ��� 12
		sui	2
		jz	printChar_c0C
		; ��� 13
		dcr	a
		jz	printChar_c0D
		; ��� 24
		sui	11
		jz	printChar_c18
		; ��� 25
		dcr	a
		jz	printChar_c19
		; ��� 26
		dcr	a
		jz	printChar_c1A
		; �����������, ���� ��� 31
		sui	5
		rnz
		; ��� 31 ������� �����
		call	clearScreen

		; ����������� � printChar_c0C

; ---------------------------------------------------------------------------
; ��������� ���� 0Ch. ������ � ����� ������� ���� ������

printChar_c0C:	; v_cursorY = 8
		mvi	l, 8

		; ����������� � printChar_c0D

; ---------------------------------------------------------------------------
; ��������� ���� 0Dh. ������ � ������ ������

printChar_c0D:	; v_cursorX = 0
		xra	a
saveVCursorHA:	mov	h, a
saveVCursor:	shld	v_cursorY
		ret

; ---------------------------------------------------------------------------
; ��������� ���� 8h. �����

printChar_c08:	; cursorX -= 3
		mov	a, h
		sui	3

		; ���� ��� ��������, ��������� ��������� ������� � �����
		jnc	saveVCursorHA

		; cursorX = 189
		mvi	h, 189
		shld	v_cursorY

		; ����������� � printChar_c19

; ---------------------------------------------------------------------------
; ��������� ���� 19h. �����

printChar_c19:	; ���� cursorY<18, �� �����. ����� cursorY -= 10
		mov	a, l
		sui	0Ah
		rc
		cpi	8
		rc

saveVCursorLA:	; ��������� ��������� ������� � �����
		mov	l, a
		jmp	saveVCursor

; ---------------------------------------------------------------------------
; ��������� ���� 18h. ������

printChar_c18:	; ���� cursorX+3 >= 192, �� ������� �� printChar_c0A
		; ����� cursorX += 3
		mov	a, h
		adi	3
		cpi	0C0h
		jc	saveVCursorHA
		jmp	printChar_c0A