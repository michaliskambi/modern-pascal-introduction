{$mode objfpc}{$H+}{$J-}
uses SysUtils, Classes;
var
  S: TStream;
  InputInt, OutputInt: Integer;
begin
  InputInt := 666;

  S := TFileStream.Create('my_binary_file.data', fmCreate);
  try
    S.WriteBuffer(InputInt, SizeOf(InputInt));
  finally FreeAndNil(S) end;

  S := TFileStream.Create('my_binary_file.data', fmOpenRead);
  try
    S.ReadBuffer(OutputInt, SizeOf(OutputInt));
  finally FreeAndNil(S) end;

  Writeln('Из файла прочитано целое число: ', OutputInt);
end.