{$mode objfpc}{$H+}{$J-}
program showcolor;

// Обидва модулі - Graphics й GoogleMapsEngine визначають тип TColor.
uses
  Graphics, GoogleMapsEngine;

var
  { Не не спрацює так, як ми хочемо, оскільки TColor в підсумку
    визначений в модулі GoogleMapsEngine. }
  // Color: TColor;
  { Це працює. }
  Color: Graphics.TColor;
begin
  Color := clYellow;
  WriteLn(Red(Color), ' ', Green(Color), ' ', Blue(Color));
end.

