����grafika                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ���/*                SARATOV BEST-C COMPILER                    prilovenie 4    dannoe prilovenie sodervit w sebe tekst funkcij, s pomo}x`kotoryh legko movno postroitx to~ku ili lini` zadannogo cweta.rabota |tih funkcij wo mnogom shodna s rabotoj analogi~nyhoperatorow b|jsika, no w sootwetstwii s sintaksisom si,neskolxko izmenena procedura obra}eniq k nim. a imenno:PLOT - dannaq funkciq stroit to~ku. ona imeet sledu`}ij format       PLOT(X,Y,cwet)       gde X i Y koordinaty to~ki, pri~em  0<=X<=127,0<=Y<=49.       to~ka s koordinatoj (0,0) levit w lewom nivnem uglu.       parametr cwet w dannoj funkcii movet prinimatx       zna~eniq: 0,1,2. w slu~ae zadaniq nomera cweta 0 ili 1       to~ka budet postroena sootwetstwenno ~ernaq ili belaq.       w slu~ae zadaniq nomera cweta 2 budet proishoditx       inwersiq cweta w zadannoj to~ke.LINE - dannaq funkciq stroit otrezok. ona imeet sledu`}ij       format: LINE(X0,Y0,X1,Y1,cwet)       gde X0 i Y0 koordinaty na~ala otrezka, a X1 i Y1       koordinaty konca otrezka. w swoej rabote funkciq LINE       ispolxzuet funkcii PLOT i ABS, po|tomu pri ee       ispolxzowanii prisutstwie |tih funkcij obqzatelxno.    programma, tekst kotoroj priwoditsq w |tom priloveniiispolxzuet funkci` LINE dlq postroeniq ornamentow.pered na~alom translqcii programmy neobhodimo:1. ustanowitx oblastx dlq skompilirowannoj programmy   ne menx{e 3000 bajt;2. izmenitx zna~enie tela #DEFINE. w slu~ae ispolxzowaniq   p|wm s pamqtx` 32 kbajta, zna~enie tela rawno 30658,   a ddq p|wm s pamqtx` 60 kbajt  59330.*/#DEFINE SCREEN 59330PLOT(X,Y,C)INT X,Y,C;[[CHAR X0,Y0,CODE,*ADDR;IF (X<0!X>=128!Y<0!Y>=50!C<0!C>=3) RETURN;CODE=*(ADDR=SCREEN+1872+(X0=X>>1)-(Y0=Y>>1)*78);IF (CODE>=8&CODE<16!CODE>=24) *ADDR=0;IF (X-(X0+X0)) CODE=6;        ELSE   CODE=17;IF (Y-(Y0+Y0)) CODE=CODE&3;        ELSE   CODE=CODE&20;IF (C==1) *ADDR=*ADDR!CODE;ELSE IF (C==0)  *ADDR=*ADDR&(CODE^23);ELSE *ADDR=*ADDR^CODE;]]ABS(X)INT X;[[IF (X<0) RETURN -X;RETURN X;]]LINE(X0,Y0,IX,IY,C)INT X0,Y0,IX,IY,C;[[INT I,D,N1,N2,LF,X,Y;IF (X0<0!X0>=128!Y0<0!Y0>=50!IX<0!IX>=128!IY<0!IY>=50    !C<0!C>=3) RETURN;PLOT(X0,Y0,C);IX=IX-X0;IY=IY-Y0;N1=N2=1;LF=X=Y=0;IF (IX<0) N1=-1;IF (IY<0) N2=-1;IX=ABS(IX);IY=ABS(IY);IF (IX<IY) [[ LF=IX;IX=IY;IY=LF;LF=1;]]D=IY-(IX>>1);I=1;WHILE(I++<=IX)    [[    IF (D>0)        [[        X=X+N1;        Y=Y+N2;        D=D+IY-IX;        ]]    ELSE        [[        IF (LF>0) Y=Y+N2;        ELSE X=X+N1;        D=D+IY;        ]]    PLOT(X0+X,Y0+Y,C);    ]]]]INT RAND1,RAND2;RND()[[RETURN (RAND2=3*RAND1+7*(RAND1=RAND2)+12345)>>1;]]MAIN()[[INT C,X,Y,VX,VY;RAND1=RAND2=1;PUTCHAR('\C');WHILE(1)    [[    X=RND()%64;    Y=RND()%24;    IF (((VX=RND()%13-6)!(VY=RND()%9-4))==0) CONTINUE;    C=RND()%2;    WHILE(1)        [[        LINE(X,Y,127-X,Y,C);        LINE(127-X,Y,127-X,49-Y,C);        LINE(127-X,49-Y,X,49-Y,C);        LINE(X,49-Y,X,Y,C);        X=X+VX;        Y=Y+VY;        IF (X<0!X>=63!Y<0!Y>=23) BREAK;        ]]    ]]]]�%S