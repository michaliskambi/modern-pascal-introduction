program MyProgram;

{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

procedure MyProcedure(const A: Integer);
begin
  WriteLn('A + 10 is: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'рядки керуються автоматично';
end;

var
  X: Single;
begin
  WriteLn(MyFunction('Примітка: '));
  MyProcedure(5);

  // Ділення за допомогою "/" завжди дає результат з плаваючою точкою, використовуйте "div" для цілочисельного ділення
  X := 15 / 5;
  WriteLn('X is now: ', X); // науковий запис
  WriteLn('X is now: ', X:1:2); // 2 десяткові позиції
end.
