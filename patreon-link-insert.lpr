{ Simple program to insert a Patreon link into modern_pascal_introduction.html .
  Inserts a snippet of CSS and HTML code into the given document.

  Copyright Michalis Kamburelis 2018-2018.

  License: Permissive Apache 2.0 license.
  See https://www.apache.org/licenses/LICENSE-2.0 .
  Feel free to modify and reuse.
}

{$mode objfpc}{$H+}{$J-}

uses SysUtils, Classes;

{ Read file contents into a String. }
function FileToString(const FileName: String): String;
var
  F: TFileStream;
begin
  F := TFileStream.Create(FileName, fmOpenRead);
  try
    // TFileStream on a simple file has always known Size
    SetLength(Result, F.Size);
    if F.Size <> 0 then
      F.ReadBuffer(Result[1], Length(Result));
  finally FreeAndNil(F) end;
end;

{ Set file contents from a String. Overrides previous file, if any. }
procedure StringToFile(const FileName, Contents: string);
var
  F: TStream;
begin
  F := TFileStream.Create(FileName, fmCreate);
  try
    if Length(Contents) <> 0 then
      F.WriteBuffer(Contents[1], Length(Contents));
  finally FreeAndNil(F) end;
end;

{ Find the 1st occurence of Search inside the Contents,
  and insert Insertion right before it. }
function InsertBefore(const Contents, Search, Insertion: String): String;
var
  P: Integer;
begin
  P := Pos(Search, Contents);
  if P = 0 then
    raise Exception.CreateFmt('Substring "%s" not found in "%s"', [Search, Contents]);
  Result := Contents;
  Insert(Insertion, Result, P);
end;

var
  Contents: String;
begin
  if ParamCount <> 1 then
    raise Exception.Create('Provide exactly 1 parameter, the HTML filename to process');

  Contents := FileToString(ParamStr(1));
  Contents := InsertBefore(Contents, '</head>',
    '<style>' + FileToString('patreon-link.css') + '</style>');
  Contents := InsertBefore(Contents, '<div id="toc" class="toc2">',
    FileToString('patreon-link.html'));
  StringToFile(ParamStr(1), Contents);
end.
