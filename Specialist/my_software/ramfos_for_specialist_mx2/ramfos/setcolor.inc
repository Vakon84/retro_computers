;+---------------------------------------------------------------------------
; RAMFOS
; �������� ���� �����
; ���������� ��� ������ ���� 89
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

inverseColor:	lda	v_color
		cma

;+---------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� C84B
; ��������� ����� ���� � ����
;
; �� �����
;  ������� ���� A - ����� ����
;  ������� ���� A - ���� ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

setColor:	sta	v_color
		sta	IO_COLOR
		ret