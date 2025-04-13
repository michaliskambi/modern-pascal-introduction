{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

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
  raise Exception.Create('Предизвикано изключение от конструктор!');
  Gun2 := TGun.Create;
end;

destructor TPlayer.Destroy;
begin
  { в случай, че конструктора крашне, бихме могли
    да имаме ситуация с Gun1 <> nil и Gun2 = nil. Справете се с това.
    ... Всъщност в случая FreeAndNil ще се справи без
    допълнителни усилия от наша страна, защото FreeAndNil проверява
    дали инстанцията е nil преди да извика деструктора. }
  FreeAndNil(Gun1);
  FreeAndNil(Gun2);
  inherited;
end;

begin
  try
    TPlayer.Create;
  except
    on E: Exception do
      WriteLn('Уловено ' + E.ClassName + ': ' + E.Message);
  end;
end.
