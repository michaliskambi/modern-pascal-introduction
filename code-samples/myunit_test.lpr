{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses MyUnit;

begin
  Writeln(MyFunction('Note: '));
  MyProcedure(5);
end.
