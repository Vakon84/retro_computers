;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� C845
; ������ ����� ����� � ���������� � v_header2_name
;
; 2013-11-01 vinxru
;----------------------------------------------------------------------------

inputFileName:	push	h
		push	d
		push	b

		; ������������� ����� ��������
		lxi	h, popa_ret
		push	h

 		; ������� ��������� �� ����� � �������� ������ ������
		lxi	h, a_inputFileName
		call	printString

		; ������ �� ����� ����� ��� ����� �������
		call	printFileName2

loc_C873:	; ������������ ������ ������
		call	popCursorLine

		; ���� ����� �����
		lxi	h, v_header2_name
		lxi	d, 0CFFh
		call	input

		; ����� ESC
		rz

		; ������ ����� �������, ������� ���� ������� � ��������� � �����
		lxi	h, loc_C873
		push	h
		jnc	xra_a_stc_ret

		; �������� ������
		lhld	v_pushCursorLn
		mov	a, h
		adi	3*8
		mov	h, a
		shld	v_cursorPos

		; ����������� ����� ������ � ����������� ������ ���� ��������
		lxi	h, v_header2_ext-1
		mvi	b, 4
		mov	a, m
		cpi	20h
		jnz	xra_a_stc_ret		

		; ����������
loc_C89C:	 dcr	b
		 call	printCharA
		 jz	loc_CE8A	; ������� �� pop h, ora a, ret
		 inx	h
		 mov	a, m
		 cpi	20h
		jnz	loc_C89C
		
xra_a_stc_ret:	; ����� ����� �������
		mvi	a, '?'
		call	printCharA
		xra	a

ora_a_stc_ret:	ora	a
		stc
		ret
