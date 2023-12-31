;+---------------------------------------------------------------------------
; MXOS
; ����� ������� �� ����� (��� �������)
;
; �� �����
;  � - ������
;
; �� ������
;  �������� �� �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

printChar2:	; �������� � HL ���������� �������
		lhld	v_cursorY

		; ����������, ���� �� ������� ����� ��������� ESC ������������������ (v_escMode==0FFh)
		lda	v_escMode
		inr	a
		jnz	printChar_esc

		; ��� v_escMode==0FFh

		; ���� ��� �������� ������� (>=20h), ��������� � ������
		mov	a, c
		cpi	' '
		jnc	printChar_real

		; ��� ���������
		cpi	9
		jz	printChar_c9	; ��� v_cursorX+=24 � ret

		; ����� ������ ����� ESC
		cpi	1Bh
		jnz	printChar3

		; ����� ESC. �������� ����� ��������� ESC ������������������ (v_escMode=0)
		xra	a
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------
; �������������� ������� �� KOI-7 � KOI-8 � ����� �� ����� (��������� ���� 
; ��� �� ����� ���������)

printChar_real:	; ������ ��� ������
		mov	c, a

		; ����������, ���� ������� ����� KOI-7 
		lda	v_koi8
		inr	a
		jnz	printChar_real2

		; ���� ������ ������ ��� ����� 0C0h ������ �������
		mov	a, c
		cpi	0C0h
		rnc

		; ���� ������ ��������� � �������� 60h ... 7Fh, ����������� ��� ��� �� 80h
		cpi	60h
		jc	printChar_real2
		cpi	80h
		jnc	printChar_real2
		adi	80h
		mov	c, a

; ---------------------------------------------------------------------------
; ����� ������� �� ����� � KOI-8 (��������� ���� ��� �� ����� ���������)

printChar_real2:	
		; ��� �����������
		lda	v_inverse
		ana	a
printChar_poly:	cz	normalVideo

		; ���� v_charGen �� ����� 0FFFFh, �� ������������ ������������� �� ������ v_charGen*8
		lhld	v_charGen
		mov	a, h
		inr	a
		jnz	printChar_alt
		mov	a, l
		inr	a
		jnz	printChar_alt

		; ����� ���������� ������� �� ���. 
		; ����� ������� � ��� (de = 0x800 + c*8)
		lxi	h, 100h		
		mvi	b, 0
		dad	b
		dad	h
		dad	h
		dad	h
		xchg

		; ������������� ����� ��� �������
		lxi	h, v_char
		push	h

		; �������� 8 ���� �� ���
		sta	IO_ROM
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		inx	h
		inx	d
		ldax	d
		mov	m, a
		sta	IO_RAM

		; ����� �������
		pop	d
		jmp	printChar_de

; ---------------------------------------------------------------------------
; ��������� ������ ESC+F

printChar_esc80:; ���� ������ � ����� 0, ��������� ����� ��������� ESC
		mov	a, c
		ora	a
		jz	printChar_esc80_exit

		; ��������� ����� <20h
		cpi	20h
		jc	printChar3

		; ���� ��� >= 80h, �����
		cpi	80h
		rnc

		; ���� c >= 40h, ������� �� ����� c+40h
		cpi	40h
		jnc	printChar_esc80_2

		; ����� ������� c - 20h
		sui	20h ; ' '
		mov	c, a
		jmp	printChar_real2

; ---------------------------------------------------------------------------

printChar_esc80_2:
		; ���� c >= 40h, ������� �� ����� c+40h
		adi	40h
		mov	c, a
		jmp	printChar_real2

; ---------------------------------------------------------------------------

printChar_esc80_exit:
		dcr	a
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------
; ������ ������� � ESC-������

printChar_esc:	; ������� ���� v_escMode=80h
		lda	v_escMode
		cpi	80h
		jz	printChar_esc80

		; ��������� ����� ��������� ESC ������������������
		push	psw
		mvi	a, 0FFh
		sta	v_escMode
		pop	psw

		; ������� ���� v_escMode==0
		ora	a
		jz	printChar_esc0

		; ������� ���� ��������� ESC+Y (v_escMode==1)
		dcr	a
		jz	printChar_esc1

		; ������� ���� v_escMode==2
		dcr	a
		jz	printChar_esc2

		; ������� ���� v_escMode==3
		dcr	a
		jz	printChar_esc3

		; �����
		ret

; ---------------------------------------------------------------------------
; ��������� ESC+Y

printChar_esc1:	; ���� ��� ������ 20h ��� ������ 20h + 24, �� ���������� ��������� Y
		mov	a, c
		cpi	20h + 25
		jnc	loc_C693
		sui	20h
		jc	loc_C693

		; cursorY = 8 + a*10
		add	a
		mov	c, a
		add	c
		add	c
		add	c
		add	c
		adi	8
		sta	v_cursorY

loc_C693:	; ��������� ������ ����� ��������� � printChar_esc2
		mvi	a, 2
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------
; ��������� ESC+Y

printChar_esc2:	; ���� ��� ������ 20h ��� ������ 20h + 63, �� ���������� ��������� X
		mov	a, c
		cpi	60h
		rnc
		sui	20h
		rc

		; cursorX = c*3;
		mov	c, a
		add	a
		add	c
		sta	v_cursorX
		ret

; ---------------------------------------------------------------------------
; ��������� ������� ������� ESC ������������������

printChar_esc0:	; ���� ��� ������ 20h
		mov	a, c
		cpi	'(' ; 28h
		jz	printChar_e28
		cpi	')' ; 29h
		jz	printChar_e29
		cpi	'P' ; 50h
		jz	printChar_eP
		sui	'A' ; 41h
		jz	printChar19
		dcr	a ; 'B' 42h
		jz	printChar1A
		dcr	a ; 'C' 43h
		jz	printChar18
		dcr	a ; 'D' 44h
		jz	printChar08
		dcr	a ; 'E' 45h
		jz	printChar1F
		dcr	a ; 'F' 46h
		jz	printChar_eF
		dcr	a
		dcr	a ; 'H' 48h
		jz	printChar0C
		dcr	a ; 'I' 49h
		jz	printChar_eI
		dcr	a
		dcr	a
		sui	14 ; 'Y' 59h
		jz	setEscMode_eY

		; ����� �������
		jmp	printChar2

; ---------------------------------------------------------------------------
; ��������� ESC+Y.

setEscMode_eY:	; ��������� ������ ����� ��������� � printChar_esc1 
		mvi	a, 1
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------

printChar18:	mvi	c, 18h
		jmp	printChar2

; ---------------------------------------------------------------------------

printChar08:	mvi	c, 8
		jmp	printChar2

; ---------------------------------------------------------------------------

printChar1F:	mvi	c, 1Fh
		jmp	printChar2

; ---------------------------------------------------------------------------

printChar0C:	mvi	c, 0Ch
		jmp	printChar2

; ---------------------------------------------------------------------------
; ��������� ESP+P. ��������� ������ ��������� �� ��������

printChar_eP:	mvi	a, 3
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------

printChar19:	mvi	c, 19h
		jmp	printChar2

; ---------------------------------------------------------------------------

printChar1A:	mvi	c, 1Ah
		jmp	printChar2

; ---------------------------------------------------------------------------
; ����� ��������� �� ��������. ���������� ESC+P

printChar_esc3:	; �������, �� ������, ���� ��� �������
		mov	a, c
		ora	a
		rz

		; ������ �� ��������
		call	printer

		; ������ �� ������
		call	printChar2

		; ��������� � ���� ������ �� ���� 0 ��� ESC
		mvi	a, 3
		sta	v_escMode
		ret

; ---------------------------------------------------------------------------
; ����������� ��������� ESC+I. ����������� ������� ����� � ���������� ������

printChar_eI_2:	; ���� cursorY > 18, ���������� ������ ����� � �������
		cpi	19
		jnc	printChar2

		; �������������� v_cursorY=8
		mvi	a, 8
		sta	v_cursorY
		ret

; ---------------------------------------------------------------------------
; ��������� ESC+I. ����������� ������� ����� � ���������� ������

printChar_eI:	; ������������ ������ �������� printChar2
		mvi	c, 19h

		; ������������ ����� ����, ������ ���� v_cursorY == 8.
		; ����� ��������� �� printChar_eI_2
		lda	v_cursorY
		cpi	8
		jnz	printChar_eI_2