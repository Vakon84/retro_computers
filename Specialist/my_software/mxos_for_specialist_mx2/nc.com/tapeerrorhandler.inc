;----------------------------------------------------------------------------
; MXOS NC.COM
; ���������� ��� ������ �������� � �����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

tapeErrorHandler:
		; �������������� �����������
		lxi	h, 0C800h
		shld	v_tapeError

		; �������������� �����
		lhld	v_savedSP
		sphl

		; ������������ ������ � ����������� ������
		jmp	mainReload
