;+---------------------------------------------------------------------------
; MXOS
; ��������� ����
;
; �� �����
;  hl - ���
;  de - ����� ��������
;
; �� ������
;  bc,de,hl - �����������
;  v_foundedFile - ��������� ����
;  cf - ������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileLoad2:	; ���� ���� � ������ � HL
		call	fileFind2
		rc

		; ��������� ��������
		push	h
		push	b
		push	d

		; ��������� �� ����� ���������� �����
		lhld	v_foundedFile
		lxi	b, 13
		dad	b

		jmp	loc_CCBA

;----------------------------------------------------------------------------
; ��������� ���� �� ������ ���������� � ���������
;
; �� �����
;  hl - ���
;
; �� ������
;  bc,de,hl - �����������
;  v_foundedFile - ��������� ����
;  cf - ������
;----------------------------------------------------------------------------

fileLoad:	; ���� ���� � ������ � HL
		call	fileFind
		rc

		; ��������� ��������
		push	h
		push	b
		push	d

		; DE = ����� ��������
		lhld	v_foundedFile
		lxi	d, 10
		dad	d
		mov	e, m ; +10
		inx	h
		mov	d, m ; +11

		inx	h
		inx	h

loc_CCBA:	; ����� ����� � ���������
		mov	b, m ; +13
		inr	b
		
		; ������ �������
		inx	h
		inx	h
		mov	a, m ; +15

		xchg

loc_CCC0:	; ������ ������� � ������
		mvi	e, 2		; ������
		mov	d, a		; �������
		call	j_diskDriver

		; ��������� �������
		inr	h
		mov	e, d
		mvi	d, 0FBh
		ldax	d

		; ����
		dcr	b
		jnz	loc_CCC0

		; ��������������� ��������
		pop	d
		pop	b
		pop	h

		jmp	loc_CCD9

; ---------------------------------------------------------------------------

fileLoadInfo:	; ���� ���� � ������ � HL
		call	fileFind
		rc

loc_CCD9:	; ��������� ��������
		push	h
		push	b
		push	d

		; ��� �� � DE
		lxi	b, 9
		dad	b
		xchg

		; ���������� � ����� �������� ���
		lhld	v_foundedFile
		dad	b

		; �������� 7 ���� �� HL � DE
		mvi	b, 7
loc_CCE7:	mov	a, m
		stax	d
		inx	h
		inx	d
		dcr	b
		jnz	loc_CCE7

		; ����� CF=0
		ora	a
		jmp	pop_dbh_ret
