{$mode objfpc}{$H+}{$J-}
program is_as;

uses
  SysUtils;

type
  TMyClass = class
    procedure MyMethod;
  end;

  TMyClassDescendant = class(TMyClass)
    procedure MyMethodInDescendant;
  end;

procedure TMyClass.MyMethod;
begin
  WriteLn('MyMethod');
end;

procedure TMyClassDescendant.MyMethodInDescendant;
begin
  WriteLn('MyMethodInDescendant');
end;

var
  Descendant: TMyClassDescendant;
  C: TMyClass;
begin
  Descendant := TMyClassDescendant.Create;
  try
    Descendant.MyMethod;
    Descendant.MyMethodInDescendant;

    { Descendant has all functionality expected of
      the TMyClass, so this assignment is OK }
    C := Descendant;
    C.MyMethod;

    { this cannot work, since TMyClass doesn't define this method }
    //C.MyMethodInDescendant;
    if C is TMyClassDescendant then
      (C as TMyClassDescendant).MyMethodInDescendant;

  finally
    FreeAndNil(Descendant);
  end;
end.
