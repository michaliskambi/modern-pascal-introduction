{ Test getting pointers to generic methods.

  With Delphi the core thing works (you can have generic function and
  take pointer to it), though in Delphi it isn't allowed to do "A < B"
  as Delphi doesn't have a constrain to express "A and B are comparable".

  It doesn't seem possible to get this to compile with FPC,
  adding generic / specialize (I removed them from this source code now,
  since they were making it quite noisy).
  It is unsure if it is possible anyway, as
  callback_from_generic_function.dpr shows that FPC 3.2.2 says
  "Pointers to generics functions not implemented".
}

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$apptype CONSOLE}

uses
  SysUtils;

type
  TMyClass = class
    class function Min<T>(const A, B: T): T; static;
    class function Max<T>(const A, B: T): T; static;
  end;

class function TMyClass.Min<T>(const A, B: T): T;
begin
//  if A < B then
//    Result := A
//  else
    Result := B;
end;

class function TMyClass.Max<T>(const A, B: T): T;
begin
//  if A < B then
//    Result := B
//  else
    Result := A;
end;

type
  TMyIntegerFunction = function (const A, B: Integer): Integer;

// Fold left ( https://en.wikipedia.org/wiki/Fold_(higher-order_function) )
// specifically for an array of Integers.
function FoldLeftInts(const F: TMyIntegerFunction; const A: array of Integer): Integer;
var
  I: Integer;
begin
  Result := A[0];
  for I := 1 to High(A) do
    Result := F(A[I], Result);
end;

begin
  Writeln('Min: ', FoldLeftInts(TMyClass.Min<Integer>, [1, 2, 3, 4, 5]));
  Writeln('Max: ', FoldLeftInts(TMyClass.Max<Integer>, [1, 2, 3, 4, 5]));

  Readln;
end.
