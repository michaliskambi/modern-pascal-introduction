{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses
  MyUnit;

var
  X: Single;
begin
  WriteLn(MyFunction('Note: '));
  MyProcedure(5);
end.
