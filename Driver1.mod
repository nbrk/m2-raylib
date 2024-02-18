MODULE Driver1; (*!m2iso*)

FROM STextIO IMPORT WriteString, WriteLn;
FROM SWholeIO IMPORT WriteInt;

FROM raylib IMPORT InitWindow, BeginDrawing, EndDrawing,
ClearBackground, WaitTime, WindowShouldClose, Color, IsKeyPressed,
DrawText, DrawLine, Vector2, GetMousePosition, ToggleFullscreen, GetScreenWidth, GetScreenHeight,
GetCurrentMonitor, GetMonitorName, GetMonitorCount, GetClipboardText, GetMousePosition, Float,
GetRandomValue, Unsigned8, OpenURL, DrawLineEx;

FROM raylib IMPORT Image, LoadImage, UnloadImage, GenImageCellular, Texture2D, LoadTextureFromImage, UnloadTexture, DrawTexture;


CONST
   imgPath = "/home/nbrk/brain.png";

VAR
   pos : Vector2;
   img : Image;
   texImg, texFile : Texture2D;
BEGIN
   InitWindow(800, 600, "Modula-2 + Raylib");

   img := GenImageCellular(800, 600, 20);
   texImg := LoadTextureFromImage(img);
   UnloadImage(img);
   img := LoadImage(imgPath);
   texFile := LoadTextureFromImage(img);
   UnloadImage(img);

   (* ToggleFullscreen; *)

   LOOP
      BeginDrawing;
      ClearBackground(Color{0,0,0, 0});

        pos := GetMousePosition();
        DrawTexture(texImg, 0, 0, Color{255,255,255,255});
        DrawTexture(texFile, 100, 100, Color{255,255,255,255});
        DrawLine(0, 0, GetScreenWidth(), GetScreenHeight(), Color{0, 255, 0, 255});
        DrawLineEx(Vector2{800.0, 0.0}, Vector2{0.0, 600.0}, 5.0, Color{0, 0, 255, 255});
        DrawText("Hello, from Modula-2!", 320, 240, 20, Color{150, 20, 100,255});
        DrawText("MOUSE", INT(pos.x), INT(pos.y), 14, Color{255,0,0,255});

      EndDrawing;

      IF WindowShouldClose OR IsKeyPressed(256) THEN
         EXIT;
      END;

      WaitTime(1.0 / 60.0);
   END (* loop *);

END Driver1.
