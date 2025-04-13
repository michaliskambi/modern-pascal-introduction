unit AnotherUnit;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

interface

uses
  Classes;

{ Тип (клас) "TComponent" визначається в модулі Classes.
   Ось чому нам довелося використати модуль Classes вище. }
procedure DoSomethingWithComponent(var C: TComponent);

implementation

uses SysUtils;

procedure DoSomethingWithComponent(var C: TComponent);
begin
  { Процедура FreeAndNil визначена в модулі SysUtils.
     Оскільки ми посилаємося лише на його назву в реалізації,
     модуль SysUtils можна використовувати у розділі «implementation». }
  FreeAndNil(C);
end;

end.
