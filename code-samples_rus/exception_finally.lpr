{$mode objfpc}{$H+}{$J-}

program MyProgram;

uses SysUtils;

type
  TMyClass = class
    procedure MyMethod;
  end;

procedure TMyClass.MyMethod;
begin
  if Random > 0.5 then
    raise Exception.Create('Вызываем exception!');
end;

var
  C: TMyClass;
begin
  randomize;
  C := TMyClass.Create;
  try
    C.MyMethod;
  finally FreeAndNil(C) end;
end.
