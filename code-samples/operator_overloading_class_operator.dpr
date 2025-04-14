{$ifdef FPC}
  {$mode objfpc}{$H+}{$J-}
  {$modeswitch advancedrecords}
{$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

uses SysUtils;

type
  TVector3 = record
  public
    X, Y, Z: Single;
    class operator {$ifdef FPC}+{$else}Add{$endif}
      (const A, B: TVector3): TVector3;
    class operator {$ifdef FPC}*{$else}Multiply{$endif}
      (const V: TVector3; const Scalar: Single): TVector3;
    function ToString: String;
  end;

class operator TVector3.{$ifdef FPC}+{$else}Add{$endif}
  (const A, B: TVector3): TVector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator TVector3.{$ifdef FPC}*{$else}Multiply{$endif}
  (const V: TVector3; const Scalar: Single): TVector3;
begin
  Result.X := V.X * Scalar;
  Result.Y := V.Y * Scalar;
  Result.Z := V.Z * Scalar;
end;

function TVector3.ToString: String;
begin
  Result := Format('(%f, %f, %f)', [X, Y, Z]);
end;

var
  V1, V2: TVector3;
begin
  V1.X := 1.0; V1.Y := 2.0;  V1.Z := 3.0;
  V2.X := 4.0; V2.Y := 5.0;  V2.Z := 6.0;
  WriteLn('V1: ', V1.ToString);
  WriteLn('V2: ', V2.ToString);
  WriteLn('V1 + V2: ', (V1 + V2).ToString);
  WriteLn('V1 * 10: ', (V1 * 10).ToString);
end.
