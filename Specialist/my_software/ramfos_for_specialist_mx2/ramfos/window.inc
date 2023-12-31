;+---------------------------------------------------------------------------
; RAMFOS
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if BIG_ROM != 1
		
#if $ > 0FFB6h
������_�����_F800_��_������
#endif
.org 0FFB6h

pageWriteROM:	sta	IO_PAGE_ROM
		jmp	pageWriteCom

pageReadROM:	sta	IO_PAGE_ROM
		jmp	pageReadCom

#endif

; ---------------------------------------------------------------------------

#if $ > 0FFC2h
������_�����_F800_��_������
#endif
.org 0FFC2h

pageRead:	lda	v_page

;----------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� F836
; ������ ����� �� ����
;
; �� �����
;   a  - ����� ��������
;   hl - �����
;
; �� ������
;   �  - ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

pageReadAny:	ora	a
#if BIG_ROM
		jm	bigRom
#else
		jm	pageReadROM
#endif
disableARAM1:	sta	IO_PAGE_ARAM		
pageReadCom:	mov	c, m
		sta	IO_PAGE_RAM
		ret

; ---------------------------------------------------------------------------

pageWrite:	lda	v_page

;----------------------------------------------------------------------------
; RAMFOS
; ����������� ����� ����� F839
; ������ ����� � ����
;
; �� �����
;   a  - ����� ��������
;   hl - �����
;   c  - ����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

pageWriteAny:	ora	a
#if BIG_ROM
		jm	pageWriteRet
#else
		jm	pageWriteROM
#endif
disableARAM2:	sta	IO_PAGE_ARAM
pageWriteCom:	mov	m, c
		sta	IO_PAGE_RAM
pageWriteRet:	ret