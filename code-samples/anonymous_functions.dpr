{ Anonymous functions test.

  - Delphi docs:
    https://docwiki.embarcadero.com/RADStudio/Sydney/en/Anonymous_Methods_in_Delphi

  - FPC docs:
    https://wiki.freepascal.org/FPC_New_Features_Trunk#Support_for_Function_References_and_Anonymous_Functions
    https://forum.lazarus.freepascal.org/index.php/topic,59468.0.html
}

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$apptype CONSOLE}

type
  TMyFunction = reference to function (const A, B: Integer): Integer;

function ProcessTheList(const F: TMyFunction): Integer;
var
  I: Integer;
begin
  Result := 1;
  for I := 2 to 10 do
    Result := F(Result, I);
end;

var
  SomeFunction: TMyFunction;
begin
  // Assign anonymous function to a variable
  SomeFunction :=
    function(const A, B: Integer): Integer
    begin
      Result := A + B;
    end;
  WriteLn('1 + 2 + 3 ... + 10 = ', ProcessTheList(SomeFunction));

  // Or, simpler, just define the anonymous function inside the parameter
  WriteLn('1 + 2 + 3 ... + 10 = ', ProcessTheList(
    function(const A, B: Integer): Integer
    begin
      Result := A + B;
    end
  ));

  // Similar test, now with multiplication
  WriteLn('1 * 2 * 3 ... * 10 = ', ProcessTheList(
    function(const A, B: Integer): Integer
    begin
      Result := A * B;
    end
  ));
end.
