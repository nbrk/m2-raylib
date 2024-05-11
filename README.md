# m2-raylib
GNU Modula-2 bindings for [raylib](http://www.raylib.com/), a simple and easy-to-use library to enjoy videogames programming.

This is a low-level, *thin* bindings, i.e. the module definition just directly maps C API to Modula-2, with all of the names
and meanings left intact to mimic the original API.

# Status
The bindings are considered to be (almost) complete, with virtually every `raylib` entity being interfaced somehow.
Testing is especially requested for stuff other than that used for a simple 2D-drawing.

# Versions
The library version used in making of the bindings is `raylib-5.1-dev` (the C header file is bundled). 
Tested with `GCC 14.0.1`, ISO Modula-2.

# TODO
- excessive testing
- custom raylib color palette constants

# Usage
Use entities from the provided definition module `rl`. Functions, datastructures and constants are bound one-to-one, 
so old knowledge holds. The [Raylib cheatsheet](https://www.raylib.com/cheatsheet/raylib_cheatsheet_v4.5.pdf) helps). 

Compile a program module with something like that:
``` sh
gm2-14 -fsoft-check-all -fiso -g -O2 -Wall SampleUsage.mod ./libraylib.so.4.5.0
```
or just
``` sh
gm2-14 -fsoft-check-all -fiso -g -O2 -Wall SampleUsage.mod -lraylib
```
if the linker can find the library on your system.

Please see the provided `Makefile` for my attempt at a more general workflow with *modules* and *driver programs*.

# Sample code
This is what a client code looks like:

``` modula-2
MODULE SampleUsage;

IMPORT rl;

PROCEDURE TestRaylib;
CONST
  imgPath = "assets/brain.png";
VAR
  pos : rl.Vector2;
  img : rl.Image;
  texImg, texFile : rl.Texture2D;
  fnt : rl.Font;
BEGIN
  rl.InitWindow(800, 600, "Modula-2 + Raylib");

  img := rl.GenImageCellular(800, 600, 20);
  texImg := rl.LoadTextureFromImage(img);
  rl.UnloadImage(img);
  img := rl.LoadImage(imgPath);
  texFile := rl.LoadTextureFromImage(img);
  rl.UnloadImage(img);

  fnt := rl.LoadFont("assets/dejavu.fnt");

(*   rl.ToggleFullscreen; *)

  WHILE NOT rl.WindowShouldClose() OR rl.IsKeyPressed(rl.KEY_SPACE) DO
    rl.BeginDrawing;
    rl.ClearBackground(rl.Color{0,0,0, 0});

    pos := rl.GetMousePosition();
    rl.DrawTexture(texImg, 0, 0, rl.Color{255,255,255,255});
    rl.DrawTexture(texFile, 100, 100, rl.Color{255,255,255,255});
    rl.DrawLine(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(),
        rl.Color{0, 255, 0, 255});
    rl.DrawLineEx(rl.Vector2{800.0, 0.0}, rl.Vector2{0.0, 600.0}, 5.0,
        rl.Color{0, 0, 255, 255});
    rl.DrawText("Hello, from Modula-2!", 320, 240, 20,
        rl.Color{150, 20, 100,255});
    rl.DrawTextEx(fnt, "MOUSE", pos, 18.0, 6.0, rl.Color{255,255,0,255});
    rl.DrawTextEx(fnt, "Привет, Мир!",
        rl.Vector2{300.0, 260.0}, 40.0, 1.0, rl.Color{255, 255, 255, 100});

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
