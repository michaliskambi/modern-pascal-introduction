{$mode objfpc}{$H+}{$J-}
uses SysUtils;

type
  TFruit = class
    procedure Eat; virtual;
  end;

  TApple = class(TFruit)
    procedure Eat; override;
  end;

procedure TFruit.Eat;
begin
  Writeln('Изядохме плод');
end;

procedure TApple.Eat;
begin
  Writeln('Изядохме ябълка');
end;

procedure DoSomethingWithAFruit(const Fruit: TFruit);
begin
  Writeln('Имаме плод от клас ', Fruit.ClassName);
  Writeln('Ядем го:');
  Fruit.Eat;
end;

var
  Apple: TApple; // Забележка: тук също така може да декларирате "Apple: TFruit"
begin
  Apple := TApple.Create;
  try
    DoSomethingWithAFruit(Apple);
  finally FreeAndNil(Apple) end;
end.
