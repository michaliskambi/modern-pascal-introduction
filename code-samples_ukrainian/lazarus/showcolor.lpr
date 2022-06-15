{$mode objfpc}{$H+}{$J-}
program showcolor;

// І Graphics і GoogleMapsEngine визначають тип TColor.
uses
  Graphics, GoogleMapsEngine;

var
  { Це не спрацює, як ми очікуємо, оскільки TColor останній раз
    було об'явлено в unit-і GoogleMapsEngine. }
  // Color: TColor;
  { Це працює правильно. }
  Color: Graphics.TColor;
begin
  Color := clYellow;
  WriteLn(Red(Color), ' ', Green(Color), ' ', Blue(Color));
end.
