{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses MyUnit;

var
  X: Single;
begin
  Writeln(MyFunction('Примечание: '));
  MyProcedure(5);
end.
