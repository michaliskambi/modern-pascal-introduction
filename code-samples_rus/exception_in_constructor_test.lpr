{$mode objfpc}{$H+}{$J-}
uses SysUtils;

type
  TGun = class
  end;

  TPlayer = class
    Gun1, Gun2: TGun;
    constructor Create;
    destructor Destroy; override;
  end;

constructor TPlayer.Create;
begin
  inherited;
  Gun1 := TGun.Create;
  raise Exception.Create('Вызваем exception из constructor-а!');
  Gun2 := TGun.Create;
end;

destructor TPlayer.Destroy;
begin
  { в данном случае в результате ошибки в constructor-е, у нас
    может оказаться Gun1 <> nil и Gun2 = nil. Смиритесь.
    В таком случае, FreeAndNil справится с задачей без каких-либо
    дополнительных действий с нашей стороны, поскольку FreeAndNil проверяет
    является ли экземпляр класса nil перед вызовом соответствующего destructor-а. }
  FreeAndNil(Gun1);
  FreeAndNil(Gun2);
  inherited;
end;

begin
  try
    TPlayer.Create;
  except
    on E: Exception do
      Writeln('Ошибка ' + E.ClassName + ': ' + E.Message);
  end;
end.