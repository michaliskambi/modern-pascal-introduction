{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses
  MyUnit;

begin
  WriteLn(MyFunction('Забележка: '));
  MyProcedure(5);
end.
