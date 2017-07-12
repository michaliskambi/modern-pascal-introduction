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
    A.Name := 'my apple';
    Apples.AddOrSetValue('apple key 1', A);

    if Apples.TryGetValue('apple key 1', FoundA) then
      Writeln('Found apple under key "apple key 1" with name: ' +
        FoundA.Name);

    for AppleKey in Apples.Keys do
      Writeln('Found apple key: ' + AppleKey);
    for A in Apples.Values do
      Writeln('Found apple value: ' + A.Name);
    for ApplePair in Apples do
      Writeln('Found apple key->value: ' +
        ApplePair.Key + '->' + ApplePair.Value.Name);

    { Line below works too, but it can only be used to set
      an *existing* dictionary key.
      Instead of this, usually use AddOrSetValue
      to set or add a new key, as necessary. }
    // Apples['apple key 1'] := ... ;

    Apples.Remove('apple key 1');

    { Note that the TDictionary doesn't own the items,
      you need to free them yourself.
      We could use TObjectDictionary to have automatic ownership
      mechanism. }
    A.Free;
  finally FreeAndNil(Apples) end;
end.
