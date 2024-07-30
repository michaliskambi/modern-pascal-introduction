{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

uses Variants;
var
  V1, V2, V3: Variant;
begin
  V1 := 'My String';
  V1 := 123; // V1 no longer holds String, it has Integer now
  V2 := 456.789;
  V3 := V1 + V2; // result is float
  Writeln('V3 = ', V3);
end.
