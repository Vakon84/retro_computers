;+---------------------------------------------------------------------------
; RAMFOS
; �������� ������� ���� � ������������
;
; ������� ���������� ������ �� ������� ������.
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

		; ������ ������ 15 ���� ��������� ����� � v_header � ����� ��� �� �����
		; ����� ������ ����� ���� (������ 2 �����) � DE
		call	fileFromTapeCom

		; ��� �� ��������, �� ���� C �� ������ ������� �� �����������.

		; ����� ���������� ����� �� �����
		lhld	v_curFile		 
verifyLoop:	 ; ������ ���� � �����
		 call	pageRead
		 ; ������ ���� � �����������
		 call	j_tapeRead
		 ; ���� ����� �� �����, ������� ������
		 cmp	c
		 jnz	dlg_error
		 ; ����������� ����� �� �����
		 inx	h
		 ; ���� (��� ��� �������� � �����, ����� ������� ����� �� ������ ����������)
		 dcx	d
		 mov	a, e
		 ora	d
		jnz	verifyLoop
		ret
