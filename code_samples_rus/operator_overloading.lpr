{$mode objfpc}{$H+}{$J-}
uses StrUtils;

operator* (const S: string; const A: Integer): string;
begin
  Result := DupeString(S, A);
end;

begin
  Writeln('повтор' * 10);
end.