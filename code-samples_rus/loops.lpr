{$mode objfpc}{$H+}{$J-}
{$R+} // включаем проверку на диапазон величин, очень полезно для отладки
var
  MyArray: array [0..9] of Integer;
  I: Integer;
begin
  // инициализация
  for I := 0 to 9 do
    MyArray[I] := I * I;

  // отображение
  for I := 0 to 9 do
    Writeln('Квадрат составляет ', MyArray[I]);

  // делает то же самое, что и предыдущий вариант
  for I := Low(MyArray) to High(MyArray) do
    Writeln('Квадрат составляет ', MyArray[I]);

  // делает то же самое
  I := 0;
  while I < 10 do
  begin
    Writeln('Квадрат составляет ', MyArray[I]);
    I := I + 1; // это идентично "I += 1" или "Inc(I)"
  end;

  // делает то же самое
  I := 0;
  repeat
    Writeln('Квадрат составляет ', MyArray[I]);
    Inc(I);
  until I = 10;

  // делает то же самое
  // обратите внимание, тут переменная I перечисляет значения элементов массива, а не его индексы
  for I in MyArray do
    Writeln('Квадрат составляет ', I);
end.