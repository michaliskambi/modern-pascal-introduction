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
  raise Exception.Create('Raising an exception from constructor!');
  Gun2 := TGun.Create;
end;

destructor TPlayer.Destroy;
begin
  { in case since the constructor crashed, we can
    have Gun1 <> nil and Gun2 = nil now. Deal with it.
    ...Actually, in this case, FreeAndNil deals with it without
    any additional effort on our side, because FreeAndNil checks
    whether the instance is nil before calling its destructor. }
  FreeAndNil(Gun1);
  FreeAndNil(Gun2);
  inherited;
end;

begin
  try
    TPlayer.Create;
  except
    on E: Exception do
      WriteLn('Caught ' + E.ClassName + ': ' + E.Message);
  end;
end.
