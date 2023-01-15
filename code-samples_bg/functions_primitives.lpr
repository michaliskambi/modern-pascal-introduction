{$mode objfpc}{$H+}{$J-}

program MyProgram;

procedure MyProcedure(const A: Integer);
begin
  WriteLn('A + 10 е: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'низовете се управляват автоматично';
end;

var
  X: Single;
begin
  WriteLn(MyFunction('Забележка: '));
  MyProcedure(5);

  // Делението с "/" винаги дава резултат float, използвайте "div" за целичислено делене
  X := 15 / 5;
  WriteLn('X сега е: ', X); // научна нотация
  WriteLn('X сега е: ', X:1:2); // 2 десетични знака
end.
