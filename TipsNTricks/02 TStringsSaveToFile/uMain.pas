unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure FillStringList;
    { Private declarations }
  public
    { Public declarations }
    FStrings : TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FillStringList;
begin
  var j: integer := Trunc(Now);
  FStrings.Clear;
  for var I: integer := 0 to j do
  begin
    FStrings.Add(format('Day %d is %s',[i, FormatDateTime('dddddd', i) ]));
  end;

  //We could put this debug info in...
//  {$ifdef DEBUG}
//  FStrings.savetofile('C:\temp\Dates.txt');
//  {$Endif}


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FillStringList;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FStrings := TStringList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FStrings.Free;
end;

end.
