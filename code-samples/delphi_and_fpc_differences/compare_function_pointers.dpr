{ Demonstrates how using @ in FPC ObjFpc makes some expressions
  unambiguous. See
  https://github.com/modern-pascal/modern-pascal-introduction/wiki/Some-differences-betwen-FPC-ObjFpc-mode-and-Delphi-(and-FPC-Delphi-mode)
  for information. }

{$ifdef FPC} {$mode objfpc}{$H+} {$endif}
{$ifdef MSWINDOWS} {$apptype console} {$endif}

type
  TMyFunction = function: Integer;

function MyFunction: Integer;
begin
  Result := Random(1000 * 1000 * 1000);
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
    Writeln('X = Y: Equal')
  else
    Writeln('X = Y: Not equal');

  { This is again valid in both modes, but means something different.

    - In FPC ObjFpc, @ gets the address of the variable.
      So it compares the address of X and Y, which are different.

    - In Delphi (or FPC Delphi mode), it compares the values of X and Y.
      Since they are function pointers, they are equal.

    So in Delphi "if @X = @Y then" is equal to FPC ObjFpc "if X = Y then".
  }
  if @X = @Y then
    Writeln('@X = @Y: Equal')
  else
    Writeln('@X = @Y: Not equal');

  {$ifndef FPC}
  { In Delphi, this allows to compare "the address of X" with "the address of Y".
    So "if @@X = @@Y then" in Delphi means the same thing
    as "if @X = @Y then" in FPC ObjFpc.

    In FPC ObjFpc, this is invalid, makes no sense -- @@X would mean we want
    an address of temporary value @X. }
  if @@X = @@Y then
    Writeln('@@X = @@Y: Equal')
  else
    Writeln('@@X = @@Y: Not equal');
  {$endif}

  { Finally, this is valid in both modes and does the same:
    compares the values of X and Y. Using () forces the call of parameter-less
    function. }
  if X() = Y() then
    Writeln('X() or Y(): Equal')
  else
    Writeln('X() or Y(): Not equal');
end.
