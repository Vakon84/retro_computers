;+---------------------------------------------------------------------------
; MXOS
; ������������� ����
;
; �� ����� 
;  hl - �������� ���
;  de - ����� ���
;
; �� ������
;  cf - ������
;  bc,de,hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileRename:	; ����� ���� � ������ �� HL
		call	fileFind
		rc

		; ��������� ��������
		push	h
		push	b
		push	d
		
		;
		lhld	v_foundedFile

		; ���������� ����� ���� � ����� ������
		xchg
		call	fileFind2		

		; ���� ����� ���� ����, �� �������
		cnc	deleteFileInt
		
		; �������� ���
		mvi	c, 9		
loc_CD2C:	mov	a, m
		stax	d
		inx	h
		inx	d
		dcr	c
		jnz	loc_CD2C

		; ��������� ���������
		call	saveFatDir

		; �����
		ora	a
		jmp	pop_dbh_ret