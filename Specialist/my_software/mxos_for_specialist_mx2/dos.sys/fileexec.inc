;+---------------------------------------------------------------------------
; MXOS
; ��������� ����
;
; �� �����
;  hl - ��� ������ � ������� [����:]����[ ���������]
;
; �� ������
;  �f - ������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileExec:	; ���� ����� ���������� ���������
		lxi	d, v_cmdLine
		
		; ���� ������ ������ ������ �������, ������� c CF
		mov	a, m
		cpi	' '
		jc	stc_ret

		; ������������ ������ ��� ������ (+2 �����������, ����� 82h)
		mvi	c, 80h		

fileExec_0:	; ���� ������ ������ �������, �������
		mov	a, m
		cpi	20h
		jc	fileExec_1

		; �������� ������� �� HL � DE
		stax	d
		inx	h
		inx	d

		; ��������� 80h ���
		dcr	c
		jnz	fileExec_0

fileExec_1:	; � ����� ����� �������� 13,0
		mvi	a, 0Dh
		stax	d
		xra	a
		inx	d
		stax	d

		; ������� �� ����� 0
		call	printCharA

		; ����� ����� ����� �� �����
		lxi	h, v_cmdLine
		call	j_printString

		; ���������� ����� �����
		lxi	h, v_cmdLine
		lxi	d, v_fileName
		call	fileNamePrepare

		push	h

		; ���� ��� BAT-����
		lxi	d, aBat		; "BAT"
		call	cmpFileExt
		jz	execBat

		; ���� ��� COM ��� EXE ����
		call	cmpFileExt
		jz	loc_CAB6
		call	cmpFileExt
		jnz	loc_CAD3
loc_CAB6:	
		pop	d

		; ��������� ����
		lxi	h, v_fileName
		call	fileLoad
		jc	badCommand

		push	d

		call	printCharA

		; �������� ����� �������� �����
		lxi	d, 10
		dad	d
		mov	e, m
		inx	h
		mov	d, m

		; ����� ��������
		lxi	h, loc_CAD1
		xthl

		; ������� �� DE
		xchg
		pchl

; ---------------------------------------------------------------------------

loc_CAD1:	ora	a
		ret

; ---------------------------------------------------------------------------

loc_CAD3:	pop	d
badCommand:	lxi	h, aBadCommandOrFi ; "\nBAD COMMAND OR FILE NAME"
		call	j_printString		                     
stc_ret:	stc
		ret

; ---------------------------------------------------------------------------

printCharA:	mvi	c, 0Ah
		jmp	j_printChar		