;+---------------------------------------------------------------------------
; RAMFOS
; ����� ����������� � ������� ������
; ��� ������� ���������� ������ �� printIndicators � clearTopLine
;
; 2013-11-01 ����������������� � ���������� vinxru
;----------------------------------------------------------------------------

#if FAST_PRINT
INDCATORS_SEP = ' '
#else
INDCATORS_SEP = 11h
#endif

printIndicatorsInt:	
		; ���� ���� �������� � ���, �����������, ������� �� ����
#if DATE_IN_RAM
		lda	v_header2_saved
		cpi	8Bh
		cnz	inputDate
#endif
		; ��������� ��������� ������� (0 ����� 45 �������)
		lxi	h, 8708h	
		shld	v_cursorPos

		; ���� ���� �������� � ����, �����������, ������� �� ����
#if DATE_IN_RAM==0
		; ������ �� ������� �������� ���� �� ������ v_aramPageEnd+1
		lhld	v_aramPageEnd
		inx	h
		xra	a
		call	j_pageReadAny
		
		; ���� ��� ������� �� 8B, �� ��������� � ����� ����
		mov	a, c
		cpi	8Bh
		push	h		
		jnz	inputDate
#endif

		; �����������
		mvi	a, INDCATORS_SEP
		call	printCharA

		; ������� �������� ������ �� �����
		lda	v_tapeMode
		call	printCharA

		; ������� ����� ���������
		lda	v_printerEcho
		call	printCharA

		; ������� CAPS LOCK
		lhld	v_rusLat
		dcr	h
		mvi	a, 0Bh
		jm	loc_C9D5
		 mvi	a, 0Fh		 
loc_C9D5:	call	printCharA

		; ������� ���/LAT
		inr	l
		lxi	h, a_lat
		jnz	loc_C9E2
		  lxi	h, a_rus
loc_C9E2:	call	printString

		; ������� KOI8/7
		lda	v_koi8
		ora	a
		mvi	a, '8'
		jz	loc_C9EF
		  dcr	a		  
loc_C9EF:	call	printCharA

#if FAST_PRINT
		mvi	a, ' '
		call	printCharA
#else
		call	printChar6
#endif

#if DATE_IN_RAM
		; �����������
		mvi	a, INDCATORS_SEP
		call	printCharA

		; ����� �� ����� ����
		lda v_header2_date
		call	printHex

#if NICE
		mvi	a, '-'
		call	printCharA
#endif
		; ����� �� ����� ����
		lda	v_header2_date+1
		call	printHex
#if NICE
		mvi	a, '-'
		call	printCharA
#endif
		; ����� �� ����� ����
		lda v_header2_date+2
		call	printHex
#else
		pop	h

		; ����� ��� ���������� ����
		lxi	d, v_header2_saved

		; ��������� C � v_header2_saved <--- ????
		mov	a, c
		stax	d

		; �����������
		mvi	a, INDCATORS_SEP
		call	printCharA

		; ����� �� ����� ����
		mvi	b, 3		; 3 �����
loc_CA02:	 inx	h
		 inx	d
		 ; ������ ���� �� ������� ��������
		 xra	a
		 call	j_pageReadAny
		 ; ������ � ������
		 mov	a, c
		 stax	d
		 ; ����� �� �����
		 call	printHex
		 ; ���� 3-1
		 dcr	b
		jnz	loc_CA02
#endif

#if FAST_PRINT
		ret
#else
		jmp	printChar6
#endif

;----------------------------------------------------------------------------
; RAMFOS
; ������ ���
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if NO_PRINT_STATUS_BUG==0
printIndicatorsEnd:
		pop	psw
		cnz	changeInverse
#endif

;----------------------------------------------------------------------------
; RAMFOS
; ������� ������� ������ � ����������� ���� �������
; ���������� ��� ������ ������� 08Fh
;
; 2013-11-01 ����������������� � ���������� vinxru
;----------------------------------------------------------------------------

clearTopLine:	
#if COLOR_SUPPORT
		; ���� �� ���������
		mvi	a, INIT_SCREEN_COLOR
		call	setColor
#endif

		; �������� ������� ������� ������
		call	clearTopLine2

		; ������������� ������ � ������� ������
		lxi	h, 8
		shld	v_cursorPos

		; ?
		lxi	h, 140Ah
		shld	v_topLineHeight

;----------------------------------------------------------------------------
; RAMFOS
; ����� ����������� � ������� ������ � ����������� �������, ����� � ��������
; ��� ������� ���������� ������ �� keyScan
;
; 2013-11-01 ����������������� � ���������� vinxru
;----------------------------------------------------------------------------

printIndicators:
		; �� �������� ����������
		lda	v_topLineHeight
		ora	a
		rz

		; ���������� ��������� �������
		lhld	v_cursorPos

		; ���������� �������� � �����
		lda	v_inverse
		ora	a
		push	psw
#if FAST_PRINT
		; ���� �������� �� ���� ��������, �������� �.
		cz	changeInverse
#else
		; ���� �������� ���� ��������, ��������� �.
		cnz	changeInverse
#endif	

		; ���������� ����� � ��������� ������������ �����
#if COLOR_SUPPORT
		lda	v_color
		push	psw
		mvi	a, 0F0h
		call	setColor
#endif

		; ����� ��������� ������
		push	h
		 call	printIndicatorsInt
		pop	h

		; �������������� �����
#if COLOR_SUPPORT
		pop	psw
		call	setColor
#endif
	
		;  �������������� ��������� �������
		shld	v_cursorPos
		 
#if NO_PRINT_STATUS_BUG==0
		jnz	printIndicatorsEnd
#endif

		;  �������������� ��������
		pop	psw
#if FAST_PRINT
		rnz
#else
		rz
#endif	
		; ������������ � changeInverse