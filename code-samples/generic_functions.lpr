{$mode objfpc}{$H+}
uses SysUtils;

generic function Min<T>(const A, B: T): T;
begin
  if A < B then
    Result := A else
    Result := B;
end;

begin
  Writeln('Min (1, 0): ', specialize Min<Integer>(1, 0));
  Writeln('Min (3.14, 5): ', specialize Min<Single>(3.14, 5):1:2);
  Writeln('Min (''a'', ''b''): ', specialize Min<string>('a', 'b'));
end.