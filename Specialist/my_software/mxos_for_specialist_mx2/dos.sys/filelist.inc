;+---------------------------------------------------------------------------
; MXOS
; �������� ������ ������
;
; �� ����� 
;  hl - ����� ������ (769 ����)
;
; �� ������
;  bc,de,hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileList:	; �������� FAT � ��������
		call	loadFatDir

		; ���������� ���������
		push	h
		push	b
		push	d

		; �������� ������
		mvi	b, 48

		; ����� ������� �����
		lxi	d, diskDirectory
		
fileList_loop:	; ���� ������ ������ �� FFh, �������� ���������
		ldax	d
		inr	a
		jnz	fileList_copy

		; ��������� ����� ���������� �����
		push	h
		lxi	h, 10h
		dad	d
		xchg
		pop	h

fileList_next:	; ����
		dcr	b
		jnz	fileList_loop

		; � ����� ������ 0FFh
		mvi	m, 0FFh
		jmp	pop_dbh_ret

; ---------------------------------------------------------------------------

fileList_copy:	; �������� 16 ���� �� DE � HL
		mvi	c, 16
fileList_copyl:	ldax	d
		mov	m, a
		inx	h
		inx	d
		dcr	c
		jnz	fileList_copyl
		jmp	fileList_next