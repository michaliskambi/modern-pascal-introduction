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
  { в данном случае вследствие ошибки в constructor-е crashed, у нас
    может оказаться Gun1 <> nil и Gun2 = nil. Смиритесь.
    ...Вообще, в таком случае, FreeAndNil справиться с задачей
    без каких-либо действий с нашей стороны, поскольку FreeAndNil проверяет
    является ли экземпляр класса nil перед вызовом destructor-а. }
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