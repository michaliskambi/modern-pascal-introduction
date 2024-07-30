{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}

uses SysUtils;

{ Example function that concatenates all elements of an array of const
  into a String. }
function GlueEverything(const MyArray: array of const): String;
var
  I: Integer;
begin
  Result := '';

  for I := 0 to High(MyArray) do
  begin
    // treat MyArray[I] as TVarRec, check for type and do something
    case MyArray[I].VType of
      vtInteger:
        begin
          Writeln('Integer: ', MyArray[I].VInteger);
          Result := Result + IntToStr(MyArray[I].VInteger) + ' ';
        end;
      vtAnsiString:
        begin
          Writeln('Ansi String (8-bit chars): ', AnsiString(MyArray[I].VAnsiString));
          Result := Result + AnsiString(MyArray[I].VAnsiString) + ' ';
        end;
      vtUnicodeString:
        begin
          Writeln('Unicode String (16-bit chars): ', UnicodeString(MyArray[I].VUnicodeString));
          Result := Result + UnicodeString(MyArray[I].VUnicodeString) + ' ';
        end;
      else
        Writeln('Something else, ignoring');
    end;
  end;
end;

var
  S: String;
begin
  S := GlueEverything([123, 'Hello', 'World', 456]);
  Writeln(S);
end.
