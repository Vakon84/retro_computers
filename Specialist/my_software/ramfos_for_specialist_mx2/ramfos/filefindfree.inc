;+---------------------------------------------------------------------------
; RAMFOS
; ������ ����������� ����� ������������ �����, ����� ��������
; � ���������� c�������� �������, �������� ����� � ������ v_header2_name
;
; �� �����
;  v_header2_name  - ��� ����� ��� ��������
;  f_header2_start - ����� ������ �����
;  f_header2_stop  - ����� ����� �����
;
; �� ������
;  jnc             - �������� �������
;  f_header2_crc   - ����������� �����
;  v_page, b       - ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileFindFree:	; ����������� ����������� ����� � v_header2_crc
		shld	v_header2_start	
		xchg
		shld	v_header2_end		
		xchg
		call	j_calcCrc
		mov	h, b
		mov	l, c
		shld	v_header2_crc

		; ����� �� ���� ��������� � �������� �����
		mvi	b, 20h
		call	fileFindEx

		; ����� ����� ������� � ������� ��������
		mvi	b, 20h
fileFindFree_0:	 ; ���������� ��������� ����� �� ��������
		 call	fileFind1
		 
		 ; de = ����������� ��������� ������ �����, ������ �� � �����.
		 call	fileGetStartAndSize2
		 lxi	d, FILE_HEADER_SIZE + 3
		 dad	d
		 xchg		

		 ; ������� � ������ NC, ���� ����� ����������
		 lhld	v_pageFreeTotal
		 cnc	j_cmp_hl_de
		 rnc		

		 ; ��������� ��������
		 call	pageNext
		jnc	fileFindFree_0
		ret