;----------------------------------------------------------------------------
; RAMFOS
; �������� ��� ������� �� ������
;
; 2013-11-01 vinxru
;----------------------------------------------------------------------------                   

getCharFromScreen:
		push	h
		push	d
		push	b

		; ����� ��������
		lxi	h, popa_ret
		push	h

		; ��������� ������� � ��������
		lhld	v_cursorPos	

		; ������ ������
		xchg
		call	calcCharAddr
		xchg
		
		; � - �������� � �����
		; hl - ����� � �����������

		mvi	b, 8 ; ������ �������
		lxi	d, unk_D21A ; ���� ����� ���������� ������ � ������
		push	d		
loc_CAF9:	 push	h
		  ; ��������� � HL �� ������ �� ������ HL
		  mov	a, m		
		  inr	h
		  mov	l, m
		  mov	h, a
		  ; �������� HL �� c*2 ���
		  mov	a, c
loc_CAFF:	   push	psw
		    call	hl_div_2
		    call	hl_div_2
		   pop 	psw
		   dcr	a
		  jnz	loc_CAFF
		  ; ��������� ������ ������ 6 ��� �� ������ de
		  mov	a, l
		  ani	3Fh
		  stax	d
		  dcx	d
		 pop	h
		 dcr	l
		 dcr	b
		jnz	loc_CAF9

		; ���� v_inverse �� ����
		lda	v_inverse
		ora	a
		jz	loc_CB29
		 ; ����������� ���� �� ������ de
		 mvi	b, 8
loc_CB1F:	  ; de++
		  inx	d
		  ; *de = (*de ^ 0xFF) & 0x3F;
		  ldax	d
		  cma
		  ani	3Fh
		  stax	d
		  ; ����
		  dcr	b
		 jnz	loc_CB1F
loc_CB29:	pop	d

		; de - ����� �� ������

		; ���������� ������ ������ �� ��������������� � �������

		mvi	a, -1
		lhld	v_charGenPtr	; ��������������
		lxi	b, 8		; ������ �������
loc_CB32:	 ; ��������� ������
		 dad	b		
		 push	b
		 push	d
		 push	h
		  mov	b, a
		  call	compareChar
		  mov	a, b
		 pop	h
		 pop	d
		 pop	b
		jnz	loc_CB32

		; �������������� �� �������� �������� 80-BF
		cpi	80h
		rc
		adi	40h		
		ret

; ---------------------------------------------------------------------------

compareChar:	; if(a == 0xBF) return true;
		cpi	0BFh
		rz
		; ���������� ����� �������
		inr	b
		; ����� memcmp_hl1_de_c
