// Просто використовуйте цей рядок у всіх сучасних сирцях
{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
// Needed for console programs on Windows,
// otherwise (with Delphi) the default is GUI program without console.
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

program MyProgram; // Збережіть цей файл як myprogram.dpr
begin
  WriteLn('Привіт, світ!');
end.
