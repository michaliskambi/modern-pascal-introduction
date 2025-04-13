{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

program MyProgram;

uses
  MyUnit;

begin
  WriteLn(MyFunction('Note: '));
  MyProcedure(5);
end.
