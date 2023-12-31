;+---------------------------------------------------------------------------
; MXOS
; ����� ���������� �������� 
;
; �� ������
;  cf - ������
;  a - �������
;  �������� BC,DE,HL �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

fileFindClusterFirst:
		; ��������� ��������
		push	h

		; �������� ����� � ������� �������� (������ 4 �� ������������)
		lxi	h,  fat + 4
		jmp	fileFindClus_2

;----------------------------------------------------------------------------
; ����������� ������ ���������� �������� 
;
; �� ������
;  cf - ������
;  a - �������
;  �������� BC,DE,HL �����������
;----------------------------------------------------------------------------

fileFindClusterNext:
		; ��������� ��������
		push	h

		; �������� ����� � ����� ��������
		lhld	v_findCluster

		; ���� ��������� �������
		; � ��������������� ������ ������� FAT ������ ���� 0
fileFindClus_2:	xra	a
fileFindClus_0:	cmp	m
		jz	fileFindClus_1	; ������
		inr	l
		jnz	fileFindClus_0

		; �������������� �������� � ������� A=1, CF=1, ZF=0
		pop	h
		mvi	a, 1
		stc
		ret

; ---------------------------------------------------------------------------

fileFindClus_1:	; ��������� ������� ������
		mov	a, l

		; ������������ ZF=0. ����� �������� �� ����� ���� �������.
		; � ������ ������ �� �� �� ������� � ZF=1
		ora	a

		; ��� ��������� ������ ��������� ����� ���������� �������� � v_findCluster
		inr	l
		shld	v_findCluster

		; ��������������� �������� � ������� � CF=0, ZF=0
		pop	h
		ret