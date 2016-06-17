{$mode objfpc}{$H+}

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
  Writeln('TMyClass shows MyInt + 10: ', MyInt + 10);
end;

procedure TMyClassDescendant.MyVirtualMethod;
begin
  Writeln('TMyClassDescendant shows MyInt + 20: ', MyInt + 20);
end;

var
  C: TMyClass;
begin
  C := TMyClass.Create;
  C.MyVirtualMethod;
  FreeAndNil(C);

  C := TMyClassDescendant.Create;
  C.MyVirtualMethod;
  FreeAndNil(C);
end.
