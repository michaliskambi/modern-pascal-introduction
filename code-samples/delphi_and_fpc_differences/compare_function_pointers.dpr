{ Demonstrates how using @ in FPC ObjFpc makes some expressions
  unambigous. See
  https://github.com/michaliskambi/modern-pascal-introduction/wiki/Some-differences-betwen-FPC-ObjFpc-mode-and-Delphi-(and-FPC-Delphi-mode)
  for information. }

{$ifdef FPC} {$mode objfpc}{$H+} {$endif}
{$ifdef MSWINDOWS} {$apptype console} {$endif}

type
  TMyFunction = function: Integer;

function MyFunction: Integer;
begin
  Result := Random(10000000000);
end;

var
  X, Y: TMyFunction;
begin
  Randomize;

  X := {$ifdef FPC}@{$endif} MyFunction;
  Y := {$ifdef FPC}@{$endif} MyFunction;

  { This is the weird point.

    - In FPC ObjFpc, it compares X and Y values,
      they are equal (both point to MyFunction).

    - In Delphi (or FPC Delphi mode), it will call X and Y.
      Most likely they'll return something different,
      since they return just random value.
  }
  if X = Y then
    Writeln('Equal')
  else
    Writeln('Not equal');
end.
