;+---------------------------------------------------------------------------
; RAMFOS
; ��������� ���������
;
; �� �����
;  hl - ��� �����
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

exec:		; ����� ����
		call	exec1

		; ���� ���� �� ������, ������������� ��
		jnz	biosInit		

exec2:		; �������� ����� ��������/������� � de � ����.
		lhld	v_header_start
		push	h
		xchg
		; ��������� ���� ��� �������� CRC (������ ��� � ������ �������
		; RKS �����, ��������� ������� CRC ��� �� �����)
                jmp	fileLoadNoCheck

; ---------------------------------------------------------------------------

exec1:		; ��������� ����� �����
		call	fileSetName
		
		; ������� ������ ���� �� RAM-�����
		call	fileFind

		; ����� �� ROM-�����
		mvi	b, 80h
		cnz	fileFindEx
		ret

