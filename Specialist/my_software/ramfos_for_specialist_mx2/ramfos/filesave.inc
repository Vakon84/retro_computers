;+---------------------------------------------------------------------------
; RAMFOS
; ��������� ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileSave:	; ����� ��������� �������� � ���������� ����������� �����
		call	fileFindFree
		rc

		; ����� �������
		jmp	fileSaveCom		

;----------------------------------------------------------------------------
; RAMFOS
; ��������� ���� � ������ ����� � ����������
;
; 2013-11-01 ����������������� vinxru
; ---------------------------------------------------------------------------

fileSaveDlg:	; ����� ������ "���������?"
		call	printStringEx
		.db C_INVERSE, C_BOTTOMLINE, ' ', 0F3h, 0CFh, 0C8h, 0D2h, 0C1h, 0CEh, 0C9h, 0D4h, 0D8h, 3Fh, C_NORMAL, 0

		; ���� ����� �����
		call	j_inputFileName
		rz

		; SD CREATE
		; SD WRITE
		; SD CLOSE

		; ����� ���������� ��������
		call	fileFindFree

		; � ������ ������ ������� "��� ����" � ����� ������� ESC
		jc	outOfSpace

fileSaveCom:	; ������ ��������� ����� �� ����
		lxi	b, v_header2
		call	fileSaveHeaderAny

		; BC = ������ �����, DE = ����� ����� - 1
		push	h
		 call	fileGetStartAndSize2
		 xchg
		 mov	c, l
		 mov	b, h
		pop	h

		; ������ ���� ����� (������ �� ���� �� ������ HL �� ������ BC ������ DE+1)
		call	pageWriteBlock 

		; ����������� � fileChanged		