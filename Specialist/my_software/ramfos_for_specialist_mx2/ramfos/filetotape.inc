;+---------------------------------------------------------------------------
; RAMFOS
; ��������� ���� �� ����������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

fileToTape:	; ������� ���������� ������ 15 ����.
		push	h
		 push	d
		  lxi	d, 15
		  call	fileToTape_0
		 pop	d
		pop	h

		; ����� ��� �� ���� ������, �� �������

fileToTape_0:	; ����� ���
		call	j_tapeWritePilot

		; ������ �����
		mov	c, e
		xra	a
		call	j_tapeWrite
		mov	c, d
		xra	a
		call	j_tapeWrite

		; ���������� ������� �������� ���������� *15 ������
		mvi	b, 8		
fileToTape_1:	 ; ���� ���������� ������, �������
		 mov	a, e
		 ora	d
		 rz
		 ; ������ ���� � �����
		 call	pageRead
		 inx	h
		 ; ��������� �������
		 dcx	d
		 ; ���������� �� ����������
		 mov	a, b
		 call	j_tapeWrite
		jmp	fileToTape_1