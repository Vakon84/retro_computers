;+---------------------------------------------------------------------------
; MXOS
; �������� �����
;
; �� ������
;  bc, de, hl - �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

clearScreen:	; bc, hl - ���������. de - �� ������������
		push	h
		push	b

		; ���������� SP
		lxi	h, 0
		dad	sp
		shld	v_oldSP

		; ������������� SP � ����� �����������
		lxi	sp, 0C000h

		; ���� (�����) ��� ���������� ������
		lhld	v_inverse

		; �������� � ���� 3000h ����
		lxi	b, 3000h / 16
clearScreen_0:	  push	h
		  push	h
		  push	h
		  push	h
		  push	h
		  push	h
		  push	h
		  push	h
		  dcx	b
		  mov	a, b
		  ora	c
		jnz	clearScreen_0

		; ��������������� SP
		lhld	v_oldSP
		sphl

		; bc, hl ���� ���������. de - �� ������������
		pop	b
		pop	h
		ret		