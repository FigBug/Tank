{ ===========================================================================
  TANK.PAS -- reconstructed from TANK.EXE (Tank v1.0 Beta, FuzzySoft, 1995)

  Decompiled by hand from the 16-bit binary. The code, control flow, constants
  and data layout match the executable; the identifier names are invented,
  since Turbo Pascal does not keep them.

  Compiler : Borland Turbo Pascal 7.0 (System unit "1983,92 Borland")
  Units    : Graph, Crt, plus three third-party/helper units whose real names
             are unknown. They are given descriptive names here:
               VGA256Drv - registers VGA256.BGI and calls InitGraph
               KeyUtil   - keyboard helpers (NumLock/CapsLock, flush buffer)
               RamPCX    - "(c) 1993 RAM Software Development": PCX loader
                           and palette fades

  Global variable addresses (DS offsets) are given in comments so this file
  can be cross-checked against TANK_main.asm.
  =========================================================================== }

program Tank;

uses Crt, Graph, RamPCX, KeyUtil, VGA256Drv;

var
  { Sizes returned by ImageSize for the dirt strips used to erase trails }
  EraseHSize,                          { 029C  2 x 27 }
  EraseVSize,                          { 029E  27 x 2 }
  TurnHSize,                           { 02A0  9 x 27 }
  TurnVSize   : Word;                  { 02A2  27 x 9 }

  { Tank sprites. Index = direction code (+1 for 2nd track frame, +8 damaged)
      1.. 8  right-hand tank (dark green):  1 up, 3 down, 5 left, 7 right
      9..16  same, damaged
     17..24  left-hand tank (bright green): 17 up, 19 down, 21 left, 23 right
     25..32  same, damaged                                                  }
  TankImg     : array[1..32] of Pointer;   { 02A4 }

  EraseH,                              { 0324  trail eraser, moving left/right }
  EraseV,                              { 0328  trail eraser, moving up/down }
  TurnH,                               { 032C  eraser after turning (horizontal) }
  TurnV       : Pointer;               { 0330  eraser after turning (vertical) }
  VSize,                               { 0334  vertical tank image size }
  HSize       : Word;                  { 0336  horizontal tank image size }
  Bullet,                              { 0338  3x3 red cross }
  BulletErase : Pointer;               { 033C  3x3 dirt patch }
  BulletSize,                          { 0340 }
  BlankSize   : Word;                  { 0342  BUG: never assigned (always 0) }
  Explode2,                            { 0344  crater for right-hand tank }
  Explode1    : Pointer;               { 0348  crater for left-hand tank }
  ExplodeSize : Word;                  { 034C }

  Quit        : Boolean;               { 0350 }
  Turn1,                               { 0351 }
  Turn2       : Boolean;               { 0352 }
  X1, X2,                              { 0354 0356 }
  Y1, Y2      : Integer;               { 0358 035A }
  OldX1, OldX2,                        { 035C 035E }
  OldY1, OldY2 : Integer;              { 0360 0362 }
  Dir1,                                { 0364  current direction, 0 = stopped }
  LastDir1,                            { 0365  last non-zero direction }
  Dir2,                                { 0366 }
  LastDir2,                            { 0367 }
  Anim1,                               { 0368  track animation counters }
  Anim2       : ShortInt;              { 0369 }
  Key         : Char;                  { 036A }
  Shot1Active,                         { 036B  left tank's bullet in flight }
  Shot2Active : Boolean;               { 036C  right tank's bullet in flight }
  Shot1X, Shot1Y,                      { 036E 0370 }
  Shot2X, Shot2Y : Integer;            { 0372 0374 }
  Shot1DX, Shot1DY,                    { 0376 0378 }
  Shot2DX, Shot2DY : Integer;          { 037A 037C }
  Dead1,                               { 037E }
  Dead2       : Boolean;               { 037F }
  Health1,                             { 0380  10 hits to kill }
  Health2     : ShortInt;              { 0381 }
  Hit1,                                { 0382 }
  Hit2        : Boolean;               { 0383 }


{ 0000 -------------------------------------------------------------------- }
procedure DrawTank(X, Y: Integer; Frame: ShortInt; var Anim: ShortInt);
begin
  { Switch to the damaged sprite once a tank has taken 5 hits }
  if (Health1 < 6) and (Frame > 16) and (Frame < 24) then Frame := Frame + 8;
  if (Health2 < 6) and (Frame > 0)  and (Frame < 8)  then Frame := Frame + 8;

  { Alternate the two track frames }
  Anim := Anim + 1;
  if Odd(Anim) then Frame := Frame + 1;

  PutImage(X, Y, TankImg[Frame]^, NormalPut);
end;


{ 007E -------------------------------------------------------------------- }
{ Bullet-versus-tank test. Shot 2 is tested against the left tank, shot 1
  against the right tank. A hit is any corner of the bullet's 4x4 box inside
  the tank's bounding box. }
procedure CheckHits(PX1, PX2, PY1, PY2, PD1, PD2: Integer);
var
  R1, B1, R2, B2 : Integer;
  S2R, S2B, S1R, S1B : Integer;
begin
  if Shot2Active then
  begin
    if PD1 = 0 then PD1 := LastDir1;
    if (PD1 >= 17) and (PD1 <= 20) then begin R1 := PX1 + 26; B1 := PY1 + 34 end;
    if (PD1 >= 21) and (PD1 <= 24) then begin R1 := PX1 + 34; B1 := PY1 + 26 end;
    S2R := Shot2X + 3;
    S2B := Shot2Y + 3;
    if (Shot2X >= PX1) and (Shot2X <= R1) and (Shot2Y >= PY1) and (Shot2Y <= B1) then Hit1 := True;
    if (Shot2X >= PX1) and (Shot2X <= R1) and (S2B   >= PY1) and (S2B   <= B1) then Hit1 := True;
    if (S2R   >= PX1) and (S2R   <= R1) and (S2B   >= PY1) and (S2B   <= B1) then Hit1 := True;
    if (S2R   >= PX1) and (S2R   <= R1) and (Shot2Y >= PY1) and (Shot2Y <= B1) then Hit1 := True;
    if Hit1 then
    begin
      Dec(Health1);
      Shot2Active := False;
      PutImage(Shot2X, Shot2Y, BulletErase^, NormalPut);
      Dec(Anim1);                       { DrawTank re-increments: same frame }
      DrawTank(X1, Y1, PD1, Anim1);
    end;
    Hit1 := False;
    if Health1 <= 0 then Dead1 := True;
    if Health1 = 5 then
      if PD1 = 0 then PutImage(X1, Y1, TankImg[LastDir1 + 8]^, NormalPut)
                 else PutImage(X1, Y1, TankImg[PD1 + 8]^, NormalPut);
  end;

  if Shot1Active then
  begin
    if PD2 = 0 then PD2 := LastDir2;
    if (PD2 >= 1) and (PD2 <= 4) then begin R2 := PX2 + 26; B2 := PY2 + 34 end;
    if (PD2 >= 5) and (PD2 <= 8) then begin R2 := PX2 + 34; B2 := PY2 + 26 end;
    S1R := Shot1X + 3;
    S1B := Shot1Y + 3;
    if (Shot1X >= PX2) and (Shot1X <= R2) and (Shot1Y >= PY2) and (Shot1Y <= B2) then Hit2 := True;
    if (Shot1X >= PX2) and (Shot1X <= R2) and (S1B   >= PY2) and (S1B   <= B2) then Hit2 := True;
    if (S1R   >= PX2) and (S1R   <= R2) and (S1B   >= PY2) and (S1B   <= B2) then Hit2 := True;
    if (S1R   >= PX2) and (S1R   <= R2) and (Shot1Y >= PY2) and (Shot1Y <= B2) then Hit2 := True;
    if Hit2 then
    begin
      Dec(Health2);
      Shot1Active := False;
      PutImage(Shot1X, Shot1Y, BulletErase^, NormalPut);
      Dec(Anim2);
      DrawTank(X2, Y2, PD2, Anim2);
    end;
    if Health2 <= 0 then Dead2 := True;
    Hit2 := False;
    if Health2 = 5 then
      if PD2 = 0 then PutImage(X2, Y2, TankImg[LastDir2 + 8]^, NormalPut)
                 else PutImage(X2, Y2, TankImg[PD2 + 8]^, NormalPut);
  end;
end;


{ 03CE -------------------------------------------------------------------- }
procedure Fire1;
var D: Integer;
begin
  if Dir1 = 0 then D := LastDir1 else D := Dir1;
  Shot1Active := True;
  if D = 17 then begin
    Shot1DX := 0;  Shot1DY := -2;
    Shot1X := (X1 + (X1 + 26)) div 2 - 1;  Shot1Y := Y1 - 3;
  end;
  if D = 19 then begin
    Shot1DX := 0;  Shot1DY := 2;
    Shot1X := (X1 + (X1 + 26)) div 2 - 1;  Shot1Y := Y1 + 35;
  end;
  if D = 21 then begin
    Shot1DX := -2; Shot1DY := 0;
    Shot1Y := (Y1 + (Y1 + 26)) div 2 - 1;  Shot1X := X1 - 3;
  end;
  if D = 23 then begin
    Shot1DX := 2;  Shot1DY := 0;
    Shot1Y := (Y1 + (Y1 + 26)) div 2 - 1;  Shot1X := X1 + 35;
  end;
  PutImage(Shot1X, Shot1Y, Bullet^, NormalPut);
end;


{ 04C7 -------------------------------------------------------------------- }
procedure Fire2;
var D: Integer;
begin
  if Dir2 = 0 then D := LastDir2 else D := Dir2;
  Shot2Active := True;
  if D = 1 then begin
    Shot2DX := 0;  Shot2DY := -2;
    Shot2X := (X2 + (X2 + 26)) div 2 - 1;  Shot2Y := Y2 - 3;
  end;
  if D = 3 then begin
    Shot2DX := 0;  Shot2DY := 2;
    Shot2X := (X2 + (X2 + 26)) div 2 - 1;  Shot2Y := Y2 + 35;
  end;
  if D = 5 then begin
    Shot2DX := -2; Shot2DY := 0;
    Shot2Y := (Y2 + (Y2 + 26)) div 2 - 1;  Shot2X := X2 - 3;
  end;
  if D = 7 then begin
    Shot2DX := 2;  Shot2DY := 0;
    Shot2Y := (Y2 + (Y2 + 26)) div 2 - 1;  Shot2X := X2 + 35;
  end;
  PutImage(Shot2X, Shot2Y, Bullet^, NormalPut);
end;


{ 05C0 -------------------------------------------------------------------- }
{ Cuts every sprite out of X_DATA.PCX, which is on screen at this point. }
procedure LoadSprites;

  procedure Grab(N, Size: Word; L, T, R, B: Integer);
  begin
    GetMem(TankImg[N], Size);
    GetImage(L, T, R, B, TankImg[N]^);
  end;

begin
  BulletSize := ImageSize(0, 0, 2, 2);
  GetMem(Bullet, BulletSize);
  GetImage(0, 0, 2, 2, Bullet^);
  GetMem(BulletErase, BlankSize);      { BUG: BlankSize is 0, should be BulletSize }
  GetImage(5, 5, 7, 7, BulletErase^);

  { The original code is 32 unrolled GetMem/GetImage pairs; Grab is only
    used here to keep the listing short. Order and rectangles are exact. }
  Grab( 1, VSize,   3,   2,  29,  36);
  Grab( 2, VSize,  34,   2,  60,  36);
  Grab( 3, VSize,   3,  49,  29,  83);
  Grab( 4, VSize,  34,  49,  60,  83);
  Grab( 5, HSize, 140,   2, 174,  28);
  Grab( 6, HSize, 140,  33, 174,  59);
  Grab( 7, HSize, 187,   2, 221,  28);
  Grab( 8, HSize, 187,  33, 221,  59);
  Grab( 9, VSize,  72,   2,  98,  36);
  Grab(10, VSize, 105,   2, 131,  36);
  Grab(11, VSize,  72,  49,  98,  83);
  Grab(12, VSize, 105,  49, 131,  83);
  Grab(13, HSize, 140,  71, 174,  97);
  Grab(14, HSize, 140, 104, 174, 130);
  Grab(15, HSize, 187,  71, 221,  97);
  Grab(16, HSize, 187, 104, 221, 130);
  Grab(17, VSize,   2,  91,  28, 125);
  Grab(18, VSize,  33,  91,  59, 125);
  Grab(19, VSize,   3, 140,  29, 174);
  Grab(20, VSize,  34, 140,  60, 174);
  Grab(21, HSize, 230,   1, 264,  27);
  Grab(22, HSize, 230,  32, 264,  58);
  Grab(23, HSize, 279,   1, 313,  27);
  Grab(24, HSize, 279,  32, 313,  58);
  Grab(25, VSize,  72,  91,  98, 125);
  Grab(26, VSize, 105,  91, 131, 125);
  Grab(27, VSize,  72, 140,  98, 174);
  Grab(28, VSize, 105, 140, 131, 174);
  Grab(29, HSize, 230,  71, 264,  97);
  Grab(30, HSize, 230, 104, 264, 130);
  Grab(31, HSize, 279,  71, 313,  97);
  Grab(32, HSize, 279, 104, 313, 130);
end;


{ 0AB2 -------------------------------------------------------------------- }
{ True if any corner of the left tank lies inside the right tank's box.
  Only the left tank's corners are tested. }
function TanksCollide(PX1, PX2, PY1, PY2, PD1, PD2: Integer): Boolean;
var
  Hit : Boolean;
  R1, B1, R2, B2 : Integer;
begin
  if PD1 = 0 then PD1 := LastDir1;
  if PD2 = 0 then PD2 := LastDir2;
  Hit := False;
  if (PD1 >= 17) and (PD1 <= 20) then begin R1 := PX1 + 26; B1 := PY1 + 34 end;
  if (PD1 >= 21) and (PD1 <= 24) then begin R1 := PX1 + 34; B1 := PY1 + 26 end;
  if (PD2 >= 1)  and (PD2 <= 4)  then begin R2 := PX2 + 26; B2 := PY2 + 34 end;
  if (PD2 >= 5)  and (PD2 <= 8)  then begin R2 := PX2 + 34; B2 := PY2 + 26 end;
  if (PX1 >= PX2) and (PX1 <= R2) and (PY1 >= PY2) and (PY1 <= B2) then Hit := True;
  if (PX1 >= PX2) and (PX1 <= R2) and (B1  >= PY2) and (B1  <= B2) then Hit := True;
  if (R1  >= PX2) and (R1  <= R2) and (B1  >= PY2) and (B1  <= B2) then Hit := True;
  if (R1  >= PX2) and (R1  <= R2) and (PY1 >= PY2) and (PY1 <= B2) then Hit := True;
  TanksCollide := Hit;
end;


{ 0BED -------------------------------------------------------------------- }
procedure ClampTanks;
begin
  if X1 < 0 then X1 := 0;
  if X2 < 0 then X2 := 0;
  if Y1 < 0 then Y1 := 0;
  if Y2 < 0 then Y2 := 0;
  if X1 > 284 then X1 := 284;
  if X2 > 284 then X2 := 284;
  if Y1 > 164 then Y1 := 164;
  if Y2 > 164 then Y2 := 164;
end;


{ 0C61 -------------------------------------------------------------------- }
{ One key per frame. Note: TANK.DOC says S is "right" and lists no stop key;
  the code actually uses D for right and S / 5 to stop. Q quits. }
procedure HandleKey;
begin
  if Dir1 <> 0 then LastDir1 := Dir1;
  if Dir2 <> 0 then LastDir2 := Dir2;
  Key := ReadKey;
  Key := UpCase(Key);
  case Key of
    '8': Dir2 := 1;
    '4': Dir2 := 5;
    '6': Dir2 := 7;
    '2': Dir2 := 3;
    '5': Dir2 := 0;
    'W': Dir1 := 17;
    'A': Dir1 := 21;
    'D': Dir1 := 23;
    'X': Dir1 := 19;
    'S': Dir1 := 0;
    'Q': Quit := True;
    ' ': if not Shot1Active then Fire1;
    '0': if not Shot2Active then Fire2;
  end;
end;


{ 0D37 -------------------------------------------------------------------- }
procedure MoveShot1;
begin
  PutImage(Shot1X, Shot1Y, BulletErase^, NormalPut);
  Shot1X := Shot1X + Shot1DX;
  Shot1Y := Shot1Y + Shot1DY;
  PutImage(Shot1X, Shot1Y, Bullet^, NormalPut);
  if (Shot1X > 320) or (Shot1X < 0) then Shot1Active := False;
  if (Shot1Y > 200) or (Shot1Y < 0) then Shot1Active := False;
end;


{ 0DA9 -------------------------------------------------------------------- }
procedure MoveShot2;
begin
  PutImage(Shot2X, Shot2Y, BulletErase^, NormalPut);
  Shot2X := Shot2X + Shot2DX;
  Shot2Y := Shot2Y + Shot2DY;
  PutImage(Shot2X, Shot2Y, Bullet^, NormalPut);
  if (Shot2X > 320) or (Shot2X < 0) then Shot2Active := False;
  if (Shot2Y > 200) or (Shot2Y < 0) then Shot2Active := False;
end;


{ 0E1B -------------------------------------------------------------------- }
{ Paints dirt over the strip a tank is about to leave behind. }
procedure EraseTrail(X, Y: Integer; D: ShortInt);
begin
  if D > 16 then D := D - 16;
  if (D = 1) or (D = 2) then PutImage(X, Y + 34, EraseV^, NormalPut);
  if (D = 3) or (D = 4) then PutImage(X, Y - 1,  EraseV^, NormalPut);
  if (D = 5) or (D = 6) then PutImage(X + 34, Y, EraseH^, NormalPut);
  if (D = 7) or (D = 8) then PutImage(X - 1, Y,  EraseH^, NormalPut);
end;


{ 0EC1 -------------------------------------------------------------------- }
{ After turning between vertical and horizontal, erase the part of the old
  sprite that the new one does not cover. }
procedure EraseTurn1(D: ShortInt);
begin
  if (D = 17) or (D = 19) then PutImage(X1, Y1 + 26, TurnV^, NormalPut);
  if (D = 21) or (D = 23) then PutImage(X1 + 26, Y1, TurnH^, NormalPut);
end;


{ 0F17 -------------------------------------------------------------------- }
procedure EraseTurn2(D: ShortInt);
begin
  if (D = 1) or (D = 3) then PutImage(X2, Y2 + 26, TurnV^, NormalPut);
  if (D = 5) or (D = 7) then PutImage(X2 + 26, Y2, TurnH^, NormalPut);
end;


{ 0F81 -------------------------------------------------------------------- }
begin
  SetNumLock(True);                    { so the numpad sends digits }
  SetCapsLock(False);
  InitVGA256;                          { InstallUserDriver + InitGraph, 320x200x256 }
  ClearDevice;
  RestorePalette;
  BlackPalette;                        { draw everything invisibly, fade in later }

  LoadPCX('X_DATA.PCX');
  VSize := ImageSize(3, 2, 29, 36);
  HSize := ImageSize(140, 2, 174, 28);
  LoadSprites;

  ExplodeSize := ImageSize(154, 149, 204, 186);
  GetMem(Explode2, ExplodeSize);
  GetImage(155, 149, 204, 186, Explode2^);
  GetMem(Explode1, ExplodeSize);
  GetImage(229, 151, 278, 188, Explode1^);

  ClearDevice;
  LoadPCX('DIRT.PCX');

  EraseHSize := ImageSize(3, 2, 4, 28);
  GetMem(EraseH, EraseHSize);
  GetImage(3, 2, 4, 28, EraseH^);
  EraseVSize := ImageSize(2, 2, 28, 3);
  GetMem(EraseV, EraseVSize);
  GetImage(2, 2, 28, 3, EraseV^);
  TurnHSize := ImageSize(2, 2, 10, 28);
  GetMem(TurnH, TurnHSize);
  GetImage(2, 2, 10, 28, TurnH^);
  TurnVSize := ImageSize(2, 2, 28, 10);
  GetMem(TurnV, TurnVSize);
  GetImage(2, 2, 28, 10, TurnV^);

  X1 := 10;  X2 := 276;
  Y1 := 87;  Y2 := 87;
  Dir1 := 0; LastDir1 := 23;           { left tank faces right }
  Dir2 := 0; LastDir2 := 5;            { right tank faces left }
  Health1 := 10;
  Health2 := 10;
  PutImage(X1, Y1, TankImg[23]^, NormalPut);
  PutImage(X2, Y2, TankImg[5]^, NormalPut);

  FadeIn(50);
  FlushKeys;
  RestorePalette;

  repeat
    if KeyPressed then HandleKey;

    if (LastDir1 >= 17) and (LastDir1 <= 20) and (Dir1 >= 21) and (Dir1 <= 24) then Turn1 := True;
    if (LastDir1 >= 21) and (LastDir1 <= 24) and (Dir1 >= 17) and (Dir1 <= 20) then Turn1 := True;
    if (LastDir2 >= 1)  and (LastDir2 <= 4)  and (Dir2 >= 5)  and (Dir2 <= 8)  then Turn2 := True;
    if (LastDir2 >= 5)  and (LastDir2 <= 8)  and (Dir2 >= 1)  and (Dir2 <= 4)  then Turn2 := True;
    if Turn1 then EraseTurn1(LastDir1);
    if Turn2 then EraseTurn2(LastDir2);
    Turn1 := False;
    Turn2 := False;

    if Dir1 <> 0 then EraseTrail(X1, Y1, LastDir1);
    if Dir1 <> 0 then LastDir1 := Dir1;
    if Dir2 <> 0 then EraseTrail(X2, Y2, LastDir2);
    if Dir2 <> 0 then LastDir2 := Dir2;

    OldX1 := X1;  OldX2 := X2;
    OldY1 := Y1;  OldY2 := Y2;

    case Dir1 of
      17: Dec(Y1);
      21: Dec(X1);
      23: Inc(X1);
      19: Inc(Y1);
    end;
    case Dir2 of
      1: Dec(Y2);
      5: Dec(X2);
      7: Inc(X2);
      3: Inc(Y2);
    end;

    if Shot1Active then MoveShot1;
    if Shot2Active then MoveShot2;
    if (Shot1Active = True) or (Shot2Active = True) then
      CheckHits(X1, X2, Y1, Y2, Dir1, Dir2);
    if Dead1 then Quit := True;
    if Dead2 then Quit := True;

    if TanksCollide(X1, X2, Y1, Y2, Dir1, Dir2) = True then
    begin
      X1 := OldX1;  X2 := OldX2;
      Y1 := OldY1;  Y2 := OldY2;
    end;
    ClampTanks;

    if Dir1 <> 0 then DrawTank(X1, Y1, Dir1, Anim1);
    if Dir2 <> 0 then DrawTank(X2, Y2, Dir2, Anim2);

    Delay(20);
  until Quit;

  if Dead1 then PutImage(X1, Y1, Explode1^, NormalPut);
  if Dead2 then PutImage(X2, Y2, Explode2^, NormalPut);
  if Shot1Active then PutImage(Shot1X, Shot1Y, BulletErase^, NormalPut);
  if Shot2Active then PutImage(Shot2X, Shot2Y, BulletErase^, NormalPut);
  Delay(2000);
  FlushKeys;
  repeat until KeyPressed;

  RestorePalette;
  FadeOut(99);
  RestorePalette;
  RestoreCrtMode;                      { Graph+0D09 / Graph+0CDC: exact pair }
  CloseGraph;                          { not confirmed, effect is the same }
end.
