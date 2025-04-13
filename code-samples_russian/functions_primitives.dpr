program MyProgram;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

procedure MyProcedure(const A: Integer);
begin
  WriteLn('A + 10 составляет: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'строки управляются автоматически';
end;

var
  X: Single;
begin
  WriteLn(MyFunction('примечание: '));
  MyProcedure(5);

  // деление с помощью оператора "/" всегда даёт результат с плавающей запятой
  // для целочисленного деления необходимо использовать "div"
  X := 15 / 5;
  WriteLn('X составляет: ', X); // отобразить в научном формате вида 3.0000000E+000
  WriteLn('X составляет: ', X:1:2); // отобразить 2 знака после запятой
end.
