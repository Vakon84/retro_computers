;+---------------------------------------------------------------------------
; RAMFOS
; ������� ��� ����� �� ����� � ������� �� ���� ��� ������������ �������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

printFileName:	
		; �����������
#if NICE
		mvi	c, ' '
#else
		; �����������
		mvi	c, 11h
#endif
		call	printChar

printFileName2:lxi	h, v_header2_name	; ���
		mvi	b, 12			; ����� �����
printFileNam_1:	 mov	a, m
		 ; ������� ������ 0x20 �������� �� ������
		 cpi	20h
		 jc	printFileNam_2
		 ; ������� �� 0x20 �� 0x7E �����������
		 cpi	7Fh
		 jc	printFileNam_3
		 ; ������� �� 0xC0 �� 0xFF �����������
		 cpi	0C0h
		 jnc	printFileNam_3		 
printFileNam_2:	 ; �������� ������������ ������ �� ������
		 mvi	m, 20h
		 mov	a, m
printFileNam_3:	 ; ������� ������ �� �����
		 call	printCharA
		 ; ��������� ������
		 inx	h
		 dcr	b
		jnz	printFileNam_1		

		; �����������
#if NICE
		mvi	c, ' '
		jmp	printChar
#endif
		; ������� �� printChar6