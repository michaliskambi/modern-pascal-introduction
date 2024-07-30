{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

type
  TVector2 = packed record
    case Integer of
      0: (X, Y: Single);
      1: (Data: array [0..1] of Single);
  end;

  TVector3 = packed record
    case Integer of
      0: (X, Y, Z: Single);
      1: (Data: array [0..2] of Single);
      2: (XY: TVector2);
  end;


var
  V2: TVector2;
  V: TVector3;
  I: Integer;
begin
  Writeln('Size of TVector2 is ', SizeOf(TVector2));
  Writeln('  Should be equal to ', SizeOf(Single) * 2);

  Writeln('Size of TVector3 is ', SizeOf(TVector3));
  Writeln('  Should be equal to ', SizeOf(Single) * 3);

  V.X := 1;
  V.Y := 2;
  V.Z := 3;

  for I := 0 to 2 do
    Writeln('V.Data[', I, '] is ', V.Data[I]:1:2);

  V2 := V.XY;

  for I := 0 to 1 do
    Writeln('V2.Data[', I, '] is ', V2.Data[I]:1:2);
end.