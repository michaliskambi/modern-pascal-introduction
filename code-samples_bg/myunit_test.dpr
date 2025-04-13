program MyProgram;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

uses MyUnit;

begin
  WriteLn(MyFunction('Забележка: '));
  MyProcedure(5);
end.
