    device zxspectrum48
   org 100h - 16h
begin:
    db "ISKRA1080", 0xD0, "LINES ", entry, entry >> 8, end, end >> 8,  entry, entry >> 8
entry:
	jp main
main:
	; Stack correction reset
; 407 );
	call Intro
; 408     NewGame();
	call NewGame
; 409     char previousPressedKey = 0;
	xor a
	ld (main_s + 0), a
; 410     uint8_t keybTimeout = 0;
; REMOVED
	ld (main_s + 1), a
l_0:
; 411     for (;;) {
; 412         // Детаем генератор случайных чисел более случайным
; 413         (void)rand();
	call rand
; 414 
; 415         // Анимация выбранного шарика
; 416         BouncingBallAnimation();
	call BouncingBallAnimation
; 417 
; 418         char pressedKey = ReadKeyboard(true);
; 25 ;
	ld a, 1
	call ReadKeyboard
	ld (main_s + 2), a
; 421  != 0) {
	ld a, (main_s + 1)
	or a
	jp z, l_3
; 422             keybTimeout--;
; REMOVED
	dec a
	ld (main_s + 1), a
	jp l_0
l_3:
; 423             continue;
; 424         }
; 425 
; 426         // Только факт нажатия
; 427         if (pressedKey == previousPressedKey) {
	ld a, (main_s + 0)
	ld d, a
	ld a, (main_s + 2)
	cp d
	jp nz, l_5
; 428             Delay(50);
	ld hl, 50
	call Delay
	jp l_0
l_5:
; 429             continue;
; 430         }
; 431         previousPressedKey = pressedKey;
; REMOVED
	ld (main_s + 0), a
; 432         if (pressedKey == 0) continue;
	ld a, (main_s + 2)
	or a
	jp z, l_0
; REMOVED
; REMOVED
; 433         keybTimeout = 50;  // TODO: magic
	ld a, 50
	ld (main_s + 1), a
; 434 
; 435         switch (pressedKey) {
	ld a, (main_s + 2)
	sub 13
	jp z, l_12
	sub 4
	jp z, l_11
	sub 6
	jp z, l_16
	dec a
	jp z, l_13
	dec a
	jp z, l_14
	dec a
	jp z, l_15
	sub 6
	jp z, l_10
	sub 17
	jp z, l_22
	dec a
	jp z, l_21
	dec a
	jp z, l_20
	dec a
	jp z, l_19
	dec a
	jp z, l_18
	dec a
	jp z, l_17
	jp l_0
l_22:
; 436             case '1':
; 437                 ChangePalette();
	call ChangePalette
	jp l_0
l_21:
; 438                 break;
; 439             case '2':
; 440                 showPath ^= 1;
	ld a, (showPath)
	xor 1
	ld (showPath), a
; 441                 DrawButton(BUTTON_PATH, showPath);
; 1 *6000
	ld hl, 61960
	ld (DrawButton_1_a), hl
; 441 );
; REMOVED
	call DrawButton
	jp l_0
l_20:
; 442                 break;
; 443             case '3':
; 444                 soundEnabled ^= 1;
	ld a, (soundEnabled)
	xor 1
	ld (soundEnabled), a
; 445                 DrawButton(BUTTON_SOUND, soundEnabled);
; 1 *6000
	ld hl, 59912
	ld (DrawButton_1_a), hl
; 445 );
; REMOVED
	call DrawButton
	jp l_0
l_19:
; 446                 break;
; 447             case '4':
; 448                 showHelp ^= 1;
	ld a, (showHelp)
	xor 1
	ld (showHelp), a
; 449                 DrawButton(BUTTON_HELP, showHelp);
; 1 *6000
	ld hl, 57864
	ld (DrawButton_1_a), hl
; 449 );
; REMOVED
	call DrawButton
; 450                 DrawHelp();
	call DrawHelp
	jp l_0
l_18:
; 451                 break;
; 452             case '5':
; 453                 DrawHiScores(0);
	xor a
	call DrawHiScores
; 454                 ReadKeyboard(false);
; 24 ;
	xor a
	call ReadKeyboard
; 455 );
	call DrawScreen
	jp l_0
l_17:
; 456                 break;
; 457             case '6':
; 458                 NewGame();
	call NewGame
	jp l_0
l_16:
; 459                 break;
; 460             case KEY_UP:
; 461                 ClearCursor();
	call ClearCursor
; 462                 if (cursorY == 0)
	ld a, (cursorY)
	or a
	jp nz, l_23
; 463                     cursorY = GAME_HEIGHT - 1;
	ld a, 8
	ld (cursorY), a
	jp l_24
l_23:
; 464                 else
; 465                     cursorY--;
; REMOVED
	dec a
	ld (cursorY), a
l_24:
; 466                 DrawCursor();
	call DrawCursor
	jp l_0
l_15:
; 467                 break;
; 468             case KEY_DOWN:
; 469                 ClearCursor();
	call ClearCursor
; 470                 if (cursorY == GAME_HEIGHT - 1)
	ld a, (cursorY)
	cp 8
	jp nz, l_25
; 471                     cursorY = 0;
	xor a
	ld (cursorY), a
	jp l_26
l_25:
; 472                 else
; 473                     cursorY++;
; REMOVED
	inc a
	ld (cursorY), a
l_26:
; 474                 DrawCursor();
	call DrawCursor
	jp l_0
l_14:
; 475                 break;
; 476             case KEY_LEFT:
; 477                 ClearCursor();
	call ClearCursor
; 478                 if (cursorX == 0)
	ld a, (cursorX)
	or a
	jp nz, l_27
; 479                     cursorX = GAME_WIDTH - 1;
	ld a, 8
	ld (cursorX), a
	jp l_28
l_27:
; 480                 else
; 481                     cursorX--;
; REMOVED
	dec a
	ld (cursorX), a
l_28:
; 482                 DrawCursor();
	call DrawCursor
	jp l_0
l_13:
; 483                 break;
; 484             case KEY_RIGHT:
; 485                 ClearCursor();
	call ClearCursor
; 486                 if (cursorX == GAME_WIDTH - 1)
	ld a, (cursorX)
	cp 8
	jp nz, l_29
; 487                     cursorX = 0;
	xor a
	ld (cursorX), a
	jp l_30
l_29:
; 488                 else
; 489                     cursorX++;
; REMOVED
	inc a
	ld (cursorX), a
l_30:
; 490                 DrawCursor();
	call DrawCursor
	jp l_0
l_12:
l_11:
l_10:
; 491                 break;
; 492             case KEY_ENTER:
; 493             case KEY_RIGHT_5:
; 494             case ' ':
; 495                 MoveBall();
	call MoveBall
; REMOVED
; REMOVED
; REMOVED
	jp l_0
l_2:
	ret
Intro:
	; Stack correction reset
; 271 );
	call SetBlackPalette
; 272     void* next = unmlz((uint8_t*)0xD000, imgTitle);  // TODO: replace magic
	ld hl, 53248
	ld (unmlz_1_a), hl
	ld hl, imgTitle
	call unmlz
	ld (Intro_s + 0), hl
; 273     unmlz((uint8_t*)0x9000, next);                   // TODO: replace magic
	ld hl, 36864
	ld (unmlz_1_a), hl
	ld hl, (Intro_s + 0)
	call unmlz
; 274     SetPaletteSlowly(introPalette);
	ld hl, introPalette
	call SetPaletteSlowly
; 275 
; 276     // Играем мелодию
; 277     const uint16_t* p = music;
	ld hl, music
	ld (Intro_s + 2), hl
l_31:
; 278     for (;;) {
; 279         const uint8_t s = *p;
	ld hl, (Intro_s + 2)
	ld a, (hl)
	ld (Intro_s + 4), a
; 280         p++;
; REMOVED
	inc hl
	inc hl
	ld (Intro_s + 2), hl
; 281         if (s == 0) {
; REMOVED
	or a
	jp nz, l_34
; 282             ReadKeyboard(false);
; 24 ;
	xor a
	call ReadKeyboard
	jp l_33
l_34:
; 285 true) != 0) break;
; 25 ;
	ld a, 1
	call ReadKeyboard
	or a
	jp nz, l_33
; REMOVED
; REMOVED
; 286 *p, s);
	ld hl, (Intro_s + 2)
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	ld (PlayTone_1_a), hl
	ld hl, (Intro_s + 4)
	ld h, 0
	call PlayTone
; 287         p++;
	ld hl, (Intro_s + 2)
	inc hl
	inc hl
	ld (Intro_s + 2), hl
; 288         (void)rand();
	call rand
l_32:
	jp l_31
l_33:
	ret
NewGame:
	; Stack correction reset
; 303  = GAME_WIDTH / 2;
	ld a, 4
	ld (cursorX), a
; 304     cursorY = GAME_HEIGHT / 2;
; REMOVED
	ld (cursorY), a
; 305     selX = NO_SEL;
; 28 ;  // Значение для selX
	ld a, 255
	ld (selX), a
; 306  = 0;
	ld hl, 0
	ld (score), hl
; 307 
; 308     uint8_t x, y;
; 309     for (y = 0; y != GAME_HEIGHT; ++y)
	xor a
	ld (NewGame_s + 1), a
l_38:
	ld a, (NewGame_s + 1)
	cp 9
	jp z, l_40
; 310         for (x = 0; x != GAME_WIDTH; ++x) game[x][y] = 0;
	xor a
	ld (NewGame_s + 0), a
l_41:
	ld a, (NewGame_s + 0)
	cp 9
	jp z, l_43
	ld hl, (NewGame_s + 0)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (NewGame_s + 1)
	ld h, 0
	add hl, de
	ld (hl), 0
l_42:
	ld a, (NewGame_s + 0)
	inc a
	ld (NewGame_s + 0), a
	jp l_41
l_43:
l_39:
	ld a, (NewGame_s + 1)
	inc a
	ld (NewGame_s + 1), a
	jp l_38
l_40:
; 311 
; 312     GenerateNewBalls();
	call GenerateNewBalls
; 313     GameStep(true);
; 25 ;
	ld a, 1
	call GameStep
; 314 );
	jp DrawScreen
; REMOVED
rand:
	; Stack correction reset

rand_seed:
        ld a, 0FAh
        ld b, a
        add a, a
        add a, a
        add a, b
        inc a
        ld (rand_seed + 1), a
    
	ret
BouncingBallAnimation:
	; Stack correction reset
; 315 }
; 316 
; 317 // Переместить шарик
; 318 
; 319 static void MoveBall() {
; 320     if (game[cursorX][cursorY] != 0) {
; 321         if (selX != NO_SEL) DrawCell(selX, selY, game[selX][selY]);
; 322         selX = cursorX;
; 323         selY = cursorY;
; 324         return;
; 325     }
; 326 
; 327     if (selX == NO_SEL) return;
; 328 
; 329     uint8_t c = game[selX][selY];
; 330 
; 331     // Алгоритм поиска поути
; 332     if (!PathFind()) {
; 333         if (soundEnabled) PlaySoundCantMove();
; 334         return;
; 335     }
; 336 
; 337     if (showPath) {
; 338         // Рисуем шаги на экране
; 339         for (;;) {
; 340             uint8_t x = path_x;
; 341             uint8_t y = path_y;
; 342             uint8_t dir = PathGetNextStep();
; 343             DrawSpriteStep(x, y, dir - 1);
; 344             DrawCell(path_x, path_y, c);
; 345             if (path_n == LAST_STEP) break;
; 346             if (soundEnabled) PlaySoundJump();
; 347             Delay(STEP_ANIMATION_DELAY);
; 348         };
; 349 
; 350         // Удаляем нарисованные шаги с экрана
; 351         PathRewind();
; 352         do {
; 353             DrawEmptyCell(path_x, path_y);
; 354             PathGetNextStep();
; 355         } while (path_n != LAST_STEP);
; 356     } else {
; 357         DrawEmptyCell(selX, selY);
; 358         DrawCell(cursorX, cursorY, c);
; 359     }
; 360 
; 361     // Очищаем игровое поле от временных значений
; 362     PathFree();
; 363 
; 364     // Реально перемещаем шарик. Все выше было лишь анимацией.
; 365     game[selX][selY] = 0;
; 366     game[cursorX][cursorY] = c;
; 367 
; 368     // Снимаем выделение
; 369     selX = NO_SEL;
; 370 
; 371     // Добавляем 3 шарика
; 372     if (!GameStep(false)) return;
; 373 
; 374     // Если не получилось добавить, то конец игры.
; 375 
; 376     // Если игрок набал мало очков, то просто показываем таблицу
; 377     if (score < hiScores[HISCORE_COUNT - 1].score) {
; 378         DrawHiScores(0);
; 379     } else {
; 380         AddToHiScores();
; 381     }
; 382 
; 383     ReadKeyboard(false);
; 384     NewGame();
; 385 }
; 386 
; 387 // Анимация прыгающего шарика
; 388 
; 389 static void BouncingBallAnimation() {
; 390     if (selX == NO_SEL) return;
	ld a, (selX)
	cp 255
	ret z
; REMOVED
; REMOVED
; 391     selAnimationDelay++;
	ld a, (selAnimationDelay)
	inc a
	ld (selAnimationDelay), a
; 392     if (selAnimationDelay >= BOUNCE_ANIMATION_DELAY) {
; REMOVED
	cp 50
	jp c, l_46
; 393         selAnimationDelay = 0;
	xor a
	ld (selAnimationDelay), a
; 394         DrawBouncingBall(selX, selY, game[selX][selY], selAnimationFrame);
	ld a, (selX)
	ld (DrawBouncingBall_1_a), a
	ld a, (selY)
	ld (DrawBouncingBall_2_a), a
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld a, (hl)
	ld (DrawBouncingBall_3_a), a
	ld a, (selAnimationFrame)
	call DrawBouncingBall
; 395         selAnimationFrame++;
	ld a, (selAnimationFrame)
	inc a
	ld (selAnimationFrame), a
; 396         if (selAnimationFrame >= BOUNCE_ANIMATION_COUNT) {
; REMOVED
	cp 6
	jp c, l_48
; 397             selAnimationFrame = 0;
	xor a
	ld (selAnimationFrame), a
	jp l_49
l_48:
; 398         } else if (soundEnabled && selAnimationFrame == 4) {
	ld a, (soundEnabled)
	or a
	jp z, l_50
	ld a, (selAnimationFrame)
	cp 4
	jp nz, l_50
; 399             PlaySoundJump();
	call PlaySoundJump
l_50:
l_49:
l_46:
	ret
ReadKeyboard:
	; Stack correction reset
; 144  ReadKeyboard(bool noWait) {
	ld (ReadKeyboard_1_a), a
l_52:
; 145     uint8_t keyNumber;
; 146     for (;;) {
; 147         uint8_t i = KEYBOARD_ROWS;
	ld a, 10
	ld (ReadKeyboard_s + 1), a
l_55:
; 148         for (;;) {
; 149             --i;
	ld a, (ReadKeyboard_s + 1)
	dec a
	ld (ReadKeyboard_s + 1), a
; 150             keyNumber = ReadKeyboardRow(i);  // TODO: Светодиоды
; REMOVED
	call ReadKeyboardRow
	ld (ReadKeyboard_s + 0), a
; 151             if (i == SHIFT_ROW) {            // Удаляем SHIFT
	ld a, (ReadKeyboard_s + 1)
	cp 3
	jp nz, l_58
; 152                 keyNumber &= ~SHIFT_MASK;
	ld a, (ReadKeyboard_s + 0)
	and 247
	ld (ReadKeyboard_s + 0), a
l_58:
; 153             }
; 154             if (keyNumber != 0) break;
	ld a, (ReadKeyboard_s + 0)
	or a
	jp nz, l_57
; REMOVED
; REMOVED
; 155             if (i != 0) continue;
	ld a, (ReadKeyboard_s + 1)
	or a
	jp nz, l_55
; REMOVED
; REMOVED
; 156             keyboardPressedKey = 0;
	xor a
	ld (keyboardPressedKey), a
; 157             if (noWait) return 0;
	ld a, (ReadKeyboard_1_a)
	or a
	jp z, l_64
	xor a
	ret
l_64:
; 158             i = KEYBOARD_ROWS;
	ld a, 10
	ld (ReadKeyboard_s + 1), a
; REMOVED
	jp l_55
l_57:
; 159         }
; 160         keyNumber = NumberOfBit(keyNumber) + i * KEYBOARD_COLUMNS;
; REMOVED
	call NumberOfBit
	ld d, a
	ld a, (ReadKeyboard_s + 1)
	add a
	add a
	add a
	add d
	ld (ReadKeyboard_s + 0), a
; 161         if (noWait) break;
	ld a, (ReadKeyboard_1_a)
	or a
	jp nz, l_54
; REMOVED
; REMOVED
; 162         if (keyboardPressedKey == keyNumber) continue;
	ld a, (ReadKeyboard_s + 0)
	ld d, a
	ld a, (keyboardPressedKey)
	cp d
	jp z, l_52
; REMOVED
; REMOVED
; 163         keyboardPressedKey = keyNumber;
	ld a, (ReadKeyboard_s + 0)
	ld (keyboardPressedKey), a
; 164         switch (keyNumber) {
	ld a, (ReadKeyboard_s + 0)
	sub 24
	jp z, l_73
	dec a
	jp z, l_72
	sub 5
	jp z, l_71
	jp l_54
l_73:
; 165             case KEY_COORD_RUS:
; 166                 keyboardMode |= MODE_RUS;
	ld a, (keyboardMode)
	or 1
	ld (keyboardMode), a
	jp l_52
l_72:
; 167                 continue;
; 168             case KEY_COORD_LAT:
; 169                 keyboardMode &= ~MODE_RUS;
	ld a, (keyboardMode)
	and 254
	ld (keyboardMode), a
	jp l_52
l_71:
; 170                 continue;
; 171             case KEY_COORD_CAPS:
; 172                 keyboardMode ^= MODE_CAPS;
	ld a, (keyboardMode)
	xor 2
	ld (keyboardMode), a
	jp l_52
; REMOVED
; REMOVED
; REMOVED
; REMOVED
l_54:
; 173                 continue;
; 174         }
; 175         break;
; 176     }
; 177 
; 178     // Преобразовать номер клавиши в код символа
; 179     uint8_t shiftPressed = ReadKeyboardRow(SHIFT_ROW) & SHIFT_MASK;
	ld a, 3
	call ReadKeyboardRow
	and 8
	ld (ReadKeyboard_s + 1), a
; 180     const uint8_t* layout = scanCodes + keyNumber;
	ld hl, (ReadKeyboard_s + 0)
	ld h, 0
	ld de, scanCodes
	add hl, de
	ld (ReadKeyboard_s + 2), hl
; 181     if ((keyboardMode & MODE_RUS) != 0) layout += KEYBOARD_LANGUAGE_SIZE;
	ld a, (keyboardMode)
	and 1
; REMOVED
	jp z, l_74
; REMOVED
	ld de, 160
	add hl, de
	ld (ReadKeyboard_s + 2), hl
l_74:
; 182     if ((*layout & L) != 0)                   // LETTERS
; REMOVED
	ld a, (hl)
	and 128
; REMOVED
	jp z, l_76
; 183         if ((keyboardMode & MODE_CAPS) != 0)  // CAPS LOCK
	ld a, (keyboardMode)
	and 2
; REMOVED
	jp z, l_78
; 184             shiftPressed ^= SHIFT_MASK;       // Применить/отменить SHIFT
	ld a, (ReadKeyboard_s + 1)
	xor 8
	ld (ReadKeyboard_s + 1), a
l_78:
l_76:
; 185     if (shiftPressed != 0) layout += KEYBOARD_SCAN_SIZE;
	ld a, (ReadKeyboard_s + 1)
	or a
	jp z, l_80
; REMOVED
	ld de, 80
	add hl, de
	ld (ReadKeyboard_s + 2), hl
l_80:
; 186     char result = *layout;
; REMOVED
	ld a, (hl)
	ld (ReadKeyboard_s + 4), a
; 187     if ((keyboardMode & MODE_RUS) == 0)  // LAT
	ld a, (keyboardMode)
	and 1
; REMOVED
	jp nz, l_82
; 188         result &= 0x7F;
	ld a, (ReadKeyboard_s + 4)
	and 127
	ld (ReadKeyboard_s + 4), a
l_82:
; 189     return result;
	ld a, (ReadKeyboard_s + 4)
	ret
; REMOVED
Delay:
	; Stack correction reset
; 22  Delay(uint16_t n) {
	ld (Delay_1_a), hl
l_84:
; 23     while (--n != 0) {
	ld hl, (Delay_1_a)
	dec hl
	ld (Delay_1_a), hl
	ld a, h
	or l
	jp nz, l_84
; REMOVED
; REMOVED
	ret
ChangePalette:
	; Stack correction reset
; 264 gamePalette, gamePalette2, sizeof(gamePalette));
	ld hl, gamePalette
	ld (memswap_1_a), hl
	ld hl, gamePalette2
	ld (memswap_2_a), hl
	ld hl, 4
	call memswap
; 265     SetPalette(gamePalette);
	ld hl, gamePalette
	jp SetPalette
; REMOVED
DrawButton:
	; Stack correction reset
	ld (DrawButton_2_a), a
	ld a, 4
	ld (DrawButton_s + 0), a
l_86:
	ld a, (DrawButton_s + 0)
	or a
	jp z, l_88
	ld a, (DrawButton_2_a)
	or a
	jp z, l_89
	ld hl, (DrawButton_1_a)
	ld de, 49152
	add hl, de
	ld (memcpy_1_a), hl
	ld hl, (DrawButton_1_a)
	ld (memcpy_2_a), hl
	ld hl, 8
	call memcpy
	jp l_90
l_89:
	ld hl, (DrawButton_1_a)
	ld de, 49152
	add hl, de
	ld (memset_1_a), hl
	xor a
	ld (memset_2_a), a
	ld hl, 8
	call memset
l_90:
	ld hl, (DrawButton_1_a)
	ld de, 256
	add hl, de
	ld (DrawButton_1_a), hl
l_87:
	ld a, (DrawButton_s + 0)
	dec a
	ld (DrawButton_s + 0), a
	jp l_86
l_88:
	ret
DrawHelp:
	; Stack correction reset
	xor a
	ld (DrawHelp_s + 0), a
l_91:
	ld a, (DrawHelp_s + 0)
	cp 3
	jp nc, l_93
	ld a, (showHelp)
	or a
	jp z, l_94
	ld hl, (DrawHelp_s + 0)
	ld h, 0
	add hl, hl
	ld de, helpCoords
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	ld (DrawSpriteNew1_1_a), hl
	ld hl, (DrawHelp_s + 0)
	ld h, 0
	ld de, newBalls
	add hl, de
	ld a, (hl)
	ld (DrawSpriteNew1_2_a), a
	ld a, 3
	call DrawSpriteNew1
	jp l_95
l_94:
	ld hl, (DrawHelp_s + 0)
	ld h, 0
	add hl, hl
	ld de, helpCoords
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	call DrawEmptyCell1
l_95:
l_92:
	ld a, (DrawHelp_s + 0)
	inc a
	ld (DrawHelp_s + 0), a
	jp l_91
l_93:
	ret
DrawHiScores:
	; Stack correction reset
; 266 }
; 267 
; 268 // Заставка
; 269 
; 270 void Intro() {
; 271     SetBlackPalette();
; 272     void* next = unmlz((uint8_t*)0xD000, imgTitle);  // TODO: replace magic
; 273     unmlz((uint8_t*)0x9000, next);                   // TODO: replace magic
; 274     SetPaletteSlowly(introPalette);
; 275 
; 276     // Играем мелодию
; 277     const uint16_t* p = music;
; 278     for (;;) {
; 279         const uint8_t s = *p;
; 280         p++;
; 281         if (s == 0) {
; 282             ReadKeyboard(false);
; 283             break;
; 284         }
; 285         if (ReadKeyboard(true) != 0) break;
; 286         PlayTone(*p, s);
; 287         p++;
; 288         (void)rand();
; 289     }
; 290 }
; 291 
; 292 // Таблица рекордов
; 293 
; 294 void DrawHiScoresScreen1(uint8_t i, uint8_t pos) {
; 295     struct HiScore* h = hiScores + i;
; 296     for (; i < HISCORE_COUNT; ++i) {
; 297         char text[sizeof(h->name) + UINT16TOSTRING_OUTPUT_SIZE];
; 298         memset(text, ' ', sizeof(h->name) - 1);
; 299         memcpy(text, h->name, strlen(h->name));
; 300         Uint16ToString(text + (sizeof(h->name) - 1), h->score);
; 301         SetTextColor(pos == i ? 1 : 3);
; 302         DrawText((TEXT_WIDTH - 14) / 2, (HISCORE_Y + 2) + i, 0x7F, text);
; 303         h++;
; 304     }
; 305 }
; 306 
; 307 void DrawHiScores(bool enterNameMode) {
	ld (DrawHiScores_1_a), a
; 308     SetFillRectColor(0);
	xor a
	call SetFillRectColor
; 309     FillRect1(FILLRECTARGS(108, PLAYFIELD_Y + 18, 274, PLAYFIELD_Y + 156));
	ld hl, 62161
	ld (FillRect1_1_a), hl
	ld hl, 21
	ld (FillRect1_2_a), hl
	ld a, 15
	ld (FillRect1_3_a), a
	ld a, 224
	ld (FillRect1_4_a), a
	ld a, 139
	call FillRect1
; 310 2);
	ld a, 2
	call SetTextColor
; 311     DrawText1(DRAWTEXTARGS((TEXT_WIDTH - 17) / 2, HISCORE_Y), 0x7F, "Лучшие результаты");
	ld hl, 61133
	ld (DrawText1_1_a), hl
	ld a, 3
	ld (DrawText1_2_a), a
; 311 , "Лучшие результаты");
	ld a, 127
	ld (DrawText1_3_a), a
	ld hl, s_8
	call DrawText1
; 312     if (enterNameMode != 0) {
	ld a, (DrawHiScores_1_a)
	or a
	jp z, l_96
; 313         DrawText1(DRAWTEXTARGS((TEXT_WIDTH - 16) / 2, HISCORE_Y + 4 + HISCORE_COUNT), 0x7F, "Введите своё имя");
	ld hl, 60757
	ld (DrawText1_1_a), hl
	xor a
	ld (DrawText1_2_a), a
; 313 , "Введите своё имя");
	ld a, 127
	ld (DrawText1_3_a), a
	ld hl, s_9
	call DrawText1
; 314         DrawHiScoresScreen1(0, HISCORE_COUNT - 1);
	xor a
	ld (DrawHiScoresScreen1_1_a), a
	ld a, 7
	call DrawHiScoresScreen1
	jp l_97
l_96:
; 315     } else {
; 316         DrawText1(DRAWTEXTARGS((TEXT_WIDTH - 21) / 2, HISCORE_Y + 3 + HISCORE_COUNT), 0x7F, "Нажмите любую клавишу");
	ld hl, 61535
	ld (DrawText1_1_a), hl
	ld a, 1
	ld (DrawText1_2_a), a
; 316 , "Нажмите любую клавишу");
	ld a, 127
	ld (DrawText1_3_a), a
	ld hl, s_10
	call DrawText1
; 317         DrawText1(DRAWTEXTARGS((TEXT_WIDTH - 15) / 2, HISCORE_Y + 4 + HISCORE_COUNT), 0x7F, "для продолжения");
	ld hl, 60757
	ld (DrawText1_1_a), hl
	xor a
	ld (DrawText1_2_a), a
; 317 , "для продолжения");
	ld a, 127
	ld (DrawText1_3_a), a
	ld hl, s_11
	call DrawText1
; 318         DrawHiScoresScreen1(0, HISCORE_COUNT);
	xor a
	ld (DrawHiScoresScreen1_1_a), a
; 25 ;
	ld a, 8
	call DrawHiScoresScreen1
l_97:
	ret
DrawScreen:
	; Stack correction reset
; 361 );
	call SetBlackPaletteSlowly
; 362 
; 363     // Рисуем фон
; 364     void* next = unmlz((uint8_t*)0xD000, imgScreen);
	ld hl, 53248
	ld (unmlz_1_a), hl
	ld hl, imgScreen
	call unmlz
	ld (DrawScreen_s + 0), hl
; 365     unmlz((uint8_t*)0x9000, next);
	ld hl, 36864
	ld (unmlz_1_a), hl
	ld hl, (DrawScreen_s + 0)
	call unmlz
; 366 
; 367     // Ваше имя
; 368     SetTextColor(3);
	ld a, 3
	call SetTextColor
; 369     DrawText(56, 19, 0x7F, "Вы");
	ld a, 56
	ld (DrawText_1_a), a
	ld a, 19
	ld (DrawText_2_a), a
	ld a, 127
	ld (DrawText_3_a), a
	ld hl, s_12
	call DrawText
; 370 
; 371     // Нужно перерисовать короля и претендента
; 372     rightCreatureY = 0xFF;
	ld a, 255
	ld (rightCreatureY), a
; 373 
; 374     // Ваш результат и изображение бойца слева
; 375     DrawScoreAndCreatures();
	call DrawScoreAndCreatures
; 376 
; 377     // Максимальный результат
; 378     char buf[UINT16TOSTRING_OUTPUT_SIZE + 1];
; 379     Uint16ToString(buf, hiScores[0].score);
	ld hl, DrawScreen_s + 2
	ld (Uint16ToString_1_a), hl
	ld hl, (((hiScores) + (0)) + (10))
	call Uint16ToString
; 380     DrawText1(PIXELCOORDS(3, 7), 1, UINT16TOSTRING_OUTPUT_SIZE, buf);
; 1  ((XX)*256))
	ld hl, 64760
	ld (DrawText1_1_a), hl
; 380 , UINT16TOSTRING_OUTPUT_SIZE, buf);
	ld a, 1
	ld (DrawText1_2_a), a
	ld a, 5
	ld (DrawText1_3_a), a
	ld hl, DrawScreen_s + 2
	call DrawText1
; 381 
; 382     // Имя набравшено максимальный результат
; 383     DrawText(3 + (9 - strlen(hiScores[0].name)) / 2, 19, 9, hiScores[0].name);
	ld hl, ((hiScores) + (0)) + (0)
	call strlen
	ld de, 9
	ex hl, de
	call __o_sub_16
	ld de, 1
	call __o_shr_u16
	ld a, l
	add 3
	ld (DrawText_1_a), a
	ld a, 19
	ld (DrawText_2_a), a
	ld a, 9
	ld (DrawText_3_a), a
	ld hl, ((hiScores) + (0)) + (0)
	call DrawText
; 384 
; 385     // Рисуем состояние кнопок
; 386     if (showPath) DrawButton(BUTTON_PATH, true);
	ld a, (showPath)
	or a
	jp z, l_98
; 1  ((XX)*256))
	ld hl, 61960
	ld (DrawButton_1_a), hl
; 25 ;
	ld a, 1
	call DrawButton
l_98:
; 387 ) DrawButton(BUTTON_SOUND, true);
	ld a, (soundEnabled)
	or a
	jp z, l_100
; 1  ((XX)*256))
	ld hl, 59912
	ld (DrawButton_1_a), hl
; 25 ;
	ld a, 1
	call DrawButton
l_100:
; 388 ) {
	ld a, (showHelp)
	or a
	jp z, l_102
; 389         DrawButton(BUTTON_HELP, true);
; 1  ((XX)*256))
	ld hl, 57864
	ld (DrawButton_1_a), hl
; 25 ;
	ld a, 1
	call DrawButton
; 390 );
	call DrawHelp
l_102:
; 391     }
; 392 
; 393     uint8_t x, y;
; 394     for (y = 0; y < GAME_HEIGHT; y++) {
	xor a
	ld (DrawScreen_s + 9), a
l_104:
	ld a, (DrawScreen_s + 9)
	cp 9
	jp nc, l_106
; 395         for (x = 0; x < GAME_WIDTH; x++) {
	xor a
	ld (DrawScreen_s + 8), a
l_107:
	ld a, (DrawScreen_s + 8)
	cp 9
	jp nc, l_109
; 396             uint8_t color = game[x][y];
	ld hl, (DrawScreen_s + 8)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (DrawScreen_s + 9)
	ld h, 0
	add hl, de
	ld a, (hl)
	ld (DrawScreen_s + 10), a
; 397             if (color != 0) DrawCell(x, y, color);
; REMOVED
	or a
	jp z, l_110
	ld a, (DrawScreen_s + 8)
	ld (DrawCell_1_a), a
	ld a, (DrawScreen_s + 9)
	ld (DrawCell_2_a), a
	ld a, (DrawScreen_s + 10)
	call DrawCell
l_110:
l_108:
	ld a, (DrawScreen_s + 8)
	inc a
	ld (DrawScreen_s + 8), a
	jp l_107
l_109:
l_105:
	ld a, (DrawScreen_s + 9)
	inc a
	ld (DrawScreen_s + 9), a
	jp l_104
l_106:
; 398         }
; 399     }
; 400 
; 401     DrawCursor();
	call DrawCursor
; 402 
; 403     // Показываем графику
; 404     SetPaletteSlowly(gamePalette);
	ld hl, gamePalette
	jp SetPaletteSlowly
; REMOVED
ClearCursor:
	; Stack correction reset
	jp DrawCursor
; REMOVED
DrawCursor:
	; Stack correction reset
	ld a, (cursorX)
	ld (CellAddress_1_a), a
	ld a, (cursorY)
	call CellAddress
	jp DrawCursorXor
; REMOVED
MoveBall:
	; Stack correction reset
; 320 cursorY] != 0) {
	ld hl, (cursorX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (cursorY)
	ld h, 0
	add hl, de
	ld a, (hl)
	or a
	jp z, l_112
; 321         if (selX != NO_SEL) DrawCell(selX, selY, game[selX][selY]);
	ld a, (selX)
	cp 255
	jp z, l_114
; REMOVED
	ld (DrawCell_1_a), a
	ld a, (selY)
	ld (DrawCell_2_a), a
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld a, (hl)
	call DrawCell
l_114:
; 322         selX = cursorX;
	ld a, (cursorX)
	ld (selX), a
; 323         selY = cursorY;
	ld a, (cursorY)
	ld (selY), a
	ret
l_112:
; 324         return;
; 325     }
; 326 
; 327     if (selX == NO_SEL) return;
	ld a, (selX)
	cp 255
	ret z
; REMOVED
; REMOVED
; 328 
; 329     uint8_t c = game[selX][selY];
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld a, (hl)
	ld (MoveBall_s + 0), a
; 330 
; 331     // Алгоритм поиска поути
; 332     if (!PathFind()) {
	call PathFind
	or a
	jp nz, l_118
; 333         if (soundEnabled) PlaySoundCantMove();
	ld a, (soundEnabled)
	or a
	call nz, PlaySoundCantMove
; REMOVED
; REMOVED
	ret
l_118:
; 334         return;
; 335     }
; 336 
; 337     if (showPath) {
	ld a, (showPath)
	or a
	jp z, l_122
l_124:
; 338         // Рисуем шаги на экране
; 339         for (;;) {
; 340             uint8_t x = path_x;
	ld a, (path_x)
	ld (MoveBall_s + 1), a
; 341             uint8_t y = path_y;
	ld a, (path_y)
	ld (MoveBall_s + 2), a
; 342             uint8_t dir = PathGetNextStep();
	call PathGetNextStep
	ld (MoveBall_s + 3), a
; 343             DrawSpriteStep(x, y, dir - 1);
	ld a, (MoveBall_s + 1)
	ld (DrawSpriteStep_1_a), a
	ld a, (MoveBall_s + 2)
	ld (DrawSpriteStep_2_a), a
	ld a, (MoveBall_s + 3)
	dec a
	call DrawSpriteStep
; 344             DrawCell(path_x, path_y, c);
	ld a, (path_x)
	ld (DrawCell_1_a), a
	ld a, (path_y)
	ld (DrawCell_2_a), a
	ld a, (MoveBall_s + 0)
	call DrawCell
; 345             if (path_n == LAST_STEP) break;
	ld a, (path_n)
	cp 9
	jp z, l_126
; REMOVED
; REMOVED
; 346             if (soundEnabled) PlaySoundJump();
	ld a, (soundEnabled)
	or a
	call nz, PlaySoundJump
; REMOVED
; REMOVED
; 347             Delay(STEP_ANIMATION_DELAY);
; 35 ; /* задерка в main */
	ld hl, 2000
	call Delay
l_125:
	jp l_124
l_126:
; 351 );
	call PathRewind
l_131:
; 352         do {
; 353             DrawEmptyCell(path_x, path_y);
	ld a, (path_x)
	ld (DrawEmptyCell_1_a), a
	ld a, (path_y)
	call DrawEmptyCell
; 354             PathGetNextStep();
	call PathGetNextStep
l_132:
; 355         } while (path_n != LAST_STEP);
	ld a, (path_n)
	cp 9
	jp nz, l_131
l_133:
	jp l_123
l_122:
; 356     } else {
; 357         DrawEmptyCell(selX, selY);
	ld a, (selX)
	ld (DrawEmptyCell_1_a), a
	ld a, (selY)
	call DrawEmptyCell
; 358         DrawCell(cursorX, cursorY, c);
	ld a, (cursorX)
	ld (DrawCell_1_a), a
	ld a, (cursorY)
	ld (DrawCell_2_a), a
	ld a, (MoveBall_s + 0)
	call DrawCell
l_123:
; 359     }
; 360 
; 361     // Очищаем игровое поле от временных значений
; 362     PathFree();
	call PathFree
; 363 
; 364     // Реально перемещаем шарик. Все выше было лишь анимацией.
; 365     game[selX][selY] = 0;
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld (hl), 0
; 366     game[cursorX][cursorY] = c;
	ld a, (MoveBall_s + 0)
	ld hl, (cursorX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (cursorY)
	ld h, 0
	add hl, de
	ld (hl), a
; 367 
; 368     // Снимаем выделение
; 369     selX = NO_SEL;
; 28 ;  // Значение для selX
	ld a, 255
	ld (selX), a
; 372 false)) return;
; 24 ;
	xor a
	call GameStep
	or a
	ret z
; REMOVED
; REMOVED
; 377 score) {
	ld hl, (((hiScores) + (84)) + (10))
	ex hl, de
	ld hl, (score)
	call __o_sub_16
	jp nc, l_136
; 378         DrawHiScores(0);
	xor a
	call DrawHiScores
	jp l_137
l_136:
; 379     } else {
; 380         AddToHiScores();
	call AddToHiScores
l_137:
; 381     }
; 382 
; 383     ReadKeyboard(false);
; 24 ;
	xor a
	call ReadKeyboard
; 384 );
	jp NewGame
; REMOVED
SetBlackPalette:
	; Stack correction reset
; 47 0x0F);
	ld a, 15
	call SetPaletteInternal

        out (0B8h), a
        out (0B9h), a
    
	ret
unmlz:
	; Stack correction reset
; 20 * __fastcall unmlz(void* destination, const void* source) {
	ld (unmlz_2_a), hl

        ex   hl, de  // source
        ld   hl, (unmlz_1_a)  // destination
        ld   bc, hl
        ld   a, 0x80
unmlz_0:
        ld   (unmlz_5 + 1), a
        ld   a, (de)
        inc  de
        jp   unmlz_4
unmlz_1:
        ld   a, (hl)
        inc  hl
        ld   (bc), a
        inc  bc
unmlz_2:
        ld   a, (hl)
        inc  hl
        ld   (bc), a
        inc  bc
unmlz_3:
        ld   a, (hl)
unmlz_4:
        ld   (bc), a
        inc  bc
unmlz_5:
        ld   a, 0x80
        add  a
        call z, unmlz_20
        jp   c, unmlz_0
        add  a
        call z, unmlz_20
        jp   c, unmlz_7
        add  a
        call z, unmlz_20
        jp   c, unmlz_6
        ld   hl, 16383
        call unmlz_16
        ld   (unmlz_5 + 1), a
        add  hl, bc
        jp   unmlz_3

unmlz_6:
        ld   (unmlz_5 + 1), a
        ld   a, (de)
        inc  de
        ld   l, a
        ld   h, 255
        add  hl, bc
        jp   unmlz_2

unmlz_7:
        add  a
        call z, unmlz_20
        jp   c, unmlz_8
        call unmlz_18
        add  hl, bc
        jp   unmlz_1

unmlz_8:
        ld   h, 0
unmlz_9:
        inc  h
        add  a
        call z, unmlz_20
        jp   nc, unmlz_9
unmlz_10:
        push af
        ld   a, h
        cp   8
        jp   nc, unmlz_15
        ld   a, 0
unmlz_11:
        rra
        dec  h
        jp   nz, unmlz_11
unmlz_12:
        ld   h, a
        ld   l, 1
        pop  af
        call unmlz_16
        inc  hl
        inc  hl
        push hl
        call unmlz_18
        ex de, hl
        ex   (sp), hl
        ex de, hl
        add  hl, bc
unmlz_13:
        ld   a, (hl)
        inc  hl
        ld   (bc), a
        inc  bc
        dec  e
        jp   nz, unmlz_13
unmlz_14:
        pop  de
        jp   unmlz_5
unmlz_15:
        pop  af
        ex   de, hl
        ret

unmlz_16:
        add  a
        call z, unmlz_20
        jp   c, unmlz_17
        add  hl, hl
        ret  c
        jp unmlz_16
unmlz_17:
        add  hl, hl
        inc  l
        ret  c
        jp   unmlz_16

unmlz_18:
        add  a
        call z, unmlz_20
        jp   c, unmlz_19
        ld   (unmlz_5 + 1), a
        ld   a, (de)
        inc  de
        ld   l, a
        ld   h, 255
        ret

unmlz_19:
        ld   hl, 8191
        call unmlz_16
        ld   (unmlz_5 + 1), a
        ld   h, l
        dec  h
        ld   a, (de)
        inc  de
        ld   l, a
        ret

unmlz_20:
        ld   a, (de)
        inc  de
        rla
    
	ret
SetPaletteSlowly:
	; Stack correction reset
; 67  SetPaletteSlowly(const uint8_t* palette) {
	ld (SetPaletteSlowly_1_a), hl
; 68     currentPalette = palette;
; REMOVED
	ld (currentPalette), hl
; 69 
; 70     // Установка темной палитры
; 71     SetPaletteInternal(0x08);
	ld a, 8
	call SetPaletteInternal

        out (0F8h), a
        out (0B9h), a
    
; 72 
; 73     // Включение цветного режима. Процессор работает в 2 раза медленнее.
; 74     asm {
; 75         out (0F8h), a
; 76         out (0B9h), a
; 77     }
; 78 
; 79     // Задержка
; 80     Delay(5000);
	ld hl, 5000
	call Delay
; 81 
; 82     // Установка нормальной палитры
; 83     SetPaletteInternal(0x00);
	xor a
	jp SetPaletteInternal
; REMOVED
PlayTone:
	; Stack correction reset
; 20  PlayTone(uint16_t time, uint16_t period) {
	ld (PlayTone_2_a), hl

        ex hl, de
        ld hl, (PlayTone_1_a)
        jp 0EAB1h
    
	ret
GenerateNewBalls:
	; Stack correction reset
; 185  = 0; i < NEW_BALL_COUNT; i++) newBalls[i] = rand() % COLORS_COUNT + 1;
	xor a
	ld (GenerateNewBalls_s + 0), a
l_138:
	ld a, (GenerateNewBalls_s + 0)
	cp 3
	jp nc, l_140
	call rand
	ld l, a
	ld h, 0
	ld de, 7
	call __o_mod_u16
	ld a, l
	inc a
	ld hl, (GenerateNewBalls_s + 0)
	ld h, 0
	ld de, newBalls
	add hl, de
	ld (hl), a
l_139:
	ld a, (GenerateNewBalls_s + 0)
	inc a
	ld (GenerateNewBalls_s + 0), a
	jp l_138
l_140:
	ret
GameStep:
	; Stack correction reset
; 186 }
; 187 
; 188 // Помещаем шарик в случайную свободную ячейку
; 189 
; 190 struct XY {
; 191     uint8_t x, y;
; 192 };
; 193 
; 194 // Удалить линии или добавить 3 шарика.
; 195 
; 196 static uint8_t GameStep(uint8_t newGame) {
	ld (GameStep_1_a), a
; 197     // Ищем готовые линии
; 198     if (FindLines()) return 0;
	call FindLines
	or a
	jp z, l_141
	xor a
	ret
l_141:
; 199 
; 200     // Считаем кол во свободных клеток
; 201     uint8_t freeCellCount = CalcFreeCellCount();
	call CalcFreeCellCount
	ld (GameStep_s + 0), a
; 202     if (freeCellCount == 0) return 1;  // Такого не может быть
; REMOVED
	or a
	jp nz, l_143
	ld a, 1
	ret
l_143:
; 203 
; 204     // Кол-во добавляемых шариков
; 205     uint8_t newBallCount = freeCellCount;
; REMOVED
	ld (GameStep_s + 1), a
; 206     if (newBallCount > NEW_BALL_COUNT) newBallCount = NEW_BALL_COUNT;
; REMOVED
	cp 4
	jp c, l_145
; 27 ;
	ld a, 3
	ld (GameStep_s + 1), a
l_145:
; 211  = 0; i < newBallCount; i++) {
	xor a
	ld (GameStep_s + 2), a
l_147:
	ld a, (GameStep_s + 1)
	ld d, a
	ld a, (GameStep_s + 2)
	cp d
	jp nc, l_149
; 212         uint8_t n = rand() % freeCellCount;
	call rand
	ld l, a
	ld h, 0
	ex hl, de
	ld hl, (GameStep_s + 0)
	ld h, 0
	ex hl, de
	call __o_mod_u16
	ld a, l
	ld (GameStep_s + 9), a
; 213         freeCellCount--;
	ld a, (GameStep_s + 0)
	dec a
	ld (GameStep_s + 0), a
; 214         uint8_t* p = &game[0][0];
	ld hl, ((game) + (0)) + (0)
	ld (GameStep_s + 10), hl
l_150:
; 215         for (;;) {
; 216             if (*p == 0) {
	ld hl, (GameStep_s + 10)
	ld a, (hl)
	or a
	jp nz, l_153
; 217                 if (n == 0) break;
	ld a, (GameStep_s + 9)
	or a
	jp z, l_152
; REMOVED
; REMOVED
; 218                 n--;
; REMOVED
	dec a
	ld (GameStep_s + 9), a
l_153:
; 219             }
; 220             p++;
; REMOVED
	inc hl
	ld (GameStep_s + 10), hl
l_151:
	jp l_150
l_152:
; 221         }
; 222 
; 223         // Заносим шарик
; 224         *p = newBalls[i];
	ld hl, (GameStep_s + 2)
	ld h, 0
	ld de, newBalls
	add hl, de
	ld a, (hl)
	ld hl, (GameStep_s + 10)
	ld (hl), a
; 225 
; 226         // ЗАпоминаем координаты для анимации
; 227         coords[i].x = (p - &game[0][0]) / GAME_WIDTH;
; REMOVED
	ld de, -(((game) + (0)) + (0))
	add hl, de
	ld de, 9
	call __o_div_u16
	ld a, l
	ld hl, (GameStep_s + 2)
	ld h, 0
	add hl, hl
	ld de, GameStep_s + 3
	add hl, de
	ld (hl), a
; 228         coords[i].y = __div_16_mod;
	ld a, (__div_16_mod)
	ld hl, (GameStep_s + 2)
	ld h, 0
	add hl, hl
; REMOVED
	add hl, de
	inc hl
	ld (hl), a
l_148:
	ld a, (GameStep_s + 2)
	inc a
	ld (GameStep_s + 2), a
	jp l_147
l_149:
; 229     }
; 230 
; 231     // Рисуем анимацию
; 232     if (!newGame) {
	ld a, (GameStep_1_a)
	or a
	jp nz, l_157
; 233         for (i = 0; i < NEW_ANIMATION_COUNT; i++) {
	xor a
	ld (GameStep_s + 2), a
l_159:
	ld a, (GameStep_s + 2)
	cp 5
	jp nc, l_161
; 234             uint8_t j;
; 235             for (j = 0; j < newBallCount; j++) {
	xor a
	ld (GameStep_s + 9), a
l_162:
	ld a, (GameStep_s + 1)
	ld d, a
	ld a, (GameStep_s + 9)
	cp d
	jp nc, l_164
; 236                 DrawSpriteNew(coords[j].x, coords[j].y, newBalls[j], i);
	ld hl, (GameStep_s + 9)
	ld h, 0
	add hl, hl
	ld de, GameStep_s + 3
	add hl, de
	ld a, (hl)
	ld (DrawSpriteNew_1_a), a
	ld hl, (GameStep_s + 9)
	ld h, 0
	add hl, hl
; REMOVED
	add hl, de
	inc hl
	ld a, (hl)
	ld (DrawSpriteNew_2_a), a
	ld hl, (GameStep_s + 9)
	ld h, 0
	ld de, newBalls
	add hl, de
	ld a, (hl)
	ld (DrawSpriteNew_3_a), a
	ld a, (GameStep_s + 2)
	call DrawSpriteNew
l_163:
	ld a, (GameStep_s + 9)
	inc a
	ld (GameStep_s + 9), a
	jp l_162
l_164:
; 237             }
; 238             Delay(NEW_ANIMATION_DELAY);
; 31 ; /* задерка в main */
	ld hl, 2000
	call Delay
l_160:
; 233 ) {
	ld a, (GameStep_s + 2)
	inc a
	ld (GameStep_s + 2), a
	jp l_159
l_161:
l_157:
; 234             uint8_t j;
; 235             for (j = 0; j < newBallCount; j++) {
; 236                 DrawSpriteNew(coords[j].x, coords[j].y, newBalls[j], i);
; 237             }
; 238             Delay(NEW_ANIMATION_DELAY);
; 239         }
; 240     }
; 241 
; 242     // Вычисляем цвета новых шариков
; 243     GenerateNewBalls();
	call GenerateNewBalls
; 244 
; 245     // Рисуем цвета новых шариков
; 246     if (newGame) return 0;
	ld a, (GameStep_1_a)
	or a
	jp z, l_165
	xor a
	ret
l_165:
; 247     DrawHelp();
	call DrawHelp
; 248 
; 249     // Ищем готовые линии
; 250     if (FindLines()) return 0;
	call FindLines
	or a
	jp z, l_167
	xor a
	ret
l_167:
; 251 
; 252     // Если свободных клеток не осталось и целых линий не обнаружено, то конец игры
; 253     return freeCellCount == 0;
	ld a, (GameStep_s + 0)
	or a
	jp nz, l_169
	ld a, 1
	jp l_170
l_169:
	xor a
l_170:
	ret
; REMOVED
DrawBouncingBall:
	; Stack correction reset
; 146  DrawBouncingBall(uint8_t x, uint8_t y, uint8_t color, uint8_t phase) {
	ld (DrawBouncingBall_4_a), a
; 147     uint8_t* graphAddress = CellAddress(x, y);
	ld a, (DrawBouncingBall_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawBouncingBall_2_a)
	call CellAddress
	ld (DrawBouncingBall_s + 0), hl
; 148     if (phase == 1) {
	ld a, (DrawBouncingBall_4_a)
	cp 1
	jp nz, l_171
; 149         graphAddress[0] = 0;
; REMOVED
	ld (hl), 0
; 150         graphAddress[-0x100] = 0;
; REMOVED
	ld de, 65280
	add hl, de
	ld (hl), 0
; 151         graphAddress++;
	ld hl, (DrawBouncingBall_s + 0)
	inc hl
	ld (DrawBouncingBall_s + 0), hl
l_171:
; 152     }
; 153     DrawBall1(graphAddress, bouncingAnimation[phase], color);
; REMOVED
	ld (DrawBall1_1_a), hl
	ld hl, (DrawBouncingBall_4_a)
	ld h, 0
	add hl, hl
	ld de, bouncingAnimation
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	ld (DrawBall1_2_a), hl
	ld a, (DrawBouncingBall_3_a)
	jp DrawBall1
; REMOVED
PlaySoundJump:
	; Stack correction reset
 out (0xB0), a
	ret
ReadKeyboardRow:
	; Stack correction reset
; 137  uint8_t ReadKeyboardRow(uint8_t row) {
	ld (ReadKeyboardRow_1_a), a

        out (0C0h), a
        in a, (0C0h)
    
	ret
NumberOfBit:
	; Stack correction reset
; 20  NumberOfBit(uint8_t b) {
	ld (NumberOfBit_1_a), a

        ld e, 0
        ld d, 7
NumberOfBit_0:
        rra
        jp c, NumberOfBit_1
        inc e
        dec d
        jp nz, NumberOfBit_0
NumberOfBit_1:
        ld a, e
    
	ret
memswap:
	; Stack correction reset
; 22  __fastcall memswap(void* buffer1, void* buffer2, size_t size) {
	ld (memswap_3_a), hl
; 23     (void)buffer1;
	ld hl, (memswap_1_a)
; 24     (void)buffer2;
	ld hl, (memswap_2_a)
; 25     (void)size;
	ld hl, (memswap_3_a)

        push bc
        ex hl, de            ; de = size
        ld hl, (memswap_2_a) ; bc = buffer2
        ld c, l
        ld b, h
        ld hl, (memswap_1_a) ; hl = buffer1
        inc d                ; enter loop
        xor a
        or e
        jp z, memswap_3
memswap_1:
        ld a, (bc)
        ld (memswap_2 + 1), a
        ld a, (hl)
        ld (bc), a
memswap_2:
        ld (hl), 0
        inc hl
        inc bc
        dec e                ; end loop
        jp nz, memswap_1
memswap_3:
        dec d
        jp nz, memswap_1
        pop bc
    
	ret
SetPalette:
	; Stack correction reset
; 86  SetPalette(const uint8_t* palette) {
	ld (SetPalette_1_a), hl
; 87     currentPalette = palette;
; REMOVED
	ld (currentPalette), hl
; 88     SetPaletteInternal(0x00);
	xor a
	jp SetPaletteInternal
; REMOVED
memcpy:
	; Stack correction reset
; 20 * __fastcall memcpy(void* destination, const void* source, size_t size) {
	ld (memcpy_3_a), hl
; 21     (void)destination;
	ld hl, (memcpy_1_a)
; 22     (void)source;
	ld hl, (memcpy_2_a)
; 23     (void)size;
	ld hl, (memcpy_3_a)

        push bc
        ex hl, de           ; de = size
        ld hl, (memcpy_2_a) ; bc = source
        ld c, l
        ld b, h
        ld hl, (memcpy_1_a) ; hl = destination
        inc d               ; enter loop
        xor a
        or e
        jp z, memcpy_2
memcpy_1:
        ld a, (bc)
        ld (hl), a
        inc hl
        inc bc
        dec e               ; end loop
        jp nz, memcpy_1
memcpy_2:
        dec d
        jp nz, memcpy_1
        pop bc
        ld hl, (memcpy_1_a) ; return destination
    
	ret
memset:
	; Stack correction reset
; 22 * __fastcall memset(void* destination, uint8_t byte, size_t size) {
	ld (memset_3_a), hl
; 23     (void)destination;
	ld hl, (memset_1_a)
; 24     (void)byte;
	ld a, (memset_2_a)
; 25     (void)size;
	ld hl, (memset_3_a)

        ex hl, de           ; de = size
        ld hl, (memset_1_a) ; hl = destination
        inc d               ; enter loop
        xor a
        or e
        ld a, (memset_2_a)  ; bc = byte
        jp z, memset_2
memset_1:
        ld (hl), a
        inc hl
        inc bc
        dec e               ; end loop
        jp nz, memset_1
memset_2:
        dec d
        jp nz, memset_1
        ld hl, (memset_1_a) ; return destination
    
	ret
DrawSpriteNew1:
	; Stack correction reset
; 123  DrawSpriteNew1(uint8_t* graphAddress, uint8_t color, uint8_t phase) {
	ld (DrawSpriteNew1_3_a), a
; 124     DrawImage(graphAddress, imgBalls + (BALL_IMAGE_SIZEOF * 10) * (color - 1) + (4 - phase) * BALL_IMAGE_SIZEOF,
	ld hl, (DrawSpriteNew1_1_a)
	ld (DrawImage_1_a), hl
	ld hl, (DrawSpriteNew1_3_a)
	ld h, 0
	ld de, 4
	ex hl, de
	call __o_sub_16
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	push hl
	ld hl, (DrawSpriteNew1_2_a)
	ld h, 0
	dec hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, imgBalls
	add hl, de
	pop de
	add hl, de
	ld (DrawImage_2_a), hl
	ld hl, 528
	jp DrawImage
; REMOVED
DrawEmptyCell1:
	; Stack correction reset
	ld (DrawEmptyCell1_1_a), hl
; REMOVED
	ld (DrawImage_1_a), hl
	ld hl, (imgBoard) + (256)
	ld (DrawImage_2_a), hl
	ld hl, 528
	jp DrawImage
; REMOVED
SetFillRectColor:
	; Stack correction reset
; 20  __fastcall SetFillRectColor(uint8_t color) {
	ld (SetFillRectColor_1_a), a

        ld de, 0B200h  // OR A + NOP
        rra
        jp c, SetFillRectColor_0
        ld de, 0A22Fh  // AND D + CMA
SetFillRectColor_0:
        ld hl, FillRectCmd0
        ld (hl), e
        ld hl, FillRectCmd1
        ld (hl), d

        ld de, 0B200h  // OR A + NOP
        rra
        jp c, SetFillRectColor_1
        ld de, 0A22Fh  // AND D + CMA
SetFillRectColor_1:
        ld hl, FillRectCmd2
        ld (hl), e
        ld hl, FillRectCmd3
        ld (hl), d
    
	ret
FillRect1:
	; Stack correction reset
; 21     asm {
; 22         ld de, 0B200h  // OR A + NOP
; 23         rra
; 24         jp c, SetFillRectColor_0
; 25         ld de, 0A22Fh  // AND D + CMA
; 26 SetFillRectColor_0:
; 27         ld hl, FillRectCmd0
; 28         ld (hl), e
; 29         ld hl, FillRectCmd1
; 30         ld (hl), d
; 31 
; 32         ld de, 0B200h  // OR A + NOP
; 33         rra
; 34         jp c, SetFillRectColor_1
; 35         ld de, 0A22Fh  // AND D + CMA
; 36 SetFillRectColor_1:
; 37         ld hl, FillRectCmd2
; 38         ld (hl), e
; 39         ld hl, FillRectCmd3
; 40         ld (hl), d
; 41     }
; 42 }
; 43 
; 44 static void __fastcall FillRectInternal(uint8_t height, uint8_t mask, uint8_t* graphAddress) {
; 45     asm {
; 46         push hl
; 47         ld a, (FillRectInternal_2_a)
; 48 FillRectCmd0:
; 49         nop  // CMA = 2F, NOP = 00
; 50         ld d, a
; 51         ld a, (FillRectInternal_1_a)
; 52         ld e, a
; 53 FillRectInternal_0:
; 54         ld a, (hl)
; 55 FillRectCmd1:
; 56         or d  // XRA D = AA, ANA D = A2, ORA D = B2
; 57         ld (hl), a
; 58         dec l
; 59         dec e
; 60         jp nz, FillRectInternal_0
; 61         pop hl
; 62 
; 63         ld a, h
; 64         sub 40h
; 65         ld h, a
; 66 
; 67         ld a, (FillRectInternal_2_a)
; 68 FillRectCmd2:
; 69         nop  // CMA = 2F, NOP = 00
; 70         ld d, a
; 71 
; 72         ld a, (FillRectInternal_1_a)
; 73         ld e, a
; 74 FillRectInternal_1:
; 75         ld a, (hl)
; 76 FillRectCmd3:
; 77         or d  // XRA D = AA, ANA D = A2, ORA D = B2
; 78         ld (hl), a
; 79         dec l
; 80         dec e
; 81         jp nz, FillRectInternal_1
; 82     }
; 83 }
; 84 
; 85 void FillRect1(uint8_t* graphAddress, uint16_t width, uint8_t left, uint8_t right, uint8_t height) {
	ld (FillRect1_5_a), a
; 86     if (width == 0) {
	ld hl, (FillRect1_2_a)
	ld a, h
	or l
	jp nz, l_173
; 87         FillRectInternal(height, left & right, graphAddress);
	ld a, (FillRect1_5_a)
	ld (FillRectInternal_1_a), a
	ld a, (FillRect1_4_a)
	ld d, a
	ld a, (FillRect1_3_a)
	and d
	ld (FillRectInternal_2_a), a
	ld hl, (FillRect1_1_a)
	jp FillRectInternal
; REMOVED
l_173:
; 88         return;
; 89     }
; 90     FillRectInternal(height, left, graphAddress);
	ld a, (FillRect1_5_a)
	ld (FillRectInternal_1_a), a
	ld a, (FillRect1_3_a)
	ld (FillRectInternal_2_a), a
	ld hl, (FillRect1_1_a)
	call FillRectInternal
; 91     graphAddress -= 0x100;
	ld hl, (FillRect1_1_a)
	ld de, 65280
	add hl, de
	ld (FillRect1_1_a), hl
; 92     --width;
	ld hl, (FillRect1_2_a)
	dec hl
	ld (FillRect1_2_a), hl
l_175:
; 93     for (; width != 0; --width) {
	ld hl, (FillRect1_2_a)
	ld a, h
	or l
	jp z, l_177
; 94         FillRectInternal(height, 0xFF, graphAddress);
	ld a, (FillRect1_5_a)
	ld (FillRectInternal_1_a), a
	ld a, 255
	ld (FillRectInternal_2_a), a
	ld hl, (FillRect1_1_a)
	call FillRectInternal
; 95         graphAddress -= 0x100;
	ld hl, (FillRect1_1_a)
	ld de, 65280
	add hl, de
	ld (FillRect1_1_a), hl
l_176:
	ld hl, (FillRect1_2_a)
	dec hl
	ld (FillRect1_2_a), hl
	jp l_175
l_177:
; 96     }
; 97     FillRectInternal(height, right, graphAddress);
	ld a, (FillRect1_5_a)
	ld (FillRectInternal_1_a), a
	ld a, (FillRect1_4_a)
	ld (FillRectInternal_2_a), a
	ld hl, (FillRect1_1_a)
	jp FillRectInternal
; REMOVED
SetTextColor:
	; Stack correction reset
; 105  SetTextColor(uint8_t color) {
	ld (SetTextColor_1_a), a
; 106     if (textColor == color) return;
; REMOVED
	ld d, a
	ld a, (textColor)
	cp d
	ret z
; REMOVED
; REMOVED
; 107     textColor = color;
	ld a, (SetTextColor_1_a)
	ld (textColor), a
; 108     SetTextColorInternal(0, color & 1, color & 4);
	xor a
	ld (SetTextColorInternal_1_a), a
	ld a, (SetTextColor_1_a)
	and 1
	ld (SetTextColorInternal_2_a), a
	ld a, (SetTextColor_1_a)
	and 4
	call SetTextColorInternal
; 109     SetTextColorInternal(1, color & 2, color & 8);
	ld a, 1
	ld (SetTextColorInternal_1_a), a
	ld a, (SetTextColor_1_a)
	and 2
	ld (SetTextColorInternal_2_a), a
	ld a, (SetTextColor_1_a)
	and 8
	jp SetTextColorInternal
; REMOVED
DrawText1:
	; Stack correction reset
; 110 }
; 111 
; 112 static uint8_t DrawChar(uint8_t offset, const uint8_t* source, uint8_t* destination) {
; 113     asm {
; 114         push bc
; 115         ex de, hl
; 116         ld hl, (DrawChar_2_a)
; 117         ex de, hl
; 118         ld c, 8
; 119         ld a, (DrawChar_1_a)
; 120         dec a
; 121         jp z, print_o1
; 122         dec a
; 123         jp z, print_o2
; 124         dec a
; 125         jp z, print_o3
; 126 
; 127         ; OFFSET 0
; 128 print_o0:
; 129         ld a, (de) ; Read
; 130         add a
; 131         add a
; 132         ld b, a
; 133         ld a, (hl) ; Copy
; 134 print_m1:
; 135         and 3
; 136         xor b
; 137         ld (hl), a
; 138         ld a, h ; Plane 2
; 139         xor 40h
; 140         ld h, a
; 141         ld a, (hl) ; Copy
; 142 print_m2:
; 143         and 3
; 144         xor b
; 145         ld (hl), a
; 146         ld a, h ; Plane 1
; 147         xor 40h
; 148         ld h, a
; 149         inc de ; Next
; 150         dec l
; 151         dec c
; 152         jp nz, print_o0
; 153         pop bc
; 154         ld a, 1
; 155         ret
; 156 
; 157         ; OFFSET 1
; 158 print_o1:
; 159         ld a, (de) ; Read
; 160         add a
; 161         adc a
; 162         adc a
; 163         adc a
; 164         push af ; Left side
; 165         adc a
; 166         and 00000011b
; 167         ld b, a
; 168         ld a, (hl) ; Copy
; 169 print_m3:
; 170         and 0FCh
; 171         xor b
; 172         ld (hl), a
; 173         ld a, h ; Plane 2
; 174         xor 40h
; 175         ld h, a
; 176         ld a, (hl) ; Copy
; 177 print_m4:
; 178         and 0FCh
; 179         xor b
; 180         ld (hl), a
; 181         ld a, h ; Plane 1
; 182         xor 40h
; 183         ld h, a
; 184         pop af ; Right side
; 185         dec h
; 186         and 011110000b
; 187         ld b, a
; 188         ld a, (hl) ; Copy
; 189 print_m5:
; 190         and 00Fh
; 191         xor b
; 192         ld (hl), a
; 193         ld a, h ; Plane 2
; 194         xor 40h
; 195         ld h, a
; 196         ld a, (hl) ; Copy
; 197 print_m6:
; 198         and 00Fh
; 199         xor b
; 200         ld (hl), a
; 201         ld a, h ; Plane 1
; 202         xor 40h
; 203         ld h, a
; 204         inc h ; Next
; 205         inc de
; 206         dec l
; 207         dec c
; 208         jp nz, print_o1
; 209         pop bc
; 210         ld a, 2
; 211         ret
; 212 
; 213         ; OFFSET 2
; 214 print_o2:
; 215         ld a, (de) ; Read
; 216         rra
; 217         rra
; 218         and 00001111b
; 219         ld b, a
; 220         ld a, (hl) ; Copy
; 221 print_m7:
; 222         and 0F0h
; 223         xor b
; 224         ld (hl), a
; 225         ld a, h ; Plane 2
; 226         xor 40h
; 227         ld h, a
; 228         ld a, (hl) ; Copy
; 229 print_m8:
; 230         and 0F0h
; 231         xor b
; 232         ld (hl), a
; 233         ld a, h ; Plane 1
; 234         xor 40h
; 235         ld h, a
; 236         dec h ; Right side
; 237         ld a, (de)
; 238         rra
; 239         rra
; 240         rra
; 241         and 11000000b
; 242         ld b, a
; 243         ld a, (hl)  ; Copy
; 244 print_m9:
; 245         and 03Fh
; 246         xor b
; 247         ld (hl), a
; 248         ld a, h ; Plane 2
; 249         xor 40h
; 250         ld h, a
; 251         ld a, (hl)  ; Copy
; 252 print_m10:
; 253         and 03Fh
; 254         xor b
; 255         ld (hl), a
; 256         ld a, h ; Plane 1
; 257         xor 40h
; 258         ld h, a
; 259         inc h ; Next
; 260         inc de
; 261         dec l
; 262         dec c
; 263         jp nz, print_o2
; 264         pop bc
; 265         ld a, 3
; 266         ret
; 267 
; 268         ; OFFSET 3
; 269 print_o3:
; 270         ld a, (de) ; Read
; 271         and 03Fh
; 272         ld b, a
; 273         ld a, (hl) ; Copy
; 274 print_m11:
; 275         and 0C0h
; 276         xor b
; 277         ld (hl), a
; 278         ld a, h ; Plane 2
; 279         xor 40h
; 280         ld h, a
; 281         ld a, (hl) ; Copy
; 282 print_m12:
; 283         and 0C0h
; 284         xor b
; 285         ld (hl), a
; 286         ld a, h ; Plane 1
; 287         xor 40h
; 288         ld h, a
; 289         inc de ; Next
; 290         dec l
; 291         dec c
; 292         jp nz, print_o3
; 293         pop bc
; 294         xor a
; 295     }
; 296 }
; 297 
; 298 void DrawText1(uint8_t* d, uint8_t st, uint8_t n, const char* text) {
	ld (DrawText1_4_a), hl
; 299     uint8_t insertSpaces = n & 0x80;
	ld a, (DrawText1_3_a)
	and 128
	ld (DrawText1_s + 0), a
; 300     n &= 0x7F;
	ld a, (DrawText1_3_a)
	and 127
	ld (DrawText1_3_a), a
l_180:
; 301     while (n != 0) {
	ld a, (DrawText1_3_a)
	or a
	jp z, l_181
; 302         uint8_t c = *text;
	ld hl, (DrawText1_4_a)
	ld a, (hl)
	ld (DrawText1_s + 1), a
; 303         if (c != 0) {
; REMOVED
	or a
	jp z, l_182
; 304             ++text;
; REMOVED
	inc hl
	ld (DrawText1_4_a), hl
	jp l_183
l_182:
; 305         } else if (!insertSpaces) {
	ld a, (DrawText1_s + 0)
	or a
	ret z
; REMOVED
; REMOVED
l_183:
; 306             return;
; 307         }
; 308         st = DrawChar(st, font_bin + c * 8, d);
	ld a, (DrawText1_2_a)
	ld (DrawChar_1_a), a
	ld hl, (DrawText1_s + 1)
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, font_bin
	add hl, de
	ld (DrawChar_2_a), hl
	ld hl, (DrawText1_1_a)
	call DrawChar
	ld (DrawText1_2_a), a
; 309         if (st != 1) d -= 0x100;
; REMOVED
	cp 1
	jp z, l_186
	ld hl, (DrawText1_1_a)
	ld de, 65280
	add hl, de
	ld (DrawText1_1_a), hl
l_186:
; 310         --n;
	ld a, (DrawText1_3_a)
	dec a
	ld (DrawText1_3_a), a
	jp l_180
l_181:
	ret
DrawHiScoresScreen1:
	; Stack correction reset
; 294  DrawHiScoresScreen1(uint8_t i, uint8_t pos) {
	ld (DrawHiScoresScreen1_2_a), a
; 295     struct HiScore* h = hiScores + i;
	ld hl, (DrawHiScoresScreen1_1_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	ld de, hiScores
	add hl, de
	ld (DrawHiScoresScreen1_s + 0), hl
l_188:
; 296     for (; i < HISCORE_COUNT; ++i) {
	ld a, (DrawHiScoresScreen1_1_a)
	cp 8
	jp nc, l_190
; 297         char text[sizeof(h->name) + UINT16TOSTRING_OUTPUT_SIZE];
; 298         memset(text, ' ', sizeof(h->name) - 1);
	ld hl, DrawHiScoresScreen1_s + 2
	ld (memset_1_a), hl
	ld a, 32
	ld (memset_2_a), a
	ld hl, 9
	call memset
; 299         memcpy(text, h->name, strlen(h->name));
	ld hl, DrawHiScoresScreen1_s + 2
	ld (memcpy_1_a), hl
	ld hl, (DrawHiScoresScreen1_s + 0)
	ld (memcpy_2_a), hl
	ld hl, (DrawHiScoresScreen1_s + 0)
	call strlen
	call memcpy
; 300         Uint16ToString(text + (sizeof(h->name) - 1), h->score);
	ld hl, (DrawHiScoresScreen1_s + 2) + (9)
	ld (Uint16ToString_1_a), hl
	ld hl, (DrawHiScoresScreen1_s + 0)
	ld de, 10
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	call Uint16ToString
; 301         SetTextColor(pos == i ? 1 : 3);
	ld a, (DrawHiScoresScreen1_1_a)
	ld d, a
	ld a, (DrawHiScoresScreen1_2_a)
	cp d
	jp nz, l_191
	ld hl, 1
	jp l_192
l_191:
	ld hl, 3
l_192:
	ld a, l
	call SetTextColor
; 302         DrawText((TEXT_WIDTH - 14) / 2, (HISCORE_Y + 2) + i, 0x7F, text);
	ld a, 25
	ld (DrawText_1_a), a
	ld a, (DrawHiScoresScreen1_1_a)
	add 7
	ld (DrawText_2_a), a
	ld a, 127
	ld (DrawText_3_a), a
	ld hl, DrawHiScoresScreen1_s + 2
	call DrawText
; 303         h++;
	ld hl, (DrawHiScoresScreen1_s + 0)
	ld de, 12
	add hl, de
	ld (DrawHiScoresScreen1_s + 0), hl
l_189:
	ld a, (DrawHiScoresScreen1_1_a)
	inc a
	ld (DrawHiScoresScreen1_1_a), a
	jp l_188
l_190:
	ret
SetBlackPaletteSlowly:
	; Stack correction reset
; 58 0x08);
	ld a, 8
	call SetPaletteInternal
; 59 
; 60     // Задержка
; 61     Delay(5000);
	ld hl, 5000
	call Delay
; 62 
; 63     // Отключение изображения
; 64     SetBlackPalette();
	jp SetBlackPalette
; REMOVED
DrawText:
	; Stack correction reset
; 314  DrawText(uint8_t x, uint8_t y, uint8_t n, const char* text) {
	ld (DrawText_4_a), hl
; 315     DrawText1(DRAWTEXTARGS(x, y), n, text);
	ld hl, (DrawText_1_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	ld de, 2
	call __o_shr_u16
	ld h, l
	ld l, 0
	push hl
	ld hl, (DrawText_2_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	ld de, 65535
	ex hl, de
	call __o_sub_16
	pop de
	call __o_sub_16
	ld (DrawText1_1_a), hl
	ld a, (DrawText_1_a)
	and 3
	ld (DrawText1_2_a), a
; 315 , text);
	ld a, (DrawText_3_a)
	ld (DrawText1_3_a), a
	ld hl, (DrawText_4_a)
	jp DrawText1
; REMOVED
DrawScoreAndCreatures:
	; Stack correction reset
; 334 scoreText, score);
	ld hl, DrawScoreAndCreatures_s + 0
	ld (Uint16ToString_1_a), hl
	ld hl, (score)
	call Uint16ToString
; 335     DrawText1(PIXELCOORDS(40, 7), 2, UINT16TOSTRING_OUTPUT_SIZE, scoreText);
; 1  ((XX)*256))
	ld hl, 55288
	ld (DrawText1_1_a), hl
; 335 , UINT16TOSTRING_OUTPUT_SIZE, scoreText);
	ld a, 2
	ld (DrawText1_2_a), a
	ld a, 5
	ld (DrawText1_3_a), a
	ld hl, DrawScoreAndCreatures_s + 0
	call DrawText1
; 336 
; 337     uint8_t n;
; 338     if (score < hiScores[0].score) {
	ld hl, (((hiScores) + (0)) + (10))
	ex hl, de
	ld hl, (score)
	call __o_sub_16
	jp nc, l_193
; 339         n = score / (hiScores[0].score / (RIGHT_CREATURE_Y_MAX - 1));
	ld hl, (((hiScores) + (0)) + (10))
	ld de, 13
	call __o_div_u16
	ex hl, de
	ld hl, (score)
	call __o_div_u16
	ld a, l
	ld (DrawScoreAndCreatures_s + 6), a
; 340         if (n > RIGHT_CREATURE_Y_MAX - 1) n = RIGHT_CREATURE_Y_MAX - 1;
; REMOVED
	cp 14
	jp c, l_194
	ld a, 13
	ld (DrawScoreAndCreatures_s + 6), a
; REMOVED
	jp l_194
l_193:
; 341     } else {
; 342         n = RIGHT_CREATURE_Y_MAX;
	ld a, 14
	ld (DrawScoreAndCreatures_s + 6), a
l_194:
; 343     }
; 344 
; 345     if (rightCreatureY != n) {
; REMOVED
	ld d, a
	ld a, (rightCreatureY)
	cp d
	jp z, l_197
; 346         rightCreatureY = n;
	ld a, (DrawScoreAndCreatures_s + 6)
	ld (rightCreatureY), a
; 347         uint8_t* s;
; 348         for (s = PIXELCOORDS(40, 168); n; --n, s += 4) DrawImage(s, imgPlayerD, 5 * 0x100 + 4);
; 1  ((XX)*256))
	ld hl, 55127
	ld (DrawScoreAndCreatures_s + 7), hl
l_199:
; 348 ; --n, s += 4) DrawImage(s, imgPlayerD, 5 * 0x100 + 4);
	ld a, (DrawScoreAndCreatures_s + 6)
	or a
	jp z, l_201
	ld hl, (DrawScoreAndCreatures_s + 7)
	ld (DrawImage_1_a), hl
	ld hl, imgPlayerD
	ld (DrawImage_2_a), hl
	ld hl, 1284
	call DrawImage
l_200:
	ld a, (DrawScoreAndCreatures_s + 6)
	dec a
	ld (DrawScoreAndCreatures_s + 6), a
	ld hl, (DrawScoreAndCreatures_s + 7)
	ld de, 4
	add hl, de
	ld (DrawScoreAndCreatures_s + 7), hl
	jp l_199
l_201:
; 349         DrawImage(s + 46, imgPlayer, 5 * 0x100 + 50);
	ld hl, (DrawScoreAndCreatures_s + 7)
	ld de, 46
	add hl, de
	ld (DrawImage_1_a), hl
	ld hl, imgPlayer
	ld (DrawImage_2_a), hl
	ld hl, 1330
	call DrawImage
; 350         if (rightCreatureY == 14) {
	ld a, (rightCreatureY)
	cp 14
	jp nz, l_202
; 351             DrawImage(s + 50 - 0x200, imgPlayerWin, 3 * 0x100 + 16);
	ld hl, (DrawScoreAndCreatures_s + 7)
	ld de, 50
	add hl, de
	ld de, 65024
	add hl, de
	ld (DrawImage_1_a), hl
	ld hl, imgPlayerWin
	ld (DrawImage_2_a), hl
	ld hl, 784
	call DrawImage
; 352             DrawImage(PIXELCOORDS(3, 54), imgKingLose, 6 * 0x100 + 62);
; 1  ((XX)*256))
	ld hl, 64713
	ld (DrawImage_1_a), hl
; 352 , 6 * 0x100 + 62);
	ld hl, imgKingLose
	ld (DrawImage_2_a), hl
	ld hl, 1598
	call DrawImage
l_202:
l_197:
	ret
Uint16ToString:
	; Stack correction reset
	ld (Uint16ToString_2_a), hl
	ld hl, (Uint16ToString_1_a)
	ld (hl), 32
; REMOVED
	inc hl
; REMOVED
; REMOVED
	ld (hl), 32
; REMOVED
	inc hl
; REMOVED
; REMOVED
	ld (hl), 32
; REMOVED
	inc hl
; REMOVED
; REMOVED
	ld (hl), 32
; REMOVED
	inc hl
; REMOVED
; REMOVED
	inc hl
	ld (Uint16ToString_1_a), hl
; REMOVED
	ld (hl), 0
l_204:
	ld hl, (Uint16ToString_2_a)
	ld de, 10
	call __o_div_u16
	ld (Uint16ToString_2_a), hl
	ld hl, (Uint16ToString_1_a)
	dec hl
	ld (Uint16ToString_1_a), hl
	ld a, (__div_16_mod)
	add 48
; REMOVED
	ld (hl), a
l_205:
	ld hl, (Uint16ToString_2_a)
	ld a, h
	or l
	jp nz, l_204
l_206:
	ret
strlen:
	; Stack correction reset
; 20  __fastcall strlen(const char string[]) {
	ld (strlen_1_a), hl
; 21     (void)string;
; REMOVED

        ld de, -1
        xor a
strlen_1:
        cp (hl)
        inc de
        inc hl
        jp nz, strlen_1
        ex hl, de
    
	ret
DrawCell:
	; Stack correction reset
; 112  DrawCell(uint8_t x, uint8_t y, uint8_t color) {
	ld (DrawCell_3_a), a
; 113     DrawCell1(CellAddress(x, y), color);
	ld a, (DrawCell_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawCell_2_a)
	call CellAddress
	ld (DrawCell1_1_a), hl
	ld a, (DrawCell_3_a)
	jp DrawCell1
; REMOVED
DrawCursorXor:
	; Stack correction reset
; 114 }
; 115 
; 116 static uint8_t* removeAnimationImages[3] = {imgBalls + 5 * BALL_IMAGE_SIZEOF, imgBalls + 6 * BALL_IMAGE_SIZEOF,
; 117                                             imgBalls + 7 * BALL_IMAGE_SIZEOF};
; 118 
; 119 void DrawSpriteRemove(uint8_t x, uint8_t y, uint8_t c, uint8_t n) {
; 120     DrawImage(CellAddress(x, y), removeAnimationImages[n] + (BALL_IMAGE_SIZEOF * 10) * (c - 1), BALL_IMAGE_WH);
; 121 }
; 122 
; 123 void DrawSpriteNew1(uint8_t* graphAddress, uint8_t color, uint8_t phase) {
; 124     DrawImage(graphAddress, imgBalls + (BALL_IMAGE_SIZEOF * 10) * (color - 1) + (4 - phase) * BALL_IMAGE_SIZEOF,
; 125               BALL_IMAGE_WH);
; 126 }
; 127 
; 128 void DrawSpriteNew(uint8_t x, uint8_t y, uint8_t color, uint8_t phase) {
; 129     DrawSpriteNew1(CellAddress(x, y), color, phase);
; 130 }
; 131 
; 132 void DrawSpriteStep(uint8_t x, uint8_t y, uint8_t color) {
; 133     DrawImage(CellAddress(x, y), imgBoard + color * BALL_IMAGE_SIZEOF, BALL_IMAGE_WH);
; 134     if (soundEnabled) {
; 135         PLAY_SOUND_TICK
; 136     }
; 137 }
; 138 
; 139 static uint8_t* bouncingAnimation[6] = {imgBalls,
; 140                                         imgBalls,
; 141                                         imgBalls,
; 142                                         imgBalls + BALL_IMAGE_SIZEOF * 8,
; 143                                         imgBalls + BALL_IMAGE_SIZEOF * 9,
; 144                                         imgBalls + BALL_IMAGE_SIZEOF * 8};
; 145 
; 146 void DrawBouncingBall(uint8_t x, uint8_t y, uint8_t color, uint8_t phase) {
; 147     uint8_t* graphAddress = CellAddress(x, y);
; 148     if (phase == 1) {
; 149         graphAddress[0] = 0;
; 150         graphAddress[-0x100] = 0;
; 151         graphAddress++;
; 152     }
; 153     DrawBall1(graphAddress, bouncingAnimation[phase], color);
; 154 }
; 155 
; 156 static uint8_t* helpCoords[NEW_BALL_COUNT] = {
; 157     PIXELCOORDS(20, 3),
; 158     PIXELCOORDS(23, 3),
; 159     PIXELCOORDS(26, 3),
; 160 };
; 161 
; 162 void DrawHelp() {
; 163     uint8_t i;
; 164     for (i = 0; i < NEW_BALL_COUNT; i++) {
; 165         if (showHelp != 0) {
; 166             DrawSpriteNew1(helpCoords[i], newBalls[i], 3 /* Размер шарика */);
; 167         } else {
; 168             DrawEmptyCell1(helpCoords[i]);
; 169         }
; 170     }
; 171 }
; 172 
; 173 // Курсор
; 174 
; 175 static void DrawCursorXor(void* hl) {
	ld (DrawCursorXor_1_a), hl

        ld de, 0x100 - 0x4000
        add hl, de
        ld a, 0x03
        xor (hl)
        ld (hl), a
        dec hl
        ld a, 0x02
        xor (hl)
        ld (hl), a
        dec hl
        ld a, 0x02
        xor (hl)
        ld (hl), a
        ld de, -11
        add hl, de
        ld a, 0x02
        xor (hl)
        ld (hl), a
        dec hl
        ld a, 0x02
        xor (hl)
        ld (hl), a
        dec hl
        ld a, 0x03
        xor (hl)
        ld (hl), a
        ld de, -0x300
        add hl, de
        ld a, 0xC0
        xor (hl)
        ld (hl), a
        inc hl
        ld a, 0x40
        xor (hl)
        ld (hl), a
        inc hl
        ld a, 0x40
        xor (hl)
        ld (hl), a
        ld de, 11
        add hl, de
        ld a, 0x40
        xor (hl)
        ld (hl), a
        inc hl
        ld a, 0x40
        xor (hl)
        ld (hl), a
        inc hl
        ld a, 0xC0
        xor (hl)
        ld (hl), a
    
	ret
CellAddress:
	; Stack correction reset
	ld (CellAddress_2_a), a
; 1  ((XX)*256))
	ld hl, (CellAddress_1_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	ld de, 11
	add hl, de
	ld h, l
	ld l, 0
	push hl
	ld hl, (CellAddress_2_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	ld de, 28
	add hl, de
	ld de, 65535
	ex hl, de
	call __o_sub_16
	pop de
	jp __o_sub_16
; REMOVED
; REMOVED
PathFind:
	; Stack correction reset
; 40  = game[selX][selY];
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld a, (hl)
	ld (path_c), a
; 41     game[selX][selY] = PATH_END_VAL;
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld (hl), 255
; 42     game[cursorX][cursorY] = PATH_START_VAL;
	ld hl, (cursorX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (cursorY)
	ld h, 0
	add hl, de
	ld (hl), 10
; 43 
; 44     // Ищем путь
; 45     for (path_n = PATH_START_VAL; path_n != PATH_START_VAL + GAME_WIDTH * GAME_HEIGHT; ++path_n) {
	ld a, 10
	ld (path_n), a
l_207:
	ld a, (path_n)
	cp 91
	jp z, l_209
; 46         uint8_t* p = &game[0][0];
	ld hl, ((game) + (0)) + (0)
	ld (PathFind_s + 0), hl
; 47         for (path_x = 0; path_x != GAME_WIDTH; ++path_x) {
	xor a
	ld (path_x), a
l_210:
	ld a, (path_x)
	cp 9
	jp z, l_212
; 48             for (path_y = 0; path_y != GAME_HEIGHT; ++path_y, ++p) {
	xor a
	ld (path_y), a
l_213:
	ld a, (path_y)
	cp 9
	jp z, l_215
; 49                 if (*p == path_n) {
	ld a, (path_n)
	ld d, a
	ld hl, (PathFind_s + 0)
	ld a, (hl)
	cp d
	jp nz, l_216
; 50                     if (path_y != 0) {
	ld a, (path_y)
	or a
	jp z, l_218
; 51                         p--;
; REMOVED
	dec hl
	ld (PathFind_s + 0), hl
; 52                         if (*p == PATH_END_VAL) {
; REMOVED
	ld a, (hl)
	cp 255
	jp nz, l_220
; 53                             --path_y;
	ld a, (path_y)
	dec a
	ld (path_y), a
; 54                             return PathFounded(p);
; REMOVED
	jp PathFounded
; REMOVED
; REMOVED
l_220:
; 55                         } else if (*p == PATH_EMPTY_VAL)
; REMOVED
	ld a, (hl)
	or a
	jp nz, l_222
; 56                             *p = path_n + 1;
	ld a, (path_n)
	inc a
; REMOVED
	ld (hl), a
l_222:
; REMOVED
; 57                         p++;
; REMOVED
	inc hl
	ld (PathFind_s + 0), hl
l_218:
; 58                     }
; 59                     if (path_y != GAME_HEIGHT - 1) {
	ld a, (path_y)
	cp 8
	jp z, l_224
; 60                         p++;
; REMOVED
	inc hl
	ld (PathFind_s + 0), hl
; 61                         if (*p == PATH_END_VAL) {
; REMOVED
	ld a, (hl)
	cp 255
	jp nz, l_226
; 62                             ++path_y;
	ld a, (path_y)
	inc a
	ld (path_y), a
; 63                             return PathFounded(p);
; REMOVED
	jp PathFounded
; REMOVED
; REMOVED
l_226:
; 64                         } else if (*p == PATH_EMPTY_VAL)
; REMOVED
	ld a, (hl)
	or a
	jp nz, l_228
; 65                             *p = path_n + 1;
	ld a, (path_n)
	inc a
; REMOVED
	ld (hl), a
l_228:
; REMOVED
; 66                         p--;
; REMOVED
	dec hl
	ld (PathFind_s + 0), hl
l_224:
; 67                     }
; 68                     if (path_x != 0) {
	ld a, (path_x)
	or a
	jp z, l_230
; 69                         p -= GAME_HEIGHT;
; REMOVED
	ld de, 65527
	add hl, de
	ld (PathFind_s + 0), hl
; 70                         if (*p == PATH_END_VAL) {
; REMOVED
	ld a, (hl)
	cp 255
	jp nz, l_232
; 71                             --path_x;
	ld a, (path_x)
	dec a
	ld (path_x), a
; 72                             return PathFounded(p);
; REMOVED
	jp PathFounded
; REMOVED
; REMOVED
l_232:
; 73                         } else if (*p == PATH_EMPTY_VAL)
; REMOVED
	ld a, (hl)
	or a
	jp nz, l_234
; 74                             *p = path_n + 1;
	ld a, (path_n)
	inc a
; REMOVED
	ld (hl), a
l_234:
; REMOVED
; 75                         p += GAME_HEIGHT;
; REMOVED
	ld de, 9
	add hl, de
	ld (PathFind_s + 0), hl
l_230:
; 76                     }
; 77                     if (path_x != GAME_WIDTH - 1) {
	ld a, (path_x)
	cp 8
	jp z, l_236
; 78                         p += GAME_HEIGHT;
; REMOVED
	ld de, 9
	add hl, de
	ld (PathFind_s + 0), hl
; 79                         if (*p == PATH_END_VAL) {
; REMOVED
	ld a, (hl)
	cp 255
	jp nz, l_238
; 80                             ++path_x;
	ld a, (path_x)
	inc a
	ld (path_x), a
; 81                             return PathFounded(p);
; REMOVED
	jp PathFounded
; REMOVED
; REMOVED
l_238:
; 82                         } else if (*p == PATH_EMPTY_VAL)
; REMOVED
	ld a, (hl)
	or a
	jp nz, l_240
; 83                             *p = path_n + 1;
	ld a, (path_n)
	inc a
; REMOVED
	ld (hl), a
l_240:
; REMOVED
; 84                         p -= GAME_HEIGHT;
; REMOVED
	ld de, 65527
	add hl, de
	ld (PathFind_s + 0), hl
l_236:
l_216:
l_214:
	ld a, (path_y)
	inc a
	ld (path_y), a
	ld hl, (PathFind_s + 0)
	inc hl
	ld (PathFind_s + 0), hl
	jp l_213
l_215:
l_211:
	ld a, (path_x)
	inc a
	ld (path_x), a
	jp l_210
l_212:
l_208:
	ld a, (path_n)
	inc a
	ld (path_n), a
	jp l_207
l_209:
; 85                     }
; 86                 }
; 87             }
; 88         }
; 89     }
; 90 
; 91     // Путь не найден
; 92     PathFree();
	call PathFree
; 93     return 0;
	xor a
	ret
; REMOVED
PlaySoundCantMove:
	; Stack correction reset
; 80 2000, 100);
	ld hl, 2000
	ld (PlayTone_1_a), hl
	ld hl, 100
	call PlayTone
; 81     Delay(2000);
	ld hl, 2000
	call Delay
; 82     PlayTone(2000, 100);
	ld hl, 2000
	ld (PlayTone_1_a), hl
	ld hl, 100
	jp PlayTone
; REMOVED
PathGetNextStep:
	; Stack correction reset
; 108 * p = path_p;
	ld hl, (path_p)
	ld (PathGetNextStep_s + 0), hl
; 109     if (path_y != 0) {
	ld a, (path_y)
	or a
	jp z, l_242
; 110         p--;
; REMOVED
	dec hl
	ld (PathGetNextStep_s + 0), hl
; 111         if (*p == path_n) {
	ld a, (path_n)
	ld d, a
; REMOVED
	ld a, (hl)
	cp d
	jp nz, l_244
; 112             --path_y;
	ld a, (path_y)
	dec a
	ld (path_y), a
; 113             --path_n;
	ld a, (path_n)
	dec a
	ld (path_n), a
; 114             path_p = p;
; REMOVED
	ld (path_p), hl
; 115             return 1;
	ld a, 1
	ret
l_244:
; 116         }
; 117         p++;
; REMOVED
	inc hl
	ld (PathGetNextStep_s + 0), hl
l_242:
; 118     }
; 119     if (path_y != GAME_HEIGHT - 1) {
	ld a, (path_y)
	cp 8
	jp z, l_246
; 120         p++;
; REMOVED
	inc hl
	ld (PathGetNextStep_s + 0), hl
; 121         if (*p == path_n) {
	ld a, (path_n)
	ld d, a
; REMOVED
	ld a, (hl)
	cp d
	jp nz, l_248
; 122             ++path_y;
	ld a, (path_y)
	inc a
	ld (path_y), a
; 123             --path_n;
	ld a, (path_n)
	dec a
	ld (path_n), a
; 124             path_p = p;
; REMOVED
	ld (path_p), hl
; 125             return 2;
	ld a, 2
	ret
l_248:
; 126         }
; 127         p--;
; REMOVED
	dec hl
	ld (PathGetNextStep_s + 0), hl
l_246:
; 128     }
; 129     if (path_x != 0) {
	ld a, (path_x)
	or a
	jp z, l_250
; 130         p -= GAME_HEIGHT;
; REMOVED
	ld de, 65527
	add hl, de
	ld (PathGetNextStep_s + 0), hl
; 131         if (*p == path_n) {
	ld a, (path_n)
	ld d, a
; REMOVED
	ld a, (hl)
	cp d
	jp nz, l_252
; 132             --path_x;
	ld a, (path_x)
	dec a
	ld (path_x), a
; 133             --path_n;
	ld a, (path_n)
	dec a
	ld (path_n), a
; 134             path_p = p;
; REMOVED
	ld (path_p), hl
; 135             return 3;
	ld a, 3
	ret
l_252:
; 136         }
; 137         p += GAME_HEIGHT;
; REMOVED
	ld de, 9
	add hl, de
	ld (PathGetNextStep_s + 0), hl
l_250:
; 138     }
; 139     if (path_x != GAME_WIDTH - 1) {
	ld a, (path_x)
	cp 8
	jp z, l_254
; 140         p += GAME_HEIGHT;
; REMOVED
	ld de, 9
	add hl, de
	ld (PathGetNextStep_s + 0), hl
; 141         if (*p == path_n) {
	ld a, (path_n)
	ld d, a
; REMOVED
	ld a, (hl)
	cp d
	jp nz, l_256
; 142             ++path_x;
	ld a, (path_x)
	inc a
	ld (path_x), a
; 143             --path_n;
	ld a, (path_n)
	dec a
	ld (path_n), a
; 144             path_p = p;
; REMOVED
	ld (path_p), hl
; 145             return 4;
	ld a, 4
	ret
l_256:
l_254:
; 146         }
; 147     }
; 148     return 0;
	xor a
	ret
; REMOVED
DrawSpriteStep:
	; Stack correction reset
; 132  DrawSpriteStep(uint8_t x, uint8_t y, uint8_t color) {
	ld (DrawSpriteStep_3_a), a
; 133     DrawImage(CellAddress(x, y), imgBoard + color * BALL_IMAGE_SIZEOF, BALL_IMAGE_WH);
	ld a, (DrawSpriteStep_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawSpriteStep_2_a)
	call CellAddress
	ld (DrawImage_1_a), hl
	ld hl, (DrawSpriteStep_3_a)
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, imgBoard
	add hl, de
	ld (DrawImage_2_a), hl
	ld hl, 528
	call DrawImage
; 134     if (soundEnabled) {
	ld a, (soundEnabled)
	or a
	jp z, l_258
 out (0xB0), a
l_258:
	ret
PathRewind:
	; Stack correction reset
; 99  = path_p1;
	ld hl, (path_p1)
	ld (path_p), hl
; 100     path_x = path_x1;
	ld a, (path_x1)
	ld (path_x), a
; 101     path_y = path_y1;
	ld a, (path_y1)
	ld (path_y), a
; 102     path_n = path_n1;
	ld a, (path_n1)
	ld (path_n), a
	ret
DrawEmptyCell:
	; Stack correction reset
; 99  DrawEmptyCell(uint8_t x, uint8_t y) {
	ld (DrawEmptyCell_2_a), a
; 100     DrawEmptyCell1(CellAddress(x, y));
	ld a, (DrawEmptyCell_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawEmptyCell_2_a)
	call CellAddress
	jp DrawEmptyCell1
; REMOVED
PathFree:
	; Stack correction reset
; 155  = &game[0][0]; p != &game[GAME_WIDTH - 1][GAME_HEIGHT - 1] + 1; ++p)
	ld hl, ((game) + (0)) + (0)
	ld (PathFree_s + 0), hl
l_260:
	ld hl, (PathFree_s + 0)
	ld de, (((game) + (72)) + (8)) + (1)
	call __o_cmp_16
	jp z, l_262
; 156         if (*p >= PATH_START_VAL) *p = PATH_EMPTY_VAL;
	ld hl, (PathFree_s + 0)
	ld a, (hl)
	cp 10
	jp c, l_263
; REMOVED
	ld (hl), 0
l_263:
l_261:
	ld hl, (PathFree_s + 0)
	inc hl
	ld (PathFree_s + 0), hl
	jp l_260
l_262:
; 157     game[selX][selY] = path_c;
	ld a, (path_c)
	ld hl, (selX)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (selY)
	ld h, 0
	add hl, de
	ld (hl), a
	ret
AddToHiScores:
	; Stack correction reset
; 260 [HISCORE_COUNT - 1].score = score;
	ld hl, (score)
	ld (((hiScores) + (84)) + (10)), hl
; 261     hiScores[HISCORE_COUNT - 1].name[0] = 0;
	xor a
	ld ((((hiScores) + (84)) + (0)) + (0)), a
; 262 
; 263     // Вывод таблицы на экран
; 264     DrawHiScores(true);
; 25 ;
	ld a, 1
	call DrawHiScores
; 267  i = 0;
	xor a
	ld (AddToHiScores_s + 0), a
l_265:
; 268     for (;;) {
; 269         char c = ReadKeyboard(false);
; 24 ;
	xor a
	call ReadKeyboard
	ld (AddToHiScores_s + 1), a
; 270  == KEY_ENTER) break;
; REMOVED
	cp 13
	jp z, l_267
; REMOVED
; REMOVED
; 271         if (c == KEY_BACKSPACE || c == KEY_DEL) {
; REMOVED
	cp 8
	jp z, l_272
; REMOVED
	cp 12
	jp nz, l_270
l_272:
; 272             if (i == 0) continue;
	ld a, (AddToHiScores_s + 0)
	or a
	jp z, l_265
; REMOVED
; REMOVED
; 273             --i;
; REMOVED
	dec a
	ld (AddToHiScores_s + 0), a
; 274             hiScores[HISCORE_COUNT - 1].name[i] = 0;
	ld hl, (AddToHiScores_s + 0)
	ld h, 0
	ld de, ((hiScores) + (84)) + (0)
	add hl, de
	ld (hl), 0
; 275             DrawHiScoresLastLine();
	call DrawHiScoresLastLine
	jp l_265
l_270:
; 276             continue;
; 277         }
; 278         if (c < ' ') continue;
; REMOVED
	cp 32
	jp m, l_265
; REMOVED
; REMOVED
; 279         if (i == sizeof(hiScores[HISCORE_COUNT - 1].name) - 1) continue;
	ld a, (AddToHiScores_s + 0)
	cp 9
	jp z, l_265
; REMOVED
; REMOVED
; 280         hiScores[HISCORE_COUNT - 1].name[i] = c;
	ld a, (AddToHiScores_s + 1)
	ld hl, (AddToHiScores_s + 0)
	ld h, 0
	ld de, ((hiScores) + (84)) + (0)
	add hl, de
	ld (hl), a
; 281         ++i;
	ld a, (AddToHiScores_s + 0)
	inc a
	ld (AddToHiScores_s + 0), a
; 282         hiScores[HISCORE_COUNT - 1].name[i] = 0;
	ld hl, (AddToHiScores_s + 0)
	ld h, 0
; REMOVED
	add hl, de
	ld (hl), 0
; 283         DrawHiScoresLastLine();
	call DrawHiScoresLastLine
; REMOVED
	jp l_265
l_267:
; 284     }
; 285 
; 286     // Анимация перемещения новой позиции вверх
; 287     struct HiScore* p = hiScores + HISCORE_COUNT - 1;
	ld hl, ((hiScores) + (96)) - (12)
	ld (AddToHiScores_s + 1), hl
; 288     for (i = HISCORE_COUNT - 1; i != 0; i--) {
	ld a, 7
	ld (AddToHiScores_s + 0), a
l_279:
	ld a, (AddToHiScores_s + 0)
	or a
	jp z, l_281
; 289         if (p->score < p[-1].score) break;
	ld hl, (AddToHiScores_s + 1)
	ld de, 65524
	add hl, de
	ld de, 10
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	push hl
	ld hl, (AddToHiScores_s + 1)
	ld de, 10
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	pop de
	call __o_sub_16
	jp c, l_281
; REMOVED
; REMOVED
; 290         p--;
	ld hl, (AddToHiScores_s + 1)
	ld de, 65524
	add hl, de
	ld (AddToHiScores_s + 1), hl
; 291         struct HiScore tmp;
; 292         memcpy(&tmp, p + 1, sizeof(tmp));
	ld hl, AddToHiScores_s + 3
	ld (memcpy_1_a), hl
	ld hl, (AddToHiScores_s + 1)
	ld de, 12
	add hl, de
	ld (memcpy_2_a), hl
	ld hl, 12
	call memcpy
; 293         memcpy(p + 1, p, sizeof(tmp));
	ld hl, (AddToHiScores_s + 1)
	ld de, 12
	add hl, de
	ld (memcpy_1_a), hl
	ld hl, (AddToHiScores_s + 1)
	ld (memcpy_2_a), hl
	ld hl, 12
	call memcpy
; 294         memcpy(p, &tmp, sizeof(tmp));
	ld hl, (AddToHiScores_s + 1)
	ld (memcpy_1_a), hl
	ld hl, AddToHiScores_s + 3
	ld (memcpy_2_a), hl
	ld hl, 12
	call memcpy
; 295         DrawHiScoresScreen(i - 1);
	ld a, (AddToHiScores_s + 0)
	dec a
	call DrawHiScoresScreen
; 296         Delay(HISCORE_ANIMATION_DELAY);
; 49 ; /* задерка в main */
	ld hl, 2000
	call Delay
l_280:
; 288 ) {
	ld a, (AddToHiScores_s + 0)
	dec a
	ld (AddToHiScores_s + 0), a
	jp l_279
l_281:
	ret
SetPaletteInternal:
	; Stack correction reset
; 23  void SetPaletteInternal(uint8_t mask) {
	ld (SetPaletteInternal_1_a), a

        ld b, a
        ld hl, (currentPalette)
        ld a, (hl)
        or b
        out (090h), a
        inc hl
        ld a, (hl)
        or b
        out (091h), a
        inc hl
        ld a, (hl)
        or b
        out (092h), a
        inc hl
        ld a, (hl)
        or b
        out (093h), a
    
	ret
FindLines:
	; Stack correction reset
; 78  c, n, total = 0;
	xor a
	ld (FindLines_s + 6), a
; 79     uint8_t* p;
; 80 
; 81     for (y = 0; y != GAME_HEIGHT; y++) {
; REMOVED
	ld (FindLines_s + 1), a
l_284:
	ld a, (FindLines_s + 1)
	cp 9
	jp z, l_286
; 82         for (p = &game[0][y], x = 0; x < GAME_WIDTH;) {
	ld hl, (FindLines_s + 1)
	ld h, 0
	ld de, (game) + (0)
	add hl, de
	ld (FindLines_s + 7), hl
	xor a
	ld (FindLines_s + 0), a
l_287:
	ld a, (FindLines_s + 0)
	cp 9
	jp nc, l_289
; 83             prevx = x;
; REMOVED
	ld (FindLines_s + 2), a
; 84             c = *p;
	ld hl, (FindLines_s + 7)
	ld a, (hl)
	ld (FindLines_s + 4), a
; 85             ++x;
	ld a, (FindLines_s + 0)
	inc a
	ld (FindLines_s + 0), a
; 86             p += GAME_WIDTH;
; REMOVED
	ld de, 9
	add hl, de
	ld (FindLines_s + 7), hl
; 87             if (c == 0) continue;
	ld a, (FindLines_s + 4)
	or a
	jp z, l_287
; REMOVED
; REMOVED
l_292:
; 88             while (x != GAME_WIDTH && c == *p) {
	ld a, (FindLines_s + 0)
	cp 9
	jp z, l_293
	ld a, (FindLines_s + 4)
	ld hl, (FindLines_s + 7)
	ld d, (hl)
	cp d
	jp nz, l_293
; 89                 p += GAME_WIDTH;
; REMOVED
	ld de, 9
	add hl, de
	ld (FindLines_s + 7), hl
; 90                 ++x;
	ld a, (FindLines_s + 0)
	inc a
	ld (FindLines_s + 0), a
	jp l_292
l_293:
; 91             }
; 92             n = x - prevx;
	ld a, (FindLines_s + 2)
	ld d, a
	ld a, (FindLines_s + 0)
	sub d
	ld (FindLines_s + 5), a
; 93             if (n < 5) continue;
; REMOVED
	cp 5
	jp c, l_287
; REMOVED
; REMOVED
; 94             ClearLine(prevx, y, 1, 0, n);
	ld a, (FindLines_s + 2)
	ld (ClearLine_1_a), a
	ld a, (FindLines_s + 1)
	ld (ClearLine_2_a), a
	ld a, 1
	ld (ClearLine_3_a), a
	xor a
	ld (ClearLine_4_a), a
	ld a, (FindLines_s + 5)
	call ClearLine
; 95             total += n;
	ld a, (FindLines_s + 5)
	ld d, a
	ld a, (FindLines_s + 6)
	add d
	ld (FindLines_s + 6), a
	jp l_289
; REMOVED
; REMOVED
l_289:
l_285:
	ld a, (FindLines_s + 1)
	inc a
	ld (FindLines_s + 1), a
	jp l_284
l_286:
; 96             break;
; 97         }
; 98     }
; 99     for (x = 0; x != GAME_WIDTH; ++x) {
	xor a
	ld (FindLines_s + 0), a
l_296:
	ld a, (FindLines_s + 0)
	cp 9
	jp z, l_298
; 100         for (p = &game[x][0], y = 0; y < 5;) {
	ld hl, (FindLines_s + 0)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ld (FindLines_s + 7), hl
	xor a
	ld (FindLines_s + 1), a
l_299:
	ld a, (FindLines_s + 1)
	cp 5
	jp nc, l_301
; 101             c = *p;
	ld hl, (FindLines_s + 7)
	ld a, (hl)
	ld (FindLines_s + 4), a
; 102             prevy = y;
	ld a, (FindLines_s + 1)
	ld (FindLines_s + 3), a
; 103             ++y;
	ld a, (FindLines_s + 1)
	inc a
	ld (FindLines_s + 1), a
; 104             ++p;
; REMOVED
	inc hl
	ld (FindLines_s + 7), hl
; 105             if (c == 0) continue;
	ld a, (FindLines_s + 4)
	or a
	jp z, l_299
; REMOVED
; REMOVED
l_304:
; 106             while (y != GAME_HEIGHT && c == *p) {
	ld a, (FindLines_s + 1)
	cp 9
	jp z, l_305
	ld a, (FindLines_s + 4)
	ld hl, (FindLines_s + 7)
	ld d, (hl)
	cp d
	jp nz, l_305
; 107                 ++p;
; REMOVED
	inc hl
	ld (FindLines_s + 7), hl
; 108                 ++y;
	ld a, (FindLines_s + 1)
	inc a
	ld (FindLines_s + 1), a
	jp l_304
l_305:
; 109             }
; 110             n = y - prevy;
	ld a, (FindLines_s + 3)
	ld d, a
	ld a, (FindLines_s + 1)
	sub d
	ld (FindLines_s + 5), a
; 111             if (n < 5) continue;
; REMOVED
	cp 5
	jp c, l_299
; REMOVED
; REMOVED
; 112             ClearLine(x, prevy, 0, 1, n);
	ld a, (FindLines_s + 0)
	ld (ClearLine_1_a), a
	ld a, (FindLines_s + 3)
	ld (ClearLine_2_a), a
	xor a
	ld (ClearLine_3_a), a
	ld a, 1
	ld (ClearLine_4_a), a
	ld a, (FindLines_s + 5)
	call ClearLine
; 113             total += n;
	ld a, (FindLines_s + 5)
	ld d, a
	ld a, (FindLines_s + 6)
	add d
	ld (FindLines_s + 6), a
	jp l_301
; REMOVED
; REMOVED
l_301:
l_297:
	ld a, (FindLines_s + 0)
	inc a
	ld (FindLines_s + 0), a
	jp l_296
l_298:
; 114             break;
; 115         }
; 116     }
; 117     for (y = 0; y != 6; ++y) {
	xor a
	ld (FindLines_s + 1), a
l_308:
	ld a, (FindLines_s + 1)
	cp 6
	jp z, l_310
; 118         for (x = 0; x != 6; ++x) {
	xor a
	ld (FindLines_s + 0), a
l_311:
	ld a, (FindLines_s + 0)
	cp 6
	jp z, l_313
; 119             p = &game[x][y];
	ld hl, (FindLines_s + 0)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (FindLines_s + 1)
	ld h, 0
	add hl, de
	ld (FindLines_s + 7), hl
; 120             c = *p;
; REMOVED
	ld a, (hl)
	ld (FindLines_s + 4), a
; 121             if (c == 0) continue;
; REMOVED
	or a
	jp z, l_312
; REMOVED
; REMOVED
; 122             prevx = x;
	ld a, (FindLines_s + 0)
	ld (FindLines_s + 2), a
; 123             prevy = y;
	ld a, (FindLines_s + 1)
	ld (FindLines_s + 3), a
l_316:
; 124             while (1) {
; 125                 ++prevy;
	ld a, (FindLines_s + 3)
	inc a
	ld (FindLines_s + 3), a
; 126                 ++prevx;
	ld a, (FindLines_s + 2)
	inc a
	ld (FindLines_s + 2), a
; 127                 p += GAME_WIDTH + 1;
	ld hl, (FindLines_s + 7)
	ld de, 10
	add hl, de
	ld (FindLines_s + 7), hl
; 128                 if (prevx == GAME_WIDTH) break;
; REMOVED
	cp 9
	jp z, l_317
; REMOVED
; REMOVED
; 129                 if (prevy == GAME_HEIGHT) break;
	ld a, (FindLines_s + 3)
	cp 9
	jp z, l_317
; REMOVED
; REMOVED
; 130                 if (c != *p) break;
	ld a, (FindLines_s + 4)
; REMOVED
	ld d, (hl)
	cp d
	jp z, l_316
; REMOVED
; REMOVED
; REMOVED
l_317:
; 131             }
; 132             n = prevy - y;
	ld a, (FindLines_s + 1)
	ld d, a
	ld a, (FindLines_s + 3)
	sub d
	ld (FindLines_s + 5), a
; 133             if (n < 5) continue;
; REMOVED
	cp 5
	jp c, l_312
; REMOVED
; REMOVED
; 134             ClearLine(x, y, 1, 1, n);
	ld a, (FindLines_s + 0)
	ld (ClearLine_1_a), a
	ld a, (FindLines_s + 1)
	ld (ClearLine_2_a), a
	ld a, 1
	ld (ClearLine_3_a), a
; REMOVED
	ld (ClearLine_4_a), a
	ld a, (FindLines_s + 5)
	call ClearLine
; 135             total += n;
	ld a, (FindLines_s + 5)
	ld d, a
	ld a, (FindLines_s + 6)
	add d
	ld (FindLines_s + 6), a
l_312:
	ld a, (FindLines_s + 0)
	inc a
	ld (FindLines_s + 0), a
	jp l_311
l_313:
l_309:
	ld a, (FindLines_s + 1)
	inc a
	ld (FindLines_s + 1), a
	jp l_308
l_310:
; 136         }
; 137     }
; 138     for (y = 0; y != 6; ++y) {
	xor a
	ld (FindLines_s + 1), a
l_326:
	ld a, (FindLines_s + 1)
	cp 6
	jp z, l_328
; 139         for (x = 4; x != GAME_WIDTH; ++x) {
	ld a, 4
	ld (FindLines_s + 0), a
l_329:
	ld a, (FindLines_s + 0)
	cp 9
	jp z, l_331
; 140             p = &game[x][y];
	ld hl, (FindLines_s + 0)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (FindLines_s + 1)
	ld h, 0
	add hl, de
	ld (FindLines_s + 7), hl
; 141             c = *p;
; REMOVED
	ld a, (hl)
	ld (FindLines_s + 4), a
; 142             if (c == 0) continue;
; REMOVED
	or a
	jp z, l_330
; REMOVED
; REMOVED
; 143             prevx = x;
	ld a, (FindLines_s + 0)
	ld (FindLines_s + 2), a
; 144             prevy = y;
	ld a, (FindLines_s + 1)
	ld (FindLines_s + 3), a
l_334:
; 145             while (1) {
; 146                 ++prevy;
	ld a, (FindLines_s + 3)
	inc a
	ld (FindLines_s + 3), a
; 147                 --prevx;
	ld a, (FindLines_s + 2)
	dec a
	ld (FindLines_s + 2), a
; 148                 p += 1 - GAME_WIDTH;
	ld hl, (FindLines_s + 7)
	ld de, 65528
	add hl, de
	ld (FindLines_s + 7), hl
; 149                 if (prevx == -1) break;
	ld hl, (FindLines_s + 2)
	ld h, 0
	ld de, 65535
	call __o_cmp_16
	jp z, l_335
; REMOVED
; REMOVED
; 150                 if (prevy == GAME_HEIGHT) break;
	ld a, (FindLines_s + 3)
	cp 9
	jp z, l_335
; REMOVED
; REMOVED
; 151                 if (c != *p) break;
	ld a, (FindLines_s + 4)
	ld hl, (FindLines_s + 7)
	ld d, (hl)
	cp d
	jp z, l_334
; REMOVED
; REMOVED
; REMOVED
l_335:
; 152             }
; 153             n = prevy - y;
	ld a, (FindLines_s + 1)
	ld d, a
	ld a, (FindLines_s + 3)
	sub d
	ld (FindLines_s + 5), a
; 154             if (n < 5) continue;
; REMOVED
	cp 5
	jp c, l_330
; REMOVED
; REMOVED
; 155             ClearLine(x, y, -1, 1, n);
	ld a, (FindLines_s + 0)
	ld (ClearLine_1_a), a
	ld a, (FindLines_s + 1)
	ld (ClearLine_2_a), a
	ld a, 255
	ld (ClearLine_3_a), a
	ld a, 1
	ld (ClearLine_4_a), a
	ld a, (FindLines_s + 5)
	call ClearLine
; 156             total += n;
	ld a, (FindLines_s + 5)
	ld d, a
	ld a, (FindLines_s + 6)
	add d
	ld (FindLines_s + 6), a
l_330:
	ld a, (FindLines_s + 0)
	inc a
	ld (FindLines_s + 0), a
	jp l_329
l_331:
l_327:
	ld a, (FindLines_s + 1)
	inc a
	ld (FindLines_s + 1), a
	jp l_326
l_328:
; 157         }
; 158     }
; 159     if (total == 0) return 0;
	ld a, (FindLines_s + 6)
	or a
	jp nz, l_344
	xor a
	ret
l_344:
; 160 
; 161     // Результат был изменен, перерисуем его
; 162     score += total * 2;
	ld hl, (FindLines_s + 6)
	ld h, 0
	add hl, hl
	ex hl, de
	ld hl, (score)
	add hl, de
	ld (score), hl
; 163     // TODO Overflow
; 164     DrawScoreAndCreatures();
	call DrawScoreAndCreatures
; 165     return 1;
	ld a, 1
	ret
; REMOVED
CalcFreeCellCount:
	; Stack correction reset
; 166 }
; 167 
; 168 // Посчитать кол-во свободных клеток
; 169 
; 170 static uint8_t CalcFreeCellCount() {
; 171     uint8_t* cell = &game[0][0];
	ld hl, ((game) + (0)) + (0)
	ld (CalcFreeCellCount_s + 0), hl
; 172     uint8_t freeCellCount = 0;
	xor a
	ld (CalcFreeCellCount_s + 2), a
; 173     uint8_t i;
; 174     for (i = GAME_WIDTH * GAME_HEIGHT; i != 0; --i) {
	ld a, 81
	ld (CalcFreeCellCount_s + 3), a
l_346:
	ld a, (CalcFreeCellCount_s + 3)
	or a
	jp z, l_348
; 175         if (*cell == 0) freeCellCount++;
	ld hl, (CalcFreeCellCount_s + 0)
	ld a, (hl)
	or a
	jp nz, l_349
	ld a, (CalcFreeCellCount_s + 2)
	inc a
	ld (CalcFreeCellCount_s + 2), a
l_349:
; 176         cell++;
; REMOVED
	inc hl
	ld (CalcFreeCellCount_s + 0), hl
l_347:
	ld a, (CalcFreeCellCount_s + 3)
	dec a
	ld (CalcFreeCellCount_s + 3), a
	jp l_346
l_348:
; 177     }
; 178     return freeCellCount;
	ld a, (CalcFreeCellCount_s + 2)
	ret
; REMOVED
DrawSpriteNew:
	; Stack correction reset
; 128  DrawSpriteNew(uint8_t x, uint8_t y, uint8_t color, uint8_t phase) {
	ld (DrawSpriteNew_4_a), a
; 129     DrawSpriteNew1(CellAddress(x, y), color, phase);
	ld a, (DrawSpriteNew_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawSpriteNew_2_a)
	call CellAddress
	ld (DrawSpriteNew1_1_a), hl
	ld a, (DrawSpriteNew_3_a)
	ld (DrawSpriteNew1_2_a), a
	ld a, (DrawSpriteNew_4_a)
	jp DrawSpriteNew1
; REMOVED
DrawBall1:
	; Stack correction reset
	ld (DrawBall1_3_a), a
	ld hl, (DrawBall1_1_a)
	ld (DrawImage_1_a), hl
	ld hl, (DrawBall1_3_a)
	ld h, 0
	dec hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ex hl, de
	ld hl, (DrawBall1_2_a)
	add hl, de
	ld (DrawImage_2_a), hl
	ld hl, 528
	jp DrawImage
; REMOVED
DrawImage:
	; Stack correction reset
; 20  DrawImage(uint8_t* destination, uint8_t* source, uint16_t width_height) {
	ld (DrawImage_3_a), hl

        push bc
        ld b, h
        ld c, l
        push bc
        ld hl, (DrawImage_1_a)
        push hl
        ex hl, de
        ld hl, (DrawImage_2_a)
DrawImage_l1:
        push de
        push bc
DrawImage_l2:
        ld a, (hl)
        inc hl
        ld (de), a
        dec de
        dec c
        jp nz, DrawImage_l2
        pop bc
        pop de
        dec d
        dec b
        jp nz, DrawImage_l1
        pop de
        ld a, d ; Plane 2
        sub 40h
        ld d, a
        pop bc
DrawImage_l3:
        push de
        push bc
DrawImage_l4:
        ld a, (hl)
        inc hl
        ld (de), a
        dec de
        dec c
        jp nz, DrawImage_l4
        pop bc
        pop de
        dec d
        dec b
        jp nz, DrawImage_l3
        pop bc
    
	ret
FillRectInternal:
	; Stack correction reset
; 44  void __fastcall FillRectInternal(uint8_t height, uint8_t mask, uint8_t* graphAddress) {
	ld (FillRectInternal_3_a), hl

        push hl
        ld a, (FillRectInternal_2_a)
FillRectCmd0:
        nop  // CMA = 2F, NOP = 00
        ld d, a
        ld a, (FillRectInternal_1_a)
        ld e, a
FillRectInternal_0:
        ld a, (hl)
FillRectCmd1:
        or d  // XRA D = AA, ANA D = A2, ORA D = B2
        ld (hl), a
        dec l
        dec e
        jp nz, FillRectInternal_0
        pop hl

        ld a, h
        sub 40h
        ld h, a

        ld a, (FillRectInternal_2_a)
FillRectCmd2:
        nop  // CMA = 2F, NOP = 00
        ld d, a

        ld a, (FillRectInternal_1_a)
        ld e, a
FillRectInternal_1:
        ld a, (hl)
FillRectCmd3:
        or d  // XRA D = AA, ANA D = A2, ORA D = B2
        ld (hl), a
        dec l
        dec e
        jp nz, FillRectInternal_1
    
	ret
SetTextColorInternal:
	; Stack correction reset
; 23  void SetTextColorInternal(uint8_t plane, uint8_t text, uint8_t background) {
	ld (SetTextColorInternal_3_a), a

        ; Background color
        or a
        jp nz, PrintColor_2
            ld hl, 003E6h  // E6 = AND
            push hl
            ld h, 0FCh
            push hl
            ld h, 00Fh
            push hl
            ld h, 0F0h
            push hl
            ld h, 03Fh
            push hl
            ld h, 0C0h
            ld bc, 000A8h  // NOP + XOR B
            jp PrintColor_3
PrintColor_2:
            ld hl, 0FCF6h  // F6 = OR
            push hl
            ld h, 003h
            push hl
            ld h, 0F0h
            push hl
            ld h, 00Fh
            push hl
            ld h, 0C0h
            push hl
            ld h, 03Fh
            ld bc, 0A800h  // NOP + XOR B
PrintColor_3:
        ; Text color
        ld a, (SetTextColorInternal_2_a)
        or a
        jp z, PrintColor_4
            ld b, c
PrintColor_4:
        ld a, (SetTextColorInternal_1_a)
        or a
        ld a, b
        jp nz, PrintColor_5
            ld (print_m1 + 2), a
            ld (print_m3 + 2), a
            ld (print_m5 + 2), a
            ld (print_m7 + 2), a
            ld (print_m9 + 2), a
            ld (print_m11 + 2), a
            ld (print_m11), hl
            pop hl
            ld (print_m9), hl
            pop hl
            ld (print_m7), hl
            pop hl
            ld (print_m5), hl
            pop hl
            ld (print_m3), hl
            pop hl
            ld (print_m1), hl
            jp PrintColor_6
PrintColor_5:
            ld (print_m2 + 2), a
            ld (print_m4 + 2), a
            ld (print_m6 + 2), a
            ld (print_m8 + 2), a
            ld (print_m10 + 2), a
            ld (print_m12 + 2), a
            ld (print_m12), hl
            pop hl
            ld (print_m10), hl
            pop hl
            ld (print_m8), hl
            pop hl
            ld (print_m6), hl
            pop hl
            ld (print_m4), hl
            pop hl
            ld (print_m2), hl
PrintColor_6:
    
	ret
DrawChar:
	; Stack correction reset
; 24     asm {
; 25         ; Background color
; 26         or a
; 27         jp nz, PrintColor_2
; 28             ld hl, 003E6h  // E6 = AND
; 29             push hl
; 30             ld h, 0FCh
; 31             push hl
; 32             ld h, 00Fh
; 33             push hl
; 34             ld h, 0F0h
; 35             push hl
; 36             ld h, 03Fh
; 37             push hl
; 38             ld h, 0C0h
; 39             ld bc, 000A8h  // NOP + XOR B
; 40             jp PrintColor_3
; 41 PrintColor_2:
; 42             ld hl, 0FCF6h  // F6 = OR
; 43             push hl
; 44             ld h, 003h
; 45             push hl
; 46             ld h, 0F0h
; 47             push hl
; 48             ld h, 00Fh
; 49             push hl
; 50             ld h, 0C0h
; 51             push hl
; 52             ld h, 03Fh
; 53             ld bc, 0A800h  // NOP + XOR B
; 54 PrintColor_3:
; 55         ; Text color
; 56         ld a, (SetTextColorInternal_2_a)
; 57         or a
; 58         jp z, PrintColor_4
; 59             ld b, c
; 60 PrintColor_4:
; 61         ld a, (SetTextColorInternal_1_a)
; 62         or a
; 63         ld a, b
; 64         jp nz, PrintColor_5
; 65             ld (print_m1 + 2), a
; 66             ld (print_m3 + 2), a
; 67             ld (print_m5 + 2), a
; 68             ld (print_m7 + 2), a
; 69             ld (print_m9 + 2), a
; 70             ld (print_m11 + 2), a
; 71             ld (print_m11), hl
; 72             pop hl
; 73             ld (print_m9), hl
; 74             pop hl
; 75             ld (print_m7), hl
; 76             pop hl
; 77             ld (print_m5), hl
; 78             pop hl
; 79             ld (print_m3), hl
; 80             pop hl
; 81             ld (print_m1), hl
; 82             jp PrintColor_6
; 83 PrintColor_5:
; 84             ld (print_m2 + 2), a
; 85             ld (print_m4 + 2), a
; 86             ld (print_m6 + 2), a
; 87             ld (print_m8 + 2), a
; 88             ld (print_m10 + 2), a
; 89             ld (print_m12 + 2), a
; 90             ld (print_m12), hl
; 91             pop hl
; 92             ld (print_m10), hl
; 93             pop hl
; 94             ld (print_m8), hl
; 95             pop hl
; 96             ld (print_m6), hl
; 97             pop hl
; 98             ld (print_m4), hl
; 99             pop hl
; 100             ld (print_m2), hl
; 101 PrintColor_6:
; 102     }
; 103 }
; 104 
; 105 void SetTextColor(uint8_t color) {
; 106     if (textColor == color) return;
; 107     textColor = color;
; 108     SetTextColorInternal(0, color & 1, color & 4);
; 109     SetTextColorInternal(1, color & 2, color & 8);
; 110 }
; 111 
; 112 static uint8_t DrawChar(uint8_t offset, const uint8_t* source, uint8_t* destination) {
	ld (DrawChar_3_a), hl

        push bc
        ex de, hl
        ld hl, (DrawChar_2_a)
        ex de, hl
        ld c, 8
        ld a, (DrawChar_1_a)
        dec a
        jp z, print_o1
        dec a
        jp z, print_o2
        dec a
        jp z, print_o3

        ; OFFSET 0
print_o0:
        ld a, (de) ; Read
        add a
        add a
        ld b, a
        ld a, (hl) ; Copy
print_m1:
        and 3
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl) ; Copy
print_m2:
        and 3
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        inc de ; Next
        dec l
        dec c
        jp nz, print_o0
        pop bc
        ld a, 1
        ret

        ; OFFSET 1
print_o1:
        ld a, (de) ; Read
        add a
        adc a
        adc a
        adc a
        push af ; Left side
        adc a
        and 00000011b
        ld b, a
        ld a, (hl) ; Copy
print_m3:
        and 0FCh
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl) ; Copy
print_m4:
        and 0FCh
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        pop af ; Right side
        dec h
        and 011110000b
        ld b, a
        ld a, (hl) ; Copy
print_m5:
        and 00Fh
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl) ; Copy
print_m6:
        and 00Fh
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        inc h ; Next
        inc de
        dec l
        dec c
        jp nz, print_o1
        pop bc
        ld a, 2
        ret

        ; OFFSET 2
print_o2:
        ld a, (de) ; Read
        rra
        rra
        and 00001111b
        ld b, a
        ld a, (hl) ; Copy
print_m7:
        and 0F0h
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl) ; Copy
print_m8:
        and 0F0h
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        dec h ; Right side
        ld a, (de)
        rra
        rra
        rra
        and 11000000b
        ld b, a
        ld a, (hl)  ; Copy
print_m9:
        and 03Fh
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl)  ; Copy
print_m10:
        and 03Fh
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        inc h ; Next
        inc de
        dec l
        dec c
        jp nz, print_o2
        pop bc
        ld a, 3
        ret

        ; OFFSET 3
print_o3:
        ld a, (de) ; Read
        and 03Fh
        ld b, a
        ld a, (hl) ; Copy
print_m11:
        and 0C0h
        xor b
        ld (hl), a
        ld a, h ; Plane 2
        xor 40h
        ld h, a
        ld a, (hl) ; Copy
print_m12:
        and 0C0h
        xor b
        ld (hl), a
        ld a, h ; Plane 1
        xor 40h
        ld h, a
        inc de ; Next
        dec l
        dec c
        jp nz, print_o3
        pop bc
        xor a
    
	ret
DrawCell1:
	; Stack correction reset
; 103  DrawCell1(uint8_t* graphAddr, uint8_t color) {
	ld (DrawCell1_2_a), a
; 104     uint8_t* image;
; 105     if (color == 0)
; REMOVED
	or a
	jp nz, l_351
; 106         image = imgBoard + BALL_IMAGE_SIZEOF * 4;
	ld hl, (imgBoard) + (256)
	ld (DrawCell1_s + 0), hl
	jp l_352
l_351:
; 107     else
; 108         image = imgBalls + (BALL_IMAGE_SIZEOF * 10) * (color - 1);
	ld hl, (DrawCell1_2_a)
	ld h, 0
	dec hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, imgBalls
	add hl, de
	ld (DrawCell1_s + 0), hl
l_352:
; 109     DrawImage(graphAddr, image, BALL_IMAGE_WH);
	ld hl, (DrawCell1_1_a)
	ld (DrawImage_1_a), hl
	ld hl, (DrawCell1_s + 0)
	ld (DrawImage_2_a), hl
	ld hl, 528
	jp DrawImage
; REMOVED
PathFounded:
	; Stack correction reset
; 29  uint8_t PathFounded(uint8_t* p) {
	ld (PathFounded_1_a), hl
; 30     path_p1 = path_p = p;
; REMOVED
	ld (path_p), hl
	ld (path_p1), hl
; 31     path_x1 = path_x;
	ld a, (path_x)
	ld (path_x1), a
; 32     path_y1 = path_y;
	ld a, (path_y)
	ld (path_y1), a
; 33     path_n1 = path_n;
	ld a, (path_n)
	ld (path_n1), a
; 34     return 1;
	ld a, 1
	ret
; REMOVED
DrawHiScoresLastLine:
	; Stack correction reset
; 327 HISCORE_COUNT - 1, HISCORE_COUNT - 1);
	ld a, 7
	ld (DrawHiScoresScreen1_1_a), a
; REMOVED
	jp DrawHiScoresScreen1
; REMOVED
DrawHiScoresScreen:
	; Stack correction reset
	ld (DrawHiScoresScreen_1_a), a
	xor a
	ld (DrawHiScoresScreen1_1_a), a
	ld a, (DrawHiScoresScreen_1_a)
	jp DrawHiScoresScreen1
; REMOVED
ClearLine:
	; Stack correction reset
; 46  void ClearLine(uint8_t x0, uint8_t y0, uint8_t dx, uint8_t dy, uint8_t length) {
	ld (ClearLine_5_a), a
; 47     register uint8_t x, y, o, i;
; 48 
; 49     // Анимация исчезновения шариков
; 50     uint8_t color = game[x0][y0];  // TODO: const вызывает сбой
	ld hl, (ClearLine_1_a)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (ClearLine_2_a)
	ld h, 0
	add hl, de
	ld a, (hl)
	ld (ClearLine_s + 4), a
; 51     for (o = 0; o < REMOVE_ANIMATION_COUNT; o++) {
	xor a
	ld (ClearLine_s + 2), a
l_353:
	ld a, (ClearLine_s + 2)
	cp 3
	jp nc, l_355
; 52         x = x0;
	ld a, (ClearLine_1_a)
	ld (ClearLine_s + 0), a
; 53         y = y0;
	ld a, (ClearLine_2_a)
	ld (ClearLine_s + 1), a
; 54         for (i = length; i != 0; --i) {
	ld a, (ClearLine_5_a)
	ld (ClearLine_s + 3), a
l_356:
	ld a, (ClearLine_s + 3)
	or a
	jp z, l_358
; 55             DrawSpriteRemove(x, y, color, o);
	ld a, (ClearLine_s + 0)
	ld (DrawSpriteRemove_1_a), a
	ld a, (ClearLine_s + 1)
	ld (DrawSpriteRemove_2_a), a
	ld a, (ClearLine_s + 4)
	ld (DrawSpriteRemove_3_a), a
	ld a, (ClearLine_s + 2)
	call DrawSpriteRemove
; 56             x += dx;
	ld a, (ClearLine_3_a)
	ld d, a
	ld a, (ClearLine_s + 0)
	add d
	ld (ClearLine_s + 0), a
; 57             y += dy;
	ld a, (ClearLine_4_a)
	ld d, a
	ld a, (ClearLine_s + 1)
	add d
	ld (ClearLine_s + 1), a
l_357:
	ld a, (ClearLine_s + 3)
	dec a
	ld (ClearLine_s + 3), a
	jp l_356
l_358:
; 58         }
; 59         Delay(REMOVE_ANIMATION_DELAY);
; 28 ; /* задерка в main */
	ld hl, 2000
	call Delay
l_354:
; 51 ) {
	ld a, (ClearLine_s + 2)
	inc a
	ld (ClearLine_s + 2), a
	jp l_353
l_355:
; 52         x = x0;
; 53         y = y0;
; 54         for (i = length; i != 0; --i) {
; 55             DrawSpriteRemove(x, y, color, o);
; 56             x += dx;
; 57             y += dy;
; 58         }
; 59         Delay(REMOVE_ANIMATION_DELAY);
; 60     }
; 61 
; 62     // Очищаем экран и массив
; 63     x = x0;
	ld a, (ClearLine_1_a)
	ld (ClearLine_s + 0), a
; 64     y = y0;
	ld a, (ClearLine_2_a)
	ld (ClearLine_s + 1), a
; 65     for (i = length; i != 0; --i) {
	ld a, (ClearLine_5_a)
	ld (ClearLine_s + 3), a
l_359:
	ld a, (ClearLine_s + 3)
	or a
	jp z, l_361
; 66         game[x][y] = 0;
	ld hl, (ClearLine_s + 0)
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	ld de, game
	add hl, de
	ex hl, de
	ld hl, (ClearLine_s + 1)
	ld h, 0
	add hl, de
	ld (hl), 0
; 67         DrawEmptyCell(x, y);
	ld a, (ClearLine_s + 0)
	ld (DrawEmptyCell_1_a), a
	ld a, (ClearLine_s + 1)
	call DrawEmptyCell
; 68         x += dx;
	ld a, (ClearLine_3_a)
	ld d, a
	ld a, (ClearLine_s + 0)
	add d
	ld (ClearLine_s + 0), a
; 69         y += dy;
	ld a, (ClearLine_4_a)
	ld d, a
	ld a, (ClearLine_s + 1)
	add d
	ld (ClearLine_s + 1), a
l_360:
	ld a, (ClearLine_s + 3)
	dec a
	ld (ClearLine_s + 3), a
	jp l_359
l_361:
	ret
DrawSpriteRemove:
	; Stack correction reset
; 119  DrawSpriteRemove(uint8_t x, uint8_t y, uint8_t c, uint8_t n) {
	ld (DrawSpriteRemove_4_a), a
; 120     DrawImage(CellAddress(x, y), removeAnimationImages[n] + (BALL_IMAGE_SIZEOF * 10) * (c - 1), BALL_IMAGE_WH);
	ld a, (DrawSpriteRemove_1_a)
	ld (CellAddress_1_a), a
	ld a, (DrawSpriteRemove_2_a)
	call CellAddress
	ld (DrawImage_1_a), hl
	ld hl, (DrawSpriteRemove_3_a)
	ld h, 0
	dec hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	push hl
	ld hl, (DrawSpriteRemove_4_a)
	ld h, 0
	add hl, hl
	ld de, removeAnimationImages
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex hl, de
	pop de
	add hl, de
	ld (DrawImage_2_a), hl
	ld hl, 528
	jp DrawImage
; REMOVED
font_bin:
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 30
	db 33
	db 51
	db 33
	db 45
	db 33
	db 30
	db 0
	db 30
	db 63
	db 45
	db 63
	db 51
	db 63
	db 30
	db 0
	db 0
	db 0
	db 10
	db 31
	db 31
	db 14
	db 4
	db 0
	db 0
	db 0
	db 4
	db 14
	db 31
	db 14
	db 4
	db 0
	db 0
	db 0
	db 4
	db 14
	db 31
	db 4
	db 14
	db 0
	db 0
	db 0
	db 4
	db 14
	db 31
	db 14
	db 31
	db 0
	db 0
	db 12
	db 30
	db 30
	db 12
	db 0
	db 0
	db 63
	db 63
	db 51
	db 33
	db 33
	db 51
	db 63
	db 63
	db 0
	db 0
	db 12
	db 18
	db 18
	db 12
	db 0
	db 0
	db 63
	db 63
	db 51
	db 45
	db 45
	db 51
	db 63
	db 63
	db 0
	db 0
	db 7
	db 3
	db 29
	db 36
	db 36
	db 24
	db 0
	db 14
	db 17
	db 17
	db 14
	db 4
	db 31
	db 4
	db 0
	db 30
	db 18
	db 30
	db 16
	db 16
	db 48
	db 48
	db 0
	db 31
	db 17
	db 31
	db 17
	db 17
	db 51
	db 51
	db 12
	db 45
	db 12
	db 51
	db 51
	db 12
	db 45
	db 12
	db 0
	db 48
	db 60
	db 63
	db 63
	db 60
	db 48
	db 0
	db 0
	db 3
	db 15
	db 63
	db 63
	db 15
	db 3
	db 0
	db 4
	db 14
	db 31
	db 4
	db 31
	db 14
	db 4
	db 0
	db 10
	db 10
	db 10
	db 10
	db 10
	db 0
	db 10
	db 0
	db 0
	db 31
	db 41
	db 25
	db 9
	db 9
	db 9
	db 0
	db 14
	db 16
	db 12
	db 18
	db 18
	db 12
	db 2
	db 28
	db 0
	db 0
	db 0
	db 0
	db 0
	db 31
	db 31
	db 0
	db 4
	db 14
	db 31
	db 4
	db 31
	db 14
	db 4
	db 31
	db 4
	db 14
	db 31
	db 4
	db 4
	db 4
	db 4
	db 0
	db 4
	db 4
	db 4
	db 4
	db 31
	db 14
	db 4
	db 0
	db 0
	db 4
	db 2
	db 31
	db 2
	db 4
	db 0
	db 0
	db 0
	db 4
	db 8
	db 31
	db 8
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 16
	db 31
	db 0
	db 0
	db 18
	db 51
	db 63
	db 63
	db 51
	db 18
	db 0
	db 0
	db 12
	db 30
	db 63
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 63
	db 63
	db 30
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 4
	db 4
	db 4
	db 4
	db 0
	db 4
	db 0
	db 10
	db 10
	db 10
	db 0
	db 0
	db 0
	db 0
	db 0
	db 10
	db 10
	db 31
	db 10
	db 31
	db 10
	db 10
	db 0
	db 4
	db 15
	db 20
	db 14
	db 5
	db 30
	db 4
	db 0
	db 24
	db 25
	db 2
	db 4
	db 8
	db 19
	db 3
	db 0
	db 4
	db 10
	db 10
	db 12
	db 21
	db 18
	db 13
	db 0
	db 6
	db 6
	db 2
	db 4
	db 0
	db 0
	db 0
	db 0
	db 2
	db 4
	db 8
	db 8
	db 8
	db 4
	db 2
	db 0
	db 8
	db 4
	db 2
	db 2
	db 2
	db 4
	db 8
	db 0
	db 0
	db 4
	db 21
	db 14
	db 21
	db 4
	db 0
	db 0
	db 0
	db 4
	db 4
	db 31
	db 4
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 12
	db 4
	db 8
	db 0
	db 0
	db 0
	db 31
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 12
	db 12
	db 0
	db 0
	db 1
	db 2
	db 4
	db 8
	db 16
	db 0
	db 0
	db 14
	db 17
	db 19
	db 21
	db 25
	db 17
	db 14
	db 0
	db 4
	db 12
	db 4
	db 4
	db 4
	db 4
	db 14
	db 0
	db 14
	db 17
	db 1
	db 6
	db 8
	db 16
	db 31
	db 0
	db 31
	db 1
	db 2
	db 6
	db 1
	db 17
	db 14
	db 0
	db 2
	db 6
	db 10
	db 18
	db 31
	db 2
	db 2
	db 0
	db 31
	db 16
	db 30
	db 1
	db 1
	db 17
	db 14
	db 0
	db 14
	db 16
	db 16
	db 30
	db 17
	db 17
	db 14
	db 0
	db 31
	db 1
	db 2
	db 4
	db 8
	db 8
	db 8
	db 0
	db 14
	db 17
	db 17
	db 14
	db 17
	db 17
	db 14
	db 0
	db 14
	db 17
	db 17
	db 15
	db 1
	db 1
	db 14
	db 0
	db 0
	db 12
	db 12
	db 0
	db 0
	db 12
	db 12
	db 0
	db 0
	db 12
	db 12
	db 0
	db 0
	db 12
	db 4
	db 8
	db 2
	db 4
	db 8
	db 16
	db 8
	db 4
	db 2
	db 0
	db 0
	db 0
	db 31
	db 0
	db 31
	db 0
	db 0
	db 0
	db 8
	db 4
	db 2
	db 1
	db 2
	db 4
	db 8
	db 0
	db 14
	db 17
	db 1
	db 2
	db 4
	db 0
	db 4
	db 0
	db 14
	db 17
	db 19
	db 21
	db 23
	db 16
	db 14
	db 0
	db 14
	db 17
	db 17
	db 17
	db 31
	db 17
	db 17
	db 0
	db 30
	db 17
	db 17
	db 30
	db 17
	db 17
	db 30
	db 0
	db 14
	db 17
	db 16
	db 16
	db 16
	db 17
	db 14
	db 0
	db 30
	db 9
	db 9
	db 9
	db 9
	db 9
	db 30
	db 0
	db 31
	db 16
	db 16
	db 30
	db 16
	db 16
	db 31
	db 0
	db 31
	db 16
	db 16
	db 30
	db 16
	db 16
	db 16
	db 0
	db 14
	db 17
	db 16
	db 16
	db 19
	db 17
	db 15
	db 0
	db 17
	db 17
	db 17
	db 31
	db 17
	db 17
	db 17
	db 0
	db 14
	db 4
	db 4
	db 4
	db 4
	db 4
	db 14
	db 0
	db 1
	db 1
	db 1
	db 1
	db 17
	db 17
	db 14
	db 0
	db 17
	db 18
	db 20
	db 24
	db 20
	db 18
	db 17
	db 0
	db 16
	db 16
	db 16
	db 16
	db 16
	db 16
	db 31
	db 0
	db 17
	db 27
	db 21
	db 21
	db 17
	db 17
	db 17
	db 0
	db 17
	db 17
	db 25
	db 21
	db 19
	db 17
	db 17
	db 0
	db 14
	db 17
	db 17
	db 17
	db 17
	db 17
	db 14
	db 0
	db 30
	db 17
	db 17
	db 30
	db 16
	db 16
	db 16
	db 0
	db 14
	db 17
	db 17
	db 17
	db 21
	db 18
	db 13
	db 0
	db 30
	db 17
	db 17
	db 30
	db 20
	db 18
	db 17
	db 0
	db 14
	db 17
	db 16
	db 14
	db 1
	db 17
	db 14
	db 0
	db 31
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 0
	db 17
	db 17
	db 17
	db 17
	db 17
	db 17
	db 14
	db 0
	db 17
	db 17
	db 17
	db 10
	db 10
	db 4
	db 4
	db 0
	db 17
	db 17
	db 17
	db 21
	db 21
	db 21
	db 10
	db 0
	db 17
	db 17
	db 10
	db 4
	db 10
	db 17
	db 17
	db 0
	db 17
	db 17
	db 10
	db 4
	db 4
	db 4
	db 4
	db 0
	db 31
	db 1
	db 2
	db 4
	db 8
	db 16
	db 31
	db 0
	db 14
	db 8
	db 8
	db 8
	db 8
	db 8
	db 14
	db 0
	db 0
	db 16
	db 8
	db 4
	db 2
	db 1
	db 0
	db 0
	db 14
	db 2
	db 2
	db 2
	db 2
	db 2
	db 14
	db 0
	db 4
	db 10
	db 17
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 31
	db 24
	db 24
	db 16
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 14
	db 1
	db 15
	db 17
	db 15
	db 0
	db 0
	db 16
	db 30
	db 17
	db 17
	db 17
	db 30
	db 0
	db 0
	db 0
	db 15
	db 16
	db 16
	db 16
	db 15
	db 0
	db 1
	db 1
	db 15
	db 17
	db 17
	db 17
	db 15
	db 0
	db 0
	db 0
	db 14
	db 17
	db 31
	db 16
	db 15
	db 0
	db 0
	db 6
	db 9
	db 8
	db 28
	db 8
	db 8
	db 0
	db 0
	db 0
	db 15
	db 17
	db 17
	db 15
	db 1
	db 14
	db 16
	db 16
	db 30
	db 17
	db 17
	db 17
	db 17
	db 0
	db 4
	db 0
	db 4
	db 4
	db 4
	db 4
	db 4
	db 0
	db 1
	db 0
	db 1
	db 1
	db 1
	db 17
	db 14
	db 0
	db 16
	db 16
	db 17
	db 18
	db 28
	db 18
	db 17
	db 0
	db 12
	db 4
	db 4
	db 4
	db 4
	db 4
	db 14
	db 0
	db 0
	db 0
	db 26
	db 21
	db 21
	db 21
	db 21
	db 0
	db 0
	db 0
	db 30
	db 17
	db 17
	db 17
	db 17
	db 0
	db 0
	db 0
	db 14
	db 17
	db 17
	db 17
	db 14
	db 0
	db 0
	db 0
	db 30
	db 17
	db 17
	db 17
	db 30
	db 16
	db 0
	db 0
	db 15
	db 17
	db 17
	db 17
	db 15
	db 1
	db 0
	db 0
	db 23
	db 24
	db 16
	db 16
	db 16
	db 0
	db 0
	db 0
	db 15
	db 16
	db 14
	db 1
	db 30
	db 0
	db 16
	db 16
	db 60
	db 16
	db 16
	db 17
	db 14
	db 0
	db 0
	db 0
	db 17
	db 17
	db 17
	db 17
	db 15
	db 0
	db 0
	db 0
	db 17
	db 17
	db 17
	db 10
	db 4
	db 0
	db 0
	db 0
	db 17
	db 21
	db 21
	db 21
	db 10
	db 0
	db 0
	db 0
	db 17
	db 10
	db 4
	db 10
	db 17
	db 0
	db 0
	db 0
	db 17
	db 17
	db 15
	db 1
	db 30
	db 0
	db 0
	db 0
	db 31
	db 2
	db 4
	db 8
	db 31
	db 0
	db 3
	db 4
	db 4
	db 8
	db 4
	db 4
	db 3
	db 0
	db 4
	db 4
	db 4
	db 0
	db 4
	db 4
	db 4
	db 0
	db 24
	db 4
	db 4
	db 2
	db 4
	db 4
	db 24
	db 0
	db 25
	db 38
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 10
	db 17
	db 17
	db 31
	db 0
	db 14
	db 17
	db 17
	db 17
	db 31
	db 17
	db 17
	db 0
	db 31
	db 16
	db 16
	db 30
	db 17
	db 17
	db 30
	db 0
	db 30
	db 17
	db 17
	db 30
	db 17
	db 17
	db 30
	db 0
	db 31
	db 16
	db 16
	db 16
	db 16
	db 16
	db 16
	db 0
	db 6
	db 10
	db 10
	db 10
	db 10
	db 10
	db 31
	db 17
	db 31
	db 16
	db 16
	db 30
	db 16
	db 16
	db 31
	db 0
	db 21
	db 21
	db 21
	db 14
	db 21
	db 21
	db 21
	db 0
	db 14
	db 17
	db 1
	db 6
	db 1
	db 17
	db 14
	db 0
	db 17
	db 17
	db 19
	db 21
	db 25
	db 17
	db 17
	db 0
	db 21
	db 17
	db 19
	db 21
	db 25
	db 17
	db 17
	db 0
	db 17
	db 18
	db 20
	db 24
	db 20
	db 18
	db 17
	db 0
	db 7
	db 9
	db 9
	db 9
	db 9
	db 9
	db 25
	db 0
	db 17
	db 27
	db 21
	db 21
	db 17
	db 17
	db 17
	db 0
	db 17
	db 17
	db 17
	db 31
	db 17
	db 17
	db 17
	db 0
	db 14
	db 17
	db 17
	db 17
	db 17
	db 17
	db 14
	db 0
	db 31
	db 17
	db 17
	db 17
	db 17
	db 17
	db 17
	db 0
	db 30
	db 17
	db 17
	db 30
	db 16
	db 16
	db 16
	db 0
	db 14
	db 17
	db 16
	db 16
	db 16
	db 17
	db 14
	db 0
	db 31
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 0
	db 17
	db 17
	db 17
	db 15
	db 1
	db 1
	db 30
	db 0
	db 14
	db 21
	db 21
	db 21
	db 21
	db 14
	db 4
	db 0
	db 17
	db 17
	db 10
	db 4
	db 10
	db 17
	db 17
	db 0
	db 18
	db 18
	db 18
	db 18
	db 18
	db 18
	db 31
	db 1
	db 17
	db 17
	db 17
	db 31
	db 1
	db 1
	db 1
	db 0
	db 17
	db 21
	db 21
	db 21
	db 21
	db 21
	db 31
	db 0
	db 17
	db 21
	db 21
	db 21
	db 21
	db 21
	db 31
	db 1
	db 48
	db 16
	db 30
	db 17
	db 17
	db 17
	db 30
	db 0
	db 17
	db 17
	db 25
	db 21
	db 21
	db 21
	db 25
	db 0
	db 16
	db 16
	db 30
	db 17
	db 17
	db 17
	db 30
	db 0
	db 14
	db 17
	db 1
	db 7
	db 1
	db 17
	db 14
	db 0
	db 18
	db 21
	db 21
	db 29
	db 21
	db 21
	db 18
	db 0
	db 15
	db 17
	db 17
	db 15
	db 5
	db 9
	db 17
	db 0
	db 0
	db 0
	db 14
	db 1
	db 15
	db 17
	db 15
	db 0
	db 1
	db 14
	db 16
	db 30
	db 17
	db 17
	db 14
	db 0
	db 0
	db 0
	db 28
	db 18
	db 30
	db 17
	db 30
	db 0
	db 0
	db 0
	db 31
	db 16
	db 16
	db 16
	db 16
	db 0
	db 0
	db 0
	db 6
	db 10
	db 10
	db 10
	db 31
	db 17
	db 0
	db 0
	db 14
	db 17
	db 31
	db 16
	db 15
	db 0
	db 0
	db 0
	db 21
	db 21
	db 14
	db 21
	db 21
	db 0
	db 0
	db 0
	db 14
	db 17
	db 6
	db 17
	db 14
	db 0
	db 0
	db 0
	db 17
	db 19
	db 21
	db 25
	db 17
	db 0
	db 0
	db 4
	db 17
	db 19
	db 21
	db 25
	db 17
	db 0
	db 0
	db 0
	db 17
	db 18
	db 28
	db 18
	db 17
	db 0
	db 0
	db 0
	db 7
	db 9
	db 9
	db 9
	db 25
	db 0
	db 0
	db 0
	db 17
	db 27
	db 21
	db 17
	db 17
	db 0
	db 0
	db 0
	db 17
	db 17
	db 31
	db 17
	db 17
	db 0
	db 0
	db 0
	db 14
	db 17
	db 17
	db 17
	db 14
	db 0
	db 0
	db 0
	db 31
	db 17
	db 17
	db 17
	db 17
	db 0
	db 17
	db 4
	db 17
	db 4
	db 17
	db 4
	db 17
	db 4
	db 21
	db 42
	db 21
	db 42
	db 21
	db 42
	db 21
	db 42
	db 46
	db 59
	db 46
	db 59
	db 46
	db 59
	db 46
	db 59
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 60
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 60
	db 4
	db 60
	db 4
	db 4
	db 4
	db 10
	db 10
	db 10
	db 58
	db 10
	db 10
	db 10
	db 10
	db 0
	db 0
	db 0
	db 63
	db 10
	db 10
	db 10
	db 10
	db 0
	db 0
	db 60
	db 4
	db 60
	db 4
	db 4
	db 4
	db 10
	db 10
	db 58
	db 2
	db 58
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 0
	db 0
	db 62
	db 2
	db 58
	db 10
	db 10
	db 10
	db 10
	db 10
	db 58
	db 2
	db 62
	db 0
	db 0
	db 0
	db 10
	db 10
	db 10
	db 62
	db 0
	db 0
	db 0
	db 0
	db 4
	db 4
	db 60
	db 4
	db 60
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 60
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 7
	db 0
	db 0
	db 0
	db 0
	db 4
	db 4
	db 4
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 63
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 7
	db 4
	db 4
	db 4
	db 4
	db 0
	db 0
	db 0
	db 63
	db 0
	db 0
	db 0
	db 0
	db 4
	db 4
	db 4
	db 63
	db 4
	db 4
	db 4
	db 4
	db 0
	db 0
	db 7
	db 4
	db 7
	db 4
	db 4
	db 4
	db 10
	db 10
	db 10
	db 11
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 11
	db 8
	db 15
	db 0
	db 0
	db 0
	db 0
	db 0
	db 15
	db 8
	db 11
	db 10
	db 10
	db 10
	db 10
	db 10
	db 59
	db 0
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 63
	db 0
	db 59
	db 10
	db 10
	db 10
	db 10
	db 10
	db 11
	db 8
	db 11
	db 10
	db 10
	db 10
	db 0
	db 0
	db 63
	db 0
	db 63
	db 0
	db 0
	db 0
	db 10
	db 10
	db 59
	db 0
	db 59
	db 10
	db 10
	db 10
	db 4
	db 4
	db 63
	db 0
	db 63
	db 0
	db 0
	db 0
	db 10
	db 10
	db 10
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 63
	db 0
	db 63
	db 4
	db 4
	db 4
	db 0
	db 0
	db 0
	db 63
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 15
	db 0
	db 0
	db 0
	db 0
	db 4
	db 4
	db 7
	db 4
	db 7
	db 0
	db 0
	db 0
	db 0
	db 0
	db 7
	db 4
	db 7
	db 4
	db 4
	db 4
	db 0
	db 0
	db 0
	db 15
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 10
	db 63
	db 10
	db 10
	db 10
	db 10
	db 4
	db 4
	db 63
	db 4
	db 63
	db 4
	db 4
	db 4
	db 4
	db 4
	db 4
	db 60
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 7
	db 4
	db 4
	db 4
	db 4
	db 63
	db 63
	db 63
	db 63
	db 63
	db 63
	db 63
	db 63
	db 0
	db 0
	db 0
	db 0
	db 63
	db 63
	db 63
	db 63
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 7
	db 7
	db 7
	db 7
	db 7
	db 7
	db 7
	db 7
	db 63
	db 63
	db 63
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 30
	db 17
	db 17
	db 30
	db 16
	db 0
	db 0
	db 0
	db 14
	db 17
	db 16
	db 17
	db 14
	db 0
	db 0
	db 0
	db 31
	db 4
	db 4
	db 4
	db 4
	db 0
	db 0
	db 0
	db 17
	db 17
	db 15
	db 1
	db 14
	db 0
	db 0
	db 0
	db 14
	db 21
	db 21
	db 14
	db 4
	db 0
	db 0
	db 0
	db 17
	db 10
	db 4
	db 10
	db 17
	db 0
	db 0
	db 0
	db 18
	db 18
	db 18
	db 18
	db 31
	db 1
	db 0
	db 0
	db 17
	db 17
	db 15
	db 1
	db 1
	db 0
	db 0
	db 0
	db 21
	db 21
	db 21
	db 21
	db 31
	db 0
	db 0
	db 0
	db 21
	db 21
	db 21
	db 21
	db 31
	db 1
	db 0
	db 0
	db 48
	db 16
	db 30
	db 17
	db 30
	db 0
	db 0
	db 0
	db 17
	db 17
	db 29
	db 21
	db 29
	db 0
	db 0
	db 0
	db 16
	db 16
	db 30
	db 17
	db 30
	db 0
	db 0
	db 0
	db 30
	db 1
	db 15
	db 1
	db 30
	db 0
	db 0
	db 0
	db 18
	db 21
	db 29
	db 21
	db 18
	db 0
	db 0
	db 0
	db 15
	db 17
	db 15
	db 9
	db 17
	db 0
	db 10
	db 31
	db 16
	db 28
	db 16
	db 16
	db 31
	db 0
	db 10
	db 0
	db 14
	db 17
	db 31
	db 16
	db 15
	db 0
	db 12
	db 18
	db 4
	db 8
	db 30
	db 0
	db 0
	db 0
	db 12
	db 18
	db 4
	db 18
	db 12
	db 0
	db 0
	db 0
	db 4
	db 12
	db 20
	db 30
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 12
	db 12
	db 0
	db 63
	db 0
	db 12
	db 12
	db 0
	db 0
	db 10
	db 20
	db 0
	db 10
	db 20
	db 0
	db 0
	db 0
	db 8
	db 20
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 12
	db 0
	db 0
	db 0
	db 28
	db 28
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 2
	db 2
	db 36
	db 20
	db 8
	db 0
	db 3
	db 3
	db 36
	db 52
	db 44
	db 36
	db 36
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 30
	db 30
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
textColor:
	db 255
scanCodes:
	db 54
	db 245
	db 234
	db 237
	db 55
	db 233
	db 235
	db 96
	db 53
	db 249
	db 232
	db 238
	db 56
	db 239
	db 236
	db 64
	db 52
	db 244
	db 231
	db 226
	db 57
	db 240
	db 91
	db 0
	db 4
	db 5
	db 6
	db 7
	db 10
	db 8
	db 11
	db 32
	db 51
	db 242
	db 230
	db 246
	db 48
	db 123
	db 93
	db 44
	db 50
	db 229
	db 228
	db 227
	db 45
	db 125
	db 58
	db 46
	db 49
	db 46
	db 225
	db 250
	db 94
	db 47
	db 59
	db 48
	db 20
	db 247
	db 243
	db 248
	db 12
	db 14
	db 25
	db 15
	db 13
	db 241
	db 9
	db 16
	db 92
	db 23
	db 17
	db 26
	db 1
	db 21
	db 2
	db 3
	db 27
	db 18
	db 24
	db 19
	db 38
	db 213
	db 202
	db 205
	db 39
	db 201
	db 203
	db 96
	db 37
	db 217
	db 200
	db 206
	db 40
	db 207
	db 204
	db 64
	db 36
	db 212
	db 199
	db 194
	db 41
	db 208
	db 219
	db 0
	db 4
	db 5
	db 6
	db 7
	db 10
	db 8
	db 11
	db 32
	db 35
	db 210
	db 198
	db 214
	db 95
	db 123
	db 93
	db 60
	db 34
	db 197
	db 196
	db 195
	db 61
	db 125
	db 42
	db 62
	db 33
	db 46
	db 193
	db 218
	db 126
	db 63
	db 43
	db 48
	db 20
	db 215
	db 211
	db 216
	db 12
	db 14
	db 25
	db 15
	db 13
	db 209
	db 9
	db 16
	db 124
	db 23
	db 17
	db 26
	db 1
	db 21
	db 2
	db 3
	db 27
	db 18
	db 24
	db 19
	db 54
	db 163
	db 174
	db 236
	db 55
	db 232
	db 171
	db 161
	db 53
	db 173
	db 224
	db 226
	db 56
	db 233
	db 164
	db 238
	db 52
	db 165
	db 175
	db 168
	db 57
	db 167
	db 166
	db 241
	db 4
	db 5
	db 6
	db 7
	db 10
	db 8
	db 11
	db 32
	db 51
	db 170
	db 160
	db 172
	db 48
	db 229
	db 237
	db 44
	db 50
	db 227
	db 162
	db 225
	db 45
	db 234
	db 58
	db 46
	db 49
	db 46
	db 228
	db 239
	db 94
	db 47
	db 59
	db 48
	db 20
	db 230
	db 235
	db 231
	db 12
	db 14
	db 25
	db 15
	db 13
	db 169
	db 9
	db 16
	db 92
	db 23
	db 17
	db 26
	db 1
	db 21
	db 2
	db 3
	db 27
	db 18
	db 24
	db 19
	db 38
	db 131
	db 142
	db 156
	db 39
	db 152
	db 139
	db 129
	db 37
	db 141
	db 144
	db 146
	db 40
	db 153
	db 132
	db 158
	db 36
	db 133
	db 143
	db 136
	db 41
	db 135
	db 134
	db 240
	db 4
	db 5
	db 6
	db 7
	db 10
	db 8
	db 11
	db 32
	db 35
	db 138
	db 128
	db 140
	db 95
	db 149
	db 157
	db 44
	db 34
	db 147
	db 130
	db 145
	db 61
	db 154
	db 42
	db 46
	db 33
	db 46
	db 148
	db 159
	db 126
	db 63
	db 43
	db 48
	db 20
	db 150
	db 155
	db 151
	db 12
	db 14
	db 25
	db 15
	db 13
	db 137
	db 9
	db 16
	db 124
	db 23
	db 17
	db 26
	db 1
	db 21
	db 2
	db 3
	db 27
	db 18
	db 24
	db 19
keyboardMode:
	db 1
keyboardPressedKey:
	ds 1
currentPalette:
	ds 2
imgTitle:
	db 0
	db 97
	db 217
	db 255
	db 129
	db 250
	db 255
	db 253
	db 24
	db 124
	db 248
	db 240
	db 192
	db 128
	db 129
	db 245
	db 255
	db 254
	db 1
	db 7
	db 31
	db 255
	db 216
	db 254
	db 248
	db 135
	db 254
	db 253
	db 32
	db 48
	db 16
	db 144
	db 112
	db 192
	db 227
	db 255
	db 254
	db 254
	db 130
	db 186
	db 140
	db 138
	db 32
	db 76
	db 65
	db 231
	db 2
	db 143
	db 9
	db 7
	db 96
	db 113
	db 126
	db 255
	db 14
	db 140
	db 255
	db 199
	db 238
	db 59
	db 127
	db 207
	db 246
	db 158
	db 56
	db 240
	db 224
	db 7
	db 215
	db 127
	db 231
	db 3
	db 14
	db 28
	db 57
	db 59
	db 31
	db 31
	db 126
	db 252
	db 227
	db 248
	db 240
	db 224
	db 208
	db 192
	db 255
	db 39
	db 0
	db 255
	db 96
	db 118
	db 255
	db 250
	db 192
	db 240
	db 199
	db 248
	db 255
	db 241
	db 207
	db 135
	db 131
	db 193
	db 252
	db 224
	db 240
	db 121
	db 63
	db 123
	db 15
	db 6
	db 206
	db 218
	db 240
	db 128
	db 128
	db 251
	db 112
	db 254
	db 6
	db 171
	db 249
	db 64
	db 6
	db 173
	db 244
	db 80
	db 1
	db 3
	db 7
	db 255
	db 12
	db 32
	db 7
	db 108
	db 109
	db 237
	db 224
	db 96
	db 160
	db 76
	db 254
	db 89
	db 204
	db 224
	db 97
	db 90
	db 255
	db 192
	db 72
	db 49
	db 255
	db 109
	db 215
	db 255
	db 200
	db 56
	db 251
	db 194
	db 64
	db 68
	db 223
	db 9
	db 0
	db 5
	db 16
	db 2
	db 255
	db 20
	db 1
	db 149
	db 4
	db 138
	db 137
	db 74
	db 10
	db 255
	db 85
	db 170
	db 213
	db 42
	db 218
	db 53
	db 235
	db 173
	db 255
	db 181
	db 239
	db 90
	db 247
	db 93
	db 245
	db 223
	db 123
	db 199
	db 46
	db 28
	db 150
	db 8
	db 255
	db 97
	db 137
	db 224
	db 187
	db 217
	db 127
	db 194
	db 94
	db 75
	db 38
	db 81
	db 78
	db 240
	db 187
	db 54
	db 64
	db 113
	db 152
	db 135
	db 191
	db 114
	db 242
	db 96
	db 184
	db 84
	db 171
	db 118
	db 159
	db 254
	db 235
	db 53
	db 206
	db 51
	db 204
	db 177
	db 247
	db 82
	db 217
	db 243
	db 207
	db 9
	db 153
	db 255
	db 127
	db 63
	db 255
	db 143
	db 31
	db 15
	db 175
	db 7
	db 140
	db 161
	db 34
	db 57
	db 255
	db 248
	db 33
	db 118
	db 132
	db 132
	db 133
	db 4
	db 136
	db 207
	db 2
	db 8
	db 254
	db 5
	db 128
	db 18
	db 31
	db 20
	db 146
	db 198
	db 25
	db 153
	db 252
	db 154
	db 28
	db 157
	db 156
	db 29
	db 158
	db 196
	db 255
	db 30
	db 199
	db 12
	db 205
	db 98
	db 135
	db 55
	db 55
	db 175
	db 191
	db 31
	db 123
	db 76
	db 96
	db 224
	db 255
	db 152
	db 124
	db 248
	db 246
	db 207
	db 191
	db 123
	db 112
	db 255
	db 119
	db 187
	db 220
	db 103
	db 185
	db 92
	db 248
	db 225
	db 253
	db 135
	db 143
	db 191
	db 252
	db 251
	db 247
	db 32
	db 223
	db 254
	db 174
	db 141
	db 48
	db 158
	db 61
	db 142
	db 19
	db 30
	db 12
	db 133
	db 93
	db 249
	db 242
	db 160
	db 88
	db 188
	db 87
	db 8
	db 159
	db 2
	db 213
	db 122
	db 157
	db 230
	db 123
	db 232
	db 156
	db 227
	db 252
	db 180
	db 195
	db 242
	db 1
	db 33
	db 114
	db 113
	db 112
	db 107
	db 203
	db 170
	db 64
	db 84
	db 255
	db 68
	db 224
	db 253
	db 66
	db 72
	db 64
	db 82
	db 135
	db 69
	db 65
	db 15
	db 68
	db 73
	db 28
	db 72
	db 74
	db 131
	db 67
	db 85
	db 145
	db 77
	db 252
	db 112
	db 90
	db 86
	db 161
	db 91
	db 120
	db 31
	db 22
	db 62
	db 21
	db 152
	db 11
	db 15
	db 241
	db 6
	db 236
	db 4
	db 221
	db 210
	db 58
	db 159
	db 255
	db 158
	db 61
	db 252
	db 6
	db 88
	db 19
	db 238
	db 249
	db 172
	db 231
	db 135
	db 41
	db 135
	db 137
	db 125
	db 253
	db 9
	db 145
	db 248
	db 145
	db 191
	db 255
	db 159
	db 47
	db 55
	db 23
	db 151
	db 236
	db 119
	db 15
	db 126
	db 41
	db 122
	db 5
	db 112
	db 232
	db 86
	db 187
	db 249
	db 12
	db 252
	db 231
	db 234
	db 213
	db 123
	db 4
	db 121
	db 158
	db 239
	db 231
	db 249
	db 254
	db 88
	db 179
	db 143
	db 160
	db 208
	db 236
	db 102
	db 31
	db 63
	db 40
	db 255
	db 254
	db 231
	db 195
	db 193
	db 30
	db 128
	db 206
	db 252
	db 48
	db 16
	db 14
	db 64
	db 2
	db 8
	db 4
	db 84
	db 14
	db 36
	db 68
	db 16
	db 44
	db 18
	db 60
	db 72
	db 42
	db 196
	db 254
	db 84
	db 255
	db 90
	db 212
	db 170
	db 172
	db 106
	db 218
	db 182
	db 108
	db 11
	db 254
	db 85
	db 248
	db 255
	db 214
	db 252
	db 184
	db 112
	db 242
	db 32
	db 255
	db 204
	db 59
	db 202
	db 252
	db 33
	db 239
	db 199
	db 7
	db 127
	db 15
	db 26
	db 53
	db 106
	db 237
	db 213
	db 171
	db 255
	db 242
	db 41
	db 215
	db 227
	db 149
	db 254
	db 249
	db 247
	db 8
	db 123
	db 71
	db 63
	db 177
	db 20
	db 98
	db 176
	db 25
	db 147
	db 63
	db 41
	db 128
	db 64
	db 176
	db 88
	db 238
	db 113
	db 8
	db 0
	db 252
	db 255
	db 213
	db 59
	db 221
	db 230
	db 217
	db 62
	db 207
	db 243
	db 222
	db 252
	db 3
	db 177
	db 175
	db 31
	db 49
	db 254
	db 118
	db 199
	db 224
	db 253
	db 243
	db 220
	db 10
	db 122
	db 248
	db 63
	db 63
	db 30
	db 14
	db 161
	db 6
	db 69
	db 255
	db 119
	db 49
	db 145
	db 131
	db 3
	db 248
	db 147
	db 1
	db 33
	db 223
	db 80
	db 0
	db 20
	db 32
	db 8
	db 137
	db 36
	db 68
	db 249
	db 84
	db 73
	db 74
	db 101
	db 106
	db 254
	db 199
	db 114
	db 117
	db 255
	db 118
	db 121
	db 123
	db 122
	db 51
	db 53
	db 55
	db 2
	db 177
	db 1
	db 34
	db 138
	db 35
	db 194
	db 193
	db 126
	db 90
	db 72
	db 6
	db 100
	db 41
	db 60
	db 30
	db 31
	db 191
	db 255
	db 251
	db 110
	db 15
	db 4
	db 124
	db 236
	db 41
	db 112
	db 96
	db 121
	db 5
	db 192
	db 247
	db 112
	db 188
	db 86
	db 239
	db 26
	db 8
	db 62
	db 4
	db 205
	db 243
	db 220
	db 123
	db 157
	db 95
	db 13
	db 248
	db 183
	db 1
	db 91
	db 63
	db 199
	db 188
	db 27
	db 19
	db 23
	db 245
	db 206
	db 239
	db 133
	db 76
	db 4
	db 249
	db 240
	db 117
	db 150
	db 159
	db 252
	db 71
	db 185
	db 16
	db 251
	db 36
	db 1
	db 0
	db 5
	db 129
	db 42
	db 82
	db 192
	db 8
	db 34
	db 95
	db 0
	db 22
	db 84
	db 42
	db 66
	db 254
	db 86
	db 139
	db 90
	db 58
	db 255
	db 106
	db 46
	db 124
	db 91
	db 251
	db 54
	db 126
	db 44
	db 143
	db 60
	db 24
	db 30
	db 16
	db 194
	db 173
	db 255
	db 56
	db 15
	db 127
	db 255
	db 120
	db 124
	db 63
	db 30
	db 177
	db 12
	db 236
	db 174
	db 41
	db 125
	db 26
	db 240
	db 92
	db 186
	db 85
	db 254
	db 17
	db 8
	db 0
	db 207
	db 248
	db 77
	db 243
	db 92
	db 251
	db 215
	db 29
	db 230
	db 154
	db 11
	db 255
	db 84
	db 0
	db 241
	db 112
	db 245
	db 29
	db 135
	db 248
	db 139
	db 24
	db 148
	db 91
	db 250
	db 3
	db 159
	db 251
	db 12
	db 184
	db 5
	db 243
	db 89
	db 70
	db 255
	db 17
	db 129
	db 98
	db 253
	db 33
	db 5
	db 65
	db 133
	db 73
	db 81
	db 11
	db 169
	db 145
	db 16
	db 97
	db 1
	db 0
	db 192
	db 253
	db 89
	db 138
	db 105
	db 52
	db 233
	db 35
	db 98
	db 244
	db 225
	db 216
	db 248
	db 176
	db 3
	db 96
	db 30
	db 64
	db 193
	db 55
	db 43
	db 41
	db 92
	db 36
	db 88
	db 252
	db 87
	db 198
	db 12
	db 255
	db 162
	db 251
	db 252
	db 127
	db 248
	db 117
	db 155
	db 103
	db 249
	db 86
	db 251
	db 53
	db 94
	db 11
	db 218
	db 248
	db 7
	db 181
	db 83
	db 63
	db 195
	db 228
	db 8
	db 248
	db 163
	db 7
	db 192
	db 19
	db 122
	db 166
	db 112
	db 120
	db 124
	db 127
	db 48
	db 255
	db 171
	db 203
	db 3
	db 75
	db 253
	db 215
	db 86
	db 4
	db 112
	db 49
	db 192
	db 251
	db 5
	db 51
	db 255
	db 132
	db 253
	db 68
	db 0
	db 96
	db 15
	db 254
	db 36
	db 133
	db 32
	db 241
	db 64
	db 148
	db 34
	db 170
	db 60
	db 164
	db 69
	db 165
	db 68
	db 100
	db 255
	db 159
	db 101
	db 253
	db 229
	db 65
	db 241
	db 211
	db 221
	db 96
	db 225
	db 161
	db 22
	db 216
	db 36
	db 229
	db 41
	db 107
	db 204
	db 248
	db 84
	db 44
	db 12
	db 150
	db 254
	db 117
	db 159
	db 137
	db 4
	db 250
	db 231
	db 105
	db 181
	db 48
	db 215
	db 9
	db 113
	db 13
	db 255
	db 5
	db 154
	db 128
	db 248
	db 240
	db 88
	db 243
	db 131
	db 223
	db 123
	db 191
	db 193
	db 227
	db 247
	db 83
	db 255
	db 8
	db 181
	db 251
	db 120
	db 31
	db 56
	db 48
	db 29
	db 167
	db 154
	db 0
	db 41
	db 255
	db 18
	db 254
	db 17
	db 164
	db 20
	db 254
	db 146
	db 1
	db 224
	db 148
	db 137
	db 149
	db 60
	db 254
	db 21
	db 146
	db 22
	db 207
	db 252
	db 147
	db 252
	db 135
	db 202
	db 207
	db 239
	db 131
	db 7
	db 2
	db 203
	db 213
	db 4
	db 107
	db 232
	db 29
	db 120
	db 254
	db 16
	db 144
	db 12
	db 119
	db 154
	db 60
	db 248
	db 55
	db 207
	db 115
	db 252
	db 235
	db 244
	db 245
	db 31
	db 108
	db 22
	db 133
	db 90
	db 225
	db 220
	db 13
	db 105
	db 203
	db 4
	db 0
	db 191
	db 244
	db 128
	db 1
	db 140
	db 75
	db 174
	db 15
	db 127
	db 26
	db 31
	db 194
	db 238
	db 55
	db 253
	db 188
	db 246
	db 208
	db 224
	db 253
	db 193
	db 196
	db 192
	db 201
	db 198
	db 69
	db 80
	db 145
	db 4
	db 6
	db 127
	db 9
	db 10
	db 146
	db 5
	db 21
	db 138
	db 241
	db 85
	db 74
	db 149
	db 86
	db 63
	db 237
	db 91
	db 181
	db 87
	db 250
	db 175
	db 251
	db 246
	db 222
	db 123
	db 111
	db 62
	db 240
	db 0
	db 195
	db 251
	db 46
	db 161
	db 244
	db 249
	db 118
	db 255
	db 213
	db 8
	db 163
	db 221
	db 252
	db 218
	db 248
	db 127
	db 183
	db 242
	db 18
	db 77
	db 248
	db 63
	db 249
	db 224
	db 148
	db 61
	db 92
	db 13
	db 218
	db 135
	db 127
	db 56
	db 246
	db 193
	db 254
	db 192
	db 132
	db 250
	db 70
	db 45
	db 149
	db 0
	db 219
	db 186
	db 248
	db 79
	db 176
	db 215
	db 214
	db 226
	db 248
	db 66
	db 129
	db 254
	db 9
	db 128
	db 16
	db 0
	db 8
	db 32
	db 4
	db 31
	db 132
	db 18
	db 146
	db 15
	db 129
	db 10
	db 199
	db 130
	db 21
	db 4
	db 92
	db 153
	db 26
	db 111
	db 27
	db 156
	db 29
	db 157
	db 31
	db 158
	db 140
	db 216
	db 204
	db 77
	db 119
	db 230
	db 5
	db 252
	db 26
	db 205
	db 220
	db 254
	db 24
	db 253
	db 33
	db 12
	db 223
	db 53
	db 107
	db 248
	db 127
	db 159
	db 238
	db 15
	db 54
	db 248
	db 246
	db 11
	db 240
	db 15
	db 177
	db 205
	db 95
	db 141
	db 175
	db 143
	db 225
	db 83
	db 168
	db 87
	db 31
	db 254
	db 0
	db 47
	db 95
	db 191
	db 220
	db 31
	db 224
	db 231
	db 237
	db 64
	db 15
	db 16
	db 53
	db 149
	db 64
	db 53
	db 183
	db 32
	db 86
	db 108
	db 26
	db 241
	db 1
	db 159
	db 123
	db 248
	db 64
	db 75
	db 205
	db 249
	db 72
	db 253
	db 73
	db 32
	db 254
	db 85
	db 230
	db 68
	db 82
	db 254
	db 74
	db 99
	db 252
	db 85
	db 134
	db 147
	db 254
	db 77
	db 254
	db 91
	db 142
	db 86
	db 47
	db 22
	db 59
	db 47
	db 181
	db 29
	db 195
	db 0
	db 13
	db 10
	db 5
	db 182
	db 240
	db 252
	db 158
	db 40
	db 93
	db 101
	db 108
	db 248
	db 120
	db 4
	db 7
	db 253
	db 23
	db 191
	db 191
	db 11
	db 95
	db 171
	db 85
	db 168
	db 5
	db 42
	db 234
	db 21
	db 162
	db 84
	db 239
	db 175
	db 116
	db 254
	db 128
	db 5
	db 160
	db 250
	db 235
	db 171
	db 87
	db 1
	db 92
	db 90
	db 128
	db 81
	db 136
	db 136
	db 232
	db 52
	db 117
	db 79
	db 213
	db 106
	db 180
	db 234
	db 194
	db 181
	db 238
	db 19
	db 212
	db 42
	db 27
	db 160
	db 0
	db 142
	db 240
	db 202
	db 48
	db 41
	db 214
	db 250
	db 249
	db 8
	db 64
	db 248
	db 3
	db 17
	db 10
	db 127
	db 68
	db 16
	db 18
	db 36
	db 8
	db 84
	db 27
	db 82
	db 20
	db 17
	db 250
	db 0
	db 131
	db 54
	db 90
	db 31
	db 86
	db 124
	db 3
	db 126
	db 234
	db 251
	db 222
	db 123
	db 239
	db 190
	db 248
	db 186
	db 210
	db 198
	db 12
	db 28
	db 43
	db 245
	db 101
	db 63
	db 121
	db 13
	db 171
	db 247
	db 227
	db 28
	db 100
	db 188
	db 232
	db 253
	db 234
	db 213
	db 42
	db 196
	db 14
	db 4
	db 106
	db 2
	db 10
	db 21
	db 80
	db 32
	db 244
	db 211
	db 22
	db 245
	db 182
	db 21
	db 168
	db 160
	db 85
	db 4
	db 155
	db 238
	db 219
	db 78
	db 132
	db 235
	db 158
	db 253
	db 61
	db 23
	db 2
	db 0
	db 3
	db 200
	db 255
	db 242
	db 195
	db 92
	db 142
	db 252
	db 238
	db 65
	db 193
	db 145
	db 88
	db 3
	db 211
	db 17
	db 65
	db 254
	db 32
	db 72
	db 226
	db 80
	db 132
	db 40
	db 194
	db 84
	db 26
	db 168
	db 85
	db 4
	db 160
	db 253
	db 54
	db 127
	db 110
	db 92
	db 106
	db 94
	db 122
	db 111
	db 251
	db 238
	db 215
	db 127
	db 30
	db 219
	db 67
	db 10
	db 248
	db 26
	db 196
	db 139
	db 5
	db 205
	db 33
	db 143
	db 4
	db 242
	db 255
	db 108
	db 248
	db 248
	db 199
	db 139
	db 59
	db 66
	db 127
	db 24
	db 254
	db 253
	db 128
	db 125
	db 250
	db 161
	db 245
	db 254
	db 10
	db 129
	db 252
	db 253
	db 92
	db 236
	db 126
	db 134
	db 4
	db 137
	db 4
	db 1
	db 141
	db 240
	db 2
	db 156
	db 5
	db 254
	db 11
	db 6
	db 98
	db 117
	db 3
	db 21
	db 52
	db 116
	db 164
	db 41
	db 135
	db 218
	db 255
	db 207
	db 24
	db 255
	db 231
	db 75
	db 251
	db 255
	db 186
	db 250
	db 82
	db 89
	db 255
	db 253
	db 213
	db 253
	db 254
	db 110
	db 255
	db 101
	db 24
	db 215
	db 97
	db 155
	db 19
	db 254
	db 48
	db 149
	db 203
	db 55
	db 14
	db 243
	db 11
	db 250
	db 20
	db 55
	db 87
	db 174
	db 81
	db 201
	db 143
	db 23
	db 250
	db 246
	db 237
	db 63
	db 67
	db 188
	db 63
	db 55
	db 120
	db 174
	db 7
	db 13
	db 99
	db 1
	db 186
	db 14
	db 211
	db 160
	db 128
	db 247
	db 3
	db 174
	db 28
	db 86
	db 82
	db 64
	db 216
	db 255
	db 133
	db 27
	db 5
	db 45
	db 255
	db 252
	db 78
	db 255
	db 48
	db 72
	db 168
	db 255
	db 255
	db 135
	db 1
	db 33
	db 127
	db 240
	db 0
	db 0
	db 80
	db 124
	db 81
	db 131
	db 163
	db 199
	db 117
	db 177
	db 228
	db 96
	db 239
	db 255
	db 131
	db 179
	db 33
	db 41
	db 104
	db 212
	db 89
	db 18
	db 121
	db 97
	db 254
	db 105
	db 101
	db 248
	db 88
	db 165
	db 132
	db 143
	db 5
	db 64
	db 112
	db 120
	db 126
	db 177
	db 127
	db 39
	db 255
	db 31
	db 103
	db 121
	db 106
	db 231
	db 105
	db 234
	db 2
	db 95
	db 155
	db 37
	db 33
	db 254
	db 84
	db 247
	db 160
	db 5
	db 130
	db 80
	db 61
	db 246
	db 171
	db 31
	db 7
	db 1
	db 115
	db 107
	db 68
	db 32
	db 196
	db 80
	db 168
	db 225
	db 169
	db 212
	db 170
	db 17
	db 230
	db 33
	db 208
	db 1
	db 184
	db 10
	db 168
	db 70
	db 240
	db 103
	db 229
	db 0
	db 149
	db 214
	db 4
	db 25
	db 245
	db 254
	db 205
	db 1
	db 4
	db 16
	db 74
	db 1
	db 65
	db 187
	db 252
	db 144
	db 3
	db 81
	db 129
	db 240
	db 41
	db 65
	db 16
	db 84
	db 53
	db 164
	db 149
	db 229
	db 1
	db 126
	db 0
	db 217
	db 80
	db 104
	db 31
	db 121
	db 209
	db 185
	db 255
	db 232
	db 88
	db 251
	db 111
	db 253
	db 183
	db 255
	db 252
	db 97
	db 29
	db 150
	db 255
	db 108
	db 117
	db 63
	db 79
	db 189
	db 114
	db 252
	db 243
	db 207
	db 167
	db 148
	db 24
	db 179
	db 219
	db 231
	db 159
	db 221
	db 245
	db 217
	db 234
	db 213
	db 37
	db 0
	db 205
	db 12
	db 168
	db 69
	db 253
	db 8
	db 115
	db 187
	db 84
	db 138
	db 123
	db 234
	db 234
	db 181
	db 252
	db 250
	db 239
	db 221
	db 255
	db 247
	db 254
	db 173
	db 206
	db 13
	db 209
	db 214
	db 216
	db 125
	db 42
	db 236
	db 152
	db 7
	db 97
	db 153
	db 252
	db 30
	db 255
	db 186
	db 12
	db 33
	db 106
	db 155
	db 255
	db 140
	db 220
	db 254
	db 76
	db 13
	db 77
	db 16
	db 3
	db 2
	db 141
	db 24
	db 34
	db 132
	db 67
	db 254
	db 132
	db 205
	db 64
	db 253
	db 15
	db 193
	db 195
	db 178
	db 227
	db 228
	db 204
	db 195
	db 31
	db 179
	db 251
	db 255
	db 252
	db 241
	db 43
	db 246
	db 183
	db 22
	db 250
	db 124
	db 250
	db 111
	db 42
	db 197
	db 160
	db 212
	db 43
	db 250
	db 158
	db 24
	db 193
	db 26
	db 253
	db 254
	db 191
	db 152
	db 224
	db 3
	db 138
	db 149
	db 198
	db 42
	db 23
	db 252
	db 85
	db 46
	db 93
	db 183
	db 111
	db 191
	db 159
	db 254
	db 88
	db 95
	db 55
	db 159
	db 207
	db 246
	db 7
	db 242
	db 1
	db 254
	db 110
	db 35
	db 180
	db 224
	db 199
	db 241
	db 163
	db 251
	db 255
	db 13
	db 14
	db 1
	db 239
	db 6
	db 240
	db 112
	db 48
	db 210
	db 32
	db 34
	db 180
	db 41
	db 16
	db 51
	db 36
	db 247
	db 40
	db 72
	db 254
	db 41
	db 81
	db 36
	db 226
	db 37
	db 244
	db 106
	db 234
	db 229
	db 254
	db 208
	db 235
	db 237
	db 253
	db 64
	db 191
	db 238
	db 203
	db 214
	db 31
	db 14
	db 11
	db 125
	db 172
	db 66
	db 2
	db 43
	db 182
	db 14
	db 15
	db 31
	db 206
	db 251
	db 251
	db 127
	db 183
	db 2
	db 251
	db 242
	db 236
	db 29
	db 220
	db 227
	db 253
	db 218
	db 243
	db 15
	db 121
	db 41
	db 115
	db 99
	db 130
	db 126
	db 43
	db 13
	db 174
	db 46
	db 168
	db 244
	db 206
	db 163
	db 250
	db 76
	db 180
	db 22
	db 219
	db 15
	db 4
	db 51
	db 255
	db 86
	db 85
	db 18
	db 128
	db 60
	db 164
	db 88
	db 146
	db 120
	db 162
	db 132
	db 129
	db 193
	db 136
	db 248
	db 37
	db 20
	db 18
	db 165
	db 84
	db 251
	db 145
	db 195
	db 42
	db 44
	db 211
	db 56
	db 195
	db 9
	db 190
	db 251
	db 198
	db 62
	db 252
	db 118
	db 247
	db 227
	db 156
	db 99
	db 225
	db 127
	db 142
	db 140
	db 241
	db 209
	db 238
	db 191
	db 91
	db 230
	db 250
	db 168
	db 5
	db 40
	db 85
	db 171
	db 126
	db 254
	db 160
	db 7
	db 168
	db 95
	db 191
	db 127
	db 140
	db 178
	db 154
	db 173
	db 125
	db 175
	db 22
	db 48
	db 153
	db 220
	db 5
	db 166
	db 116
	db 59
	db 120
	db 152
	db 255
	db 253
	db 144
	db 16
	db 40
	db 96
	db 168
	db 97
	db 72
	db 136
	db 97
	db 32
	db 84
	db 241
	db 146
	db 42
	db 168
	db 215
	db 39
	db 254
	db 180
	db 254
	db 108
	db 216
	db 15
	db 212
	db 124
	db 32
	db 254
	db 249
	db 254
	db 236
	db 188
	db 120
	db 255
	db 143
	db 48
	db 32
	db 97
	db 175
	db 234
	db 251
	db 7
	db 14
	db 240
	db 75
	db 42
	db 119
	db 253
	db 117
	db 248
	db 124
	db 125
	db 1
	db 216
	db 0
	db 174
	db 126
	db 183
	db 245
	db 63
	db 106
	db 250
	db 4
	db 252
	db 227
	db 211
	db 11
	db 249
	db 226
	db 0
	db 171
	db 84
	db 191
	db 240
	db 115
	db 224
	db 2
	db 252
	db 65
	db 98
	db 110
	db 164
	db 15
	db 31
	db 191
	db 57
	db 253
	db 97
	db 151
	db 85
	db 2
	db 157
	db 0
	db 116
	db 43
	db 188
	db 48
	db 251
	db 70
	db 41
	db 134
	db 252
	db 38
	db 12
	db 99
	db 251
	db 166
	db 0
	db 34
	db 253
	db 8
	db 73
	db 254
	db 102
	db 132
	db 198
	db 103
	db 255
	db 230
	db 254
	db 160
	db 241
	db 28
	db 91
	db 224
	db 15
	db 164
	db 255
	db 191
	db 251
	db 29
	db 70
	db 16
	db 246
	db 4
	db 121
	db 248
	db 255
	db 252
	db 123
	db 248
	db 143
	db 127
	db 117
	db 54
	db 24
	db 225
	db 254
	db 79
	db 64
	db 248
	db 215
	db 126
	db 128
	db 6
	db 224
	db 200
	db 232
	db 5
	db 252
	db 18
	db 0
	db 254
	db 186
	db 249
	db 196
	db 52
	db 146
	db 56
	db 28
	db 34
	db 99
	db 227
	db 120
	db 119
	db 166
	db 255
	db 247
	db 88
	db 254
	db 89
	db 88
	db 254
	db 124
	db 248
	db 60
	db 56
	db 238
	db 132
	db 45
	db 2
	db 85
	db 55
	db 2
	db 32
	db 253
	db 21
	db 41
	db 143
	db 6
	db 2
	db 31
	db 84
	db 146
	db 240
	db 85
	db 133
	db 18
	db 149
	db 226
	db 21
	db 195
	db 150
	db 16
	db 84
	db 251
	db 82
	db 255
	db 23
	db 133
	db 3
	db 96
	db 135
	db 37
	db 255
	db 189
	db 230
	db 55
	db 127
	db 212
	db 8
	db 186
	db 93
	db 111
	db 4
	db 122
	db 248
	db 118
	db 249
	db 103
	db 159
	db 125
	db 248
	db 254
	db 121
	db 231
	db 131
	db 124
	db 148
	db 96
	db 237
	db 241
	db 143
	db 112
	db 93
	db 246
	db 193
	db 63
	db 1
	db 104
	db 252
	db 70
	db 109
	db 23
	db 0
	db 254
	db 112
	db 136
	db 140
	db 220
	db 216
	db 248
	db 178
	db 12
	db 43
	db 95
	db 176
	db 201
	db 214
	db 88
	db 254
	db 208
	db 193
	db 49
	db 194
	db 6
	db 133
	db 200
	db 196
	db 140
	db 209
	db 121
	db 253
	db 197
	db 201
	db 202
	db 254
	db 48
	db 255
	db 213
	db 162
	db 214
	db 254
	db 86
	db 90
	db 85
	db 23
	db 26
	db 87
	db 24
	db 220
	db 30
	db 43
	db 63
	db 93
	db 23
	db 15
	db 143
	db 209
	db 255
	db 133
	db 122
	db 225
	db 55
	db 4
	db 87
	db 158
	db 0
	db 248
	db 107
	db 254
	db 252
	db 87
	db 252
	db 115
	db 238
	db 183
	db 245
	db 130
	db 7
	db 235
	db 248
	db 93
	db 191
	db 85
	db 139
	db 7
	db 141
	db 0
	db 48
	db 27
	db 3
	db 4
	db 98
	db 255
	db 194
	db 116
	db 195
	db 20
	db 20
	db 99
	db 255
	db 121
	db 112
	db 255
	db 100
	db 74
	db 22
	db 52
	db 111
	db 84
	db 62
	db 241
	db 54
	db 26
	db 126
	db 86
	db 182
	db 254
	db 240
	db 30
	db 73
	db 253
	db 105
	db 82
	db 175
	db 217
	db 145
	db 26
	db 225
	db 175
	db 21
	db 55
	db 246
	db 131
	db 0
	db 215
	db 2
	db 53
	db 31
	db 250
	db 209
	db 245
	db 84
	db 219
	db 8
	db 212
	db 227
	db 190
	db 6
	db 50
	db 244
	db 224
	db 203
	db 150
	db 255
	db 63
	db 134
	db 255
	db 166
	db 61
	db 8
	db 84
	db 2
	db 5
	db 212
	db 2
	db 198
	db 4
	db 80
	db 170
	db 16
	db 70
	db 0
	db 72
	db 218
	db 36
	db 20
	db 83
	db 0
	db 90
	db 36
	db 225
	db 94
	db 52
	db 106
	db 213
	db 110
	db 98
	db 1
	db 118
	db 141
	db 255
	db 174
	db 109
	db 199
	db 113
	db 60
	db 176
	db 24
	db 235
	db 71
	db 248
	db 190
	db 243
	db 225
	db 199
	db 193
	db 131
	db 245
	db 7
	db 15
	db 158
	db 252
	db 150
	db 28
	db 175
	db 233
	db 13
	db 31
	db 117
	db 238
	db 74
	db 2
	db 239
	db 38
	db 252
	db 248
	db 87
	db 236
	db 191
	db 252
	db 239
	db 175
	db 86
	db 45
	db 242
	db 181
	db 247
	db 246
	db 2
	db 225
	db 31
	db 160
	db 6
	db 232
	db 183
	db 229
	db 242
	db 0
	db 243
	db 69
	db 4
	db 111
	db 44
	db 251
	db 177
	db 162
	db 125
	db 122
	db 224
	db 167
	db 35
	db 97
	db 80
	db 164
	db 2
	db 116
	db 65
	db 191
	db 110
	db 126
	db 109
	db 127
	db 15
	db 1
	db 97
	db 111
	db 231
	db 15
	db 240
	db 166
	db 30
	db 62
	db 192
	db 252
	db 120
	db 252
	db 192
	db 112
	db 56
	db 156
	db 220
	db 248
	db 126
	db 126
	db 63
	db 31
	db 210
	db 98
	db 141
	db 132
	db 224
	db 255
	db 12
	db 205
	db 244
	db 230
	db 46
	db 213
	db 191
	db 0
	db 162
	db 251
	db 252
	db 126
	db 248
	db 89
	db 231
	db 157
	db 111
	db 220
	db 179
	db 223
	db 165
	db 245
	db 9
	db 121
	db 251
	db 255
	db 254
	db 106
	db 208
	db 150
	db 193
	db 255
	db 30
	db 27
	db 10
	db 213
	db 6
	db 233
	db 255
	db 17
	db 245
	db 158
	db 32
	db 250
	db 147
	db 131
	db 199
	db 59
	db 244
	db 233
	db 235
	db 204
	db 70
	db 239
	db 244
	db 147
	db 127
	db 33
	db 57
	db 80
	db 108
	db 248
	db 104
	db 40
	db 120
	db 41
	db 121
	db 29
	db 241
	db 216
	db 184
	db 137
	db 87
	db 0
	db 224
	db 240
	db 31
	db 208
	db 176
	db 13
	db 191
	db 160
	db 31
	db 96
	db 80
	db 112
	db 255
	db 255
	db 251
	db 120
	db 232
	db 88
	db 168
	db 216
	db 172
	db 223
	db 79
	db 79
	db 32
	db 0
	db 220
	db 254
	db 252
	db 243
	db 121
	db 12
	db 48
	db 62
	db 14
	db 123
	db 4
	db 8
	db 57
	db 235
	db 30
	db 185
	db 53
	db 0
	db 187
	db 113
	db 252
	db 175
	db 239
	db 252
	db 227
	db 194
	db 218
	db 162
	db 7
	db 218
	db 243
	db 4
	db 246
	db 202
	db 156
	db 27
	db 31
	db 118
	db 30
	db 213
	db 6
	db 186
	db 179
	db 65
	db 160
	db 162
	db 169
	db 0
	db 81
	db 7
	db 145
	db 17
	db 252
	db 160
	db 136
	db 16
	db 82
	db 148
	db 162
	db 110
	db 168
	db 81
	db 169
	db 59
	db 171
	db 0
	db 176
	db 196
	db 168
	db 233
	db 6
	db 249
	db 31
	db 248
	db 219
	db 255
	db 216
	db 237
	db 191
	db 141
	db 110
	db 0
	db 239
	db 134
	db 54
	db 227
	db 224
	db 62
	db 80
	db 168
	db 232
	db 126
	db 79
	db 255
	db 0
	db 127
	db 65
	db 93
	db 81
	db 48
	db 129
	db 0
	db 219
	db 159
	db 163
	db 159
	db 239
	db 16
	db 222
	db 226
	db 159
	db 252
	db 247
	db 31
	db 70
	db 152
	db 144
	db 176
	db 224
	db 147
	db 125
	db 230
	db 6
	db 13
	db 59
	db 45
	db 0
	db 171
	db 63
	db 252
	db 93
	db 251
	db 179
	db 205
	db 62
	db 241
	db 231
	db 184
	db 247
	db 215
	db 12
	db 235
	db 185
	db 176
	db 10
	db 230
	db 171
	db 2
	db 46
	db 5
	db 173
	db 6
	db 4
	db 116
	db 7
	db 55
	db 160
	db 255
	db 13
	db 170
	db 170
	db 6
	db 241
	db 0
	db 28
	db 60
	db 61
	db 66
	db 117
	db 69
	db 0
	db 26
	db 77
	db 17
	db 254
	db 130
	db 205
	db 127
	db 253
	db 69
	db 164
	db 229
	db 200
	db 154
	db 131
	db 142
	db 129
	db 196
	db 121
	db 1
	db 112
	db 164
	db 249
	db 255
	db 121
	db 125
	db 63
	db 245
	db 4
	db 2
	db 82
	db 35
	db 38
	db 110
	db 251
	db 225
	db 202
	db 234
	db 176
	db 168
	db 30
	db 255
	db 249
	db 244
	db 236
	db 232
	db 233
	db 236
	db 238
	db 240
	db 126
	db 42
	db 215
	db 225
	db 11
	db 53
	db 110
	db 88
	db 1
	db 119
	db 255
	db 248
	db 239
	db 92
	db 179
	db 207
	db 60
	db 243
	db 218
	db 143
	db 63
	db 97
	db 235
	db 182
	db 27
	db 13
	db 24
	db 255
	db 107
	db 187
	db 11
	db 31
	db 33
	db 148
	db 16
	db 114
	db 255
	db 17
	db 139
	db 253
	db 48
	db 1
	db 146
	db 127
	db 2
	db 136
	db 21
	db 80
	db 69
	db 10
	db 248
	db 148
	db 17
	db 146
	db 18
	db 149
	db 209
	db 147
	db 98
	db 21
	db 129
	db 151
	db 63
	db 252
	db 133
	db 143
	db 138
	db 223
	db 182
	db 119
	db 44
	db 1
	db 192
	db 243
	db 87
	db 151
	db 179
	db 189
	db 23
	db 107
	db 127
	db 45
	db 25
	db 62
	db 31
	db 111
	db 243
	db 253
	db 255
	db 222
	db 14
	db 238
	db 221
	db 59
	db 231
	db 159
	db 63
	db 248
	db 31
	db 135
	db 225
	db 241
	db 253
	db 91
	db 223
	db 239
	db 250
	db 175
	db 186
	db 7
	db 55
	db 121
	db 224
	db 192
	db 236
	db 200
	db 120
	db 48
	db 42
	db 207
	db 220
	db 2
	db 13
	db 30
	db 169
	db 117
	db 43
	db 253
	db 254
	db 3
	db 175
	db 92
	db 179
	db 109
	db 156
	db 99
	db 238
	db 178
	db 245
	db 82
	db 224
	db 124
	db 255
	db 195
	db 45
	db 245
	db 252
	db 127
	db 57
	db 48
	db 98
	db 58
	db 255
	db 218
	db 244
	db 193
	db 192
	db 255
	db 135
	db 194
	db 196
	db 56
	db 251
	db 197
	db 200
	db 18
	db 202
	db 254
	db 28
	db 193
	db 61
	db 201
	db 210
	db 102
	db 0
	db 213
	db 152
	db 254
	db 218
	db 203
	db 220
	db 214
	db 205
	db 219
	db 96
	db 96
	db 207
	db 253
	db 15
	db 61
	db 55
	db 31
	db 29
	db 136
	db 229
	db 0
	db 117
	db 122
	db 93
	db 235
	db 148
	db 239
	db 1
	db 220
	db 34
	db 172
	db 6
	db 142
	db 32
	db 9
	db 63
	db 44
	db 244
	db 63
	db 191
	db 208
	db 3
	db 14
	db 21
	db 190
	db 106
	db 191
	db 247
	db 235
	db 86
	db 185
	db 102
	db 153
	db 178
	db 119
	db 248
	db 131
	db 59
	db 12
	db 247
	db 16
	db 252
	db 30
	db 120
	db 205
	db 253
	db 120
	db 32
	db 126
	db 248
	db 16
	db 0
	db 192
	db 226
	db 128
	db 20
	db 195
	db 136
	db 199
	db 36
	db 72
	db 196
	db 144
	db 84
	db 138
	db 168
	db 250
	db 248
	db 0
	db 172
	db 104
	db 220
	db 216
	db 31
	db 252
	db 212
	db 188
	db 244
	db 110
	db 193
	db 254
	db 220
	db 97
	db 181
	db 88
	db 0
	db 127
	db 128
	db 215
	db 123
	db 3
	db 5
	db 6
	db 83
	db 254
	db 57
	db 212
	db 7
	db 97
	db 113
	db 255
	db 159
	db 250
	db 112
	db 2
	db 67
	db 255
	db 66
	db 153
	db 130
	db 251
	db 34
	db 252
	db 129
	db 162
	db 146
	db 140
	db 66
	db 0
	db 226
	db 68
	db 82
	db 138
	db 162
	db 230
	db 254
	db 210
	db 178
	db 6
	db 114
	db 98
	db 4
	db 242
	db 251
	db 254
	db 208
	db 185
	db 249
	db 112
	db 91
	db 48
	db 211
	db 196
	db 47
	db 195
	db 252
	db 48
	db 215
	db 98
	db 93
	db 255
	db 1
	db 244
	db 244
	db 253
	db 90
	db 241
	db 5
	db 26
	db 253
	db 1
	db 254
	db 94
	db 31
	db 64
	db 253
	db 2
	db 223
	db 5
	db 7
	db 86
	db 3
	db 11
	db 134
	db 125
	db 47
	db 134
	db 215
	db 6
	db 129
	db 255
	db 248
	db 215
	db 102
	db 31
	db 238
	db 128
	db 215
	db 24
	db 28
	db 134
	db 255
	db 248
	db 215
	db 98
	db 18
	db 48
	db 143
	db 144
	db 224
	db 96
	db 111
	db 186
	db 2
	db 128
	db 224
	db 248
	db 187
	db 236
	db 16
	db 239
	db 178
	db 4
	db 12
	db 8
	db 216
	db 9
	db 14
	db 27
	db 239
	db 2
	db 24
	db 62
	db 31
	db 15
	db 89
	db 203
	db 96
	db 93
	db 152
	db 255
	db 31
	db 166
	db 255
	db 1
	db 0
	db 97
	db 115
	db 255
	db 128
	db 192
	db 64
	db 255
	db 217
	db 64
	db 239
	db 12
	db 240
	db 224
	db 120
	db 96
	db 34
	db 71
	db 240
	db 4
	db 58
	db 64
	db 22
	db 228
	db 239
	db 6
	db 210
	db 255
	db 255
	db 154
	db 255
	db 191
	db 31
	db 127
	db 247
	db 192
	db 96
	db 224
	db 152
	db 124
	db 248
	db 246
	db 255
	db 207
	db 191
	db 123
	db 112
	db 119
	db 187
	db 220
	db 103
	db 255
	db 185
	db 92
	db 248
	db 225
	db 135
	db 143
	db 191
	db 252
	db 210
	db 251
	db 247
	db 223
	db 254
	db 8
	db 24
	db 248
	db 240
	db 223
	db 158
	db 7
	db 3
	db 19
	db 30
	db 176
	db 12
	db 51
	db 90
	db 0
	db 14
	db 159
	db 71
	db 255
	db 158
	db 241
	db 252
	db 87
	db 170
	db 85
	db 132
	db 242
	db 238
	db 249
	db 231
	db 31
	db 19
	db 30
	db 135
	db 125
	db 36
	db 253
	db 32
	db 27
	db 49
	db 255
	db 127
	db 191
	db 250
	db 159
	db 15
	db 7
	db 7
	db 255
	db 126
	db 96
	db 104
	db 253
	db 0
	db 223
	db 33
	db 211
	db 239
	db 199
	db 35
	db 26
	db 53
	db 255
	db 106
	db 213
	db 171
	db 255
	db 0
	db 254
	db 130
	db 186
	db 140
	db 138
	db 32
	db 64
	db 52
	db 0
	db 4
	db 63
	db 249
	db 247
	db 8
	db 231
	db 123
	db 71
	db 63
	db 247
	db 248
	db 96
	db 176
	db 16
	db 52
	db 252
	db 0
	db 80
	db 7
	db 255
	db 54
	db 174
	db 243
	db 1
	db 3
	db 6
	db 5
	db 14
	db 14
	db 255
	db 251
	db 30
	db 31
	db 132
	db 255
	db 9
	db 255
	db 255
	db 15
	db 4
	db 0
	db 59
	db 127
	db 207
	db 158
	db 174
	db 56
	db 118
	db 243
	db 112
	db 96
	db 0
	db 7
	db 107
	db 255
	db 1
	db 15
	db 255
	db 127
	db 255
	db 120
	db 124
	db 63
	db 30
	db 12
	db 3
	db 248
	db 14
	db 28
	db 57
	db 59
	db 31
	db 245
	db 126
	db 200
	db 249
	db 224
	db 238
	db 216
	db 206
	db 78
	db 0
	db 255
	db 192
	db 237
	db 255
	db 241
	db 192
	db 240
	db 248
	db 143
	db 255
	db 207
	db 227
	db 135
	db 131
	db 193
	db 248
	db 224
	db 240
	db 121
	db 63
	db 235
	db 204
	db 201
	db 19
	db 209
	db 255
	db 128
	db 214
	db 152
	db 142
	db 82
	db 255
	db 70
	db 210
	db 13
	db 62
	db 241
	db 187
	db 3
	db 97
	db 249
	db 132
	db 0
	db 237
	db 157
	db 82
	db 224
	db 96
	db 160
	db 169
	db 254
	db 139
	db 12
	db 204
	db 229
	db 192
	db 105
	db 64
	db 254
	db 114
	db 255
	db 0
	db 8
	db 209
	db 32
	db 0
	db 98
	db 204
	db 215
	db 4
	db 6
	db 117
	db 213
	db 118
	db 209
	db 139
	db 196
	db 98
	db 167
	db 255
	db 110
	db 86
	db 223
	db 150
	db 255
	db 255
	db 99
	db 255
	db 127
	db 62
	db 143
	db 28
	db 8
	db 44
	db 255
	db 27
	db 125
	db 244
	db 128
	db 253
	db 96
	db 184
	db 84
	db 171
	db 85
	db 170
	db 62
	db 254
	db 235
	db 53
	db 206
	db 51
	db 12
	db 197
	db 189
	db 245
	db 176
	db 244
	db 111
	db 218
	db 214
	db 90
	db 219
	db 23
	db 169
	db 146
	db 252
	db 165
	db 74
	db 8
	db 81
	db 133
	db 16
	db 29
	db 0
	db 145
	db 142
	db 255
	db 0
	db 224
	db 240
	db 142
	db 248
	db 43
	db 192
	db 255
	db 38
	db 255
	db 252
	db 188
	db 113
	db 255
	db 190
	db 158
	db 205
	db 6
	db 143
	db 41
	db 255
	db 135
	db 255
	db 131
	db 74
	db 255
	db 129
	db 52
	db 255
	db 252
	db 0
	db 193
	db 118
	db 16
	db 99
	db 96
	db 24
	db 124
	db 44
	db 176
	db 18
	db 189
	db 217
	db 192
	db 235
	db 160
	db 88
	db 188
	db 41
	db 209
	db 2
	db 213
	db 253
	db 122
	db 157
	db 230
	db 123
	db 28
	db 3
	db 140
	db 63
	db 213
	db 168
	db 247
	db 173
	db 118
	db 170
	db 219
	db 115
	db 0
	db 84
	db 146
	db 252
	db 164
	db 73
	db 21
	db 160
	db 10
	db 32
	db 35
	db 235
	db 36
	db 98
	db 254
	db 160
	db 49
	db 255
	db 3
	db 247
	db 7
	db 15
	db 121
	db 253
	db 132
	db 167
	db 255
	db 151
	db 213
	db 163
	db 201
	db 6
	db 216
	db 4
	db 223
	db 181
	db 71
	db 7
	db 31
	db 171
	db 62
	db 128
	db 4
	db 23
	db 5
	db 112
	db 232
	db 86
	db 161
	db 187
	db 49
	db 252
	db 231
	db 234
	db 213
	db 123
	db 4
	db 121
	db 30
	db 216
	db 7
	db 1
	db 219
	db 208
	db 13
	db 6
	db 244
	db 29
	db 43
	db 90
	db 182
	db 207
	db 139
	db 165
	db 148
	db 197
	db 82
	db 37
	db 243
	db 64
	db 149
	db 0
	db 84
	db 235
	db 73
	db 99
	db 12
	db 208
	db 16
	db 24
	db 121
	db 60
	db 255
	db 143
	db 126
	db 255
	db 28
	db 70
	db 52
	db 255
	db 183
	db 254
	db 58
	db 255
	db 248
	db 100
	db 248
	db 112
	db 242
	db 32
	db 255
	db 198
	db 205
	db 120
	db 178
	db 41
	db 195
	db 159
	db 123
	db 16
	db 64
	db 176
	db 88
	db 238
	db 136
	db 8
	db 252
	db 7
	db 213
	db 59
	db 221
	db 251
	db 230
	db 217
	db 62
	db 15
	db 3
	db 8
	db 157
	db 199
	db 160
	db 181
	db 109
	db 221
	db 217
	db 252
	db 146
	db 84
	db 37
	db 74
	db 168
	db 2
	db 205
	db 2
	db 169
	db 238
	db 146
	db 132
	db 85
	db 106
	db 100
	db 105
	db 153
	db 253
	db 246
	db 143
	db 120
	db 124
	db 30
	db 60
	db 60
	db 62
	db 120
	db 30
	db 239
	db 248
	db 16
	db 175
	db 226
	db 119
	db 37
	db 255
	db 250
	db 1
	db 132
	db 151
	db 24
	db 70
	db 255
	db 89
	db 239
	db 190
	db 88
	db 41
	db 66
	db 115
	db 247
	db 112
	db 188
	db 86
	db 239
	db 26
	db 8
	db 63
	db 4
	db 205
	db 243
	db 220
	db 123
	db 29
	db 3
	db 97
	db 55
	db 252
	db 200
	db 110
	db 213
	db 91
	db 181
	db 226
	db 0
	db 82
	db 74
	db 224
	db 73
	db 146
	db 192
	db 0
	db 27
	db 136
	db 34
	db 14
	db 68
	db 198
	db 146
	db 208
	db 4
	db 255
	db 122
	db 87
	db 31
	db 63
	db 127
	db 227
	db 40
	db 99
	db 255
	db 25
	db 243
	db 247
	db 252
	db 215
	db 189
	db 206
	db 24
	db 29
	db 134
	db 119
	db 98
	db 99
	db 217
	db 41
	db 92
	db 26
	db 250
	db 240
	db 92
	db 186
	db 85
	db 254
	db 35
	db 8
	db 0
	db 159
	db 248
	db 77
	db 243
	db 92
	db 251
	db 29
	db 216
	db 6
	db 1
	db 80
	db 157
	db 250
	db 173
	db 219
	db 182
	db 109
	db 213
	db 239
	db 0
	db 165
	db 154
	db 161
	db 255
	db 42
	db 66
	db 20
	db 81
	db 132
	db 16
	db 2
	db 32
	db 99
	db 155
	db 85
	db 199
	db 64
	db 96
	db 127
	db 21
	db 5
	db 24
	db 141
	db 249
	db 255
	db 161
	db 218
	db 13
	db 209
	db 204
	db 64
	db 130
	db 110
	db 86
	db 41
	db 185
	db 36
	db 88
	db 252
	db 87
	db 12
	db 141
	db 255
	db 251
	db 68
	db 252
	db 248
	db 254
	db 117
	db 155
	db 103
	db 249
	db 86
	db 251
	db 53
	db 188
	db 11
	db 194
	db 135
	db 255
	db 112
	db 104
	db 92
	db 250
	db 117
	db 46
	db 106
	db 91
	db 170
	db 46
	db 0
	db 199
	db 255
	db 73
	db 225
	db 18
	db 162
	db 8
	db 246
	db 0
	db 132
	db 33
	db 16
	db 96
	db 253
	db 104
	db 225
	db 241
	db 243
	db 196
	db 98
	db 5
	db 255
	db 166
	db 17
	db 89
	db 240
	db 228
	db 218
	db 209
	db 44
	db 204
	db 18
	db 114
	db 41
	db 165
	db 245
	db 248
	db 150
	db 84
	db 12
	db 75
	db 254
	db 117
	db 159
	db 67
	db 4
	db 250
	db 31
	db 176
	db 7
	db 219
	db 31
	db 43
	db 161
	db 85
	db 162
	db 164
	db 65
	db 255
	db 34
	db 33
	db 66
	db 18
	db 64
	db 74
	db 0
	db 16
	db 177
	db 132
	db 193
	db 114
	db 255
	db 127
	db 99
	db 40
	db 143
	db 199
	db 199
	db 177
	db 135
	db 244
	db 255
	db 207
	db 112
	db 29
	db 196
	db 248
	db 203
	db 96
	db 141
	db 125
	db 29
	db 120
	db 254
	db 18
	db 16
	db 12
	db 119
	db 19
	db 71
	db 248
	db 55
	db 207
	db 115
	db 153
	db 252
	db 244
	db 245
	db 4
	db 97
	db 171
	db 158
	db 3
	db 6
	db 199
	db 45
	db 10
	db 91
	db 255
	db 174
	db 36
	db 124
	db 255
	db 169
	db 2
	db 72
	db 9
	db 32
	db 75
	db 136
	db 83
	db 230
	db 12
	db 110
	db 246
	db 222
	db 236
	db 252
	db 20
	db 49
	db 0
	db 128
	db 93
	db 249
	db 233
	db 118
	db 255
	db 213
	db 8
	db 221
	db 71
	db 252
	db 189
	db 248
	db 127
	db 183
	db 207
	db 243
	db 0
	db 4
	db 175
	db 63
	db 48
	db 11
	db 217
	db 170
	db 160
	db 250
	db 104
	db 88
	db 117
	db 86
	db 170
	db 127
	db 0
	db 149
	db 169
	db 146
	db 164
	db 10
	db 168
	db 1
	db 141
	db 84
	db 32
	db 183
	db 4
	db 235
	db 84
	db 31
	db 187
	db 248
	db 29
	db 187
	db 252
	db 21
	db 196
	db 0
	db 252
	db 8
	db 112
	db 16
	db 24
	db 32
	db 140
	db 88
	db 248
	db 79
	db 126
	db 52
	db 240
	db 220
	db 254
	db 105
	db 24
	db 253
	db 12
	db 223
	db 9
	db 171
	db 248
	db 127
	db 159
	db 238
	db 231
	db 249
	db 254
	db 88
	db 248
	db 31
	db 119
	db 95
	db 26
	db 245
	db 223
	db 181
	db 183
	db 220
	db 85
	db 219
	db 0
	db 254
	db 82
	db 148
	db 42
	db 80
	db 133
	db 40
	db 130
	db 23
	db 1
	db 16
	db 4
	db 111
	db 150
	db 84
	db 63
	db 118
	db 248
	db 26
	db 98
	db 0
	db 249
	db 4
	db 224
	db 8
	db 48
	db 16
	db 25
	db 44
	db 240
	db 33
	db 118
	db 5
	db 224
	db 240
	db 252
	db 144
	db 21
	db 80
	db 247
	db 108
	db 248
	db 121
	db 4
	db 205
	db 240
	db 63
	db 7
	db 135
	db 93
	db 169
	db 207
	db 240
	db 176
	db 2
	db 182
	db 246
	db 173
	db 195
	db 237
	db 85
	db 159
	db 106
	db 0
	db 74
	db 89
	db 146
	db 37
	db 255
	db 42
	db 160
	db 10
	db 80
	db 130
	db 8
	db 65
	db 16
	db 17
	db 161
	db 224
	db 135
	db 247
	db 249
	db 71
	db 255
	db 223
	db 254
	db 248
	db 224
	db 102
	db 78
	db 249
	db 227
	db 82
	db 2
	db 254
	db 51
	db 5
	db 225
	db 142
	db 182
	db 5
	db 248
	db 252
	db 109
	db 28
	db 181
	db 13
	db 94
	db 13
	db 121
	db 247
	db 222
	db 11
	db 97
	db 227
	db 255
	db 127
	db 91
	db 235
	db 126
	db 107
	db 62
	db 117
	db 0
	db 219
	db 101
	db 255
	db 159
	db 255
	db 148
	db 41
	db 73
	db 146
	db 135
	db 34
	db 16
	db 202
	db 66
	db 136
	db 33
	db 48
	db 227
	db 199
	db 54
	db 252
	db 252
	db 230
	db 255
	db 66
	db 0
	db 127
	db 236
	db 93
	db 215
	db 31
	db 182
	db 67
	db 90
	db 0
	db 134
	db 4
	db 198
	db 8
	db 102
	db 22
	db 195
	db 47
	db 198
	db 26
	db 38
	db 5
	db 219
	db 127
	db 191
	db 18
	db 4
	db 174
	db 1
	db 193
	db 70
	db 64
	db 193
	db 82
	db 2
	db 254
	db 4
	db 140
	db 247
	db 37
	db 14
	db 208
	db 140
	db 41
	db 131
	db 255
	db 10
	db 16
	db 110
	db 15
	db 29
	db 248
	db 69
	db 12
	db 22
	db 7
	db 41
	db 155
	db 19
	db 254
	db 60
	db 6
	db 215
	db 200
	db 13
	db 248
	db 194
	db 191
	db 49
	db 11
	db 188
	db 227
	db 139
	db 216
	db 248
	db 69
	db 184
	db 198
	db 208
	db 120
	db 15
	db 168
	db 108
	db 139
	db 216
	db 84
	db 56
	db 254
	db 164
	db 72
	db 127
	db 148
	db 34
	db 136
	db 82
	db 66
	db 224
	db 8
	db 33
	db 0
	db 176
	db 148
	db 160
	db 255
	db 222
	db 1
	db 120
	db 255
	db 152
	db 252
	db 253
	db 48
	db 237
	db 188
	db 200
	db 1
	db 245
	db 70
	db 238
	db 135
	db 231
	db 249
	db 232
	db 156
	db 28
	db 74
	db 254
	db 248
	db 89
	db 252
	db 254
	db 190
	db 170
	db 215
	db 112
	db 120
	db 152
	db 208
	db 139
	db 255
	db 31
	db 103
	db 181
	db 121
	db 49
	db 231
	db 255
	db 45
	db 11
	db 248
	db 69
	db 68
	db 32
	db 80
	db 168
	db 156
	db 169
	db 212
	db 170
	db 33
	db 162
	db 84
	db 66
	db 208
	db 2
	db 184
	db 72
	db 36
	db 240
	db 214
	db 128
	db 127
	db 126
	db 3
	db 125
	db 247
	db 255
	db 107
	db 190
	db 39
	db 221
	db 91
	db 246
	db 139
	db 173
	db 182
	db 215
	db 106
	db 85
	db 5
	db 255
	db 255
	db 41
	db 162
	db 138
	db 40
	db 66
	db 20
	db 65
	db 8
	db 116
	db 216
	db 255
	db 69
	db 214
	db 254
	db 158
	db 116
	db 101
	db 245
	db 254
	db 112
	db 84
	db 102
	db 103
	db 94
	db 235
	db 220
	db 179
	db 252
	db 45
	db 255
	db 140
	db 2
	db 152
	db 5
	db 252
	db 159
	db 181
	db 0
	db 42
	db 250
	db 15
	db 171
	db 168
	db 17
	db 123
	db 255
	db 252
	db 243
	db 207
	db 63
	db 203
	db 247
	db 140
	db 181
	db 122
	db 155
	db 240
	db 84
	db 138
	db 227
	db 11
	db 234
	db 253
	db 181
	db 250
	db 239
	db 221
	db 255
	db 247
	db 22
	db 113
	db 134
	db 209
	db 236
	db 214
	db 125
	db 42
	db 209
	db 217
	db 104
	db 197
	db 223
	db 251
	db 255
	db 235
	db 191
	db 118
	db 219
	db 187
	db 214
	db 189
	db 107
	db 140
	db 90
	db 159
	db 206
	db 42
	db 210
	db 21
	db 164
	db 74
	db 250
	db 144
	db 69
	db 8
	db 33
	db 68
	db 155
	db 255
	db 8
	db 143
	db 255
	db 140
	db 34
	db 227
	db 113
	db 24
	db 217
	db 255
	db 226
	db 223
	db 215
	db 204
	db 64
	db 75
	db 241
	db 188
	db 25
	db 254
	db 3
	db 204
	db 242
	db 123
	db 236
	db 251
	db 255
	db 236
	db 252
	db 240
	db 192
	db 107
	db 190
	db 107
	db 10
	db 21
	db 42
	db 23
	db 55
	db 85
	db 46
	db 93
	db 231
	db 183
	db 111
	db 191
	db 254
	db 127
	db 63
	db 254
	db 95
	db 55
	db 31
	db 15
	db 7
	db 2
	db 1
	db 196
	db 39
	db 65
	db 241
	db 255
	db 209
	db 250
	db 219
	db 123
	db 235
	db 189
	db 237
	db 182
	db 131
	db 109
	db 181
	db 112
	db 0
	db 88
	db 36
	db 127
	db 20
	db 162
	db 40
	db 133
	db 16
	db 197
	db 66
	db 4
	db 216
	db 32
	db 2
	db 250
	db 3
	db 2
	db 235
	db 12
	db 253
	db 235
	db 136
	db 250
	db 198
	db 207
	db 255
	db 62
	db 223
	db 204
	db 66
	db 149
	db 172
	db 49
	db 110
	db 4
	db 179
	db 4
	db 243
	db 177
	db 248
	db 139
	db 22
	db 14
	db 200
	db 35
	db 255
	db 251
	db 254
	db 249
	db 231
	db 159
	db 104
	db 233
	db 175
	db 252
	db 176
	db 252
	db 180
	db 255
	db 141
	db 202
	db 102
	db 76
	db 244
	db 246
	db 238
	db 47
	db 223
	db 246
	db 191
	db 247
	db 255
	db 190
	db 235
	db 222
	db 181
	db 239
	db 90
	db 214
	db 173
	db 112
	db 0
	db 79
	db 41
	db 69
	db 168
	db 5
	db 253
	db 40
	db 66
	db 8
	db 145
	db 0
	db 9
	db 132
	db 148
	db 83
	db 191
	db 254
	db 140
	db 114
	db 209
	db 255
	db 91
	db 216
	db 124
	db 56
	db 242
	db 199
	db 204
	db 185
	db 4
	db 141
	db 91
	db 250
	db 1
	db 142
	db 29
	db 217
	db 246
	db 251
	db 47
	db 246
	db 252
	db 63
	db 214
	db 245
	db 123
	db 178
	db 1
	db 161
	db 3
	db 160
	db 72
	db 27
	db 80
	db 132
	db 24
	db 255
	db 252
	db 161
	db 97
	db 163
	db 7
	db 15
	db 54
	db 255
	db 255
	db 237
	db 191
	db 117
	db 222
	db 123
	db 214
	db 93
	db 235
	db 220
	db 90
	db 181
	db 0
	db 253
	db 169
	db 165
	db 137
	db 82
	db 21
	db 160
	db 122
	db 255
	db 8
	db 194
	db 13
	db 215
	db 255
	db 32
	db 40
	db 30
	db 126
	db 121
	db 186
	db 18
	db 203
	db 47
	db 255
	db 128
	db 237
	db 205
	db 37
	db 238
	db 222
	db 120
	db 219
	db 227
	db 100
	db 222
	db 171
	db 207
	db 151
	db 0
	db 15
	db 24
	db 252
	db 68
	db 73
	db 247
	db 7
	db 31
	db 63
	db 255
	db 37
	db 150
	db 119
	db 253
	db 186
	db 248
	db 124
	db 186
	db 243
	db 236
	db 88
	db 0
	db 126
	db 83
	db 237
	db 249
	db 169
	db 20
	db 111
	db 240
	db 117
	db 219
	db 235
	db 253
	db 254
	db 251
	db 135
	db 239
	db 72
	db 233
	db 190
	db 255
	db 20
	db 0
	db 11
	db 31
	db 55
	db 157
	db 27
	db 173
	db 247
	db 187
	db 214
	db 181
	db 109
	db 49
	db 0
	db 164
	db 42
	db 191
	db 41
	db 66
	db 20
	db 160
	db 10
	db 64
	db 188
	db 17
	db 0
	db 194
	db 25
	db 46
	db 251
	db 142
	db 187
	db 35
	db 28
	db 60
	db 255
	db 222
	db 206
	db 145
	db 255
	db 0
	db 189
	db 204
	db 254
	db 140
	db 97
	db 63
	db 242
	db 68
	db 7
	db 29
	db 16
	db 222
	db 207
	db 4
	db 53
	db 248
	db 250
	db 252
	db 88
	db 248
	db 240
	db 75
	db 236
	db 249
	db 5
	db 2
	db 105
	db 11
	db 254
	db 248
	db 22
	db 13
	db 23
	db 15
	db 7
	db 3
	db 63
	db 31
	db 112
	db 34
	db 99
	db 195
	db 97
	db 101
	db 241
	db 163
	db 98
	db 161
	db 210
	db 19
	db 0
	db 169
	db 74
	db 15
	db 36
	db 73
	db 145
	db 21
	db 1
	db 174
	db 4
	db 48
	db 0
	db 138
	db 191
	db 254
	db 131
	db 135
	db 199
	db 207
	db 143
	db 102
	db 205
	db 16
	db 125
	db 107
	db 159
	db 32
	db 255
	db 25
	db 210
	db 255
	db 164
	db 24
	db 254
	db 31
	db 177
	db 252
	db 255
	db 179
	db 0
	db 247
	db 230
	db 55
	db 186
	db 127
	db 151
	db 8
	db 93
	db 77
	db 4
	db 239
	db 248
	db 118
	db 249
	db 103
	db 159
	db 77
	db 248
	db 254
	db 120
	db 133
	db 157
	db 245
	db 1
	db 127
	db 112
	db 136
	db 140
	db 255
	db 220
	db 216
	db 248
	db 92
	db 250
	db 86
	db 124
	db 234
	db 195
	db 175
	db 122
	db 95
	db 0
	db 119
	db 240
	db 254
	db 37
	db 73
	db 113
	db 128
	db 42
	db 184
	db 17
	db 68
	db 0
	db 172
	db 52
	db 147
	db 254
	db 31
	db 163
	db 255
	db 15
	db 207
	db 255
	db 209
	db 225
	db 4
	db 188
	db 87
	db 0
	db 243
	db 248
	db 95
	db 246
	db 252
	db 87
	db 252
	db 112
	db 59
	db 215
	db 245
	db 245
	db 114
	db 173
	db 174
	db 170
	db 239
	db 79
	db 251
	db 237
	db 249
	db 189
	db 247
	db 111
	db 250
	db 221
	db 123
	db 214
	db 91
	db 219
	db 238
	db 0
	db 171
	db 84
	db 38
	db 42
	db 73
	db 55
	db 80
	db 66
	db 20
	db 27
	db 136
	db 32
	db 216
	db 1
	db 68
	db 124
	db 89
	db 143
	db 4
	db 14
	db 241
	db 30
	db 62
	db 127
	db 126
	db 75
	db 255
	db 168
	db 253
	db 188
	db 94
	db 195
	db 201
	db 59
	db 6
	db 175
	db 183
	db 235
	db 188
	db 125
	db 87
	db 225
	db 21
	db 155
	db 246
	db 193
	db 0
	db 59
	db 2
	db 115
	db 207
	db 53
	db 190
	db 252
	db 198
	db 78
	db 151
	db 179
	db 94
	db 93
	db 191
	db 92
	db 120
	db 193
	db 247
	db 223
	db 190
	db 111
	db 253
	db 119
	db 221
	db 96
	db 254
	db 181
	db 255
	db 170
	db 109
	db 85
	db 90
	db 82
	db 173
	db 169
	db 255
	db 165
	db 73
	db 149
	db 84
	db 129
	db 42
	db 64
	db 8
	db 236
	db 34
	db 0
	db 68
	db 17
	db 104
	db 2
	db 243
	db 255
	db 128
	db 146
	db 27
	db 208
	db 24
	db 13
	db 203
	db 0
	db 71
	db 248
	db 190
	db 243
	db 225
	db 199
	db 193
	db 131
	db 241
	db 7
	db 15
	db 158
	db 252
	db 246
	db 240
	db 224
	db 175
	db 233
	db 13
	db 31
	db 117
	db 238
	db 74
	db 2
	db 239
	db 38
	db 252
	db 248
	db 87
	db 236
	db 191
	db 252
	db 239
	db 236
	db 86
	db 248
	db 96
	db 111
	db 234
	db 147
	db 141
	db 73
	db 61
	db 251
	db 189
	db 15
	db 251
	db 127
	db 240
	db 247
	db 223
	db 125
	db 215
	db 33
	db 213
	db 245
	db 181
	db 109
	db 219
	db 168
	db 2
	db 170
	db 254
	db 146
	db 42
	db 162
	db 20
	db 55
	db 10
	db 32
	db 69
	db 171
	db 16
	db 176
	db 255
	db 245
	db 255
	db 32
	db 31
	db 112
	db 120
	db 226
	db 124
	db 254
	db 126
	db 151
	db 255
	db 79
	db 253
	db 15
	db 1
	db 97
	db 183
	db 254
	db 7
	db 112
	db 56
	db 156
	db 220
	db 248
	db 62
	db 126
	db 63
	db 176
	db 60
	db 176
	db 189
	db 252
	db 35
	db 140
	db 247
	db 51
	db 125
	db 230
	db 46
	db 213
	db 191
	db 40
	db 0
	db 251
	db 252
	db 159
	db 248
	db 89
	db 231
	db 157
	db 111
	db 220
	db 177
	db 176
	db 142
	db 171
	db 245
	db 180
	db 110
	db 237
	db 253
	db 253
	db 71
	db 183
	db 175
	db 251
	db 254
	db 223
	db 125
	db 235
	db 190
	db 106
	db 183
	db 109
	db 172
	db 255
	db 159
	db 0
	db 74
	db 169
	db 36
	db 69
	db 40
	db 39
	db 2
	db 3
	db 18
	db 128
	db 97
	db 173
	db 88
	db 6
	db 197
	db 88
	db 0
	db 250
	db 255
	db 112
	db 140
	db 255
	db 199
	db 238
	db 220
	db 254
	db 243
	db 216
	db 121
	db 12
	db 75
	db 205
	db 235
	db 30
	db 53
	db 203
	db 0
	db 187
	db 141
	db 252
	db 126
	db 252
	db 182
	db 238
	db 197
	db 247
	db 71
	db 31
	db 29
	db 120
	db 0
	db 82
	db 3
	db 22
	db 250
	db 87
	db 6
	db 182
	db 219
	db 60
	db 117
	db 37
	db 228
	db 255
	db 0
	db 255
	db 82
	db 164
	db 21
	db 81
	db 138
	db 17
	db 68
	db 136
	db 236
	db 34
	db 0
	db 36
	db 43
	db 171
	db 6
	db 62
	db 172
	db 3
	db 82
	db 172
	db 0
	db 114
	db 60
	db 116
	db 65
	db 93
	db 81
	db 97
	db 2
	db 97
	db 214
	db 250
	db 230
	db 6
	db 13
	db 59
	db 90
	db 0
	db 171
	db 127
	db 252
	db 93
	db 179
	db 215
	db 205
	db 62
	db 89
	db 215
	db 230
	db 255
	db 195
	db 106
	db 85
	db 239
	db 48
	db 253
	db 109
	db 127
	db 119
	db 221
	db 187
	db 238
	db 170
	db 127
	db 238
	db 213
	db 91
	db 106
	db 124
	db 0
	db 45
	db 80
	db 165
	db 9
	db 84
	db 234
	db 0
	db 16
	db 66
	db 108
	db 255
	db 114
	db 170
	db 8
	db 189
	db 6
	db 225
	db 227
	db 195
	db 153
	db 90
	db 23
	db 129
	db 248
	db 165
	db 140
	db 193
	db 237
	db 219
	db 119
	db 99
	db 75
	db 129
	db 177
	db 255
	db 40
	db 177
	db 40
	db 21
	db 216
	db 44
	db 1
	db 33
	db 107
	db 225
	db 11
	db 53
	db 239
	db 110
	db 213
	db 170
	db 255
	db 248
	db 239
	db 92
	db 179
	db 217
	db 207
	db 60
	db 219
	db 133
	db 111
	db 95
	db 104
	db 191
	db 254
	db 251
	db 255
	db 198
	db 239
	db 123
	db 240
	db 189
	db 119
	db 238
	db 173
	db 162
	db 214
	db 191
	db 255
	db 0
	db 149
	db 169
	db 82
	db 10
	db 81
	db 240
	db 138
	db 33
	db 164
	db 0
	db 172
	db 32
	db 107
	db 47
	db 196
	db 254
	db 46
	db 223
	db 143
	db 206
	db 205
	db 6
	db 143
	db 25
	db 234
	db 225
	db 236
	db 239
	db 223
	db 49
	db 210
	db 205
	db 122
	db 101
	db 24
	db 62
	db 31
	db 15
	db 195
	db 112
	db 4
	db 136
	db 122
	db 56
	db 2
	db 13
	db 30
	db 117
	db 146
	db 253
	db 207
	db 45
	db 175
	db 92
	db 179
	db 217
	db 109
	db 156
	db 219
	db 238
	db 92
	db 106
	db 118
	db 241
	db 252
	db 238
	db 127
	db 63
	db 237
	db 95
	db 251
	db 111
	db 186
	db 247
	db 247
	db 173
	db 109
	db 218
	db 182
	db 48
	db 0
	db 84
	db 34
	db 191
	db 149
	db 160
	db 10
	db 80
	db 2
	db 8
	db 141
	db 33
	db 64
	db 97
	db 54
	db 88
	db 8
	db 47
	db 229
	db 0
	db 135
	db 26
	db 202
	db 247
	db 14
	db 21
	db 106
	db 213
	db 99
	db 41
	db 235
	db 86
	db 236
	db 185
	db 102
	db 152
	db 190
	db 71
	db 164
	db 224
	db 43
	db 2
	db 225
	db 2
	db 227
	db 123
	db 223
	db 7
	db 93
	db 255
	db 251
	db 86
	db 253
	db 171
	db 182
	db 109
	db 213
	db 149
	db 227
	db 106
	db 74
	db 85
	db 255
	db 146
	db 84
	db 66
	db 20
	db 33
	db 68
	db 17
	db 133
	db 0
	db 8
	db 98
	db 188
	db 195
	db 91
	db 126
	db 191
	db 143
	db 10
	db 195
	db 172
	db 41
	db 116
	db 255
	db 207
	db 171
	db 0
	db 6
	db 3
	db 13
	db 63
	db 0
	db 215
	db 246
	db 3
	db 5
	db 6
	db 166
	db 254
	db 113
	db 212
	db 218
	db 184
	db 74
	db 252
	db 5
	db 72
	db 254
	db 2
	db 226
	db 34
	db 6
	db 97
	db 252
	db 1
	db 145
	db 255
	db 9
	db 251
	db 25
	db 24
	db 6
	db 43
	db 133
	db 43
	db 129
	db 42
	db 218
	db 71
	db 98
	db 253
	db 249
	db 30
	db 240
	db 194
	db 51
	db 255
	db 141
	db 216
	db 12
	db 107
	db 24
	db 12
	db 0
	db 252
	db 48
	db 215
	db 86
	db 70
	db 152
	db 7
	db 97
	db 58
	db 255
	db 7
	db 59
	db 234
	db 3
	db 193
	db 87
	db 255
	db 15
	db 240
	db 254
	db 255
	db 30
	db 62
	db 216
	db 252
	db 120
	db 190
	db 24
	db 215
	db 24
	db 12
	db 255
	db 224
	db 240
	db 124
	db 208
	db 176
	db 54
	db 254
	db 31
	db 180
	db 96
	db 192
	db 215
	db 127
	db 120
	db 232
	db 88
	db 168
	db 216
	db 173
	db 172
	db 237
	db 162
	db 240
	db 32
	db 49
	db 215
	db 48
	db 199
	db 62
	db 14
	db 92
	db 157
	db 96
	db 103
	db 157
	db 255
	db 206
	db 146
	db 247
	db 227
	db 224
	db 63
	db 80
	db 168
	db 84
	db 92
	db 51
	db 183
	db 255
	db 195
	db 215
	db 75
	db 128
	db 58
	db 63
	db 159
	db 239
	db 16
	db 235
	db 222
	db 226
	db 252
	db 59
	db 194
	db 6
	db 8
	db 3
	db 68
	db 2
	db 173
	db 232
	db 249
	db 72
	db 255
	db 121
	db 250
	db 63
	db 245
	db 8
	db 2
	db 107
	db 18
	db 231
	db 1
	db 215
	db 225
	db 225
	db 254
	db 178
	db 88
	db 255
	db 254
	db 253
	db 247
	db 249
	db 112
	db 157
	db 80
	db 236
	db 126
	db 13
	db 19
	db 0
	db 191
	db 27
	db 189
	db 191
	db 248
	db 131
	db 139
	db 255
	db 25
	db 62
	db 31
	db 111
	db 243
	db 253
	db 222
	db 255
	db 14
	db 238
	db 221
	db 59
	db 231
	db 159
	db 63
	db 31
	db 240
	db 135
	db 225
	db 241
	db 253
	db 183
	db 223
	db 239
	db 1
	db 222
	db 93
	db 7
	db 27
	db 121
	db 224
	db 246
	db 192
	db 200
	db 120
	db 48
	db 6
	db 105
	db 0
	db 100
	db 141
	db 102
	db 93
	db 203
	db 227
	db 244
	db 185
	db 34
	db 6
	db 80
	db 247
	db 28
	db 16
	db 238
	db 2
	db 219
	db 163
	db 2
	db 168
	db 49
	db 192
	db 32
imgScreen:
	db 255
	db 56
	db 255
	db 31
	db 239
	db 246
	db 111
	db 75
	db 255
	db 239
	db 255
	db 96
	db 118
	db 168
	db 255
	db 0
	db 253
	db 38
	db 224
	db 16
	db 224
	db 255
	db 64
	db 22
	db 255
	db 52
	db 213
	db 216
	db 1
	db 0
	db 22
	db 200
	db 255
	db 1
	db 236
	db 113
	db 0
	db 68
	db 185
	db 69
	db 255
	db 56
	db 108
	db 0
	db 199
	db 7
	db 3
	db 178
	db 227
	db 155
	db 255
	db 243
	db 251
	db 67
	db 213
	db 2
	db 228
	db 255
	db 152
	db 65
	db 15
	db 247
	db 246
	db 55
	db 74
	db 255
	db 247
	db 201
	db 76
	db 0
	db 81
	db 255
	db 223
	db 219
	db 253
	db 78
	db 24
	db 0
	db 159
	db 152
	db 248
	db 251
	db 0
	db 224
	db 252
	db 251
	db 254
	db 255
	db 63
	db 207
	db 246
	db 2
	db 92
	db 0
	db 3
	db 48
	db 62
	db 202
	db 250
	db 0
	db 246
	db 3
	db 247
	db 20
	db 61
	db 228
	db 187
	db 0
	db 128
	db 192
	db 97
	db 129
	db 0
	db 57
	db 223
	db 63
	db 193
	db 254
	db 251
	db 96
	db 89
	db 23
	db 0
	db 166
	db 3
	db 125
	db 253
	db 68
	db 201
	db 251
	db 8
	db 12
	db 216
	db 0
	db 224
	db 31
	db 108
	db 10
	db 244
	db 0
	db 224
	db 217
	db 253
	db 240
	db 38
	db 255
	db 28
	db 51
	db 0
	db 7
	db 63
	db 222
	db 252
	db 236
	db 227
	db 159
	db 127
	db 10
	db 115
	db 0
	db 11
	db 204
	db 255
	db 127
	db 121
	db 154
	db 3
	db 7
	db 255
	db 17
	db 129
	db 84
	db 0
	db 97
	db 62
	db 88
	db 0
	db 24
	db 91
	db 0
	db 94
	db 36
	db 178
	db 248
	db 76
	db 255
	db 174
	db 217
	db 0
	db 248
	db 25
	db 0
	db 96
	db 106
	db 152
	db 0
	db 230
	db 122
	db 0
	db 67
	db 65
	db 121
	db 221
	db 253
	db 120
	db 179
	db 216
	db 15
	db 7
	db 30
	db 199
	db 202
	db 109
	db 255
	db 231
	db 247
	db 157
	db 0
	db 248
	db 8
	db 232
	db 158
	db 255
	db 96
	db 80
	db 44
	db 236
	db 240
	db 121
	db 0
	db 158
	db 200
	db 161
	db 33
	db 255
	db 129
	db 48
	db 131
	db 32
	db 0
	db 49
	db 19
	db 231
	db 2
	db 132
	db 236
	db 199
	db 158
	db 0
	db 232
	db 8
	db 9
	db 206
	db 48
	db 129
	db 50
	db 22
	db 0
	db 128
	db 7
	db 99
	db 0
	db 131
	db 130
	db 227
	db 242
	db 139
	db 138
	db 219
	db 243
	db 22
	db 0
	db 24
	db 58
	db 179
	db 0
	db 8
	db 239
	db 103
	db 152
	db 255
	db 19
	db 198
	db 236
	db 83
	db 0
	db 57
	db 189
	db 31
	db 141
	db 253
	db 18
	db 143
	db 227
	db 245
	db 28
	db 203
	db 0
	db 3
	db 87
	db 251
	db 0
	db 159
	db 223
	db 150
	db 255
	db 195
	db 48
	db 28
	db 96
	db 110
	db 175
	db 0
	db 15
	db 89
	db 253
	db 12
	db 45
	db 227
	db 127
	db 191
	db 152
	db 255
	db 121
	db 235
	db 129
	db 175
	db 239
	db 0
	db 28
	db 207
	db 238
	db 126
	db 70
	db 253
	db 103
	db 236
	db 207
	db 1
	db 147
	db 255
	db 3
	db 115
	db 248
	db 0
	db 159
	db 216
	db 28
	db 189
	db 188
	db 191
	db 179
	db 253
	db 185
	db 0
	db 145
	db 227
	db 81
	db 18
	db 28
	db 8
	db 19
	db 110
	db 99
	db 0
	db 31
	db 15
	db 217
	db 143
	db 77
	db 255
	db 207
	db 239
	db 129
	db 138
	db 0
	db 92
	db 18
	db 184
	db 247
	db 255
	db 206
	db 110
	db 0
	db 251
	db 20
	db 89
	db 255
	db 227
	db 57
	db 0
	db 96
	db 103
	db 250
	db 0
	db 15
	db 196
	db 77
	db 231
	db 219
	db 0
	db 59
	db 69
	db 150
	db 255
	db 56
	db 6
	db 214
	db 3
	db 0
	db 99
	db 89
	db 0
	db 189
	db 17
	db 255
	db 31
	db 108
	db 8
	db 193
	db 252
	db 254
	db 96
	db 115
	db 149
	db 0
	db 236
	db 22
	db 192
	db 149
	db 255
	db 255
	db 129
	db 167
	db 182
	db 0
	db 40
	db 71
	db 96
	db 117
	db 229
	db 0
	db 139
	db 214
	db 254
	db 127
	db 204
	db 48
	db 255
	db 59
	db 137
	db 0
	db 232
	db 3
	db 100
	db 152
	db 255
	db 29
	db 254
	db 0
	db 127
	db 35
	db 0
	db 16
	db 227
	db 32
	db 192
	db 22
	db 251
	db 220
	db 0
	db 217
	db 63
	db 31
	db 141
	db 255
	db 159
	db 223
	db 129
	db 187
	db 188
	db 0
	db 121
	db 5
	db 122
	db 61
	db 203
	db 255
	db 3
	db 223
	db 88
	db 0
	db 62
	db 161
	db 238
	db 48
	db 253
	db 54
	db 177
	db 0
	db 248
	db 99
	db 76
	db 0
	db 7
	db 8
	db 24
	db 1
	db 66
	db 4
	db 217
	db 8
	db 248
	db 88
	db 255
	db 96
	db 106
	db 78
	db 0
	db 1
	db 6
	db 191
	db 131
	db 108
	db 253
	db 129
	db 197
	db 207
	db 128
	db 146
	db 255
	db 96
	db 110
	db 203
	db 0
	db 51
	db 155
	db 209
	db 219
	db 251
	db 255
	db 140
	db 152
	db 27
	db 27
	db 146
	db 0
	db 243
	db 112
	db 63
	db 187
	db 248
	db 253
	db 251
	db 96
	db 123
	db 194
	db 0
	db 192
	db 6
	db 239
	db 225
	db 140
	db 253
	db 150
	db 227
	db 1
	db 254
	db 61
	db 6
	db 146
	db 255
	db 176
	db 254
	db 55
	db 29
	db 0
	db 193
	db 252
	db 222
	db 44
	db 255
	db 199
	db 238
	db 99
	db 0
	db 192
	db 32
	db 138
	db 19
	db 205
	db 255
	db 45
	db 237
	db 63
	db 102
	db 172
	db 255
	db 191
	db 12
	db 111
	db 99
	db 0
	db 121
	db 125
	db 229
	db 13
	db 253
	db 252
	db 156
	db 0
	db 199
	db 35
	db 34
	db 75
	db 253
	db 250
	db 39
	db 86
	db 0
	db 254
	db 81
	db 255
	db 129
	db 145
	db 251
	db 0
	db 254
	db 20
	db 214
	db 0
	db 124
	db 2
	db 62
	db 62
	db 66
	db 88
	db 255
	db 27
	db 88
	db 0
	db 1
	db 133
	db 49
	db 0
	db 236
	db 240
	db 248
	db 252
	db 85
	db 0
	db 31
	db 216
	db 40
	db 47
	db 129
	db 255
	db 129
	db 60
	db 236
	db 216
	db 32
	db 63
	db 233
	db 0
	db 146
	db 255
	db 99
	db 123
	db 0
	db 96
	db 87
	db 152
	db 255
	db 249
	db 40
	db 159
	db 214
	db 238
	db 15
	db 107
	db 0
	db 224
	db 60
	db 255
	db 209
	db 232
	db 128
	db 29
	db 158
	db 231
	db 199
	db 240
	db 248
	db 20
	db 9
	db 64
	db 255
	db 198
	db 76
	db 254
	db 66
	db 250
	db 246
	db 194
	db 22
	db 0
	db 3
	db 253
	db 61
	db 13
	db 146
	db 255
	db 176
	db 253
	db 191
	db 44
	db 0
	db 120
	db 66
	db 171
	db 202
	db 63
	db 246
	db 207
	db 246
	db 216
	db 168
	db 26
	db 187
	db 254
	db 248
	db 56
	db 8
	db 70
	db 183
	db 64
	db 128
	db 241
	db 254
	db 9
	db 241
	db 198
	db 79
	db 108
	db 252
	db 253
	db 124
	db 60
	db 24
	db 16
	db 136
	db 49
	db 147
	db 1
	db 3
	db 197
	db 115
	db 248
	db 6
	db 15
	db 25
	db 132
	db 159
	db 0
	db 103
	db 249
	db 22
	db 134
	db 25
	db 0
	db 99
	db 237
	db 158
	db 63
	db 193
	db 195
	db 193
	db 252
	db 253
	db 97
	db 72
	db 252
	db 38
	db 205
	db 244
	db 63
	db 1
	db 171
	db 183
	db 8
	db 21
	db 233
	db 10
	db 5
	db 2
	db 243
	db 4
	db 241
	db 14
	db 206
	db 223
	db 31
	db 2
	db 110
	db 159
	db 142
	db 64
	db 178
	db 92
	db 44
	db 224
	db 1
	db 186
	db 240
	db 216
	db 168
	db 248
	db 210
	db 246
	db 112
	db 166
	db 232
	db 30
	db 30
	db 0
	db 234
	db 105
	db 91
	db 4
	db 224
	db 29
	db 203
	db 0
	db 31
	db 97
	db 158
	db 224
	db 31
	db 176
	db 225
	db 255
	db 224
	db 106
	db 184
	db 198
	db 132
	db 66
	db 180
	db 64
	db 242
	db 10
	db 152
	db 77
	db 172
	db 148
	db 159
	db 16
	db 122
	db 29
	db 220
	db 127
	db 63
	db 15
	db 58
	db 122
	db 218
	db 170
	db 28
	db 88
	db 250
	db 246
	db 117
	db 9
	db 10
	db 0
	db 248
	db 27
	db 3
	db 253
	db 251
	db 39
	db 86
	db 0
	db 252
	db 118
	db 88
	db 0
	db 251
	db 0
	db 7
	db 63
	db 63
	db 222
	db 252
	db 227
	db 159
	db 127
	db 223
	db 141
	db 171
	db 173
	db 97
	db 72
	db 252
	db 38
	db 233
	db 244
	db 252
	db 125
	db 67
	db 11
	db 254
	db 65
	db 253
	db 170
	db 85
	db 42
	db 132
	db 224
	db 240
	db 174
	db 129
	db 125
	db 174
	db 248
	db 177
	db 25
	db 195
	db 134
	db 15
	db 220
	db 0
	db 128
	db 188
	db 162
	db 119
	db 25
	db 253
	db 38
	db 0
	db 24
	db 245
	db 0
	db 118
	db 108
	db 7
	db 68
	db 255
	db 97
	db 219
	db 89
	db 1
	db 4
	db 127
	db 81
	db 122
	db 185
	db 162
	db 255
	db 1
	db 59
	db 250
	db 234
	db 193
	db 116
	db 0
	db 38
	db 15
	db 8
	db 243
	db 255
	db 39
	db 44
	db 0
	db 13
	db 29
	db 35
	db 0
	db 44
	db 43
	db 204
	db 43
	db 48
	db 205
	db 0
	db 128
	db 129
	db 112
	db 1
	db 176
	db 128
	db 66
	db 201
	db 0
	db 212
	db 96
	db 90
	db 152
	db 255
	db 185
	db 28
	db 128
	db 64
	db 0
	db 115
	db 255
	db 192
	db 64
	db 100
	db 12
	db 255
	db 242
	db 224
	db 86
	db 48
	db 255
	db 176
	db 128
	db 45
	db 150
	db 255
	db 0
	db 52
	db 255
	db 165
	db 255
	db 11
	db 16
	db 192
	db 255
	db 158
	db 242
	db 98
	db 236
	db 216
	db 254
	db 1
	db 6
	db 5
	db 178
	db 255
	db 1
	db 199
	db 91
	db 0
	db 68
	db 69
	db 150
	db 255
	db 56
	db 44
	db 0
	db 129
	db 224
	db 248
	db 121
	db 230
	db 129
	db 124
	db 255
	db 217
	db 224
	db 32
	db 3
	db 255
	db 242
	db 240
	db 100
	db 38
	db 0
	db 81
	db 255
	db 223
	db 108
	db 253
	db 78
	db 182
	db 0
	db 120
	db 204
	db 152
	db 255
	db 248
	db 192
	db 224
	db 56
	db 236
	db 51
	db 9
	db 155
	db 0
	db 192
	db 240
	db 2
	db 101
	db 0
	db 255
	db 98
	db 100
	db 242
	db 248
	db 94
	db 3
	db 199
	db 247
	db 20
	db 178
	db 228
	db 86
	db 234
	db 64
	db 82
	db 255
	db 63
	db 194
	db 103
	db 0
	db 192
	db 254
	db 255
	db 29
	db 129
	db 100
	db 0
	db 94
	db 3
	db 155
	db 125
	db 253
	db 68
	db 117
	db 234
	db 1
	db 156
	db 255
	db 176
	db 0
	db 145
	db 0
	db 31
	db 176
	db 255
	db 44
	db 24
	db 0
	db 32
	db 39
	db 204
	db 165
	db 255
	db 31
	db 141
	db 24
	db 194
	db 251
	db 255
	db 3
	db 31
	db 176
	db 127
	db 42
	db 12
	db 0
	db 47
	db 48
	db 194
	db 47
	db 140
	db 255
	db 243
	db 0
	db 18
	db 203
	db 0
	db 3
	db 97
	db 0
	db 16
	db 140
	db 19
	db 202
	db 89
	db 255
	db 15
	db 11
	db 40
	db 248
	db 39
	db 44
	db 0
	db 13
	db 99
	db 0
	db 26
	db 117
	db 40
	db 67
	db 65
	db 121
	db 187
	db 253
	db 120
	db 22
	db 64
	db 26
	db 192
	db 177
	db 240
	db 149
	db 0
	db 224
	db 129
	db 62
	db 236
	db 177
	db 240
	db 231
	db 0
	db 158
	db 161
	db 33
	db 34
	db 255
	db 4
	db 203
	db 104
	db 0
	db 240
	db 24
	db 255
	db 28
	db 128
	db 123
	db 248
	db 30
	db 205
	db 0
	db 255
	db 129
	db 62
	db 236
	db 25
	db 143
	db 60
	db 0
	db 232
	db 8
	db 9
	db 206
	db 97
	db 2
	db 100
	db 140
	db 190
	db 8
	db 129
	db 161
	db 253
	db 251
	db 255
	db 75
	db 248
	db 127
	db 3
	db 121
	db 0
	db 131
	db 241
	db 130
	db 242
	db 139
	db 138
	db 237
	db 243
	db 214
	db 190
	db 2
	db 114
	db 255
	db 1
	db 221
	db 164
	db 8
	db 103
	db 172
	db 255
	db 239
	db 9
	db 227
	db 236
	db 41
	db 0
	db 140
	db 51
	db 255
	db 252
	db 253
	db 248
	db 121
	db 244
	db 133
	db 89
	db 0
	db 96
	db 99
	db 126
	db 0
	db 193
	db 241
	db 255
	db 0
	db 99
	db 6
	db 255
	db 6
	db 226
	db 0
	db 224
	db 245
	db 253
	db 231
	db 140
	db 24
	db 26
	db 172
	db 88
	db 212
	db 24
	db 222
	db 0
	db 199
	db 199
	db 102
	db 113
	db 253
	db 150
	db 40
	db 101
	db 214
	db 24
	db 255
	db 192
	db 219
	db 255
	db 0
	db 192
	db 207
	db 140
	db 30
	db 143
	db 140
	db 253
	db 44
	db 172
	db 234
	db 128
	db 11
	db 224
	db 3
	db 27
	db 219
	db 0
	db 63
	db 49
	db 204
	db 255
	db 33
	db 76
	db 0
	db 96
	db 255
	db 224
	db 68
	db 255
	db 104
	db 190
	db 96
	db 97
	db 121
	db 0
	db 159
	db 118
	db 231
	db 61
	db 252
	db 0
	db 7
	db 6
	db 121
	db 3
	db 255
	db 96
	db 107
	db 226
	db 0
	db 255
	db 197
	db 209
	db 0
	db 4
	db 236
	db 5
	db 161
	db 255
	db 241
	db 176
	db 3
	db 54
	db 24
	db 0
	db 128
	db 159
	db 204
	db 165
	db 255
	db 127
	db 129
	db 165
	db 182
	db 0
	db 42
	db 71
	db 96
	db 115
	db 229
	db 0
	db 142
	db 24
	db 71
	db 31
	db 171
	db 0
	db 254
	db 38
	db 168
	db 24
	db 235
	db 192
	db 238
	db 243
	db 0
	db 31
	db 203
	db 0
	db 240
	db 200
	db 192
	db 236
	db 219
	db 0
	db 203
	db 13
	db 47
	db 4
	db 60
	db 252
	db 190
	db 192
	db 240
	db 101
	db 0
	db 3
	db 6
	db 252
	db 84
	db 240
	db 38
	db 153
	db 0
	db 96
	db 105
	db 122
	db 0
	db 15
	db 197
	db 198
	db 0
	db 228
	db 10
	db 202
	db 118
	db 255
	db 9
	db 8
	db 7
	db 6
	db 55
	db 241
	db 0
	db 252
	db 128
	db 228
	db 248
	db 253
	db 38
	db 82
	db 224
	db 63
	db 204
	db 48
	db 210
	db 55
	db 55
	db 0
	db 153
	db 142
	db 217
	db 44
	db 25
	db 178
	db 255
	db 86
	db 225
	db 1
	db 98
	db 255
	db 0
	db 192
	db 220
	db 150
	db 0
	db 31
	db 152
	db 58
	db 88
	db 253
	db 24
	db 30
	db 240
	db 0
	db 199
	db 127
	db 97
	db 113
	db 253
	db 148
	db 224
	db 217
	db 252
	db 4
	db 5
	db 255
	db 134
	db 242
	db 6
	db 227
	db 0
	db 124
	db 198
	db 112
	db 255
	db 38
	db 22
	db 69
	db 0
	db 81
	db 219
	db 129
	db 141
	db 233
	db 0
	db 12
	db 255
	db 163
	db 252
	db 252
	db 8
	db 87
	db 0
	db 192
	db 3
	db 9
	db 41
	db 255
	db 5
	db 254
	db 96
	db 100
	db 102
	db 0
	db 3
	db 208
	db 255
	db 194
	db 23
	db 0
	db 15
	db 12
	db 6
	db 173
	db 3
	db 133
	db 242
	db 7
	db 96
	db 105
	db 97
	db 0
	db 142
	db 163
	db 0
	db 16
	db 217
	db 20
	db 78
	db 255
	db 19
	db 16
	db 15
	db 217
	db 230
	db 32
	db 179
	db 40
	db 214
	db 255
	db 47
	db 4
	db 250
	db 236
	db 63
	db 198
	db 214
	db 0
	db 127
	db 19
	db 229
	db 0
	db 129
	db 166
	db 255
	db 179
	db 2
	db 22
	db 255
	db 1
	db 15
	db 43
	db 0
	db 224
	db 61
	db 255
	db 0
	db 167
	db 240
	db 255
	db 16
	db 176
	db 128
	db 103
	db 177
	db 231
	db 240
	db 248
	db 197
	db 2
	db 64
	db 113
	db 255
	db 76
	db 254
	db 144
	db 250
	db 176
	db 246
	db 141
	db 160
	db 248
	db 100
	db 237
	db 234
	db 105
	db 8
	db 135
	db 185
	db 0
	db 98
	db 146
	db 215
	db 236
	db 240
	db 216
	db 168
	db 53
	db 114
	db 254
	db 248
	db 56
	db 200
	db 45
	db 59
	db 166
	db 144
	db 205
	db 191
	db 98
	db 128
	db 195
	db 225
	db 91
	db 121
	db 9
	db 152
	db 232
	db 142
	db 3
	db 255
	db 227
	db 86
	db 6
	db 15
	db 48
	db 217
	db 62
	db 255
	db 97
	db 134
	db 88
	db 0
	db 251
	db 2
	db 254
	db 255
	db 38
	db 255
	db 252
	db 253
	db 194
	db 144
	db 252
	db 77
	db 146
	db 244
	db 63
	db 48
	db 228
	db 195
	db 242
	db 163
	db 20
	db 255
	db 191
	db 33
	db 228
	db 143
	db 14
	db 31
	db 30
	db 206
	db 23
	db 16
	db 235
	db 63
	db 156
	db 223
	db 255
	db 191
	db 127
	db 47
	db 95
	db 94
	db 220
	db 48
	db 56
	db 230
	db 224
	db 0
	db 203
	db 235
	db 157
	db 227
	db 210
	db 218
	db 112
	db 152
	db 139
	db 124
	db 0
	db 75
	db 248
	db 128
	db 214
	db 255
	db 224
	db 61
	db 150
	db 0
	db 62
	db 255
	db 216
	db 31
	db 255
	db 112
	db 255
	db 76
	db 130
	db 240
	db 249
	db 112
	db 52
	db 48
	db 16
	db 255
	db 115
	db 184
	db 127
	db 7
	db 126
	db 129
	db 80
	db 233
	db 192
	db 191
	db 224
	db 0
	db 239
	db 227
	db 247
	db 226
	db 210
	db 241
	db 221
	db 98
	db 31
	db 255
	db 63
	db 0
	db 58
	db 122
	db 218
	db 170
	db 28
	db 88
	db 250
	db 248
	db 117
	db 2
	db 241
	db 7
	db 88
	db 34
	db 40
	db 0
	db 248
	db 3
	db 108
	db 253
	db 251
	db 88
	db 0
	db 178
	db 0
	db 194
	db 65
	db 0
	db 81
	db 241
	db 31
	db 127
	db 223
	db 171
	db 172
	db 173
	db 41
	db 4
	db 252
	db 221
	db 244
	db 252
	db 254
	db 224
	db 159
	db 127
	db 63
	db 47
	db 38
	db 28
	db 215
	db 204
	db 32
	db 143
	db 72
	db 22
	db 15
	db 11
	db 228
	db 7
	db 45
	db 7
	db 3
	db 138
	db 241
	db 100
	db 135
	db 238
	db 0
	db 128
	db 188
	db 162
	db 59
	db 143
	db 253
	db 50
	db 242
	db 240
	db 214
	db 243
	db 139
	db 124
	db 176
	db 0
	db 45
	db 140
	db 255
	db 127
	db 246
	db 0
	db 15
	db 155
	db 236
	db 99
	db 57
	db 0
	db 96
	db 97
	db 44
	db 0
	db 4
	db 197
	db 255
	db 3
	db 133
	db 185
	db 0
	db 216
	db 127
	db 128
	db 28
	db 153
	db 0
	db 96
	db 116
	db 152
	db 255
	db 4
imgBalls:
	db 255
	db 252
	db 240
	db 230
	db 206
	db 204
	db 128
	db 128
	db 128
	db 128
	db 192
	db 192
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 15
	db 7
	db 3
	db 3
	db 1
	db 1
	db 1
	db 1
	db 3
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 3
	db 15
	db 31
	db 31
	db 63
	db 63
	db 63
	db 63
	db 31
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 240
	db 230
	db 236
	db 192
	db 192
	db 192
	db 224
	db 224
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 15
	db 7
	db 7
	db 3
	db 3
	db 3
	db 3
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 3
	db 15
	db 15
	db 31
	db 31
	db 31
	db 15
	db 15
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 248
	db 242
	db 244
	db 224
	db 224
	db 240
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 31
	db 15
	db 15
	db 7
	db 7
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 1
	db 7
	db 7
	db 15
	db 15
	db 7
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 224
	db 224
	db 192
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 252
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 31
	db 31
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 193
	db 153
	db 129
	db 195
	db 255
	db 255
	db 195
	db 129
	db 129
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 135
	db 131
	db 129
	db 129
	db 195
	db 255
	db 255
	db 195
	db 129
	db 129
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 28
	db 56
	db 48
	db 0
	db 0
	db 0
	db 0
	db 60
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 56
	db 56
	db 32
	db 0
	db 0
	db 0
	db 0
	db 48
	db 48
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 211
	db 131
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 131
	db 195
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 195
	db 193
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 193
	db 195
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 24
	db 48
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 24
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 240
	db 230
	db 206
	db 140
	db 128
	db 128
	db 128
	db 128
	db 192
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 15
	db 7
	db 3
	db 1
	db 1
	db 1
	db 1
	db 1
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 3
	db 15
	db 31
	db 63
	db 63
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 224
	db 198
	db 206
	db 140
	db 128
	db 128
	db 128
	db 192
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 7
	db 3
	db 3
	db 1
	db 1
	db 1
	db 1
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 7
	db 31
	db 31
	db 63
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 240
	db 240
	db 240
	db 240
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 243
	db 239
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 223
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 243
	db 241
	db 225
	db 225
	db 193
	db 131
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 3
	db 9
	db 17
	db 19
	db 63
	db 63
	db 63
	db 63
	db 31
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 239
	db 223
	db 223
	db 223
	db 239
	db 239
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 247
	db 243
	db 227
	db 227
	db 195
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 3
	db 9
	db 3
	db 31
	db 31
	db 31
	db 15
	db 15
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 249
	db 247
	db 247
	db 239
	db 239
	db 247
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 159
	db 239
	db 239
	db 199
	db 199
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 1
	db 5
	db 3
	db 15
	db 15
	db 7
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 224
	db 224
	db 192
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 253
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 223
	db 159
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 221
	db 185
	db 177
	db 195
	db 255
	db 255
	db 195
	db 189
	db 137
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 167
	db 187
	db 185
	db 161
	db 195
	db 255
	db 255
	db 195
	db 177
	db 177
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 28
	db 32
	db 48
	db 0
	db 0
	db 0
	db 0
	db 60
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 56
	db 56
	db 32
	db 0
	db 0
	db 0
	db 0
	db 48
	db 48
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 219
	db 179
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 155
	db 211
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 219
	db 217
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 217
	db 211
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 8
	db 48
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 24
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 223
	db 191
	db 191
	db 191
	db 191
	db 191
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 241
	db 241
	db 225
	db 193
	db 129
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 3
	db 9
	db 17
	db 51
	db 63
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 231
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 222
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 231
	db 243
	db 243
	db 241
	db 241
	db 193
	db 129
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 7
	db 25
	db 17
	db 51
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 240
	db 240
	db 240
	db 240
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 243
	db 239
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 223
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 243
	db 241
	db 225
	db 225
	db 193
	db 131
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 239
	db 223
	db 223
	db 223
	db 239
	db 239
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 247
	db 243
	db 227
	db 227
	db 195
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 6
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 249
	db 247
	db 247
	db 239
	db 239
	db 247
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 159
	db 239
	db 239
	db 199
	db 199
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 253
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 223
	db 159
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 221
	db 185
	db 177
	db 195
	db 255
	db 255
	db 195
	db 189
	db 137
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 167
	db 187
	db 185
	db 161
	db 195
	db 255
	db 255
	db 195
	db 177
	db 177
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 0
	db 24
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 219
	db 179
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 155
	db 211
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 219
	db 217
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 217
	db 211
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 223
	db 191
	db 191
	db 191
	db 191
	db 191
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 241
	db 241
	db 225
	db 193
	db 129
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 231
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 222
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 231
	db 243
	db 243
	db 241
	db 241
	db 193
	db 129
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 240
	db 230
	db 206
	db 204
	db 128
	db 128
	db 128
	db 128
	db 192
	db 192
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 15
	db 7
	db 3
	db 3
	db 1
	db 1
	db 1
	db 1
	db 3
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 240
	db 230
	db 236
	db 192
	db 192
	db 192
	db 224
	db 224
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 15
	db 7
	db 7
	db 3
	db 3
	db 3
	db 3
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 6
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 248
	db 242
	db 244
	db 224
	db 224
	db 240
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 31
	db 15
	db 15
	db 7
	db 7
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 252
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 31
	db 31
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 193
	db 153
	db 129
	db 195
	db 255
	db 255
	db 195
	db 129
	db 129
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 135
	db 131
	db 129
	db 129
	db 195
	db 255
	db 255
	db 195
	db 129
	db 129
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 0
	db 24
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 211
	db 131
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 131
	db 195
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 195
	db 193
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 193
	db 195
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 240
	db 230
	db 206
	db 140
	db 128
	db 128
	db 128
	db 128
	db 192
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 15
	db 7
	db 3
	db 1
	db 1
	db 1
	db 1
	db 1
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 224
	db 198
	db 206
	db 140
	db 128
	db 128
	db 128
	db 192
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 7
	db 3
	db 3
	db 1
	db 1
	db 1
	db 1
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 6
	db 14
	db 12
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 242
	db 231
	db 206
	db 221
	db 170
	db 149
	db 170
	db 149
	db 202
	db 212
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 143
	db 87
	db 163
	db 83
	db 161
	db 65
	db 161
	db 65
	db 131
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 1
	db 14
	db 31
	db 14
	db 21
	db 42
	db 21
	db 42
	db 21
	db 10
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 64
	db 160
	db 80
	db 160
	db 80
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 242
	db 239
	db 238
	db 213
	db 202
	db 213
	db 234
	db 229
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 143
	db 87
	db 167
	db 83
	db 163
	db 67
	db 131
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 1
	db 6
	db 13
	db 10
	db 21
	db 10
	db 5
	db 10
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 64
	db 160
	db 80
	db 160
	db 64
	db 160
	db 64
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 248
	db 243
	db 246
	db 229
	db 234
	db 245
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 159
	db 79
	db 175
	db 71
	db 135
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 1
	db 7
	db 7
	db 15
	db 15
	db 7
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 224
	db 224
	db 192
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 253
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 159
	db 31
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 201
	db 153
	db 161
	db 195
	db 255
	db 255
	db 195
	db 169
	db 129
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 135
	db 171
	db 145
	db 161
	db 195
	db 255
	db 255
	db 195
	db 161
	db 145
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 20
	db 56
	db 16
	db 0
	db 0
	db 0
	db 0
	db 20
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 16
	db 40
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 32
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 219
	db 147
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 139
	db 211
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 203
	db 209
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 201
	db 211
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 16
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 242
	db 231
	db 206
	db 157
	db 170
	db 149
	db 170
	db 149
	db 202
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 143
	db 87
	db 163
	db 81
	db 161
	db 65
	db 129
	db 1
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 1
	db 14
	db 31
	db 46
	db 21
	db 42
	db 21
	db 42
	db 20
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 64
	db 160
	db 80
	db 160
	db 80
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 229
	db 206
	db 223
	db 174
	db 149
	db 170
	db 149
	db 202
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 71
	db 163
	db 83
	db 161
	db 81
	db 129
	db 1
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 2
	db 23
	db 14
	db 29
	db 42
	db 21
	db 42
	db 20
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 160
	db 80
	db 160
	db 80
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 242
	db 231
	db 206
	db 221
	db 170
	db 149
	db 170
	db 149
	db 202
	db 212
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 143
	db 87
	db 163
	db 83
	db 161
	db 65
	db 161
	db 65
	db 131
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 3
	db 15
	db 31
	db 31
	db 63
	db 63
	db 63
	db 63
	db 31
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 242
	db 231
	db 238
	db 213
	db 202
	db 213
	db 234
	db 229
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 143
	db 87
	db 167
	db 83
	db 163
	db 67
	db 131
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 3
	db 15
	db 15
	db 31
	db 31
	db 31
	db 15
	db 15
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 224
	db 224
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 248
	db 243
	db 246
	db 229
	db 234
	db 245
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 159
	db 79
	db 175
	db 71
	db 135
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 1
	db 7
	db 7
	db 15
	db 15
	db 7
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 224
	db 224
	db 192
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 253
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 159
	db 31
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 213
	db 185
	db 145
	db 195
	db 255
	db 255
	db 195
	db 169
	db 129
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 135
	db 171
	db 145
	db 161
	db 195
	db 255
	db 255
	db 195
	db 145
	db 161
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 28
	db 32
	db 48
	db 0
	db 0
	db 0
	db 0
	db 60
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 56
	db 56
	db 32
	db 0
	db 0
	db 0
	db 0
	db 48
	db 48
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 211
	db 163
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 147
	db 195
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 211
	db 201
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 209
	db 195
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 8
	db 48
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 24
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 24
	db 16
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 143
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 241
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 242
	db 239
	db 206
	db 157
	db 170
	db 149
	db 170
	db 149
	db 202
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 143
	db 87
	db 163
	db 81
	db 161
	db 65
	db 129
	db 1
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 3
	db 15
	db 31
	db 63
	db 63
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 240
	db 240
	db 240
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 229
	db 206
	db 223
	db 174
	db 149
	db 170
	db 149
	db 202
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 71
	db 163
	db 83
	db 161
	db 81
	db 129
	db 1
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 7
	db 31
	db 31
	db 63
	db 63
	db 63
	db 63
	db 30
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 240
	db 240
	db 240
	db 240
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 252
	db 243
	db 239
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 223
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 243
	db 241
	db 225
	db 225
	db 193
	db 131
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 2
	db 7
	db 14
	db 29
	db 42
	db 21
	db 42
	db 21
	db 10
	db 20
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 80
	db 160
	db 80
	db 160
	db 64
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 239
	db 223
	db 223
	db 223
	db 239
	db 239
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 247
	db 243
	db 227
	db 227
	db 195
	db 7
	db 7
	db 15
	db 63
	db 255
	db 255
	db 0
	db 0
	db 0
	db 2
	db 7
	db 14
	db 21
	db 10
	db 21
	db 10
	db 5
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 80
	db 160
	db 80
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 254
	db 249
	db 247
	db 247
	db 239
	db 239
	db 247
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 159
	db 239
	db 239
	db 199
	db 199
	db 15
	db 15
	db 31
	db 127
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 3
	db 6
	db 5
	db 10
	db 5
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 64
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 253
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 63
	db 223
	db 159
	db 31
	db 63
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 254
	db 253
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 251
	db 225
	db 221
	db 185
	db 177
	db 195
	db 255
	db 255
	db 195
	db 189
	db 137
	db 193
	db 225
	db 251
	db 255
	db 255
	db 223
	db 167
	db 187
	db 185
	db 161
	db 195
	db 255
	db 255
	db 195
	db 177
	db 177
	db 131
	db 135
	db 223
	db 255
	db 0
	db 0
	db 0
	db 20
	db 32
	db 16
	db 0
	db 0
	db 0
	db 0
	db 40
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 40
	db 16
	db 32
	db 0
	db 0
	db 0
	db 0
	db 16
	db 32
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 231
	db 219
	db 179
	db 199
	db 255
	db 255
	db 255
	db 255
	db 199
	db 155
	db 211
	db 231
	db 255
	db 255
	db 255
	db 255
	db 231
	db 219
	db 217
	db 227
	db 255
	db 255
	db 255
	db 255
	db 227
	db 217
	db 211
	db 231
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 223
	db 175
	db 223
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 251
	db 245
	db 251
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 32
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 252
	db 243
	db 239
	db 223
	db 191
	db 191
	db 191
	db 191
	db 191
	db 222
	db 224
	db 240
	db 252
	db 255
	db 255
	db 255
	db 63
	db 207
	db 247
	db 243
	db 241
	db 241
	db 225
	db 193
	db 129
	db 3
	db 7
	db 15
	db 63
	db 255
	db 0
	db 0
	db 0
	db 2
	db 15
	db 14
	db 29
	db 42
	db 21
	db 42
	db 21
	db 10
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 80
	db 160
	db 80
	db 160
	db 64
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 248
	db 231
	db 223
	db 223
	db 191
	db 191
	db 191
	db 191
	db 222
	db 192
	db 224
	db 248
	db 255
	db 255
	db 255
	db 255
	db 31
	db 231
	db 243
	db 243
	db 241
	db 241
	db 193
	db 129
	db 3
	db 3
	db 7
	db 31
	db 255
	db 0
	db 0
	db 0
	db 0
	db 5
	db 14
	db 31
	db 46
	db 21
	db 42
	db 21
	db 10
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 64
	db 160
	db 80
	db 160
	db 80
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
imgBoard:
	db 255
	db 255
	db 255
	db 245
	db 223
	db 241
	db 225
	db 241
	db 249
	db 249
	db 255
	db 249
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 175
	db 251
	db 143
	db 135
	db 143
	db 159
	db 159
	db 255
	db 159
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 249
	db 255
	db 249
	db 249
	db 241
	db 225
	db 241
	db 223
	db 245
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 159
	db 255
	db 159
	db 159
	db 143
	db 135
	db 143
	db 251
	db 175
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 253
	db 255
	db 250
	db 254
	db 250
	db 255
	db 255
	db 232
	db 248
	db 232
	db 253
	db 247
	db 255
	db 255
	db 255
	db 255
	db 255
	db 127
	db 63
	db 11
	db 11
	db 255
	db 255
	db 47
	db 47
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 244
	db 244
	db 255
	db 255
	db 208
	db 208
	db 252
	db 254
	db 255
	db 255
	db 255
	db 255
	db 255
	db 239
	db 191
	db 23
	db 31
	db 23
	db 255
	db 255
	db 95
	db 127
	db 95
	db 255
	db 191
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
imgPlayer:
	db 16
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 130
	db 254
	db 218
	db 138
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 56
	db 124
	db 56
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 64
	db 64
	db 224
	db 112
	db 121
	db 59
	db 55
	db 23
	db 27
	db 11
	db 1
	db 16
	db 8
	db 20
	db 10
	db 21
	db 10
	db 21
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 252
	db 223
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 29
	db 16
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 192
	db 223
	db 159
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 65
	db 130
	db 1
	db 0
	db 3
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 64
	db 64
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 7
	db 255
	db 255
	db 255
	db 255
	db 15
	db 1
	db 0
	db 0
	db 1
	db 2
	db 21
	db 10
	db 20
	db 8
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 16
	db 16
	db 56
	db 248
	db 252
	db 252
	db 252
	db 254
	db 254
	db 254
	db 254
	db 254
	db 126
	db 62
	db 15
	db 167
	db 83
	db 171
	db 19
	db 11
	db 3
	db 9
	db 4
	db 0
	db 0
	db 56
	db 248
	db 216
	db 16
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 56
	db 130
	db 254
	db 218
	db 138
	db 96
	db 96
	db 64
	db 124
	db 125
	db 125
	db 125
	db 1
	db 56
	db 124
	db 56
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 3
	db 7
	db 15
	db 15
	db 31
	db 31
	db 63
	db 31
	db 15
	db 6
	db 128
	db 129
	db 195
	db 135
	db 7
	db 3
	db 3
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 28
	db 50
	db 59
	db 63
	db 63
	db 31
	db 224
	db 252
	db 223
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 3
	db 4
	db 7
	db 9
	db 8
	db 7
	db 31
	db 98
	db 221
	db 210
	db 210
	db 226
	db 247
	db 239
	db 223
	db 223
	db 223
	db 224
	db 191
	db 64
	db 63
	db 158
	db 192
	db 192
	db 128
	db 128
	db 63
	db 127
	db 255
	db 255
	db 127
	db 31
	db 24
	db 24
	db 24
	db 56
	db 120
	db 248
	db 252
	db 252
	db 248
	db 0
	db 0
	db 224
	db 128
	db 192
	db 128
	db 192
	db 64
	db 192
	db 128
	db 0
	db 128
	db 128
	db 0
	db 0
	db 192
	db 48
	db 220
	db 94
	db 95
	db 63
	db 127
	db 191
	db 223
	db 223
	db 223
	db 63
	db 238
	db 28
	db 240
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 240
	db 254
	db 252
	db 248
	db 192
	db 64
	db 64
	db 64
	db 65
	db 99
	db 127
	db 255
	db 255
	db 127
	db 0
	db 1
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 192
	db 224
	db 224
	db 224
	db 192
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 32
	db 160
	db 224
	db 224
	db 192
	db 56
	db 248
	db 216
imgPlayerWin:
	db 0
	db 0
	db 0
	db 0
	db 117
	db 250
	db 250
	db 218
	db 170
	db 170
	db 218
	db 122
	db 58
	db 0
	db 63
	db 31
	db 0
	db 0
	db 0
	db 0
	db 112
	db 248
	db 248
	db 216
	db 168
	db 168
	db 216
	db 240
	db 224
	db 0
	db 224
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2
	db 7
	db 2
	db 2
	db 117
	db 250
	db 250
	db 218
	db 170
	db 170
	db 218
	db 122
	db 58
	db 0
	db 63
	db 31
	db 0
	db 0
	db 0
	db 0
	db 112
	db 248
	db 248
	db 216
	db 168
	db 168
	db 216
	db 240
	db 224
	db 0
	db 224
	db 192
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
imgPlayerD:
	db 0
	db 0
	db 0
	db 0
	db 173
	db 223
	db 171
	db 223
	db 255
	db 255
	db 255
	db 255
	db 253
	db 255
	db 254
	db 255
	db 168
	db 216
	db 168
	db 216
	db 0
	db 0
	db 0
	db 0
	db 173
	db 223
	db 171
	db 223
	db 255
	db 255
	db 255
	db 255
	db 253
	db 255
	db 254
	db 255
	db 168
	db 216
	db 168
	db 216
imgKingLose:
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 1
	db 1
	db 1
	db 3
	db 3
	db 3
	db 3
	db 3
	db 7
	db 7
	db 7
	db 7
	db 7
	db 7
	db 7
	db 6
	db 6
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 192
	db 240
	db 252
	db 254
	db 255
	db 195
	db 129
	db 129
	db 128
	db 128
	db 128
	db 192
	db 224
	db 240
	db 224
	db 192
	db 128
	db 0
	db 96
	db 252
	db 223
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 29
	db 16
	db 16
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 255
	db 255
	db 255
	db 252
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 224
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 64
	db 64
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 3
	db 250
	db 248
	db 224
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 1
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 0
	db 0
	db 0
	db 8
	db 0
	db 8
	db 16
	db 40
	db 16
	db 8
	db 192
	db 48
	db 8
	db 56
	db 248
	db 216
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 7
	db 15
	db 31
	db 63
	db 63
	db 127
	db 127
	db 127
	db 63
	db 15
	db 3
	db 1
	db 0
	db 0
	db 0
	db 60
	db 60
	db 62
	db 62
	db 63
	db 31
	db 15
	db 0
	db 3
	db 3
	db 1
	db 0
	db 96
	db 252
	db 223
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 1
	db 0
	db 0
	db 0
	db 0
	db 0
	db 3
	db 4
	db 7
	db 9
	db 8
	db 7
	db 31
	db 98
	db 221
	db 210
	db 210
	db 226
	db 247
	db 239
	db 223
	db 223
	db 223
	db 224
	db 255
	db 240
	db 239
	db 127
	db 0
	db 0
	db 0
	db 0
	db 0
	db 3
	db 127
	db 127
	db 191
	db 63
	db 223
	db 223
	db 223
	db 15
	db 0
	db 0
	db 224
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 192
	db 128
	db 128
	db 192
	db 64
	db 192
	db 128
	db 0
	db 128
	db 128
	db 0
	db 0
	db 224
	db 56
	db 222
	db 95
	db 95
	db 63
	db 127
	db 191
	db 223
	db 223
	db 223
	db 63
	db 255
	db 127
	db 190
	db 253
	db 3
	db 2
	db 1
	db 1
	db 25
	db 251
	db 251
	db 251
	db 247
	db 224
	db 238
	db 223
	db 222
	db 128
	db 0
	db 1
	db 63
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 128
	db 192
	db 224
	db 240
	db 248
	db 254
	db 255
	db 255
	db 255
	db 252
	db 251
	db 119
	db 175
	db 15
	db 236
	db 224
	db 224
	db 224
	db 192
	db 192
	db 128
	db 0
	db 0
	db 192
	db 48
	db 8
	db 56
	db 248
	db 216
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 192
	db 240
	db 248
	db 248
	db 224
	db 128
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
game:
	ds 81
newBalls:
	ds 3
cursorX:
	ds 1
cursorY:
	ds 1
selX:
	ds 1
selY:
	ds 1
showPath:
	db 1
showHelp:
	db 1
soundEnabled:
	db 1
score:
	ds 2
hiScores:
	db 65
	db 108
	db 101
	db 109
	db 111
	db 114
	db 102
	ds 3
	dw 400
	db 66
	db 50
	db 77
	ds 7
	dw 350
	db 69
	db 108
	db 116
	db 97
	db 114
	db 111
	db 110
	ds 3
	dw 300
	db 69
	db 114
	db 114
	db 111
	db 114
	db 52
	db 48
	db 52
	ds 2
	dw 250
	db 83
	db 89
	db 83
	db 67
	db 65
	db 84
	ds 4
	dw 200
	db 77
	db 105
	db 99
	db 107
	ds 6
	dw 150
	db 83
	db 86
	db 79
	db 70
	db 83
	db 75
	ds 4
	dw 100
	db 84
	db 105
	db 116
	db 117
	db 115
	ds 5
	dw 50
path_x:
	ds 1
path_y:
	ds 1
path_n:
	ds 1
selAnimationDelay:
	ds 1
selAnimationFrame:
	ds 1
path_c:
	ds 1
path_p:
	ds 2
path_p1:
	ds 2
path_n1:
	ds 1
path_x1:
	ds 1
path_y1:
	ds 1
music:
	dw 75
	dw 48000
	dw 59
	dw 24000
	dw 50
	dw 24000
	dw 59
	dw 24000
	dw 75
	dw 48000
	dw 100
	dw 24000
	dw 89
	dw 24000
	dw 79
	dw 24000
	dw 75
	dw 48000
	dw 59
	dw 24000
	dw 50
	dw 24000
	dw 59
	dw 24000
	dw 67
	dw 48000
	dw 100
	dw 24000
	dw 89
	dw 24000
	dw 79
	dw 24000
	dw 79
	dw 48000
	dw 100
	dw 24000
	dw 89
	dw 24000
	dw 79
	dw 24000
	dw 75
	dw 30464
	dw 75
	dw 48000
	dw 59
	dw 24000
	dw 50
	dw 24000
	dw 59
	dw 24000
	dw 67
	dw 48000
	dw 100
	dw 24000
	dw 89
	dw 24000
	dw 79
	dw 24000
	dw 79
	dw 48000
	dw 100
	dw 24000
	dw 89
	dw 24000
	dw 79
	dw 24000
	dw 75
	dw 30464
	dw 0
rightCreatureY:
	ds 1
removeAnimationImages:
	dw (imgBalls) + (320)
	dw (imgBalls) + (384)
	dw (imgBalls) + (448)
bouncingAnimation:
	dw imgBalls
	dw imgBalls
	dw imgBalls
	dw (imgBalls) + (512)
	dw (imgBalls) + (576)
	dw (imgBalls) + (512)
helpCoords:
	dw 60412
	dw 59644
	dw 58876
introPalette:
	db 15
	db 6
	db 1
	db 4
gamePalette:
	db 15
	db 6
	db 9
	db 0
gamePalette2:
	db 15
	db 3
	db 12
	db 0
DrawImage_1_a:
	ds 2
DrawImage_2_a:
	ds 2
DrawImage_3_a:
	ds 2
SetFillRectColor_1_a:
	ds 1
FillRectInternal_1_a:
	ds 1
FillRectInternal_2_a:
	ds 1
FillRectInternal_3_a:
	ds 2
FillRect1_1_a:
	ds 2
FillRect1_2_a:
	ds 2
FillRect1_3_a:
	ds 1
FillRect1_4_a:
	ds 1
FillRect1_5_a:
	ds 1
FillRect_1_a:
	ds 2
FillRect_2_a:
	ds 1
FillRect_3_a:
	ds 2
FillRect_4_a:
	ds 1
SetTextColorInternal_1_a:
	ds 1
SetTextColorInternal_2_a:
	ds 1
SetTextColorInternal_3_a:
	ds 1
SetTextColor_1_a:
	ds 1
DrawChar_1_a:
	ds 1
DrawChar_2_a:
	ds 2
DrawChar_3_a:
	ds 2
DrawText1_1_a:
	ds 2
DrawText1_2_a:
	ds 1
DrawText1_3_a:
	ds 1
DrawText1_4_a:
	ds 2
DrawText_1_a:
	ds 1
DrawText_2_a:
	ds 1
DrawText_3_a:
	ds 1
DrawText_4_a:
	ds 2
ReadKeyboardRow_1_a:
	ds 1
ReadKeyboard_1_a:
	ds 1
NumberOfBit_1_a:
	ds 1
SetPaletteInternal_1_a:
	ds 1
Delay_1_a:
	ds 2
SetPaletteSlowly_1_a:
	ds 2
SetPalette_1_a:
	ds 2
PlayTone_1_a:
	ds 2
PlayTone_2_a:
	ds 2
ClearLine_1_a:
	ds 1
ClearLine_2_a:
	ds 1
ClearLine_3_a:
	ds 1
ClearLine_4_a:
	ds 1
ClearLine_5_a:
	ds 1
DrawSpriteRemove_1_a:
	ds 1
DrawSpriteRemove_2_a:
	ds 1
DrawSpriteRemove_3_a:
	ds 1
DrawSpriteRemove_4_a:
	ds 1
DrawEmptyCell_1_a:
	ds 1
DrawEmptyCell_2_a:
	ds 1
GameStep_1_a:
	ds 1
DrawSpriteNew_1_a:
	ds 1
DrawSpriteNew_2_a:
	ds 1
DrawSpriteNew_3_a:
	ds 1
DrawSpriteNew_4_a:
	ds 1
DrawHiScores_1_a:
	ds 1
memcpy_1_a:
	ds 2
memcpy_2_a:
	ds 2
memcpy_3_a:
	ds 2
DrawHiScoresScreen_1_a:
	ds 1
DrawCell_1_a:
	ds 1
DrawCell_2_a:
	ds 1
DrawCell_3_a:
	ds 1
DrawSpriteStep_1_a:
	ds 1
DrawSpriteStep_2_a:
	ds 1
DrawSpriteStep_3_a:
	ds 1
DrawBouncingBall_1_a:
	ds 1
DrawBouncingBall_2_a:
	ds 1
DrawBouncingBall_3_a:
	ds 1
DrawBouncingBall_4_a:
	ds 1
DrawButton_1_a:
	ds 2
DrawButton_2_a:
	ds 1
PathFounded_1_a:
	ds 2
Uint16ToString_1_a:
	ds 2
Uint16ToString_2_a:
	ds 2
CellAddress_1_a:
	ds 1
CellAddress_2_a:
	ds 1
DrawBall1_1_a:
	ds 2
DrawBall1_2_a:
	ds 2
DrawBall1_3_a:
	ds 1
DrawEmptyCell1_1_a:
	ds 2
DrawCell1_1_a:
	ds 2
DrawCell1_2_a:
	ds 1
DrawSpriteNew1_1_a:
	ds 2
DrawSpriteNew1_2_a:
	ds 1
DrawSpriteNew1_3_a:
	ds 1
DrawCursorXor_1_a:
	ds 2
memset_1_a:
	ds 2
memset_2_a:
	ds 1
memset_3_a:
	ds 2
memswap_1_a:
	ds 2
memswap_2_a:
	ds 2
memswap_3_a:
	ds 2
unmlz_1_a:
	ds 2
unmlz_2_a:
	ds 2
DrawHiScoresScreen1_1_a:
	ds 1
DrawHiScoresScreen1_2_a:
	ds 1
strlen_1_a:
	ds 2
main_s:
	ds 3
Intro_s:
	ds 5
NewGame_s:
	ds 2
ReadKeyboard_s:
	ds 5
DrawButton_s:
	ds 1
DrawHelp_s:
	ds 1
DrawScreen_s:
	ds 11
MoveBall_s:
	ds 4
GenerateNewBalls_s:
	ds 1
GameStep_s:
	ds 12
DrawBouncingBall_s:
	ds 2
DrawText1_s:
	ds 2
DrawHiScoresScreen1_s:
	ds 17
DrawScoreAndCreatures_s:
	ds 9
PathFind_s:
	ds 2
PathGetNextStep_s:
	ds 2
PathFree_s:
	ds 2
AddToHiScores_s:
	ds 15
FindLines_s:
	ds 9
CalcFreeCellCount_s:
	ds 4
DrawCell1_s:
	ds 2
ClearLine_s:
	ds 5
__o_sub_16:
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    ret
__o_cmp_16:
    ld a, h
    cp d
    ret nz
    ld a, l
    cp e
    ret
__o_div_u16:
    push bc
    ex hl, de
    call __o_div_u16__l0
    ex hl, de
    ld (__div_16_mod), hl
    ex hl, de
    pop bc
    ret

__o_div_u16__l0:
__o_div_u16__l:
    ld a, h
    or l
    ret z
    ld bc, 0
    push bc
__o_div_u16__l1:
    ld a, e
    sub l
    ld a, d
    sbc h
    jp c, __o_div_u16__l2
    push hl
    add hl, hl
    jp nc, __o_div_u16__l1
__o_div_u16__l2:
    ld hl, 0
__o_div_u16__l3:
    pop bc
    ld a, b
    or c
    ret z
    add hl, hl
    push de
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jp c, __o_div_u16__l4
    inc hl
    pop bc
    jp __o_div_u16__l3
__o_div_u16__l4:
    pop de
    jp __o_div_u16__l3
__o_mod_u16:
    push bc
    ex hl, de
    call __o_div_u16__l0
    ex hl, de
    pop bc
    ret
__o_shr_u16:
    inc e
__o_shr_u16__l1:
    dec e
    ret z
    ld a, h
    or a  ; cf = 0
    rra
    ld h, a
    ld a, l
    rra
    ld l, a
    jp __o_shr_u16__l1
__div_16_mod:
	ds 2
s_9: db 130, 162, 165, 164, 168, 226, 165, 32, 225, 162, 174, 241, 32, 168, 172, 239, 0
s_12: db 130, 235, 0
s_8: db 139, 227, 231, 232, 168, 165, 32, 224, 165, 167, 227, 171, 236, 226, 160, 226, 235, 0
s_10: db 141, 160, 166, 172, 168, 226, 165, 32, 171, 238, 161, 227, 238, 32, 170, 171, 160, 162, 168, 232, 227, 0
s_11: db 164, 171, 239, 32, 175, 224, 174, 164, 174, 171, 166, 165, 173, 168, 239, 0
end:
    savebin 'output.i1080', begin, end - begin
