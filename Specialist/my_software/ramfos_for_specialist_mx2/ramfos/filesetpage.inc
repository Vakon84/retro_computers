;+---------------------------------------------------------------------------
; RAMFOS
; ���������� �������� ��������
;
; �� �����
;  b - ����
;
; �� ������
;  v_pageStart = v_curFile = f_nextFile = ������ ��������, ��������� ������� �����
;  hl - ������ ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileSetPage:	; ������ RAM-�����
		lhld	v_aramPageStart

		; ����
		mov	a, b
		sta	v_page

		; � ROM-����� ������ ������
		; ��������� ������� RAM/ROM � ��������� �������� ������
		ora	a
		mvi	a, 'A'
		jp	fileSetPage_1
		 mvi	a, 'O'
		 ; ������ ROM-�����
		 lxi	h, ROM_PAGE_START
fileSetPage_1:	sta	a_panelOA

                ; ��������� �����
		shld	v_pageStart
		shld	v_curFile
		shld	f_nextFile
		ret		