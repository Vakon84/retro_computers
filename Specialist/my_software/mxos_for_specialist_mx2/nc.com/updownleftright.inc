;----------------------------------------------------------------------------
; MXOS NC.COM
; ������� ����������� �������
;
; 2013-12-18 ����������������� vinxru
;----------------------------------------------------------------------------

Down:		; ���� curFile+1 < filesCnt, �� curFile = curFile+1
		lxi	h, panelA_filesCnt
		call	readBytePanel
		mov	c, a
		lxi	h, panelA_curFile
		call	readBytePanel
		inr	a
		cmp	c
		jz	mainDriveChanged
		call	writeBytePanel
		jmp	mainDriveChanged

; ---------------------------------------------------------------------------

Up:		; ���� curFile > 0, �� curFile = curFile-1
		lxi	h, panelA_curFile
		call	readBytePanel
		dcr	a
		jm	mainDriveChanged
		call	writeBytePanel
		jmp	mainDriveChanged

; ---------------------------------------------------------------------------

Left:		; ���� curFile > 18, �� curFile = curFile-18, ����� curFile = 0
		lxi	h, panelA_curFile
		call	readBytePanel
		sui	18
		jp	Left_1
		xra	a		
Left_1:		call	writeBytePanel
		jmp	mainDriveChanged

; ---------------------------------------------------------------------------

Right:		lxi	h, panelA_filesCnt
		call	readBytePanel
		mov	c, a
		dcr	c
		jz	mainDriveChanged
		lxi	h, panelA_curFile
		call	readBytePanel
		adi	18
		cmp	c
		jc	Right_1
		mov	a, c
Right_1:	call	writeBytePanel
		jmp	mainDriveChanged