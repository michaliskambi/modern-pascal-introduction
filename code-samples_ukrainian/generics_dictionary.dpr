{$mode objfpc}{$H+}{$J-}
uses SysUtils, Generics.Collections;

type
  TApple = class
    Name: string;
  end;

  TAppleDictionary = specialize TDictionary<string, TApple>;

var
  Apples: TAppleDictionary;
  A, FoundA: TApple;
  ApplePair: TAppleDictionary.TDictionaryPair;
  AppleKey: string;
begin
  Apples := TAppleDictionary.Create;
  try
    A := TApple.Create;
    A.Name := 'моє яблуко';
    Apples.AddOrSetValue('яблучний ключ 1', A);

    if Apples.TryGetValue('яблучний ключ 1', FoundA) then
      Writeln('Знайдено яблуко під ключем "яблучний ключ 1" з назвою: ' +
        FoundA.Name);

    for AppleKey in Apples.Keys do
      Writeln('Знайдено яблучний ключ: ' + AppleKey);
    for A in Apples.Values do
      Writeln('Знайдено яблучне значення: ' + A.Name);
    for ApplePair in Apples do
      Writeln('Знайдено яблучні ключ->значення: ' +
        ApplePair.Key + '->' + ApplePair.Value.Name);

    { Рядок нижче також працює, але його можна використовувати
     лише для встановлення *існуючого* ключа словника.
     Замість цього зазвичай використовуйте AddOrSetValue,
     щоб установити або додати новий ключ, якщо це необхідно. }
    // Apples['яблучний ключ 1'] := ... ;

    Apples.Remove('яблучний ключ 1');

    { Зверніть увагу, що TDictionary не володіє елементами,
     вам потрібно звільнити їх самостійно.
     Ми могли б використовувати TObjectDictionary,
     щоб мати автоматичний механізм власності. }
    A.Free;
  finally FreeAndNil(Apples) end;
end.
