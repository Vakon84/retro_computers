;----------------------------------------------------------------------------
; RAMFOS
; ����� ������ �����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

scrollUp:	push	h
		mov	a, l		; c =  (l + 2 -	word_D231)/2

		lhld	v_topLineHeight
		mov	e, h		; e = word_D231
		inr	a
		inr	a
c_scrolUpEx:	sub	e
		rar
		mov	c, a
		; ����� �����
		mvi	h, 90h
		mov	d, h
		; �������		
		mvi	b, 48
loc_CD5A:	 push	h
		 push	d
		 push	b
		  ; �������� C ����
		  inr	c
		  dcr	c
		  cnz	memcpy_hl_de_c2
		  ; ������� ��������� 10 ����
		  lda	v_inverse
		  mvi	c, 10
loc_CD67:	   mov	m, a
		   inr	l
		   dcr	c
		  jnz	loc_CD67
		 pop	b
		 pop	d
		 pop	h
		 ; ��������� �������
		 inr	h
		 inr	d
		 dcr	b
		jnz	loc_CD5A
		pop	h
		; ��������� ��������� �������	
saveCursorPosX0:mvi	h, 0
		jmp	saveCursorPos
