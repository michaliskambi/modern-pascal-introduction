{$mode objfpc}{$H+}{$J-}

program MyProgram;

procedure MyProcedure(const A: Integer);
begin
  Writeln('A + 10 составляет: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'строки управляются автоматически';
end;

var
  X: Single;
begin
  Writeln(MyFunction('примечание: '));
  MyProcedure(5);

  // деление с помощью оператора "/" всегда даст результат с плавающей запятой
  // для целочисленного деления необходимо использовать "div"
  X := 15 / 5;
  Writeln('X составляет: ', X); // в научном формате
  Writeln('X составляет: ', X:1:2); // 2 знака после запятой
end.
