{$ifdef FPC} {$mode objfpc}{$H+}{$J-} {$endif}
{$ifdef MSWINDOWS} {$apptype CONSOLE} {$endif}

{ The expected output:

$ fpc method_with_self_nil.dpr
$ ./method_with_self_nil
WriteSomethig: Self <> nil? FALSE
Runtime error 216 at $000000000040119D
  $000000000040119D
  $0000000000422F7C
}

type
  TMyClass = class
    procedure WriteSomethig;
    procedure WriteSomethigVirtual; virtual;
  end;

procedure TMyClass.WriteSomethig;
begin
  Writeln('WriteSomethig: Self <> nil? ', Self <> nil);
end;

procedure TMyClass.WriteSomethigVirtual;
begin
  Writeln('WriteSomethigVirtual: Self <> nil? ', Self <> nil);
end;

var
  C: TMyClass;
begin
  { This test deliberately calls method with Self = nil.
    This is a dirty trick, should not be used (is definitely counter-intuitive as a programming pattern)
    but it works on non-virtual methods,
    and standard Free actually does it ("if Self <> nil then Destroy").
  }

  // this works
  C.WriteSomethig;

  // this will crash
  C.WriteSomethigVirtual;
end.
