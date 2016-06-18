{$mode objfpc}{$H+}

program MyProgram;

procedure MyProcedure(const A: Integer);
begin
  Writeln('A + 10 is: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  Result := S + 'strings are automatically managed';
end;

var
  X: Single;
begin
  Writeln(MyFunction('Note: '));
  MyProcedure(5);

  // Division using "/" always makes float result, use "div" for integer division
  X := 15 / 5;
  Writeln('X is now: ', X); // scientific notation
  Writeln('X is now: ', X:1:2); // 2 decimal places
end.
