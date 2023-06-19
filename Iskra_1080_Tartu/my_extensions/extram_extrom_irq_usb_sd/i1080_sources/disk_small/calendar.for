	IOUT = 6
	WRITE(1,200)
200	FORMAT('1','ENTER YEAR (4 DIGITS)')
	READ (1,100) IYR
100	FORMAT(I4)
	CALL OPEN (IOUT,11HCALENDAR   ,0)
	WRITE(IOUT,300)
300	FORMAT(1H1)
	CALL NPRINT(IYR,IOUT)
	WRITE(IOUT,301)
301	FORMAT(' ')
	CALL CALNDR(IYR,IOUT)
	END
	SUBROUTINE CALNDR(INYEAR,IOUT)
	DIMENSION KDATES(7,6,12),KPRINT(504),KHARS(32)
	DATA KHARS /
     1	'  ',' 1',' 2',' 3',' 4',' 5',' 6',' 7',' 8',' 9',
     2	'10','11','12','13','14','15','16','17','18','19',
     3	'20','21','22','23','24','25','26','27','28','29',
     4	'30','31' /
	DO 10 I=1,7
	DO 10 J=1,6
	DO 10 K=1,12
10	KDATES(I,J,K) = 0
	IDAYW = 0
	IDAYR = 1
	ILINE = 0
20	CALL IDATE1(INYEAR,IDAYR,IMON,IDAYM)
	IF(IMON .GT. 12 .OR. IMON .LT. 1) GO TO 999
	IDAYW = IDATE3(INYEAR,IMON,IDAYM) + 1
	IF(IDAYW .EQ. 1) ILINE = ILINE + 1
	IF(IDAYM .EQ. 1) ILINE = 1
	KDATES(IDAYW,ILINE,IMON) = IDAYM
	IDAYR = IDAYR + 1
	IF (IDAYR .LE. 366) GO TO 20
999	ICTR = 1
	DO 30 J=3,12,3
	M=J-2
	DO 30 L=1,6
	DO 30 K=M,J
	DO 30 N=1,7
	MNUM=KDATES(N,L,K) + 1
	KPRINT(ICTR) = KHARS(MNUM)
30	ICTR = ICTR + 1
	WRITE(IOUT,2000)
	WRITE(IOUT,3000)
	WRITE(IOUT,6000)
	DO 40 I=1,6
	L=((I-1)*21) + 1
	K=L + 20
40	WRITE(IOUT,4000) (KPRINT(J),J=L,K)
	WRITE(IOUT,2200)
	WRITE(IOUT,3000)
	WRITE(IOUT,6000)
	DO 50 I=1,6
	L=((I-1)*21)+(7*6*3)+1
	K=L+20
50	WRITE(IOUT,4000) (KPRINT(J),J=L,K)
	WRITE(IOUT,2500)
	WRITE(IOUT,3000)
	WRITE(IOUT,6000)
	DO 60 I=1,6
	L=((I-1)*21)+(7*6*3*2)+1
	K=L+20
60	WRITE(IOUT,4000) (KPRINT(J),J=L,K)
	WRITE(IOUT,2700)
	WRITE(IOUT,3000)
	WRITE(IOUT,6000)
	DO 70 I=1,6
	L=((I-1)*21)+(7*6*3*3)+1
	K=L+20
70	WRITE(IOUT,4000) (KPRINT(J),J=L,K)
	RETURN
2000	FORMAT(1H0,
     1	'    J A N U A R Y     ',
     2	'   F E B R U A R Y    ',
     3	'      M A R C H       ')
2200	FORMAT(1H0,
     4	'      A P R I L       ',
     5	'        M A Y         ',
     6	'       J U N E        ')
2500	FORMAT(1H0,
     1	'       J U L Y        ',
     2	'     A U G U S T      ',
     3	'  S E P T E M B E R   ')
2700	FORMAT(1H0,
     4	'    O C T O B E R     ',
     5	'   N O V E M B E R    ',
     6	'   D E C E M B E R    ')
3000	FORMAT(1H0,3(' S  M  T  W  T  F  S  '))
4000	FORMAT(1H ,7(A2,1X),1X,7(A2,1X),1X,7(A2,1X),1X)
6000	FORMAT(1H )
	END

	SUBROUTINE IDATE1(IYEAR,IDAY,IMON,IDY)
C
C	THIS SUBROUTINE RETURNS MM/DD WHEN GIVEN YYY/DD
C
C	IYEAR = YEAR (INPUT
C	IDAY  = DAY WITHIN YEAR(I-366, INPUT)
C
C	IMON  = MONTH (OUTPUT)
C	IDY   = DAY WITHIN MONTH (1-31) OUTPUT
C
	IT = 0
	IF ((IYEAR/4)*4 .EQ. IYEAR) IT = 1
	IF ((IYEAR/400)*400 .EQ. IYEAR .OR.
     1	   (IYEAR/100)*100 .NE. IYEAR) GO TO 20
	IT = 0
20	ITEMP = 0
	IF (IDAY .GT. (59+IT)) ITEMP = 2 - IT
	IDY = IDAY + ITEMP
	IMON = IFIX((FLOAT(IDY+91) * 100.)/3055.)
	IDY = IDY+91-(IFIX(FLOAT(IMON)*3055./100.))
	IMON = IMON - 2
	RETURN
	END

	FUNCTION IDATE3(I,J,K)
C
C	IDATE3 RETURNS DATE OF WEEK (0-6) GIVVEN YY/MM/DD
C
C	I=YEAR, J=MONTH, K=DAY
C
	IDATE3=MOD((13*(J+10-(J+10)/13*12)-1)/5+K+77
     1	      +5*(I+(J-14)/12-(I+(J-14)/12)/100*100)/4
     2	      +(I+(J-14)/12)/400-(I+(J-14)/12)/100*2,7)
	RETURN
	END

	SUBROUTINE NPRINT(INUM,IOUT)
	LOGICAL CH(5,7,4)
	DIMENSION N(4)
	NUM=INUM
	ITEN = 1000
	DO 4 I=1,4
	NTEMP = NUM/ITEN
	N(I) = NTEMP
	NTEMP = NTEMP*ITEN
	NUM = NUM - NTEMP
	ITEN = ITEN / 10
4	CONTINUE
	DO 10 I=1,7
	J=I-1
	DO 11 K=1,4
11	CALL NUMBER(CH(1,I,K),N(K),J)
	WRITE(IOUT,200) ((CH(I1,I,I3),I1=1,5),I3=1,4)
200	FORMAT(' ','                    ',4(A1,A1,A1,A1,A1,3X))
10	CONTINUE
	RETURN
	END

