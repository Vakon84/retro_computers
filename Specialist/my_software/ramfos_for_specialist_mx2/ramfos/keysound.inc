;+---------------------------------------------------------------------------
; RAMFOS
; �������� ������ ��� ������� �������
;
; 2013-11-01 vinxru
;----------------------------------------------------------------------------

keySound:	push	b
		 ; �������
		 xchg
		 lhld	v_beepConfig
		 xchg

		 ; �������� ������� � ��� ����, ���� ������ ���/LAT
		 lda	v_rusLat
		 ani	1
		 mov	a, d
		 jnz	keySound_0
		  rrc			; ���������, � ����� CF?
keySound_0:	 mov	d, a

		 ; ������������ ������ (����)
		 mov	b, e
		 mov	c, e
		 ora	a
		 call	setTimer
		pop	b

		; ��� ������� keyScan
		mvi	a, 0FFh
		ret
