10 CLS:OUT 144,3
20 Z=0:W=00:W1=00:W2=00
30 LOCATE 15,2:PRINT"И С К Р А  -  1080 Тарту"
40 LOCATE 5,5:PRINT"Проверка функционирования в автоматическом режиме" 
50 LOCATE 22,23:PRINT"Цикл";SRC(5);Z
60 LOCATE 10,7:PRINT" Время    ";W2;"час ";W;"мин ";W1;"сек "
70 LOCATE 22,10:PRINT"Проверка  О З У"
80 FOR I=16384 TO 16447
90 READ X:POKE I,X:NEXT I
100 DATA 14,170,205,11,64,14,85,205,11,64,201,33,0,1,70,113,126,185,194,55,64,112,35,124,254,64,194
110 DATA 41,64,125,254,0,194,14,64,33,80,64,195,14,64,254,255,194,14,64,125,254,255,194,14,64,62,1,201,62,2,51,51,0,0,0,0,0
120 D=USR(16384):IF D=2 THEN GOTO 140
130 LOCATE 22,15:PRINT"ОЗУ  проверено":FOR P=0 TO 300:NEXT P:GOTO 150
140 LOCATE 22,15:PRINT"ОЗУ не проверено":BEEP 50,500:FOR P=0 TO 300:NEXT P:END
150 CLS:FOR I=0 TO  255 STEP  32:LINE (0,I)-(383,I),1:NEXT I:LINE (0,255)-(383,255),1
160 FOR I=0 TO 383 STEP  48:LINE (I,0)-(I,255),1:NEXT I:LINE (383,0)-(383,255),1
170 LINE (0,0)-(383,255),1:LINE (0,255)-(383,0),1:FOR P=0 TO 500:NEXT P
180 OUT 145,5:OUT 147,6
190 CLS:FOR I=0 TO 60 STEP 20:CIRCLE (182,128),20+I,1:PAINT (183+I,128),I/20:NEXT I 
200 FOR I=1 TO 400:NEXT I
210 CLS:A$="AAAAAAAABBBBBBBBCCCCCCCCDDDDDDDDEEEEEEEEFFFFFFFFGGGGGGGGHHHHHHHHH" 
220 FOR I=0 TO 23:PRINT A$;:NEXT I:LOCATE 24,24:PRINT LEFT$(A$,39):FOR I=0 TO 100:NEXT I
230 CLS:INVERSE:FOR I=0 TO 23:PRINT A$;:NEXT I:LOCATE 24,24:PRINT LEFT$(A$,39):FOR I=0 TO 100:NEXT I:NORMAL 
240 CLS:FOR I=0 TO 15:OUT 144,I:LOCATE 24,15:PRINT"Проверка цвета ";I:FOR P=0 TO 300:NEXT P,I:CLS:OUT 144,3
250  Z=Z+1:W=W+1:W1=W1+14:IF W1>60 OR W1=60 THEN GOTO 270
255 IF W>60 OR W=60 THEN GOTO 280
260  RESTORE:GOTO 30
270  W=W+1:W1=W1-60:IF W<60 THEN GOTO 260
280  W2=W2+1:W=W-60:GOTO 260
290  END
