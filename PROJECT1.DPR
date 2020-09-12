program Project1;

uses
  Classes, SysUtils, WinTypes, WinProcs, Graphics, Forms, Dialogs,
  Unit1 in 'UNIT1.PAS' {Form1};

{$R *.RES}

var
  DeskDC: HDC;
  Bitmap: TBitmap;
  fs, sStream: TFileStream;
  infile: string;
  outfile: string;
  http_res: string;
const
  bmppath: string = 'C:\scrgrab.tmp';
begin
  if ParamCount <> 3 then
  begin
    MessageDlg('Expecting 3 arguments: profile, input file, output file',
      mtError, [mbOK], 0);
    Exit;
  end;

  infile := ParamStr(2);
  outfile := ParamStr(3);

  DeskDC:=GetDC(0);
  Bitmap:=TBitmap.Create;
  Bitmap.Width:=Screen.Width;
  Bitmap.Height:=Screen.Height;
  WinProcs.BitBlt(Bitmap.Canvas.Handle, 0, 0, Screen.Width, Screen.Height,
    DeskDC, 0, 0, SRCCOPY);
  ReleaseDC(0, DeskDC);
  Bitmap.SaveToFile(bmppath);
  Bitmap.Free;

  http_res := 'HTTP/1.0 200 OK' + #13#10 +
           'Content-Type: image/bmp' + #13#10#13#10;
  fs := TFileStream.Create(outfile, fmCreate or fmOpenWrite);
  fs.Write(http_res[1], Length(http_res));

  sStream := TFileStream.Create(bmppath, fmOpenRead);
  fs.CopyFrom(sStream, 0);
  sStream.Free;
  fs.Free;
  DeleteFile(bmppath);

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

