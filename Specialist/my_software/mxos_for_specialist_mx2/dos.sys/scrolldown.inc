;+---------------------------------------------------------------------------
; MXOS
; ��������� ������ ����
;
; �� ������
;   af, bc - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

		; ��������� ��������
		push	b
		push	psw
		lxi	h, 0
		dad	sp
		shld	v_oldSP

		; ���������� ����������
		lxi	sp, 0C000h ; ����
		mvi	h, 0BFh	   ; ������
		mvi	b, 48      ; ��������
loc_C741:	mvi	c, 246 / 6 ; 246 �����
		mvi	l, 245	   ; �������� � 245 ������

loc_C745:	; �������� 6 ���� �� HL � SP
		mov	d, m
		dcx	h
		mov	e, m
		dcx	h
		push	d		
		mov	d, m
		dcx	h
		mov	e, m
		dcx	h
		push	d
		mov	d, m
		dcx	h
		mov	e, m
		dcx	h
		push	d

		; ����
		dcr	c
		jnz	loc_C745

		; ��������� H
		mov	a, h
		
		; ������� ������� 10 �����
		lhld	v_inverse
		push	h
		push	h
		push	h
		push	h
		push	h

		; ��������������� H
		mov	h, a

		; ��������� �������
		dcr	b
		jnz	loc_C741

		; �������������� �������� � �������
		lhld	v_oldSP
		sphl
		pop	psw
		pop	b
		ret