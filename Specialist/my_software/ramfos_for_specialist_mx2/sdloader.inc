CLC_PORT        = 0FFE5h
DATA_PORT       = 0FFE6h
CTL_PORT        = 0FFE7h
CLC_BIT         = 80h;
SEND_MODE       = 10010000b ; ���������: 1 0 0 A �H 0 B CL   1=���� 0=�����
RECV_MODE       = 10011001b

ERR_START  	= 040h
ERR_WAIT   	= 041h
ERR_OK_DISK 	= 042h
ERR_OK          = 043h
ERR_OK_READ	= 044h
ERR_OK_RKS  	= 047h

;----------------------------------------------------------------------------

Entry:
     ; ������ ������ ���������� ������������� � ������������
     ; ����������� 256 �������. ��� ����� � ������� C ��������� 0
     MVI	C, 0

RetrySync:
     ; ����� ��������
     MVI	A, SEND_MODE
     STA	CTL_PORT

     ; �������� ������ �������
     MVI	A, 013h
     CALL	Send
     MVI	A, 0B4h
     CALL	Send
     MVI	A, 057h
     CALL	Send
     XRA	A
     CALL	Send

     ; ����� ������  
     MVI	A, RECV_MODE
     STA	CTL_PORT

     ; ���� ���� �������������, �� ���������� ������� ERR_START
     CALL	Recv
     CPI	ERR_START
     JZ 	Sync

     ; ����� / ���������� 256 ����, ���� ���������� ��� ��� �� ��������.
     ; � ����� ����� ��������� 64 �� ������
     MVI	B, 0
RetrySync2:
     CALL	Recv
     DCR	B
     JNZ	RetrySync2

     ; �������
     DCR	C
     JZ 	MONITOR ; ������ �������������

     JMP	RetrySync

;----------------------------------------------------------------------------
; ��� �� �� ��������� ����

Error:
    CALL	Recv
    JMP 	MONITOR

;----------------------------------------------------------------------------

Sync:
     ; ���� ���� �� ��������� ����.
     CALL	WaitForReady
     CPI	ERR_OK_RKS
     JNZ	Error ; ������ ������ �����

     ; ����� �������� � BC
     CALL	Recv
     MOV	C, A
     CALL	Recv
     MOV	B, A

     ; ��������� � ���� ����� �������
     PUSH	B

RecvLoop:
     ; ���������
     CALL	WaitForReady
     CPI 	ERR_OK_READ
     JZ 	Recv	; �� ���������, ������
     ORA A	; ������, ������������
     JNZ 	Error	; ������ ������ �����

     ; ����� ���������� �����
     CALL	Recv
     MOV	E, A
     CALL	Recv
     MOV	D, A

     ; ������������ ����
     LXI	H, CLC_PORT

     ; ������� ��������� ����
     INR	D
     XRA	A
     ORA	E
     JZ 	RecvBlock2
RecvBlock1:
     MVI	M, CLC_BIT    ; 11
     MVI	M, 0          ; 11
     LDA	DATA_PORT     ; 13
     STAX	B             ; 7
     INX	B             ; 5
     DCR	E             ; 5
     JNZ	RecvBlock1    ; 10
RecvBlock2:
     DCR	D
     JNZ	RecvBlock1

     JMP	RecvLoop

;----------------------------------------------------------------------------
; �������� � ����� �����

Send:
     STA	DATA_PORT     
Recv:
     MVI	A, CLC_BIT
     STA	CLC_PORT
     XRA	A
     STA	CLC_PORT
     LDA	DATA_PORT
     RET

;----------------------------------------------------------------------------
; �������� ���������� ��

WaitForReady:
     CALL       Recv
     CPI	ERR_WAIT
     JZ		WaitForReady
     RET

;----------------------------------------------------------------------------

MONITOR: