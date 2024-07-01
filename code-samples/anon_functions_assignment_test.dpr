{ Working example adjusted from
  https://forum.lazarus.freepascal.org/index.php?topic=59468.0 }

{$ifdef FPC}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch functionreferences}
  {$modeswitch anonymousfunctions}
{$endif}

uses Classes;

type
  TFunc = function: LongInt;

var
  p: TProcedure;
  f: TFunc;
  n: TNotifyEvent;
begin
  procedure(const aArg: String)
  begin
    Writeln(aArg);
  end('Hello World');

  p := procedure
       begin
         Writeln('Foobar');
       end;
  p();

  n := procedure(aSender: TObject)
       begin
         Writeln(HexStr(Pointer(aSender)));
       end;
  n(Nil);

  f := function MyRes : LongInt
       begin
         MyRes := 42;
       end;
  Writeln(f());
end.