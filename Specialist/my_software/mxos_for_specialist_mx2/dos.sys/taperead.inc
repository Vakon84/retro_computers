;+---------------------------------------------------------------------------
; MXOS
; ������ ����� � �����
;
; �� �����
;  a=255 �������� ������� ����� 
;  a=8   ��������
;
; �� ������
;  c - ����
;  de,hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

tapeRead:	; ��������� ��������
		push	b
		push	d

		; ��� ����� �������� ����
		mvi	c, 0

		; d=8 ���� �������� (������� ���) ��� 0FFh ���� ��������
		mov	d, a

tapeRead_0:	; �������� ���������
		lda	IO_KEYB_B
		ani	1
		mov	e, a

		; �������� C
		mov	a, c
		ani	7Fh
		rlc
		mov	c, a

tapeRead_1:	; �������� ���������
		lda	IO_KEYB_B

		; ���� ������ �������, �������
		cpi	80h
		jc	tapeReadError

		; ���� ��������� �������
		ani	1
		cmp	e
		jz	tapeRead_1

		; ��������� ���
		ora	c
		mov	c, a

		; ��������
		call	readDelay

		lda	IO_KEYB_B
		ani	1
		mov	e, a

		; ���� ���������� �������� ������, ��������� �� tapeRead_4
		mov	a, d
		ora	a
		jp	tapeRead_4

		; ���� ���������� ��������
		; ���� �� ������ 0E6h, ��������� tapeRead_2
		mov	a, c		
		cpi	0E6h
		jnz	tapeRead_2

		; �������� �������� ��� ��������
		xra	a
		sta	v_tapeInverse
		jmp	tapeRead_3

tapeRead_2:	; ���� �� ������ 19h, ��������� �� tapeRead_0
		cpi	19h
		jnz	tapeRead_0

		; �������� �������� � ���������
		mvi	a, 0FFh
		sta	v_tapeInverse

		; ��������� 8 ���
tapeRead_3:	mvi	d, 9

		; ��������� 8 ����
tapeRead_4:	dcr	d
		jnz	tapeRead_0

		; �������� �����
		lda	v_tapeInverse
		xra	c

		; �������������� ��������
		pop	d
		pop	b
		ret
