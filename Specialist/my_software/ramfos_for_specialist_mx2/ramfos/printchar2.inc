;+---------------------------------------------------------------------------
; RAMFOS
; ��������� ����������� ����� ��������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

printChar2:	sui	21h
		jnc	setColorChar
		adi	19h
		jz	popColor	; 87h ������������ ���� ����� �� �����
		dcr	a
		jz	pushColor	; 88h ����������� ���� ����� �� �������� ����� (������� 2 �����)
		dcr	a
		jz	inverseColor	; 89h �������� ���� �����
		dcr	a
		jz	changeInverse	; 8Ah �������� ���� ����������� ������ (�������� ��������)
		dcr	a
		jz	setInverseNeg	; 8Bh ��������� �������� ���� �����-������ ������ (������ ��� A=0 ����� �������������)
		dcr	a
		jz	setInverse	; 8�h ��������� ������� ���� �����-������ ������ (������ ��� A=0)
		dcr	a
		jz	pushCursorLine	; 8Dh ����������� ������� ������
		dcr	a
		jz	popCursorLine	; 8Eh �������������� ������� ������
		dcr	a
		jz	clearTopLine	; 8Fh ������� ������� ��������� ������
		dcr	a
		jz	clearBottomLine	; 90h ������� ������ ��������� ������
		dcr	a
		jz	scrollDown	; 91h ������ ������ ���� �� �������
		dcr	a
		jz	scrollUp	; 92h ����� ������ ����� �� �������
		dcr	a
		jz	pushCursor	; 93h ����������� ������� ������
		dcr	a
		jz	popCursor	; 94h �������������� ������� ������
		dcr	a
		jz	printFileName	; 95h ����� ����� ����� ������������ � �����
		dcr	a
		xchg
		lhld	v_koi8
		dcr	a
		jz	c_koi7		; 97h ��������� ������ KOI-7
		dcr	a
		jz	c_koi8		; 98h ��������� ������ KOI-8
		dcr	a
		dcr	a
		rnz			; �����, � ������ 9Ah ����� ������ ����� �� ������ ��������� ������ �� ������� ������ �������
		xchg
		push	h
		inr	l
		inr	l
		mov	a, l
		adi	10
		mov	e, a
		lda	v_screenHeight
		jmp	c_scrolUpEx