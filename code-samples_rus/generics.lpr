{$mode objfpc}{$H+}{$J-}
uses SysUtils;

type
  generic TMyCalculator<T> = class
    Value: T;
    procedure Add(const A: T);
  end;

procedure TMyCalculator.Add(const A: T);
begin
  Value := Value + A;
end;

type
  TMyFloatCalculator = specialize TMyCalculator<Single>;
  TMyStringCalculator = specialize TMyCalculator<string>;

var
  FloatCalc: TMyFloatCalculator;
  StringCalc: TMyStringCalculator;
begin
  FloatCalc := TMyFloatCalculator.Create;
  try
    FloatCalc.Add(3.14);
    FloatCalc.Add(1);
    Writeln('FloatCalc: ', FloatCalc.Value:1:2);
  finally FreeAndNil(FloatCalc) end;

  StringCalc := TMyStringCalculator.Create;
  try
    StringCalc.Add('что-нибудь');
    StringCalc.Add(' ещё');
    Writeln('StringCalc: ', StringCalc.Value);
  finally FreeAndNil(StringCalc) end;
end.