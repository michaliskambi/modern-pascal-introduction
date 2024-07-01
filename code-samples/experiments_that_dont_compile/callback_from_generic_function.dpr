{ Test getting pointers to generic functions.

  With FPC 3.2.2 this fails with clear message:
    callback_from_generic_function.dpr(40,74) Error: Pointers to generics functions not implemented
    callback_from_generic_function.dpr(41,74) Error: Pointers to generics functions not implemented

  With Delphi this fails as Delphi supports only generic methods, not global routines:
    [dcc32 Error] callback_from_generic_function.dpr(14): E2530 Type parameters not allowed on global procedure or function
}

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$apptype CONSOLE}

uses
  SysUtils;

{$ifdef FPC}generic{$endif} function Min<T>(const A, B: T): T;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

{$ifdef FPC}generic{$endif} function Max<T>(const A, B: T): T;
begin
  if A < B then
    Result := B
  else
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

var
  F: TMyIntegerFunction;
begin
  Writeln('Min: ', FoldLeftInts([1, 2, 3, 4, 5], @{$ifdef FPC}specialize{$endif} Min<Integer>));
  Writeln('Max: ', FoldLeftInts([1, 2, 3, 4, 5], @{$ifdef FPC}specialize{$endif} Max<Integer>));
end.
