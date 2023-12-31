;----------------------------------------------------------------------------
; RAMFOS
; ����� ������� �� �����. ����������� printChar.inc
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

printChar_esc1:	; ��������� ������� ������� ESC-������������������

		; ���� ������ Y, ������� � ��������� ������� �������
		mov	a, c
		cpi	'Y'
		mvi	a, 2
		jz	setEscMode

		; ��������� ��� ������ ���� �������� ���������������
#if ALL_CHARS
printCharAll:
		xra	a
		sta	v_escMode
		lhld	v_cursorPos
		jmp	printChar_0
#endif

; ---------------------------------------------------------------------------

setEscMode0:	xra	a
setEscMode:	sta	v_escMode
		ret

; ---------------------------------------------------------------------------

printChar_esc2:	sta	v_escRow
		mvi	a, 3
		jmp	setEscMode

; ---------------------------------------------------------------------------

setEscMode1:	mvi	a, 1
		jmp	setEscMode
		
; ---------------------------------------------------------------------------

printChar_esc:	; ��������� ESC ������������������

		; ���� printChar_esc1Mode=1
		dcr	a
		jz	printChar_esc1
		mov	b, a

		; ������� �� ����� 20h
		mov	a, c
		sui	20h

		; ���� printChar_esc1Mode=2, ��������� 
		dcr	b
		jz	printChar_esc2

		mov	l, a
		lda	v_escRow
		mov	h, a
		call	setEscMode0

		; ����������� setCursorPos