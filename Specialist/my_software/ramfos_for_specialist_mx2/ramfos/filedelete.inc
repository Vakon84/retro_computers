;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� F851
; �������� ����� ���������� ���������� F84B
;
; ���� ������ ���� ����������� ������ �������� fileFind (F84B), �����
; ����� ���������� ��������� ������.
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileDelete:	; ������ ����� �������� ������ ����� ������ �����, �������
		; ���� ��������.
		; de = v_pageFreePtr - f_nextFile - 1 
		lhld	f_nextFile
		xchg
		lhld	v_pageFreePtr
		dcx	h		
		call	sub_hl_de
		xchg

		; �������� � ���� ����� ���������� �����
		push	h

		; �������� � HL ����� ������ �����
		lhld	v_curFile

		; ����� ���������� ����� ��������� ����� ������,
		; � �� ������������ � ������� compareFileName
		shld	f_nextFile

		; ���� ��� ���� ��� ��������, ������ �� ����������
		jc	fileDelete_1

fileDelete_0:	 ; ������ � �����
		 xthl
		 call	pageRead
		 inx	h
		 xthl
		 ; ������ �� ����
		 call	pageWrite
		 inx	h
		 ; if(de==0) break;
		 mov	a, e
		 ora	d
		 ; de--
		 dcx	d
		jnz	fileDelete_0

fileDelete_1:	; ��������� ������� ���������� �����
		xthl
		pop	h
		jmp	fileChanged