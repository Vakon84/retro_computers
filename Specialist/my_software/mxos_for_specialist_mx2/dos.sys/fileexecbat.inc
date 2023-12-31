;+---------------------------------------------------------------------------
; MXOS
; ��������� BAT ����. ���������� �������� fileExec
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

execBat:	pop	d

		; ���������� �������
		lxi	h, diskDirectory 
		shld	v_batPtr		
		xchg

		; ��������� ������� BAT-�����
		lxi	h, v_fileName
		mvi	c, 1
		call	fileGetSetAddr
		jc	badCommand

		; ��������� ��� BAT-�����
		lxi	h, v_fileName	
		lxi	d, v_fileName_end
		lxi	b, v_batFileName
		call	memmove_bc_hl

		; ��������� ���� ���������� BAT-����
		lda	v_drive
		sta	v_batDrive+1

execBat_loop:	; ���� ���� ����������� ��� ������ ������ BAT-�����

		; ��������� ������� ����
		lda	v_drive
		mov	b, a

v_batDrive:	; ������� ���� ���������� BAT ����
		mvi	a, 1		
		call	fileSelectDrive

		; ��������� BAT-���� � ������
		lxi	h, v_batFileName 
		call	fileLoad
		lhld	v_batPtr

		; ��������� ������ ������
		mov	d, h
		mov	e, l

execBat_0:	; ���� ����� ������
		mov	a, m		
		inx	h

		; ������ ����� ������, ��������� ����
		cpi	0Dh		
		jz	execBat_1

		; �����	�����
		cpi	0FFh		
		jnz	execBat_0
		ret

; ---------------------------------------------------------------------------

execBat_1:	; ��������� ���������
		shld	v_batPtr	

		; �������������� ��������� �����		
		mov	a, b		
		call	fileSelectDrive

		; ��������� ����
		xchg			
		call	fileExec

		jmp	execBat_loop