;+---------------------------------------------------------------------------
; RAMFOS
; ��������� ��� ���������� ������������ ��������� �����
;
; �� �����
;   v_curFile      - ����� �������� ����� � ����
;   f_header       - ��������� �����
;
; �� ������
;   f_fileBodySize - ����� ����� ��� ��������� - 1
;   f_fileSize     - ����� ����� � ����������
;   f_nextFile     - ����� ���������� ����� � ����
;
;   ���� �� �������� � ���� �� ������ v_curFile + f_fileSize 
;   ������������ v_curFile
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileLoadHeader2:; ����� ����� ��� ���������
		; f_fileBodySize = v_header_stop - v_header_start
		call	loadDStartDStop	
		xchg
		call	sub_hl_de
		shld	f_fileBodySize

		; ����� ����� � ���������
		; f_fileSize = f_fileBodySize+1
		lxi	d, FILE_HEADER_SIZE+1
		dad	d
		shld	f_fileSize

		; ����� �����
		; de = v_curFile + f_fileSize
		xchg
		lhld	v_curFile
		xchg
		dad	d

		; ��������� � ���� ��������� �� ��� ����, ������� ���������
		; ����� ��������� ������.
		mov	c, e
		call	pageWrite
		inx	h
		mov	c, d
		call	pageWrite
		inx	h

		; ����� ���������� �����
		; f_nextFile =  v_curFile + f_fileSize + 2
		shld	f_nextFile

		; ���������� ���� � Z
		xra	a
		ret