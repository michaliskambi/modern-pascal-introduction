{$mode objfpc}{$H+}{$J-}
uses SysUtils, FGL;

type
  TMyClass = class
    I, Square: Integer;
  end;
  TMyClassList = specialize TFPGObjectList<TMyClass>;

var
  List: TMyClassList;
  C: TMyClass;
  I: Integer;
begin
  List := TMyClassList.Create(true); // значение true означает, что List владеет всеми дочерними объектами
  try
    for I := 0 to 9 do
    begin
      C := TMyClass.Create;
      C.I := I;
      C.Square := I * I;
      List.Add(C);
    end;

    for C in List do
      Writeln('Квадрат ', C.I, ' составляет ', C.Square);
  finally FreeAndNil(List) end;
end.