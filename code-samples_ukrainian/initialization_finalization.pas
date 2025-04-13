unit initialization_finalization;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

interface

implementation

initialization
  WriteLn('Привіт, світ!');
finalization
  WriteLn('Бувай, світ!');
end.
