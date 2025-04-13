{$mode objfpc}{$H+}{$J-}
uses SysUtils, Generics.Collections;

type
  TApple = class
    Name: string;
  end;

  TAppleDictionary = {$ifdef FPC}specialize{$endif} TDictionary<String, TApple>;

var
  Apples: TAppleDictionary;
  A, FoundA: TApple;
  ApplePair: {$ifdef FPC} TAppleDictionary.TDictionaryPair {$else} TPair<String, TApple> {$endif};
  AppleKey: string;
begin
  Apples := TAppleDictionary.Create;
  try
    A := TApple.Create;
    A.Name := 'моята ябълка';
    Apples.AddOrSetValue('ключ за ябълка 1', A);

    if Apples.TryGetValue('ключ за ябълка 1', FoundA) then
      Writeln('Намерена ябълка с ключ "ключ за ябълка 1" с име: ' +
        FoundA.Name);

    for AppleKey in Apples.Keys do
      Writeln('Намерен ключ за ябълка: ' + AppleKey);
    for A in Apples.Values do
      Writeln('Намерена ябълка с име: ' + A.Name);
    for ApplePair in Apples do
      Writeln('Намерен ключ за ябълка->име на ябълка: ' +
        ApplePair.Key + '->' + ApplePair.Value.Name);

    { Долният ред също работи, но може да се използва само да
      зададе стойност на *съществуващ* ключ в речника.
      Вместо това обикновено се използва AddOrSetValue
      за да се зададе или добави нов ключ ако е необходимо. }
    // Apples['ключ за ябълка 1'] := ... ;

    Apples.Remove('ключ за ябълка 1');

    { Забележете, че TDictionary не притежава елементите си
      и трябва да ги освобожавате ръчно.
      Може да използвате TObjectDictionary за да имате автоматичен
      режим за притежание. }
    A.Free;
  finally FreeAndNil(Apples) end;
end.
