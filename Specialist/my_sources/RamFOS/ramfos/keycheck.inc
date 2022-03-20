;----------------------------------------------------------------------------
; RAMFOS
; ���������� ���������� � ��������� (������� ��� ������������ ����������)
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if FAST_PRINT==0
keyScanWhilePrint:
		; ��������� ������ �� ����� ������ � ���������

		; ���� v_cursorY=8 ��� 248, ������� 
		mov	a, e
		cpi	8
		rz
		cpi	248
		rz

		; ���� ������� ��� ����� �� �������
		lda	v_printerEcho
		cpi	0D2h
		jz	doPrinterEcho
#endif
		
keyCheck:
		; ����� �� ����
		lda	v_key2
		ora	a
		rnz

		; ��� �� �������
		push	h
		push	d
		 lhld	v_key0
		 xchg
		 lhld	v_key1
		 call	sub_CEE2
		 shld	v_key1	; ������� ������� � L
		 xchg
		 shld	v_key0
		 sta	v_key2

		; pop d
		; pop h
		; ora a
		; ret
		jmp	popa_ora_a_ret

; ---------------------------------------------------------------------------

sub_CEE2:	; �������� ��� ������� �������
		call	keyScan

		; ���� ������� ������� �� L
		cmp	l
		mov	l, a
		jnz	loc_CF01

		; ���� ������� �� ���� ������, ������� � ����� 0
		inr	a
		rz

		; ��������� DE, � ���� �� �� �������, ������� � ����� 0
		dcx	d
		mov	a, d
		ora	e
		mvi	a, 0
		rnz

		; �������� ������
		call	keySound

		; �������������� �������
		lxi	d, 17Ch

		; ���� H=0, ������� � ����� 0FFh
		dcr	h
		mvi	a, 0FFh
		rz

		; ���������� H
		inr	h

		; �������������� �������
		lxi	d, 1Ch
		ret
; ---------------------------------------------------------------------------

loc_CF01:	; ���������� H=1
		mvi	h, 1

		; ������� � ����� 0
		xra	a        	

		; �������������� �������
		lxi	d, 30h
		ret

; ---------------------------------------------------------------------------