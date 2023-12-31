;----------------------------------------------------------------------------
; RAMFOS
; ��������� ��������� �����
;
; �� �����
;   v_page          - ����� ������� ��������
;   hl              - ����� �������� ����� � ����
;
; �� ������, ���� ���� ������
;   b               - ������� �������� ����
;   v_curFile       - ����� �������� ����� � ����
;   v_header        - ��������� �����
;   f_fileBodySize  - ����� ����� ��� ��������� - 1
;   f_fileSize      - ����� ����� � ����������
;   f_nextFile      - ����� ���������� ����� � ����
;
;   ���� �� �������� � ���� �� ������ v_curFile + f_fileSize 
;   ������������ v_curFile
;
; �� ������, ���� ���� �� ������
;   v_pageFreePtr, v_curFile - ����� ������� ���������� �����
;   v_pageFreeTotal      - �������� ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileLoadHeader:	; ��������� �������� �������� ����� � v_curFile
		shld	v_curFile

		; ������ ��������� ����� � ����� � v_header
		lxi	d, v_header
		push	d
		 lxi	b, FILE_HEADER_SIZE-1
		 call	pageReadBlock
		pop	d

		; �������� � � ������� ��������
		lda	v_page
		mov	b, a

		; � ������ ����� ������ ���� D3,D3,D3
		lxi	h, a_defHeader
		call	memcmp_hl_de_3	; b �� ��������

		; ���� ������ ������, �� ��������� � fileLoadHeader2
		jz	fileLoadHeader2

		; �� ������ ������ ������ �����!

		; �������������� ��������� � ������
		lxi	h, a_defHeader
		lxi	d, v_header
		call	memcpy_de_hl_15

		; ������������ ����� ��������
		lhld	f_nextFile	
		shld	v_pageFreePtr
		xchg

		; �������� � HL ������ ��������
		lhld	v_aramPageEnd
		lda	a_panelOA
		cpi	'O'
		jnz	fileLoadHeader_0
		 lxi	h, ROM_PAGE_END
fileLoadHeader_0:	
                ; ������������ ��������� ����� �� �����
		call	sub_hl_de
		shld	v_pageFreeTotal

		; ?
		dcr	c
		ret