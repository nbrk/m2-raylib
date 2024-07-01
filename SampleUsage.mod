(*
    Title:     Sample usage of the m2-raylib bindings.
    Author:    Nikolay A. Burkov <nbrk@linklevel.net>
 *)

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
