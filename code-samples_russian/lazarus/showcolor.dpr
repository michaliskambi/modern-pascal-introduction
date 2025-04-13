program showcolor;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

// и Graphics и GoogleMapsEngine определяют тип TColor.
uses
  Graphics, GoogleMapsEngine;

var
  { Это не сработает, как мы ожидаем, поскольку TColor последний раз
    был объявлен в unit-е GoogleMapsEngine. }
  // Color: TColor;
  { This works Ok. }
  Color: Graphics.TColor;
begin
  Color := clYellow;
  WriteLn(Red(Color), ' ', Green(Color), ' ', Blue(Color));
end.

