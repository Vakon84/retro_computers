;----------------------------------------------------------------------------
; MXOS
; �������� ����� � ���������� (�����������)
;
; �� ������
;  ? - ���
;
; 2013-12-12 ����������������� vinxru
;----------------------------------------------------------------------------

loc_C55C:	; ���� ����� ���� ���/LAT - �� ������������ ��� ��� CAPS/LOCK
		call	setKeybMode91
		mvi	a, 0F8h
		sta	IO_KEYB_B
		lda	IO_KEYB_A		
		push	psw
		call	setKeybMode82
		pop	psw
		ani	8
		jnz	getch_capsLock

		; ������ KOI-7 / KOI-8
		lda	v_koi8
		cma
		sta	v_koi8

		; �������� ������
		call	beep

		mvi	a, 3Ah
		sta	v_keyLocks

		; ������ �������
		mvi	a, 5Fh
		sta	v_beep

		jmp	getch_retry

; ---------------------------------------------------------------------------
; CAPS LOCK ��� KOI-7

getch_capsLock:	; ����������� capsLock
		lda	v_keyLocks
		xri	80h
		sta	v_keyLocks

		; �������� ������ �������� �������		
		lda	v_beep
		xri	10h
		sta	v_beep

		; ���� ��������� �������
		jmp	getch_retry

; ---------------------------------------------------------------------------
; CAPS LOCK ��� KOI-7 ��� ���/LAT ��� KOI-8

getch_rc:	; � ������ KOI-8 �� ����������� ���������
		lda	v_koi8
		inr	a

		lda	v_keyLocks	; ��������� � getch_rusLat
		jnz	getch_rusLat

		; � ������ KOI-7 �� ���������� �������
		jmp	getch_capsLock	

; ---------------------------------------------------------------------------

loc_C5A8:	; ������� KOI-7
		mov	b, a

		lda	IO_KEYB_B
		ani	2
		jnz	loc_C311

		mvi	a, 0A0h
		xra	b
		mov	b, a

		jmp	loc_C311