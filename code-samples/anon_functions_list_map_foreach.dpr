{ Example of Map, ForEach methods and processing list with anonymous functions.
  Compiles with FPC 3.3.1
  (see https://forum.lazarus.freepascal.org/index.php?topic=59468.0 ). }

{$ifdef FPC}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch functionreferences}
  {$modeswitch anonymousfunctions}
{$endif}

uses SysUtils, Generics.Collections;

type
  TIntMapFunc =
    { All the following are valid function types, and they all will compile,
      that is: you can pass anonymous function to them.

      - The 1st (without "of object", without "reference to")
        allows to stores a reference to a global function,
      - The 2nd (with "of object") allows stores a reference to a method of an object,

      - The 3rd (with "reference to") allows a lot of things -- see
        https://forum.lazarus.freepascal.org/index.php?topic=59468.0 .
    }
    //function(const Index, Item: Integer): Integer;
    //function(const Index, Item: Integer): Integer of object;
    reference to function(const Index, Item: Integer): Integer;
  TIntMapProc =
    //procedure(const Index, Item: Integer);
    //procedure(const Index, Item: Integer) of object;
    reference to procedure(const Index, Item: Integer);

  TMyInts = class(specialize TList<Integer>)
    { Change every item in the list using AFunc. }
    procedure Map(const AFunc: TIntMapFunc);
    { Call AProc for every item in the list. }
    procedure ForEach(const AProc: TIntMapProc);
  end;

procedure TMyInts.Map(const AFunc: TIntMapFunc);
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Items[Index] := AFunc(Index, Items[Index]);
end;

procedure TMyInts.ForEach(const AProc: TIntMapProc);
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    AProc(Index, Items[Index]);
end;

var
  MyList: TMyInts;
  I: Integer;
begin
  MyList := TMyInts.Create;
  try
    for I := 0 to 10 do
      MyList.Add(I);
    MyList.Map(function(const Index, Item: Integer): Integer
      begin
        Result := Item * Item;
      end);
    MyList.ForEach(procedure(const Index, Item: Integer)
      begin
        WriteLn('Index: ', Index, ', Item: ', Item);
      end);
  finally FreeAndNil(MyList) end;
end.
