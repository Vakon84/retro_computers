;+---------------------------------------------------------------------------
; RAMFOS
; �������� � ���������� �������� �����
;
; �� �����
;  hl - �����
; 
; �� ������
;  z  - ���� ����� �����
; 
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

memcmp_ext:	lxi	d, v_header_ext

;----------------------------------------------------------------------------
; RAMFOS
; �������� 3 ����� ���
;
; �� �����
;  hl - ����� 1
;  de - ����� 2
; 
; �� ������
;  z  - ���� ����� �����
; 
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

memcmp_hl_de_3:	mvi	c, 3

;----------------------------------------------------------------------------
; RAMFOS
; �������� ���
;
; �� �����
;  hl - ����� 1
;  de - ����� 2
;  �  - ������
; 
; �� ������
;  z  - ���� ����� �����
; 
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

memcmp_hl_de_c:	 ; if(*de-- != *hl--) return;
		 ldax	d
		 cmp	m
		 inx	h
		 rnz
		 inx	d
		 dcr	c
		jnz	memcmp_hl_de_c
		ret
