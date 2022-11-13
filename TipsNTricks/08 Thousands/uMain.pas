unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const

  LARGE_NUMBER = 31324134341; //What number is this?

implementation

{$R *.dfm}



procedure TForm1.btnStartClick(Sender: TObject);
begin
  for var I := 0 to LARGE_NUMBER do
    begin
      if i mod 1000 = 0 then
      begin
        ProgressBar1.StepIt;
        Application.ProcessMessages;
      end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ProgressBar1.Max := LARGE_NUMBER div 100;
end;

end.
