;+---------------------------------------------------------------------------
; MXOS
; ��������� ������ ����� (�����������)
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

scrollUp2:	; �������� 246 ���� �� SP � H0 
		mvi	c, 246 / 6
		mvi	l, 0

scrollUp2_0:	; ����������� 6 ���� �� SP � HL
		pop	d
		mov	m, e
		inx	h
		mov	m, d
		inx	h
		pop	d
		mov	m, e
		inx	h
		mov	m, d
		inx	h
		pop	d
		mov	m, e
		inx	h
		mov	m, d
		inx	h

		; ����
		dcr	c
		jnz	scrollUp2_0

		; ��������� H
		mov	a, h
		
		; ��������� 10 ���� 
		lhld	v_inverse
		push	h
		push	h
		push	h
		push	h
		push	h

		; ��������� ������� (SP += 20)
		lxi	h, 14h
		dad	sp
		sphl

		; ��������������� H
		mov	h, a

		; ��������� �������
		inr	h

		; ����
		dcr	b
		jnz	scrollUp2

		; �������������� ��������� � �����
		lhld	v_oldSP
		sphl
		pop	psw
		pop	b
		ret