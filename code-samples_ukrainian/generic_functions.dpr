{$mode objfpc}{$H+}{$J-}
uses
  SysUtils;

{ Примітка: для цього прикладу потрібен FPC 3.1.1 (не компілюється з FPC 3.0.0 або старішим). }

generic function Min<T>(const A, B: T): T;
begin
  if A < B then
    Result := A else
    Result := B;
end;

begin
  WriteLn('Min (1, 0): ', specialize Min<Integer>(1, 0));
  WriteLn('Min (3.14, 5): ', specialize Min<Single>(3.14, 5):1:2);
  WriteLn('Min (''a'', ''b''): ', specialize Min<string>('a', 'b'));
end.