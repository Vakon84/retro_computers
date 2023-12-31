;+---------------------------------------------------------------------------
; RAMFOS
; ������������� ������ � 16-������ �����
;
; �� �����
;  de - ������
;
; �� ������
;  bc       - �����������
;  de       - ��������� ������ �� ������� ��� ������ ������
;  jz       - ������
;  jnz, jc  - ����� ������
;  jnz, jnc - ������ ��� �������
;  hl       - �����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

strToHex:
#if SIZE_OPTIMIZATION==0
		push	b
		 call	strToHex2
		pop	b
		ret
#endif

; ---------------------------------------------------------------------------

strToHex2:	lxi	h, 0		
#if SIZE_OPTIMIZATION==0
		mvi	b, 0		
#endif

strToHex2_loop:	; ������ �������
		ldax	d
		inx	d

		; ���� ����� ������, ������� � ������� NZ, C
		cpi	0Dh
		jz	ora_a_stc_ret

		; ���� ������ ��� �������, ������� � ������� NZ, NC
		cpi	','
		jz	ora_a_ret		
		cpi	' '
		jz	ora_a_ret

		; ���� ������������ ������, ������� � ������� �,Z
		sui	'0'
		jm	xra_a_stc_ret		

		; ���� ��� �����
		cpi	10
		jm	strToHex2_0

		; ���� ������������ ������, ������� � ������� �,Z
		cpi	11h
		jm	xra_a_stc_ret
		cpi	17h
		jp	xra_a_stc_ret

		; ��� ����� A..F
		sui	'A'-'0'-10

strToHex2_0:	
#if SIZE_OPTIMIZATION==0
		mov	c, a
#endif
		; hl *=	16
		dad	h
		dad	h
		dad	h
		dad	h

		; ���� ������������, ��	����� c ������� �,Z
		jc	xra_a_stc_ret
		
		; hl += bc
#if SIZE_OPTIMIZATION
		push	b
		mvi	b, 0
		mov	c, a
#endif
		dad	b
#if SIZE_OPTIMIZATION
		pop	b
#endif
		jmp	strToHex2_loop