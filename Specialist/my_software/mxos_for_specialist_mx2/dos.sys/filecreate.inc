;----------------------------------------------------------------------------
; MXOS
; ������� ����
;
; �� �����
;  hl - ��� ����� � ���������� (�� � ������� ������ ��������)
;
; �� ������
;  �f - ������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileCreate:	; ��������� ��������
		push	h
		push	b
		push	d

		; ���� ���� ����������, �� ������� ���
		call	fileFind
		cnc	deleteFileInt

		; ��������� ������� ������ ��������
		push	h

		; ���� ��������� ������ � ��������
		lxi	h, diskDirectory	; ����� ��������
		lxi	d, 16			; ������ ������ � ��������
		mvi	b, 48			; �������� ������
fileCreate_0:	mov	a, m
		inr	a
		jz	fileCreate_1		; ��������� ������ �������
		dad	d
		dcr	b
		jnz	fileCreate_0

		; ��������� ������� ���

		; ����������� ����
		pop	h

		; ��������� A=0, ZF=1
		xra	a		

stc_pop_dbh_ret:; ��������� ����� CF=1
		stc

pop_dbh_ret:	; �������������� ��������� � �����
		pop	d
		pop	b
		pop	h
		ret

; ---------------------------------------------------------------------------
; ��������� ������ �������

fileCreate_1:	; ����� ��������� ������ � DE
		xchg

		; ������� ������ �������� � HL
		pop	h

		; �������� ������� ������ � ������� 
		mvi	c, 14
fileCreate_2:	mov	a, m
		stax	d
		inx	h
		inx	d
		dcr	c
		jnz	fileCreate_2

		; ��������� ����� ���������� �����
		xchg
		shld	v_createdFile
			
		; ���� ��������� �������
		call	fileFindClusterFirst
		jc	stc_pop_dbh_ret

		push	psw

		; ��������� � ������� ����� ������� ��������
		inx	h
		mov	m, a ; [15]

		; ������ �����
		dcx	h
		dcx	h
		mov	d, m ; [13]
		dcx	h
		mov	e, m ; [12]

		; ������ �����
		dcx	h
		mov	b, m ; [11]
		dcx	h
		mov	l, m ; [10]

		; ��������� �����
		mov	h, b
		shld	v_input_start

		; ��������� �����
		xchg
		shld	v_input_end

		; ?
		mov	b, h
		inr	b
		mvi	h, 0FBh

		; ������ ������� �����
		pop	psw
		mov	c, a
		mov	l, a

		jmp	loc_CC24

; ---------------------------------------------------------------------------

allocClusters:	call	fileFindClusterNext
		jc	stc_pop_dbh_ret		
loc_CC24:	mov	m, a
		mov	l, a
		dcr	b
		jnz	allocClusters
		mov	m, l		
		mvi	b, 0FBh
		xchg
		mvi	e, 1		
loc_CC30:	mov	d, c
		call	j_diskDriver
		inr	h
		ldax	b
		cmp	c
		mov	c, a
		jnz	loc_CC30		
		lhld	v_input_end
		inx	h
		xchg
		lhld	v_input_start
		mvi	b, 0		
loc_CC45:	mov	a, d
		ora	e
		jz	loc_CC52
		mov	a, m
		add	b
		mov	b, a
		inx	h
		dcx	d
		jmp	loc_CC45

; ---------------------------------------------------------------------------

loc_CC52:	mov	a, b
		lhld	v_createdFile
		mov	m, a
		call	saveFatDir
		ora	a
		jmp	pop_dbh_ret