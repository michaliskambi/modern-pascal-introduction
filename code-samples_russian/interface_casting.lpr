{$mode objfpc}{$H+}{$J-}

// {$interfaces corba} // обратите внимание, что приведение типа с помощью "as" для интерфейсов типа CORBA не скомпилируется

uses Classes;

type
  IMyInterface = interface
  ['{7FC754BC-9CA7-4399-B947-D37DD30BA90A}']
    procedure One;
  end;

  IMyInterface2 = interface(IMyInterface)
  ['{A72B7008-3F90-45C1-8F4C-E77C4302AA3E}']
    procedure Two;
  end;

  IMyInterface3 = interface(IMyInterface2)
  ['{924BFB98-B049-4945-AF17-1DB08DB1C0C5}']
    procedure Three;
  end;

  TMyClass = class(TComponent, IMyInterface)
    procedure One;
  end;

  TMyClass2 = class(TMyClass, IMyInterface, IMyInterface2)
    procedure One;
    procedure Two;
  end;

procedure TMyClass.One;
begin
  Writeln('TMyClass.One');
end;

procedure TMyClass2.One;
begin
  Writeln('TMyClass2.One');
end;

procedure TMyClass2.Two;
begin
  Writeln('TMyClass2.Two');
end;

procedure UseInterface2(const I: IMyInterface2);
begin
  I.One;
  I.Two;
end;

procedure UseInterface3(const I: IMyInterface3);
begin
  I.One;
  I.Two;
  I.Three;
end;

var
  My: IMyInterface;
  MyClass: TMyClass;
begin
  My := TMyClass2.Create(nil);
  MyClass := TMyClass2.Create(nil);

  // Следующий код не скомпилируется, так как в момент компиляции неизвестно является ли My интерфейсом IMyInterface2.
  // UseInterface2(My);
  // UseInterface2(MyClass);

  // Это скомпилируется и работает правильно.
  UseInterface2(IMyInterface2(My));
  // А это не скомпилируется. Приведение типа InterfaceType(ClassType) проверяется в момент компиляции.
  // UseInterface2(IMyInterface2(MyClass));

  // Это скомпилируется и работает правильно.
  UseInterface2(My as IMyInterface2);
  // Это скомпилируется и работает правильно.
  UseInterface2(MyClass as IMyInterface2);

  // Это скомпилируется, но приведёт к непонятной ошибке "Access violation" при выполнении программы.
  // UseInterface3(IMyInterface3(My));
  // Это не скомпилируется. Приведение типа InterfaceType(ClassType) проверяется в момент компиляции.
  // UseInterface3(IMyInterface3(MyClass));

  // Это скомпилируется, но приведёт понятному сообщению об ошибке "EInvalidCast: Invalid type cast" и укажет на проблему.
  // UseInterface3(My as IMyInterface3);
  // Это скомпилируется, но приведёт понятному сообщению об ошибке "EInvalidCast: Invalid type cast" и укажет на проблему.
  // UseInterface3(MyClass as IMyInterface3);

  Writeln('Готово');
end.
