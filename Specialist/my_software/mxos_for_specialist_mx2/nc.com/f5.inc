;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� F5 - �����������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

F5:		; ������ ����
		call	drawWindowIfSel

		; ������ ������� "COPY FROM DISK A: TO"
		lxi	h, 405Eh
		shld	v_cursorY
		lxi	h, aCopyFromDiskTo 
		call	printString
		call	printSelDrive

		call	inputForCopyMove
		cpi	1Bh
		jz	mainReload

		call	copyFileInt
		jmp	mainReload
