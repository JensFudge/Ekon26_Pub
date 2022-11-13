unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  , uArcherClass;

type
  TForm1 = class(TForm)
    Button1: TButton;
    lblStatus: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    fArcher : TArcher;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  fArcher.AddPoints(10);
  lblStatus.Caption := format('%s has %d points', [fArcher.Name, fArcher.TotalPoints]);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  fArcher.AddPoints(1);
  var i := fArcher.TotalPoints;
  lblStatus.Caption := format('%s has %d points', [fArcher.Name, i]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fArcher := TArcher.Create;
  fArcher.Name := 'Jens Fudge';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fArcher.Free;
end;

end.
