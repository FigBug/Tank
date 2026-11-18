# Tank

A modern port of **Tank v1.0 Beta** (FuzzySoft, 1995), a two-player DOS tank
game by Roland Rabien and Malcolm Walker.

The original `TANK.EXE` was decompiled by hand back into Turbo Pascal, and the
game was then rewritten in C with SDL3. It uses the original sprite and
background images, and plays the same way the DOS version did.

## Folders

| Path | Contents |
| --- | --- |
| `original/` | The files from `tank.zip`, unchanged |
| `decompiled/TANK.PAS` | Turbo Pascal 7 source rebuilt from the executable |
| `decompiled/TANK_main.asm` | Disassembly of the game code, used to check the Pascal |
| `src/tank.c` | The modern port |
| `assets/` | `X_DATA.PCX` sprite sheet and `DIRT.PCX` background |

## Building

You need CMake and SDL3.

```sh
# macOS
brew install cmake sdl3

# Debian / Ubuntu (24.10 or newer)
sudo apt install cmake libsdl3-dev

# Windows
vcpkg install sdl3
```

Then build and run:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
./build/tank
```

The build copies `assets/` next to the executable.

## Controls

| Action | Left tank | Right tank |
| --- | --- | --- |
| Up | W | Keypad 8 |
| Left | A | Keypad 4 |
| Right | D | Keypad 6 |
| Down | X | Keypad 2 |
| Stop | S | Keypad 5 |
| Fire | Space | Keypad 0 |

Tanks keep moving until you press stop. Ten hits destroy a tank. Q ends the
game. After a game ends, press any key to fade out and exit.

The original `TANK.DOC` lists S as "right" and does not mention the stop keys
or Q. The code shows D is right and S is stop, so the table above follows the
code.

The port adds a few conveniences that the DOS version did not have. The arrow
keys and Right Ctrl also control the right tank, for keyboards without a
numeric keypad. Escape exits at any time, and F11 or Alt+Enter toggles full
screen.

## How faithful is it

`src/tank.c` follows `TANK.PAS` procedure by procedure. It draws into a
320x200 256-colour framebuffer with small replacements for Borland's
`GetImage` and `PutImage`, just as the original drew into VGA mode 13h. The
game runs at 50 ticks per second, which matches the `Delay(20)` in the
original main loop. The screen is shown at 4:3, like a VGA monitor.

These quirks of the original are kept on purpose:

- Only one key is read per frame, from a queue like the BIOS keyboard buffer.
- Tank-to-tank collision only checks the left tank's corners against the
  right tank's box.
- Tanks switch to the damaged sprite after five hits.

One original bug is not kept. The buffer for the bullet's erase patch was
allocated with a size variable that is never set, so it got zero bytes. The
port allocates it properly.
