;----------------------------------------------------------------------------
; MXOS NC.COM
; ���� ������ � ������� ���������� ���������� ��� ���������� �����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

inputForCopyMove:
		; ��������� �������
		lxi	h, 3D6Eh
		shld	v_cursorY

		; ������ ��� ��������������	
		lxi	d, v_input

		; ������������ �� ������?
		lxi	h, panelA_info
		lda	activePanel
		ana	a
		jnz	loc_D255
		inx	h
loc_D255:	mov	a, m

		; ���� �� ������������, �� ���������� � ������ �� ��������
		ana	a
		jnz	loc_D265

		; ���������� ����� ����������
		inx	h
		inx	h
		mov	a, m
		adi	'A'
		stax	d
		inx	d

		; ���������� ':'
		mvi	a, ':'
		stax	d
		inx	d

loc_D265:	; �������� ��������� ����
		call	getSelectedFile
		call	compactName

		; �������� 0
		dcx	d
		dcx	d
		xra	a
		stax	d

		; ������� � �������������
		jmp	input