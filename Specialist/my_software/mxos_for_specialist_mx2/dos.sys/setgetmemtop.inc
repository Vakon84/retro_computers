;+---------------------------------------------------------------------------
; MXOS
; ���������� ����� ��������� ������
;
; �� �����
;  hl - ��������� ������. ���� ������ 0D000h, �� �������� �� ����������.
;
; �� ������
;  ��� �������� �����������
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

setMemTop:	push	psw
		mov	a, h
		cpi	0D0h
		jc	setMemTop_0
		  shld	v_memTop
setMemTop_0:	pop	psw
		ret

;----------------------------------------------------------------------------
; �������� ����� ��������� ������
;
; �� ������
;  hl - ��������� ������
;
; �� ������
;  ��� �������� �����������
;----------------------------------------------------------------------------
		
getMemTop:	lhld	v_memTop
		ret