// Използвайте този ред във всички нови програми
{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
// Needed for console programs on Windows,
// otherwise (with Delphi) the default is GUI program without console.
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

program MyProgram; // Запишете файла като myprogram.dpr
begin
  WriteLn('Hello world!');
end.
