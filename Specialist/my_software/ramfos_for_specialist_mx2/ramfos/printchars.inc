;+---------------------------------------------------------------------------
; RAMFOS
; ����� �� ����� ���������� ��������
;
; �� �����:
;  b - ���-��
;  � - ������
;
; 2013-11-01 ����������������� vinxru
;----------------------------------------------------------------------------

#if ALL_CHARS
                 
printChars:	 push	b
		  call	printCharAll
		 pop	b
		 dcr	b
		jnz	printChars
		ret

#else

printChars:	 call	j_printChar
		 dcr	b
		 rz
		jmp	printChars

#endif
