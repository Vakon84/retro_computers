j_reboot3:	jmp	reboot3		; ��������� NC.COM
j_getch:	jmp	getch		; �������� ����� � ����������
j_tapeRead:	jmp	tapeRead	; ������ ����� � �����������
j_printChar:	jmp	printChar	; ����� ������� �� �����
j_tapeWrite:	jmp	tapeWrite	; ������ ����� �� ����������
		jmp	input		; ���� ������ � ����������
		jmp	j_keyScan	; �������� ��� ������� �������
		jmp	printHexByte	; ������� 16-������ ����� (����)
j_printString:	jmp	printString1	; ������� ������ �� �����
		jmp	j_keyScan	; �������� ��� ������� �������
		jmp	getCursorPos	; �������� ���������� ������� � HL (���������� � ��������)
		jmp	setCursorPos	; ���������� ���������� ������� �� HL (���������� � ��������)
		jmp	tapeLoad	; ��������� ��������� � �����������
		jmp	tapeSave	; ��������� ��������� �� ����������
		jmp	calcCS		; ������ ����������� �����
		jmp	printHexWord	; ������� 16-������ ����� (�����)
		jmp	getMemTop	; �������� ����� ��������� ������
		jmp	setMemTop	; ���������� ����� ��������� ������
		jmp	printer		; ���������� ���� �� ��������
		jmp	j_reboot3	; ��������� NC.COM
		jmp	reboot3		; ��������� NC.COM
		jmp	fileList	; �������� ������ ������
		jmp	fileGetSetDrive	; ��������/���������� �������� ����������
		jmp	fileCreate	; ������� ����
		jmp	fileLoad	; ��������� ���� �� ������ �� ��������� ����� �����
		jmp	fileDelete	; ������� ����
		jmp	fileRename	; ������������� ����
		jmp	fileLoadInfo	; ��������� ���������� � �����
		jmp	fileGetSetAddr	; ��������/���������� ����� �������� �����
		jmp	fileGetSetAttr	; ��������/���������� �������� �����
		jmp	fileNamePrepare	; ������������� ��� ����� �� ���������� ������
		jmp	fileExec	; ��������� ����
		jmp	installDriver	; ���������� ������� ����������
j_diskDriver:	jmp	diskDriver	; ������� ���������� �����
		jmp	fileLoad2	; ��������� ���� �� ������ DE