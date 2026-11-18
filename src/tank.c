/*
 * Tank -- modern port of Tank v1.0 Beta (FuzzySoft, 1995)
 *
 * This is a direct translation of decompiled/TANK.PAS. The game logic is
 * kept procedure-for-procedure, and it draws into a 320x200 8-bit indexed
 * framebuffer exactly the way the DOS version drew into VGA mode 13h, using
 * small stand-ins for the Borland BGI GetImage/PutImage calls. That keeps the
 * original look, including how tanks erase their own trails.
 *
 * SDL3 supplies the window, the 4:3 scaling, keyboard input, timing and the
 * palette fades that RAM Software's unit did on the VGA DAC.
 */

#include <SDL3/SDL.h>
#include <SDL3/SDL_main.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SCREEN_W 320
#define SCREEN_H 200
#define TICK_NS  (20 * 1000000ULL)     /* Delay(20) in the main loop */
#define UPSCALE  5                     /* sharp pre-scale before 4:3 stretch */

/* ------------------------------------------------------------------------ */
/* Minimal BGI emulation                                                     */
/* ------------------------------------------------------------------------ */

static uint8_t vram[SCREEN_W * SCREEN_H];
static uint8_t palette[256][3];

typedef struct
{
    int w, h;
    uint8_t *px;
} Image;

/* GetImage(l, t, r, b): rectangle is inclusive, like BGI */
static Image get_image (int l, int t, int r, int b)
{
    Image img;
    img.w  = r - l + 1;
    img.h  = b - t + 1;
    img.px = malloc ((size_t) (img.w * img.h));
    if (img.px == NULL)
    {
        fprintf (stderr, "Out of memory\n");
        exit (1);
    }

    for (int y = 0; y < img.h; y++)
        for (int x = 0; x < img.w; x++)
            img.px[y * img.w + x] = vram[(t + y) * SCREEN_W + (l + x)];

    return img;
}

/* PutImage(x, y, img, NormalPut). An image whose top-left corner is off the
   screen is not drawn; one that runs past the right or bottom edge is
   clipped. */
static void put_image (int x, int y, const Image *img)
{
    if (x < 0 || y < 0 || x >= SCREEN_W || y >= SCREEN_H)
        return;

    int w = img->w, h = img->h;
    if (x + w > SCREEN_W) w = SCREEN_W - x;
    if (y + h > SCREEN_H) h = SCREEN_H - y;

    for (int row = 0; row < h; row++)
        memcpy (&vram[(y + row) * SCREEN_W + x], &img->px[row * img->w], (size_t) w);
}

static void clear_device (void)
{
    memset (vram, 0, sizeof (vram));
}

/* ------------------------------------------------------------------------ */
/* PCX loader: 320x200, 8 bits per pixel, 1 plane, RLE, 256 colour palette   */
/* ------------------------------------------------------------------------ */

static char asset_dir[1024];

static bool load_pcx (const char *name)
{
    char path[1200];
    snprintf (path, sizeof (path), "%s%s", asset_dir, name);

    size_t size = 0;
    uint8_t *data = SDL_LoadFile (path, &size);
    if (data == NULL)
    {
        SDL_ShowSimpleMessageBox (SDL_MESSAGEBOX_ERROR, "Tank", SDL_GetError(), NULL);
        return false;
    }

    bool ok = false;
    if (size > 128 + 769 && data[0] == 0x0A && data[2] == 1 && data[3] == 8 && data[65] == 1)
    {
        int xmin = data[4] | (data[5] << 8), ymin = data[6]  | (data[7]  << 8);
        int xmax = data[8] | (data[9] << 8), ymax = data[10] | (data[11] << 8);
        int bpl  = data[66] | (data[67] << 8);
        int w = xmax - xmin + 1, h = ymax - ymin + 1;

        size_t pos = 128;
        size_t end = size - 769;
        for (int y = 0; y < h && pos < end; y++)
        {
            int x = 0;
            while (x < bpl && pos < end)
            {
                uint8_t c = data[pos++];
                int run = 1;
                if ((c & 0xC0) == 0xC0)
                {
                    run = c & 0x3F;
                    c = pos < end ? data[pos++] : 0;
                }
                for (; run > 0 && x < bpl; run--, x++)
                    if (x < w && x < SCREEN_W && y < SCREEN_H)
                        vram[y * SCREEN_W + x] = c;
            }
        }

        if (data[size - 769] == 0x0C)
        {
            memcpy (palette, &data[size - 768], 768);
            ok = true;
        }
    }

    if (! ok)
        SDL_ShowSimpleMessageBox (SDL_MESSAGEBOX_ERROR, "Tank", "Unsupported PCX file", NULL);

    SDL_free (data);
    return ok;
}

/* ------------------------------------------------------------------------ */
/* Game state: same variables as TANK.PAS                                    */
/* ------------------------------------------------------------------------ */

static Image TankImg[33];              /* 1..32 */
static Image EraseH, EraseV, TurnH, TurnV;
static Image Bullet, BulletErase;
static Image Explode1, Explode2;

static bool   Quit, Turn1, Turn2;
static int    X1, X2, Y1, Y2;
static int    OldX1, OldX2, OldY1, OldY2;
static int8_t Dir1, LastDir1, Dir2, LastDir2;
static int8_t Anim1, Anim2;
static bool   Shot1Active, Shot2Active;
static int    Shot1X, Shot1Y, Shot2X, Shot2Y;
static int    Shot1DX, Shot1DY, Shot2DX, Shot2DY;
static bool   Dead1, Dead2;
static int8_t Health1, Health2;
static bool   Hit1, Hit2;

static void DrawTank (int X, int Y, int8_t Frame, int8_t *Anim)
{
    if (Health1 < 6 && Frame > 16 && Frame < 24) Frame += 8;
    if (Health2 < 6 && Frame > 0  && Frame < 8)  Frame += 8;

    *Anim = (int8_t) (*Anim + 1);
    if (*Anim & 1) Frame += 1;

    put_image (X, Y, &TankImg[Frame]);
}

static bool in_box (int px, int py, int l, int t, int r, int b)
{
    return px >= l && px <= r && py >= t && py <= b;
}

static void CheckHits (int PX1, int PX2, int PY1, int PY2, int PD1, int PD2)
{
    int R1 = 0, B1 = 0, R2 = 0, B2 = 0;

    if (Shot2Active)
    {
        if (PD1 == 0) PD1 = LastDir1;
        if (PD1 >= 17 && PD1 <= 20) { R1 = PX1 + 26; B1 = PY1 + 34; }
        if (PD1 >= 21 && PD1 <= 24) { R1 = PX1 + 34; B1 = PY1 + 26; }
        int S2R = Shot2X + 3, S2B = Shot2Y + 3;
        if (in_box (Shot2X, Shot2Y, PX1, PY1, R1, B1)) Hit1 = true;
        if (in_box (Shot2X, S2B,    PX1, PY1, R1, B1)) Hit1 = true;
        if (in_box (S2R,    S2B,    PX1, PY1, R1, B1)) Hit1 = true;
        if (in_box (S2R,    Shot2Y, PX1, PY1, R1, B1)) Hit1 = true;
        if (Hit1)
        {
            Health1--;
            Shot2Active = false;
            put_image (Shot2X, Shot2Y, &BulletErase);
            Anim1--;
            DrawTank (X1, Y1, (int8_t) PD1, &Anim1);
        }
        Hit1 = false;
        if (Health1 <= 0) Dead1 = true;
        if (Health1 == 5)
            put_image (X1, Y1, &TankImg[(PD1 == 0 ? LastDir1 : PD1) + 8]);
    }

    if (Shot1Active)
    {
        if (PD2 == 0) PD2 = LastDir2;
        if (PD2 >= 1 && PD2 <= 4) { R2 = PX2 + 26; B2 = PY2 + 34; }
        if (PD2 >= 5 && PD2 <= 8) { R2 = PX2 + 34; B2 = PY2 + 26; }
        int S1R = Shot1X + 3, S1B = Shot1Y + 3;
        if (in_box (Shot1X, Shot1Y, PX2, PY2, R2, B2)) Hit2 = true;
        if (in_box (Shot1X, S1B,    PX2, PY2, R2, B2)) Hit2 = true;
        if (in_box (S1R,    S1B,    PX2, PY2, R2, B2)) Hit2 = true;
        if (in_box (S1R,    Shot1Y, PX2, PY2, R2, B2)) Hit2 = true;
        if (Hit2)
        {
            Health2--;
            Shot1Active = false;
            put_image (Shot1X, Shot1Y, &BulletErase);
            Anim2--;
            DrawTank (X2, Y2, (int8_t) PD2, &Anim2);
        }
        if (Health2 <= 0) Dead2 = true;
        Hit2 = false;
        if (Health2 == 5)
            put_image (X2, Y2, &TankImg[(PD2 == 0 ? LastDir2 : PD2) + 8]);
    }
}

static void Fire1 (void)
{
    int D = Dir1 == 0 ? LastDir1 : Dir1;
    Shot1Active = true;
    if (D == 17) { Shot1DX = 0;  Shot1DY = -2; Shot1X = (X1 + X1 + 26) / 2 - 1; Shot1Y = Y1 - 3;  }
    if (D == 19) { Shot1DX = 0;  Shot1DY = 2;  Shot1X = (X1 + X1 + 26) / 2 - 1; Shot1Y = Y1 + 35; }
    if (D == 21) { Shot1DX = -2; Shot1DY = 0;  Shot1Y = (Y1 + Y1 + 26) / 2 - 1; Shot1X = X1 - 3;  }
    if (D == 23) { Shot1DX = 2;  Shot1DY = 0;  Shot1Y = (Y1 + Y1 + 26) / 2 - 1; Shot1X = X1 + 35; }
    put_image (Shot1X, Shot1Y, &Bullet);
}

static void Fire2 (void)
{
    int D = Dir2 == 0 ? LastDir2 : Dir2;
    Shot2Active = true;
    if (D == 1) { Shot2DX = 0;  Shot2DY = -2; Shot2X = (X2 + X2 + 26) / 2 - 1; Shot2Y = Y2 - 3;  }
    if (D == 3) { Shot2DX = 0;  Shot2DY = 2;  Shot2X = (X2 + X2 + 26) / 2 - 1; Shot2Y = Y2 + 35; }
    if (D == 5) { Shot2DX = -2; Shot2DY = 0;  Shot2Y = (Y2 + Y2 + 26) / 2 - 1; Shot2X = X2 - 3;  }
    if (D == 7) { Shot2DX = 2;  Shot2DY = 0;  Shot2Y = (Y2 + Y2 + 26) / 2 - 1; Shot2X = X2 + 35; }
    put_image (Shot2X, Shot2Y, &Bullet);
}

static void LoadSprites (void)
{
    static const int16_t rects[32][4] = {
        {  3,   2,  29,  36}, { 34,   2,  60,  36}, {  3,  49,  29,  83}, { 34,  49,  60,  83},
        {140,   2, 174,  28}, {140,  33, 174,  59}, {187,   2, 221,  28}, {187,  33, 221,  59},
        { 72,   2,  98,  36}, {105,   2, 131,  36}, { 72,  49,  98,  83}, {105,  49, 131,  83},
        {140,  71, 174,  97}, {140, 104, 174, 130}, {187,  71, 221,  97}, {187, 104, 221, 130},
        {  2,  91,  28, 125}, { 33,  91,  59, 125}, {  3, 140,  29, 174}, { 34, 140,  60, 174},
        {230,   1, 264,  27}, {230,  32, 264,  58}, {279,   1, 313,  27}, {279,  32, 313,  58},
        { 72,  91,  98, 125}, {105,  91, 131, 125}, { 72, 140,  98, 174}, {105, 140, 131, 174},
        {230,  71, 264,  97}, {230, 104, 264, 130}, {279,  71, 313,  97}, {279, 104, 313, 130},
    };

    Bullet = get_image (0, 0, 2, 2);
    /* The original allocated this with an unset size variable (0 bytes). */
    BulletErase = get_image (5, 5, 7, 7);

    for (int i = 0; i < 32; i++)
        TankImg[i + 1] = get_image (rects[i][0], rects[i][1], rects[i][2], rects[i][3]);
}

static bool TanksCollide (int PX1, int PX2, int PY1, int PY2, int PD1, int PD2)
{
    int R1 = 0, B1 = 0, R2 = 0, B2 = 0;
    if (PD1 == 0) PD1 = LastDir1;
    if (PD2 == 0) PD2 = LastDir2;
    bool Hit = false;
    if (PD1 >= 17 && PD1 <= 20) { R1 = PX1 + 26; B1 = PY1 + 34; }
    if (PD1 >= 21 && PD1 <= 24) { R1 = PX1 + 34; B1 = PY1 + 26; }
    if (PD2 >= 1  && PD2 <= 4)  { R2 = PX2 + 26; B2 = PY2 + 34; }
    if (PD2 >= 5  && PD2 <= 8)  { R2 = PX2 + 34; B2 = PY2 + 26; }
    if (in_box (PX1, PY1, PX2, PY2, R2, B2)) Hit = true;
    if (in_box (PX1, B1,  PX2, PY2, R2, B2)) Hit = true;
    if (in_box (R1,  B1,  PX2, PY2, R2, B2)) Hit = true;
    if (in_box (R1,  PY1, PX2, PY2, R2, B2)) Hit = true;
    return Hit;
}

static void ClampTanks (void)
{
    if (X1 < 0) X1 = 0;
    if (X2 < 0) X2 = 0;
    if (Y1 < 0) Y1 = 0;
    if (Y2 < 0) Y2 = 0;
    if (X1 > 284) X1 = 284;
    if (X2 > 284) X2 = 284;
    if (Y1 > 164) Y1 = 164;
    if (Y2 > 164) Y2 = 164;
}

static void HandleKey (char Key)
{
    if (Dir1 != 0) LastDir1 = Dir1;
    if (Dir2 != 0) LastDir2 = Dir2;
    switch (Key)
    {
        case '8': Dir2 = 1; break;
        case '4': Dir2 = 5; break;
        case '6': Dir2 = 7; break;
        case '2': Dir2 = 3; break;
        case '5': Dir2 = 0; break;
        case 'W': Dir1 = 17; break;
        case 'A': Dir1 = 21; break;
        case 'D': Dir1 = 23; break;
        case 'X': Dir1 = 19; break;
        case 'S': Dir1 = 0; break;
        case 'Q': Quit = true; break;
        case ' ': if (! Shot1Active) Fire1(); break;
        case '0': if (! Shot2Active) Fire2(); break;
        default: break;
    }
}

static void MoveShot1 (void)
{
    put_image (Shot1X, Shot1Y, &BulletErase);
    Shot1X += Shot1DX;
    Shot1Y += Shot1DY;
    put_image (Shot1X, Shot1Y, &Bullet);
    if (Shot1X > 320 || Shot1X < 0) Shot1Active = false;
    if (Shot1Y > 200 || Shot1Y < 0) Shot1Active = false;
}

static void MoveShot2 (void)
{
    put_image (Shot2X, Shot2Y, &BulletErase);
    Shot2X += Shot2DX;
    Shot2Y += Shot2DY;
    put_image (Shot2X, Shot2Y, &Bullet);
    if (Shot2X > 320 || Shot2X < 0) Shot2Active = false;
    if (Shot2Y > 200 || Shot2Y < 0) Shot2Active = false;
}

static void EraseTrail (int X, int Y, int8_t D)
{
    if (D > 16) D -= 16;
    if (D == 1 || D == 2) put_image (X, Y + 34, &EraseV);
    if (D == 3 || D == 4) put_image (X, Y - 1,  &EraseV);
    if (D == 5 || D == 6) put_image (X + 34, Y, &EraseH);
    if (D == 7 || D == 8) put_image (X - 1, Y,  &EraseH);
}

static void EraseTurn1 (int8_t D)
{
    if (D == 17 || D == 19) put_image (X1, Y1 + 26, &TurnV);
    if (D == 21 || D == 23) put_image (X1 + 26, Y1, &TurnH);
}

static void EraseTurn2 (int8_t D)
{
    if (D == 1 || D == 3) put_image (X2, Y2 + 26, &TurnV);
    if (D == 5 || D == 7) put_image (X2 + 26, Y2, &TurnH);
}

/* Body of the repeat..until loop in the main program, minus Delay(20) */
static void GameTick (bool KeyPressed, char Key)
{
    if (KeyPressed) HandleKey (Key);

    if (LastDir1 >= 17 && LastDir1 <= 20 && Dir1 >= 21 && Dir1 <= 24) Turn1 = true;
    if (LastDir1 >= 21 && LastDir1 <= 24 && Dir1 >= 17 && Dir1 <= 20) Turn1 = true;
    if (LastDir2 >= 1  && LastDir2 <= 4  && Dir2 >= 5  && Dir2 <= 8)  Turn2 = true;
    if (LastDir2 >= 5  && LastDir2 <= 8  && Dir2 >= 1  && Dir2 <= 4)  Turn2 = true;
    if (Turn1) EraseTurn1 (LastDir1);
    if (Turn2) EraseTurn2 (LastDir2);
    Turn1 = false;
    Turn2 = false;

    if (Dir1 != 0) EraseTrail (X1, Y1, LastDir1);
    if (Dir1 != 0) LastDir1 = Dir1;
    if (Dir2 != 0) EraseTrail (X2, Y2, LastDir2);
    if (Dir2 != 0) LastDir2 = Dir2;

    OldX1 = X1; OldX2 = X2;
    OldY1 = Y1; OldY2 = Y2;

    switch (Dir1) { case 17: Y1--; break; case 21: X1--; break; case 23: X1++; break; case 19: Y1++; break; }
    switch (Dir2) { case 1:  Y2--; break; case 5:  X2--; break; case 7:  X2++; break; case 3:  Y2++; break; }

    if (Shot1Active) MoveShot1();
    if (Shot2Active) MoveShot2();
    if (Shot1Active || Shot2Active)
        CheckHits (X1, X2, Y1, Y2, Dir1, Dir2);
    if (Dead1) Quit = true;
    if (Dead2) Quit = true;

    if (TanksCollide (X1, X2, Y1, Y2, Dir1, Dir2))
    {
        X1 = OldX1; X2 = OldX2;
        Y1 = OldY1; Y2 = OldY2;
    }
    ClampTanks();

    if (Dir1 != 0) DrawTank (X1, Y1, Dir1, &Anim1);
    if (Dir2 != 0) DrawTank (X2, Y2, Dir2, &Anim2);
}

/* Main program up to the start of the game loop */
static bool StartGame (void)
{
    clear_device();
    if (! load_pcx ("X_DATA.PCX"))
        return false;
    LoadSprites();
    Explode2 = get_image (155, 149, 204, 186);
    Explode1 = get_image (229, 151, 278, 188);

    clear_device();
    if (! load_pcx ("DIRT.PCX"))
        return false;
    EraseH = get_image (3, 2, 4, 28);
    EraseV = get_image (2, 2, 28, 3);
    TurnH  = get_image (2, 2, 10, 28);
    TurnV  = get_image (2, 2, 28, 10);

    X1 = 10;  X2 = 276;
    Y1 = 87;  Y2 = 87;
    Dir1 = 0; LastDir1 = 23;
    Dir2 = 0; LastDir2 = 5;
    Health1 = 10;
    Health2 = 10;
    put_image (X1, Y1, &TankImg[23]);
    put_image (X2, Y2, &TankImg[5]);
    return true;
}

/* Code after the game loop, before the fade out */
static void EndGame (void)
{
    if (Dead1) put_image (X1, Y1, &Explode1);
    if (Dead2) put_image (X2, Y2, &Explode2);
    if (Shot1Active) put_image (Shot1X, Shot1Y, &BulletErase);
    if (Shot2Active) put_image (Shot2X, Shot2Y, &BulletErase);
}

/* ------------------------------------------------------------------------ */
/* Platform layer                                                            */
/* ------------------------------------------------------------------------ */

/* Turn a key press into the character DOS ReadKey + UpCase would return.
   Uses physical key positions. Main-row digits worked in DOS too. Arrow keys
   did nothing in the original; they are added here for player 2 on
   keyboards without a numeric keypad. */
static char key_to_char (SDL_Scancode sc)
{
    switch (sc)
    {
        case SDL_SCANCODE_W: return 'W';
        case SDL_SCANCODE_A: return 'A';
        case SDL_SCANCODE_S: return 'S';
        case SDL_SCANCODE_D: return 'D';
        case SDL_SCANCODE_X: return 'X';
        case SDL_SCANCODE_Q: return 'Q';
        case SDL_SCANCODE_SPACE: return ' ';

        case SDL_SCANCODE_KP_8: case SDL_SCANCODE_8: case SDL_SCANCODE_UP:    return '8';
        case SDL_SCANCODE_KP_4: case SDL_SCANCODE_4: case SDL_SCANCODE_LEFT:  return '4';
        case SDL_SCANCODE_KP_6: case SDL_SCANCODE_6: case SDL_SCANCODE_RIGHT: return '6';
        case SDL_SCANCODE_KP_2: case SDL_SCANCODE_2: case SDL_SCANCODE_DOWN:  return '2';
        case SDL_SCANCODE_KP_5: case SDL_SCANCODE_5:                          return '5';
        case SDL_SCANCODE_KP_0: case SDL_SCANCODE_0: case SDL_SCANCODE_RCTRL: return '0';
        default: return 0;
    }
}

/* BIOS keyboard buffer: the game reads one key per frame */
static char key_queue[16];
static int  key_head, key_count;

static void push_key (char c)
{
    if (key_count < (int) sizeof (key_queue))
    {
        key_queue[(key_head + key_count) % (int) sizeof (key_queue)] = c;
        key_count++;
    }
}

static bool pop_key (char *c)
{
    if (key_count == 0)
        return false;
    *c = key_queue[key_head];
    key_head = (key_head + 1) % (int) sizeof (key_queue);
    key_count--;
    return true;
}

static void flush_keys (void)
{
    key_head = key_count = 0;
}

typedef enum
{
    STATE_FADE_IN,      /* FadeIn(50)                       */
    STATE_PLAY,         /* repeat ... until Quit            */
    STATE_PAUSE,        /* Delay(2000)                      */
    STATE_WAIT_KEY,     /* FlushKeys; repeat until KeyPressed */
    STATE_FADE_OUT,     /* FadeOut(99)                      */
    STATE_DONE
} State;

/* FadeIn/FadeOut step once per VGA retrace (70 Hz) */
#define FADE_IN_NS  (50ULL * 1000000000ULL / 70)
#define FADE_OUT_NS (99ULL * 1000000000ULL / 70)

static void present (SDL_Renderer *renderer, SDL_Texture *screen, SDL_Texture *upscaled, float brightness)
{
    uint32_t pal[256];
    for (int i = 0; i < 256; i++)
    {
        uint32_t r = (uint32_t) (palette[i][0] * brightness);
        uint32_t g = (uint32_t) (palette[i][1] * brightness);
        uint32_t b = (uint32_t) (palette[i][2] * brightness);
        pal[i] = 0xFF000000u | (r << 16) | (g << 8) | b;
    }

    void *pixels;
    int pitch;
    if (SDL_LockTexture (screen, NULL, &pixels, &pitch))
    {
        for (int y = 0; y < SCREEN_H; y++)
        {
            uint32_t *row = (uint32_t *) ((uint8_t *) pixels + y * pitch);
            for (int x = 0; x < SCREEN_W; x++)
                row[x] = pal[vram[y * SCREEN_W + x]];
        }
        SDL_UnlockTexture (screen);
    }

    /* Nearest-neighbour upscale first, then a smooth stretch to 4:3. Mode 13h
       pixels were taller than wide, so this matches a CRT without uneven rows. */
    SDL_SetRenderTarget (renderer, upscaled);
    SDL_RenderTexture (renderer, screen, NULL, NULL);
    SDL_SetRenderTarget (renderer, NULL);

    int ww, wh;
    SDL_GetCurrentRenderOutputSize (renderer, &ww, &wh);
    float dw = (float) ww, dh = dw * 3.0f / 4.0f;
    if (dh > (float) wh) { dh = (float) wh; dw = dh * 4.0f / 3.0f; }
    SDL_FRect dst = { ((float) ww - dw) / 2.0f, ((float) wh - dh) / 2.0f, dw, dh };

    SDL_SetRenderDrawColor (renderer, 0, 0, 0, 255);
    SDL_RenderClear (renderer);
    SDL_RenderTexture (renderer, upscaled, NULL, &dst);
    SDL_RenderPresent (renderer);
}

int main (int argc, char *argv[])
{
    (void) argc;
    (void) argv;

    if (! SDL_Init (SDL_INIT_VIDEO))
    {
        fprintf (stderr, "SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }

    const char *base = SDL_GetBasePath();
    snprintf (asset_dir, sizeof (asset_dir), "%sassets/", base ? base : "");
    {
        /* Fall back to ./assets/ when run from the source tree */
        char probe[1200];
        snprintf (probe, sizeof (probe), "%sDIRT.PCX", asset_dir);
        SDL_PathInfo info;
        if (! SDL_GetPathInfo (probe, &info))
            snprintf (asset_dir, sizeof (asset_dir), "assets/");
    }

    SDL_Window *window = NULL;
    SDL_Renderer *renderer = NULL;
    if (! SDL_CreateWindowAndRenderer ("Tank", 960, 720, SDL_WINDOW_RESIZABLE | SDL_WINDOW_HIGH_PIXEL_DENSITY,
                                       &window, &renderer))
    {
        fprintf (stderr, "Window creation failed: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }
    SDL_SetRenderVSync (renderer, 1);

    SDL_Texture *screen = SDL_CreateTexture (renderer, SDL_PIXELFORMAT_XRGB8888, SDL_TEXTUREACCESS_STREAMING,
                                             SCREEN_W, SCREEN_H);
    SDL_Texture *upscaled = SDL_CreateTexture (renderer, SDL_PIXELFORMAT_XRGB8888, SDL_TEXTUREACCESS_TARGET,
                                               SCREEN_W * UPSCALE, SCREEN_H * UPSCALE);
    SDL_SetTextureScaleMode (screen, SDL_SCALEMODE_NEAREST);
    SDL_SetTextureScaleMode (upscaled, SDL_SCALEMODE_LINEAR);

    if (! StartGame())
    {
        SDL_Quit();
        return 1;
    }

    State state = STATE_FADE_IN;
    uint64_t state_start = SDL_GetTicksNS();
    uint64_t next_tick = state_start;
    bool running = true;

    while (running && state != STATE_DONE)
    {
        SDL_Event e;
        while (SDL_PollEvent (&e))
        {
            if (e.type == SDL_EVENT_QUIT)
                running = false;
            else if (e.type == SDL_EVENT_KEY_DOWN && ! e.key.repeat)
            {
                if (e.key.scancode == SDL_SCANCODE_ESCAPE)
                    running = false;
                else if (e.key.scancode == SDL_SCANCODE_F11 ||
                         (e.key.scancode == SDL_SCANCODE_RETURN && (e.key.mod & SDL_KMOD_ALT)))
                    SDL_SetWindowFullscreen (window, ! (SDL_GetWindowFlags (window) & SDL_WINDOW_FULLSCREEN));
                else if (state == STATE_PLAY || state == STATE_WAIT_KEY)
                {
                    char c = key_to_char (e.key.scancode);
                    if (state == STATE_WAIT_KEY)
                        push_key (c ? c : '?');
                    else if (c)
                        push_key (c);
                }
            }
        }

        uint64_t now = SDL_GetTicksNS();
        uint64_t elapsed = now - state_start;
        float brightness = 1.0f;

        switch (state)
        {
            case STATE_FADE_IN:
                brightness = (float) elapsed / (float) FADE_IN_NS;
                if (elapsed >= FADE_IN_NS)
                {
                    flush_keys();
                    state = STATE_PLAY;
                    next_tick = now;
                    brightness = 1.0f;
                }
                break;

            case STATE_PLAY:
                for (int ticks = 0; now >= next_tick && ticks < 5 && ! Quit; ticks++)
                {
                    char key = 0;
                    bool pressed = pop_key (&key);
                    GameTick (pressed, key);
                    next_tick += TICK_NS;
                }
                if (now >= next_tick)
                    next_tick = now;   /* don't try to catch up after a stall */
                if (Quit)
                {
                    EndGame();
                    state = STATE_PAUSE;
                    state_start = now;
                }
                break;

            case STATE_PAUSE:
                if (elapsed >= 2000ULL * 1000000ULL)
                {
                    flush_keys();
                    state = STATE_WAIT_KEY;
                    state_start = now;
                }
                break;

            case STATE_WAIT_KEY:
            {
                char c;
                if (pop_key (&c))
                {
                    state = STATE_FADE_OUT;
                    state_start = now;
                }
                break;
            }

            case STATE_FADE_OUT:
                brightness = 1.0f - (float) elapsed / (float) FADE_OUT_NS;
                if (elapsed >= FADE_OUT_NS)
                {
                    brightness = 0.0f;
                    state = STATE_DONE;
                }
                break;

            case STATE_DONE:
                break;
        }

        if (brightness < 0.0f) brightness = 0.0f;
        if (brightness > 1.0f) brightness = 1.0f;
        present (renderer, screen, upscaled, brightness);

        SDL_Delay (1);
    }

    SDL_DestroyTexture (upscaled);
    SDL_DestroyTexture (screen);
    SDL_DestroyRenderer (renderer);
    SDL_DestroyWindow (window);
    SDL_Quit();
    return 0;
}
