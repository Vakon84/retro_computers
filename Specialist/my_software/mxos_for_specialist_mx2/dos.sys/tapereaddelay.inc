;+---------------------------------------------------------------------------
; MXOS
; �������� ��� ������ � �����
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

readDelay:	lda	v_readDelay
delay_a:	mov	b, a
		jmp	delay_l_0
