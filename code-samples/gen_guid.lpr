{$mode objfpc}{$H+}{$J-}
uses SysUtils;
var
  MyGuid: TGUID;
begin
  Randomize;
  CreateGUID(MyGuid);
  Writeln('[''' + GUIDToString(MyGuid) + ''']');
end.
