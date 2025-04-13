{$mode objfpc}{$H+}{$J-}

// {$interfaces corba} // зауважте, що приведення типу "as" для CORBA не компілюється

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

  // Це не компілюється, оскільки під час компіляції невідомо, чи My є IMyInterface2.
  // UseInterface2(My);
  // UseInterface2(MyClass);

  // Це компілюється та працює нормально.
  UseInterface2(IMyInterface2(My));
  // Це не компілюється. Приведення InterfaceType(ClassType) перевіряється під час компіляції.
  // UseInterface2(IMyInterface2(MyClass));

  // Це компілюється та працює нормально.
  UseInterface2(My as IMyInterface2);
  // Це компілюється та працює нормально.
  UseInterface2(MyClass as IMyInterface2);

  // Це компілюється, але зазнає збою під час виконання, з потворним «Access Violation».
  // UseInterface3(IMyInterface3(My));
  // Це не компілюється. Приведення InterfaceType(ClassType) перевіряється під час компіляції.
  // UseInterface3(IMyInterface3(MyClass));

  // Це компілюється, але зазнає збою під час виконання, з гарним «EInvalidCast: неправильне приведення типу».
  // UseInterface3(My as IMyInterface3);
  // Це компілюється, але зазнає збою під час виконання, з гарним «EInvalidCast: неправильне приведення типу».
  // UseInterface3(MyClass as IMyInterface3);

  Writeln('Завершено');
end.
