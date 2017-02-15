{$mode objfpc}{$H+}{$J-}
program MyProgram;

uses SysUtils;

type
  TMyClass = class
    MyInt: Integer;
    procedure MyVirtualMethod; virtual;
  end;

  TMyClassDescendant = class(TMyClass)
    procedure MyVirtualMethod; override;
  end;

procedure TMyClass.MyVirtualMethod;
begin
  Writeln('TMyClass отображает MyInt + 10: ', MyInt + 10);
end;

procedure TMyClassDescendant.MyVirtualMethod;
begin
  Writeln('TMyClassDescendant отображает MyInt + 20: ', MyInt + 20);
end;

var
  C: TMyClass;
begin
  C := TMyClass.Create;
  try
    C.MyVirtualMethod;
  finally FreeAndNil(C) end;

  C := TMyClassDescendant.Create;
  try
    C.MyVirtualMethod;
  finally FreeAndNil(C) end;
end.
