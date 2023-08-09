{$mode objfpc}{$H+}{$J-}
unit MyUnit;
interface

procedure MyProcedure(const A: Integer);
function MyFunction(const S: string): string;

implementation

procedure MyProcedure(const A: Integer);
begin
  WriteLn('A + 10 is: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'strings are automatically managed';
end;

end.
