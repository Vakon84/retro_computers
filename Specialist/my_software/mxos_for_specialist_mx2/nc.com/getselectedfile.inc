;----------------------------------------------------------------------------
; MXOS NC.COM
; �������� ��� ���������� �����
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

getSelectedFile:push	d

		; �������� ����� �������� �����
		lxi	h, panelA_curFile
		call	readBytePanel

		; �������� ��� (�����) �������� �����
		; files2 += 16*curFile[activePanel];
		lxi	h, files2	
		lxi	d, 16
loc_D80F:	 dad	d
		 dcr	a
		jp	loc_D80F

		pop	d
		ret