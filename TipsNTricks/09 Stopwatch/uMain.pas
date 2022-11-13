unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uStopWatch;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    lblValue: TLabel;
    btnStop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    fStopWatch : TEKON26Watch;
    procedure StopWatchClicked(Sender: TObject);
//    Procedure StopWatchClicked(Sender: TObject; aVal : integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
begin
  fStopWatch.Start;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  fStopWatch.Stop;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fStopWatch := TEKON26Watch.Create(self);
  fStopWatch.OnValueChanged :=  StopWatchClicked;
end;

Procedure TForm1.StopWatchClicked(Sender: TObject);
begin
  if sender is TEKON26Watch then
    lblValue.Caption := TEKON26Watch(sender).Value.ToString;
end;


//Procedure TForm1.StopWatchClicked(Sender: TObject; aVal : integer);
//begin
//    lblValue.Caption := aVal.ToString;;
//end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  fStopWatch.Free;
end;

end.
