;----------------------------------------------------------------------------
; MXOS NC.COM
; ��������� ��������� ���� � ��� ������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

selFileToCmdLine:
		xchg

		; �������� ������� ����������
		lxi	h, panelA_drive
		call	readBytePanel
		adi	'A'

		; ������� ��� � ��� ������
		lhld	v_cmdLineEnd
		mov	m, a
		inx	h

		; ������� ����������
		mvi	m, ':'
		inx	h

		; ������� ��� �����
		xchg
		call	compactName

		; ����������� �����
		dcx	d
		mvi	a, (v_cmdLine+59 & 0FFh)
		cmp	e
		jnc	loc_D146
		 mov	e, a		 
loc_D146:	
		; ����������
		xra	a
		stax	d

		; �����
		COLOR(COLOR_CMDLINE)
		lhld	v_cmdLineEnd
		call	printString

		; ���������� ��� �����
		xchg
		shld	v_cmdLineEnd

		; ��������� ����� ���������
		lhld	v_cursorY
		shld	v_cmdLinePos
		ret