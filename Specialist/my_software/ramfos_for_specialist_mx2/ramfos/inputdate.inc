;+---------------------------------------------------------------------------
; RAMFOS
; ���� ������� ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

inputDate:	; ����� ����������� "V3.1/����:" ��� "����:"
		lxi	h, a_inputDate
		call	printString
	
		; ���� ����
		lxi	h, buffer
		lxi	d, 9FFh ; �������� 9 ��������
		call	input

		; ���� ���� ������
		jnc	inputDate
		mov	m, a

		; �������������� ��������� ������ � �����
		cm	parseDate

		; ���� �������������� �� ������� ������ ��������
		jz	inputDate

#if DATE_IN_RAM
		; ��������� ������� ����, ��� ���� �������
		mvi	a, 8Bh 
		sta	v_header2_saved

		ret
#else
		; ��������� �� ����� ����� �� �����
		pop	h

		; ��������� 08Bh
		mvi	c, 8Bh 
		call	inputDate_1
		
		; ��������� ���� �� ����
parseDate_r1:	mvi	c, 22h
		call	inputDate_1

		; ��������� ����� �� ����
parseDate_r2:	mvi	c, 09h
		call	inputDate_1

		; ��������� ��� �� ����
parseDate_r3:	mvi	c, 92h
inputDate_1:	xra	a
		call	j_pageWriteAny
		inx	h
		inr	a
		ret
#endif

#if NICE
#define A_INPUTDATE a_inputDate: .db 0Dh, 0C4h, 0C1h, 0D4h, 0C1h, ':', 0 ; "����:"
#else
#define A_INPUTDATE a_inputDate: .db 0Dh, 'V', '3', '.', '1', '/', 0C4h, 0C1h, 0D4h, 0C1h, ':', 0 ; "V3.1/����:"
#endif