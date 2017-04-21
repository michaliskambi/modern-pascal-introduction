{$mode objfpc}{$H+}{$J-}
{$interfaces com}

uses SysUtils, Classes;

type
  IMyInterface = interface
  ['{3075FFCD-8EFB-4E98-B157-261448B8D92E}']
    procedure Shoot;
  end;

  TMyClass1 = class(TInterfacedObject, IMyInterface)
    procedure Shoot;
  end;

  TMyClass2 = class(TInterfacedObject, IMyInterface)
    procedure Shoot;
  end;

  TMyClass3 = class(TInterfacedObject)
    procedure Shoot;
  end;

procedure TMyClass1.Shoot;
begin
  Writeln('TMyClass1.Shoot');
end;

procedure TMyClass2.Shoot;
begin
  Writeln('TMyClass2.Shoot');
end;

procedure TMyClass3.Shoot;
begin
  Writeln('TMyClass3.Shoot');
end;

procedure UseThroughInterface(I: IMyInterface);
begin
  Write('Стреляем... ');
  I.Shoot;
end;

var
  C1: IMyInterface;  // COM управляет освобождением памяти
  C2: IMyInterface;  // COM управляет освобождением памяти
  C3: TMyClass3;     // Здесь управлять освобождением памяти придётся ВАМ
begin
  C1 := TMyClass1.Create as IMyInterface;
  C2 := TMyClass2.Create as IMyInterface;
  C3 := TMyClass3.Create;
  try
    UseThroughInterface(C1); // Нет необходимости в операторе "as"
    UseThroughInterface(C2);
    if C3 is IMyInterface then
      UseThroughInterface(C3 as IMyInterface); // Так не сработает
  finally
    { Переменные C1 и C2 выходят из поля зрения
      и будут автоматически уничтожены сейчас.

      а переменная C3 является экземпляром класса
      и не управляется интерфейсом,
      и по этому её необходимо совободить вручную. }
    FreeAndNil(C3);
  end;
end.