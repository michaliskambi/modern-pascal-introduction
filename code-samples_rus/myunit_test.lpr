{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses MyUnit;

begin
  Writeln(MyFunction('Примечание: '));
  MyProcedure(5);
end.
