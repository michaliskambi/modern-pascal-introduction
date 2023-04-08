{$mode objfpc}{$H+}{$J-}

// {$interfaces corba} // забележете, че "as" конверсии за CORBA няма да се компилират

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

  // Това не може да с компилира, не е известно дали My е IMyInterface2.
  // UseInterface2(My);
  // UseInterface2(MyClass);

  // Това се компилира и работи.
  UseInterface2(IMyInterface2(My));
  // Това не може да с компилира. Преобразуването InterfaceType(ClassType) се проверява при компилация.
  // UseInterface2(IMyInterface2(MyClass));

  // Това се компилира и работи.
  UseInterface2(My as IMyInterface2);
  // Това се компилира и работи.
  UseInterface2(MyClass as IMyInterface2);

  // Това се компилира но не работи при изпълнение, с грозно "Access violation".
  // UseInterface3(IMyInterface3(My));
  // Това не може да с компилира. Преобразуването InterfaceType(ClassType) се проверява при компилация.
  // UseInterface3(IMyInterface3(MyClass));

  // Това се компилира но не работи при изпълнение, с хубаво "EInvalidCast: Invalid type cast".
  // UseInterface3(My as IMyInterface3);
  // Това се компилира но не работи при изпълнение, с хубаво "EInvalidCast: Invalid type cast".
  // UseInterface3(MyClass as IMyInterface3);

  Writeln('Край');
end.
