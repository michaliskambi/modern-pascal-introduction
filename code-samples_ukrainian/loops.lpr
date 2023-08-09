{$mode objfpc}{$H+}{$J-}
{$R+} // перевірку діапазону ввімкнено – добре для налагодження
var
  MyArray: array [0..9] of Integer;
  I: Integer;
begin
  // ініціалізувати
  for I := 0 to 9 do
    MyArray[I] := I * I;

  // показати
  for I := 0 to 9 do
    WriteLn('Квадрати: ', MyArray[I]);

  // виконує те саме, що й вище
  for I := Low(MyArray) to High(MyArray) do
    WriteLn('Квадрати: ', MyArray[I]);

  // виконує те саме, що й вище
  I := 0;
  while I < 10 do
  begin
    WriteLn('Квадрати: ', MyArray[I]);
    I := I + 1; // or "I += 1", or "Inc(I)"
  end;

  // виконує те саме, що й вище
  I := 0;
  repeat
    WriteLn('Квадоати: ', MyArray[I]);
    Inc(I);
  until I = 10;

  // виконує те саме, що й вище
  // зауваження: тут я перераховую значення MyArray, а не індекси
  for I in MyArray do
    WriteLn('Квадрати: ', I);
end.