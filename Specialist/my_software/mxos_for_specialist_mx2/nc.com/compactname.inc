;----------------------------------------------------------------------------
; MXOS NC.COM
; ������ �� ����� �������
;
; hl - ������
; de - ����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

compactName:	; ��������� ��������
		push	h
		push	b

		; �������� �� �������, �� �� ����� 6 ����
		lxi	b, 6		
compactName_1:	mov	a, m
		cpi	' '
		jz	compactName_2		
		stax	d
		inx	h
		inx	d
		dcr	c
		jnz	compactName_1

compactName_2:	; ����������� ������� �������� ������
		dad	b

		; �����
		mvi	a, '.'
		stax	d
		inx	d

		; �������� 3 �����
		mvi	c, 3
compactName_3:	mov	a, m
		cpi	' '
		jz	compactName_4
		stax	d
		inx	h
		inx	d
		dcr	c
		jnz	compactName_3

compactName_4:	xchg
		push	psw

		; ���� ��������� ������ '.', �� ������� ���
		dcx	h
		mov	a, m
		cpi	'.'
		jz	compactName_5
		inx	h
compactName_5:	

		; ��������� ������ � ����� ������
		mvi	m, ' '
		inx	h
		mvi	m, 0Dh
		inx	h
		mvi	m, 0

		; ��������� � DE
		xchg

		; �������������� �������� � �������
		pop	psw
		pop	b
		pop	h
		ret