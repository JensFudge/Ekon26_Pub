unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnArcher: TButton;
    procedure btnArcherClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uArcherClass;

procedure TForm1.btnArcherClick(Sender: TObject);
begin
  var
    lArcher := TArcher.Create;

    lArcher.FirstName := 'Jens';
    lArcher.GetPoints(true);

end;

end.
