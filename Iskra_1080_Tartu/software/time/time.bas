30 CO=1:SC=1:MC=2:TC=3
40 NORMAL:CLS
50 LOCATE 50,3:PRINT"Курск";:LOCATE 5,22:PRINT"Искра 1080";
60 PI=2*3.1415927:X0=191:Y0=127:DX=106:DY=106
70 MX=0.95:MY=0.95:TX=0.65:TY=0.65 
80 MI=0:SE=0:TU=0
90 N=60
100 DIM X(N),Y(N)
110 FOR I=-PI/4 TO 3*PI/4 STEP PI/N
120 X(J)=DX*COS(I):Y(J)=DY*SIN(I)
130 XX=X0+1.05*X(J):YY=Y0+1.05*Y(J):PSET (XX,YY),CO
140 IF J/5=INT(J/5)THEN LINE(XX,YY)-(X0+1.1*X(J),Y0+1.1*Y(J)),CO
150 J=J+1:NEXT I
170 OUT 144,7:OUT 145,13:OUT 146,14:OUT 147,11
180 LOCATE 0,0
190 INPUT "Сколько часов?";TU:INPUT"Сколько минут?";MI
200 LOCATE 0,0:PRINT"                "
210 PRINT"                "
220 XM=MX*X(MI)+X0:YM=MY*Y(MI)+Y0 
230 T1=TU:IF T1>11 THEN T1=T1-12
240 T1=INT(5*T1+MI/12)
250 XT=TX*X(T1)+X0:YT=TY*Y(T1)+Y0
260 XS=X(SE)+X0:YS=Y(SE)+Y0
270 LINE(X0,Y0)-(XS,YS),SC:LINE (X0,Y0)-(XM,YM),MC:LINE (X0,Y0)-(XT,YT),TC
280 LOCATE 28,20:PRINT"81 камень";
290 LOCATE 50,6:PRINT MID$(STR$(100+TU),3,2)+":"+MID$(STR$(100+MI),3,2)+"."+MID$(STR$(100+SE),3,2);
300 BEEP 100,200
310 FOR I=1 TO 30:NEXT I
320 SE=SE+1:IF SE=60 THEN SE=0:MI=MI+1:LINE(X0,Y0)-(XM,YM),0:LINE (X0,Y0)-(XT,YT),0:IF MI=60 THEN MI=0:TU=TU+1
330 LINE (X0,Y0)-(XS,YS),0
340 GOTO 220
350 POKE 51185,0:POKE 51186,80:LIST 0*256+15*16+1,0:POKE 12*4096+7*256+15*16+2,80:LIST 
360 END
