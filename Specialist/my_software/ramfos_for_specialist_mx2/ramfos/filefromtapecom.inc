;+---------------------------------------------------------------------------
; RAMFOS
; ������ ������ 15 ���� ��������� ����� � v_header � ����� ��� �� �����
; ����� ������ ����� ���� (������ 2 �����) � DE
;
; ��� ����� ������ ������� fileFromTape, fileVerify
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileFromTapeCom:; ���� ����� ���
		; ������ ����� � DE, �� ���������� �.
		lxi	h, v_header
		call	fileFromT_1

		; ������ 15 ���� � ����������� �� ������ hl
		mvi	e, 15
fileFromT_0:	 call	j_tapeRead
		 mov	m, a
		 inx	h
		 dcr	e
		jnz	fileFromT_0

		; ���������� D3,D3,D3

		; ������� ��� �� �����
		call	printFileHeaderName

fileFromT_1:	; ���� ����� ���
		call	j_tapeReadPilot

		; ������ ����� � DE
		cnc	j_tapeRead
		mov	e, a
		cnc	j_tapeRead
		mov	d, a
		ret