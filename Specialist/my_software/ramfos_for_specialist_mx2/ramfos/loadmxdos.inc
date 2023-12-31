;+---------------------------------------------------------------------------
; RAMFOS
; �������� � ������ MXDOS � �������
; ���������� ��� ������� �� F6 �� �������� ������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if NO_MXDOS==0

MXDOS_ADDR = 0E400h

loadMxDos:	mov	b, a

		; ��������� ������� � �������
		mvi	a, 1
		sta	IO_FLOPPY_HEAD
		sta	IO_FLOPPY_SECTOR

		; �����
		mvi	h, 13h
loadMxDos_0:	 dcx	h
		 mov	a, l
		 ora	h
		jnz	loadMxDos_0

		; ������������� �������
		sta	IO_FLOPPY_HEAD

		; ����� ��������
		lxi	h, MXDOS_ADDR

		; ������ �������
		mvi	a, 90h
		sta	IO_FLOPPY_CMD

		; �������� ���������� � �������� ������� ���������
loadMxDos_1:	 lda	IO_FLOPPY_CMD ; ���� ��� ��������� �������� ����� ��������� ���������� 83h
		 ral
		 rc    ; ���� ������� ��� �� ����, ������ ��������� ���
		 rar
		 rar   ; ���� ������� ��� �� ����, ������ �������� �� �����.
		jnc	loadMxDos_1

		; ��������� ������
		mvi	c, 13h 
loadMxDos_2:	  sta	IO_FLOPPY_TRIG
		  lda	IO_FLOPPY_DATA
		  mov	m, a
		  inr	l
		 jnz	loadMxDos_2
		 inr	h
		 dcr	c
		jp	loadMxDos_2

		; ��������
		lda	IO_FLOPPY_CMD
		xri	1
		ora	a
		mvi	a, 0D0h
		sta	IO_FLOPPY_CMD
		jnz	dlg_error

		; ��������
		dcx	h
		mov	a, m
		dcx	h
		inr	m
		cmp	m
		jnz	dlg_error

		; ������ MXDOS
		.db 078h
		call	MXDOS_ADDR

		; ��� ������ �� MXDOS �������� ROM-����
		mvi	b, 80h
		ret
#endif