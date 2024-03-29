{$mode objfpc}{$H+}{$J-}
uses SysUtils, Generics.Collections;

type
  TApple = class
    Name: string;
  end;

  TAppleDictionary = specialize TObjectDictionary<string, TApple>;

var
  Apples: TAppleDictionary;
  A: TApple;
  ApplePair: TAppleDictionary.TDictionaryPair;
begin
  Apples := TAppleDictionary.Create([doOwnsValues]);
  try
    A := TApple.Create;
    A.Name := 'моє яблуко';
    Apples.AddOrSetValue('яблучний ключ 1', A);

    for ApplePair in Apples do
      Writeln('Знайдено яблучний ключ->значення: ' +
        ApplePair.Key + '->' + ApplePair.Value.Name);

    Apples.Remove('яблучний ключ 1');
  finally FreeAndNil(Apples) end;
end.
