;+---------------------------------------------------------------------------
; MXOS
; ����������� ��� ����� ��� ������� ��
;
; �� ����� 
;  hl - �������� ���
;  de - ����� ��� ���������� (9 ����)
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileNamePrepare:; ��������� ��������
		push	b
		push	d

		; ���� ������ ������ �������� ������ ':', �� ������ ����
		inx	h		
		mov	a, m
		cpi	':'
		dcx	h
		jnz	fileNamePr_1

		; ������ ����
		mov	a, m		
		sui	'A'
		call	fileSelectDrive

		; ���� �� ������ � ��� �����
		inx	h		
		inx	h		
		
fileNamePr_1:	; 6 �������� �����, 3 ����������
		lxi	b, 603h

		; �������� ����� �� �����, ������� ��� ����� ������, �� ����� 6 ��������. 
fileNamePr_2:	mov	a, m
		ana	a
		jp	fileNamePr_3
		sui	40h
fileNamePr_3:	cpi	' '+1
		jc	fileNamePr_5
		inx	h
		cpi	'.'
		jz	fileNamePr_5		
		stax	d
		inx	d
		dcr	b
		jnz	fileNamePr_2

		; ���������� ����� �� �����, ������� ��� ����� ������
fileNamePr_4:	mov	a, m
		cpi	' '+1
		jc	fileNamePr_6
		inx	h
		cpi	'.'
		jnz	fileNamePr_4
		jmp	fileNamePr_6

; ---------------------------------------------------------------------------

fileNamePr_5:	; ��� ������ 6 ��������
		; ��������� ����������� ������� ����� ���������
		call	memset_de_20_b

		; �������� ����� �� ������� ��� ����� ������, �� ����� 3 ��������. 
fileNamePr_6:	mov	a, m                         
		ana	a
		jp	fileNamePr_7
		sui	40h		
fileNamePr_7:	cpi	' '+1
		jc	fileNamePr_11
		stax	d
		inx	h
		inx	d
		dcr	c
		jnz	fileNamePr_6

fileNamePr_8:	; ���������� ����� �� ������� ��� ����� ������
		mov	a, m
		cpi	' '
		jc	fileNamePr_10
		inx	h
		jnz	fileNamePr_8
		
fileNamePr_9:	; ���������� ����� �� ������� ��� ����� ������
		; ������ �� ����������� ���
		mov	a, m
		cpi	' '
		jc	fileNamePr_10
		inx	h
		jz	fileNamePr_9
		dcx	h

fileNamePr_10:	; ��������������� �������� � �������
		pop	d
		pop	b
		ret

; ---------------------------------------------------------------------------

fileNamePr_11:	; ��������� ����������� ������� ���������� ���������
		mov	b, c
		call	memset_de_20_b

		; ��������������� �������� � �������
		pop	d
		pop	b
		ret		