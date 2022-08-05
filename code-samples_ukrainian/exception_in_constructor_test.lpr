{$mode objfpc}{$H+}{$J-}
uses
  SysUtils;

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
  raise Exception.Create('Підняття винятку з конструктора!');
  Gun2 := TGun.Create;
end;

destructor TPlayer.Destroy;
begin
  { у випадку, якщо в конструкторі стався збій, ми можемо
    мати Gun1 <> nil і Gun2 = nil зараз. Змиріться з цим.
    ...Насправді, у цьому випадку FreeAndNil справляється
    з цим без будь-яких додаткових зусиль з нашого боку,
    тому що FreeAndNil перевіряє, чи є екземпляр нульовим,
    перш ніж викликати його деструктор }
  FreeAndNil(Gun1);
  FreeAndNil(Gun2);
  inherited;
end;

begin
  try
    TPlayer.Create;
  except
    on E: Exception do
      WriteLn('Спіймано ' + E.ClassName + ': ' + E.Message);
  end;
end.
