;+---------------------------------------------------------------------------
; MXOS
; ������ ������ ������� � ����������� (�����������);
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

calcCursorAd_0:	; ������� ������ (�� ����� C=10)
		call	printChar

		; �������������� ��������� ����� printChar (���� �� �� ������ ��������)
		lhld	v_cursorY
		mov	a, h

calcCursorAd_1:	; ������ �������� ����� ������
		; a = cursorX / 4 + 90h		
		rrc
		rrc
		ani	3Fh
		adi	90h
		ret
