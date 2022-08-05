{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses
  MyUnit;

begin
  WriteLn(MyFunction('Note: '));
  MyProcedure(5);
end.
