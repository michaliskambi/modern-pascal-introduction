// Эту строку необходимо использовать во всех современных программах
{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
// Needed for console programs on Windows,
// otherwise (with Delphi) the default is GUI program without console.
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

program MyProgram; // Сохраните этот файл под названием myprogram.dpr
begin
  WriteLn('Hello world!');
end.
