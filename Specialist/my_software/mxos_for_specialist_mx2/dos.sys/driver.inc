;+---------------------------------------------------------------------------
; MXOS
; ������� ����� � ����, ���
;
; ������ 256-�������� �����
;   �� �����
;     e - 1
;     d - ����� ����� 
;     hl - ����� ������ � ������
;   �� ������
;     ��� �������� �����������
;
; ������ 256-�������� �����
;   �� �����
;     e - 2
;     d - ����� ����� 
;     hl - ����� ������ � ������
;   �� ������
;     ��� �������� �����������
;
; ��������� ������� ����������
;   �� �����
;     e - 3
;   �� ������
;     a - ���-�� �������� �� ����� (��� ������� e=0)
;     bc, de, hl - �����������
;
; 2013-12-12 ����������������� � ���������� vinxru
;----------------------------------------------------------------------------

#if START_FROM_RAM
ROM_SIZE = 70h
#else
#if ROM_64K
ROM_SIZE = 0
#else
ROM_SIZE = 0C0h
#endif
#endif

diskDriver:	; ��������� ��������
		push	h
#if BIG_MEM
		push	b		; +1
#endif
		push	d
		push	psw

		; ������� ��������� � � �������� ����
#if BIG_MEM
		lda	v_drive		; +4
		mov	c, a		; +5
		dcr	c		; +6
#endif
		; ������� 1 - ������ �����
		dcr	e
		jz	diskDriver_w

		; ������� 2 - ������ �����
		dcr	e
		jz	diskDriver_r
		
		; ������� 3 - ��������� ������� �����
		pop	psw		
#if BIG_MEM==0
		lda	v_drive         ; +3
		ana	a
		mvi	a, ROM_SIZE
#else
		inr	c
		mvi	a, ROM_SIZE
#endif
		jz	diskDriver_1
		mvi	a, 0FFh		; ������ RAM-����� 64K-256
diskDriver_1:		
		; ��������������� �������� � �������
#if BIG_MEM
		jmp	pop_dbh_ret
#else
		pop	d
		pop	h
		ret
#endif
		
; ---------------------------------------------------------------------------
; ������� 2 - ������ �����

diskDriver_r:	
#if ROM_64K
		; ��� ���
		inr	c
		jnz	rom_64k
		; ��� ������� ����� ���
		mvi	a, 80h
		xra	d
		jm	rom_64k
		; 
		mov	d, a
		; ������ 4 ����� � ��� ��� ��� ��������� ������������
		inx	d
		inx	d
		inx	d
		inx	d
		; �������� ��� ��� (��, ���� ������� ����� �������� ��� �����)
		xra	a
		sta	IO_COLOR
		; �������� ��� ���
rom_64k_0:	sta	IO_PAGE_STD
		; ������
		ldax	d
		; ��������� ��� MX
		sta	IO_RAM-800h
		; ������
		mov	m, a
		inx	h
		; ����
		inx	d
		mvi	a, 4
		cmp	e
		jnz	rom_64k_0
		; �������������� ����
		mvi	a, INIT_COLOR
		sta	IO_COLOR
		; �������
		jmp	popa_adh_ret
		
rom_64k:	dcr	c
#endif
#if BIG_MEM==0
		; �� �����, ��� � ��� E=0
		mvi	e, 0		;+1
#endif
		call	0FFC0h

popa_adh_ret:	; ��������������� �������� � �������
		pop	psw
#if BIG_MEM
		jmp	pop_dbh_ret
#else
		pop	d
		pop	h
		ret
#endif

; ---------------------------------------------------------------------------
; ������� 1 - ������ �����

diskDriver_w:	
#if BIG_MEM==0
		; �� �����, ��� � ��� E=0
		mvi	e, 0		;-1 � ��� ������ ���� � ��������
#endif
		call	0FFD0h

		; ��������������� �������� � �������
		jmp	popa_adh_ret