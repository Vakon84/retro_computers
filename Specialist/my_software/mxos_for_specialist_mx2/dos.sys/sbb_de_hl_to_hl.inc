;+---------------------------------------------------------------------------
; MXOS
; HL = DE - HL
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

sbb_de_hl_to_hl:
		mov	a, e
		sub	l
		mov	l, a
		mov	a, d
		sbb	h
		mov	h, a
		ret