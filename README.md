# Description
GNU Modula-2 bindings to excellent **Raylib** and **Raygui**.

[Raylib](http://www.raylib.com/) is a "simple and easy-to-use library to enjoy videogames programming".
[Raygui](https://github.com/raysan5/raygui) is a "simple and easy-to-use immediate-mode gui library". 

This is a low-level, *thin* bindings, i.e. the module definitions just directly map C API to Modula-2, with all of the names and meanings left intact to mimic the original behaviour.

# Status
The bindings are considered to be **complete**, with every type, procedure or constant being interfaced somehow. The following raylib library components are bound to their respective Modula-2 definition files:
- **raylib** as per `raylib.h` is covered in **rl.def**
- **raymath** as per `raymath.h` is covered in **rm.def**
- **raygui** as per `raygui.h` is covered in **rg.def**
 
# Versions
The library versions used in making of the bindings are:
- `raylib-5.1-dev`
- `raygui-4.0-dev` 

Tested with `GCC 14.0.1`, ISO Modula-2.

# Usage
Use entities from provided definition modules:
- module **rl** covers `raylib`
- module **rm** covers `raymath`
- module **rg** convers `raygui`

Functions, datastructures and constants are bound one-to-one, so old knowledge of the API holds. 
The [Raylib](https://www.raylib.com/cheatsheet/raylib_cheatsheet_v4.5.pdf) and 
[Raymath](https://www.raylib.com/cheatsheet/raymath_cheatsheet.html) cheatsheets help, the [Raygui](https://github.com/raysan5/raygui/blob/master/src/raygui.h) is not documented well enough for the moment, so one must consult the source file.

I have decided to explicitly redefine the C primitives as follows:

``` modula-2
TYPE
  voidptr = SYSTEM.ADDRESS;
  int     = SYSTEM.INTEGER32;
  uint    = SYSTEM.CARDINAL32;
  ushort  = SYSTEM.CARDINAL16;
  char    = SYSTEM.INTEGER8;
  uchar   = SYSTEM.BYTE;
  float   = SYSTEM.REAL32;
  double  = SYSTEM.REAL64;
  long    = SYSTEM.INTEGER64;
```

# Compilation
Compile program module with something like that:
``` sh
gm2-14 -fsoft-check-all -fiso -g -O2 -Wall SampleUsage.mod ./libraylib.so.4.5.0 ./raygui.so
```
or just
``` sh
gm2-14 -fsoft-check-all -fiso -g -O2 -Wall SampleUsage.mod -lraylib -lraygui
```
if the linker can find the library on your system.
Please see provided `Makefile` for my attempt at a more general workflow with *modules* and *driver programs*.

N.B. The raylib component named `raymath` is contained also in `raylib.so`.
N.B. The raygui is a separate library per se.

# TODO
- excessive testing
- unify comments formatting
- optimize code sections 
- cleanup ugliness in `rg`

# Sample code
This is what a client code looks like:

``` modula-2
MODULE SampleUsage;

IMPORT rl, rm, rg;

PROCEDURE TestRaylib;
CONST
  imgPath = "assets/brain.png";
VAR
  pos : rl.Vector2;
  img : rl.Image;
  texImg, texFile : rl.Texture2D;
  fnt : rl.Font;
  showMessageBox : BOOLEAN;
  result : rl.int;
BEGIN
  showMessageBox := FALSE;

  rl.InitWindow(800, 600, "Modula-2 + Raylib");

  img := rl.GenImageCellular(800, 600, 20);
  texImg := rl.LoadTextureFromImage(img);
  rl.UnloadImage(img);
  img := rl.LoadImage(imgPath);
  texFile := rl.LoadTextureFromImage(img);
  rl.UnloadImage(img);

  fnt := rl.LoadFont("assets/dejavu.fnt");

(*   rl.ToggleFullscreen; *)

  WHILE (NOT rl.WindowShouldClose()) AND (NOT rl.IsKeyPressed(rl.KEY_SPACE)) DO
    rl.BeginDrawing;
    rl.ClearBackground(rl.Color{0,0,0, 0});

    pos := rl.GetMousePosition();
    pos := rm.Vector2AddValue(pos, FLOAT(100.0));
    rl.DrawTexture(texImg, 0, 0, rl.Color{255,255,255,255});
    rl.DrawTexture(texFile, 100, 100, rl.Color{255,255,255,255});
    rl.DrawLine(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(),
        rl.Color{0, 255, 0, 255});
    rl.DrawLineEx(rl.Vector2{800.0, 0.0}, rl.Vector2{0.0, 600.0}, 5.0,
        rl.Color{0, 0, 255, 255});
    rl.DrawText("Hello, from Modula-2!", 320, 240, 20,
        rl.Color{150, 20, 100,255});
    rl.DrawTextEx(fnt, "MOUSE", pos, 18.0, 6.0, rl.YELLOW);
    rl.DrawTextEx(fnt, "Привет, Мир!",
        rl.Vector2{300.0, 260.0}, 40.0, 1.0, rl.Color{255, 255, 255, 100});

    IF rg.GuiButton(rl.Rectangle{ 24, 24, 120, 30 }, "#191#Show Message") THEN
      showMessageBox := TRUE;
    END;

    IF showMessageBox THEN
       result := rg.GuiMessageBox(rl.Rectangle{ 85, 70, 250, 100 },
                    "#191#Message Box", "Hi! This is a message!", "Nice;Cool");
        IF result >= 0 THEN
          showMessageBox := FALSE;
        END;
    END;

    rl.EndDrawing;
    rl.WaitTime(1.0 / 60.0);
  END;
END TestRaylib;

BEGIN
   TestRaylib;
END SampleUsage.

```

# Screenshot
![screenshot](screenshot.png)
