unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnDateTime: TButton;
    mmoDates: TMemo;
    btnArcher: TButton;
    mmoArcher: TMemo;
    procedure btnDateTimeClick(Sender: TObject);
    procedure btnArcherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AddArcherToMemo(sender :TObject);
    procedure AddArcherToMemoStep2(sender: TObject);
    procedure AddArcherToMemoStep3(sender: TObject);
    procedure AddArcherToMemoStep4(sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.DateUtils, uArcherClass
  ;

procedure TForm1.AddArcherToMemo(sender :TObject);
begin
  var vArcher := TArcher.Create;
  vArcher.FirstName := 'Jens';
  vArcher.LastName := 'Fudge';
  vArcher.BowType := 'Recurve';
  var totPoints :=  vArcher.AddPoints(10);
  totPoints := vArcher.AddPoints(10);

  mmoArcher.Lines.Add(vArcher.FirstName + ' ' + vArcher.LastName);
  mmoArcher.Lines.Add(vArcher.BowType);
  mmoArcher.Lines.Add('Has');
  mmoArcher.Lines.Add(totPoints.ToString + ' points'); //<== Another RecordHelper
end;

procedure TForm1.AddArcherToMemoStep2(sender : TObject);
begin
  //We would like to

//  var vArcher := TArcher.Create;
//  vArcher.FirstName := 'Jens';
//  vArcher.LastName := 'Fudge';
//  vArcher.BowType := 'Recurve';
//  var totPoints :=  vArcher.AddPoints(10);
//  totPoints := vArcher.AddPoints(10);
//
//  mmoArcher.Lines.Add(vArcher.GetFullname);  //There is no GetFullName method on TArcher
//  mmoArcher.Lines.Add(vArcher.BowType);
//  mmoArcher.Lines.Add('Has');
//  mmoArcher.Lines.Add(totPoints.ToString + ' points'); //<== Another RecordHelper

end;

procedure TForm1.AddArcherToMemoStep3(sender : TObject);
begin
  //We would like to

//  var vArcher := TArcher.Create;
//  vArcher.FirstName := 'Jens';
//  vArcher.LastName := 'Fudge';
//  vArcher.BowType := 'Recurve';
//  var totPoints :=  vArcher.AddPoints(10);
//  totPoints := vArcher.AddPoints(10);
//
//  mmoArcher.Lines.Add(vArcher.GetNameReversed); //Hey, we can just create a Class Helper right?
//  mmoArcher.Lines.Add(vArcher.BowType);
//  mmoArcher.Lines.Add('Has');
//  mmoArcher.Lines.Add(totPoints.ToString + ' points'); //<== Another RecordHelper

end;

procedure TForm1.AddArcherToMemoStep4(sender : TObject);
begin
  //We would like to

//    var vArcher := TArcher.Create;
//  vArcher.FirstName := 'Jens';
//  vArcher.LastName := 'Fudge';
//  vArcher.BowType := 'Recurve';
//  var totPoints :=  vArcher.AddPoints(10);  //We might not want this to be the only way
//  totPoints := vArcher.AddPoints(10);
//  totPoints := vArcher.GetTotalPoints;
//  var seriesCount := vArcher.GetPointEntryCount;
//
//  mmoArcher.Lines.Add(vArcher.GetNameReversed);
//  mmoArcher.Lines.Add(vArcher.BowType);
//  mmoArcher.Lines.Add('Has');
//
//  mmoArcher.Lines.Add(totPoints.ToString + ' points in ' + seriesCount.ToString + ' Series' ); //<== Another RecordHelper

end;


procedure TForm1.btnArcherClick(Sender: TObject);
begin
  ShowMessage('assign the Proc');
end;

procedure TForm1.btnDateTimeClick(Sender: TObject);
begin
//  var vToday: TDateTime := now;
  var vToday: TDateTime := TDateTime.Now;  //Uses System.DateUtils
  var s: string := vToday.ToString;
  mmoDates.Lines.Add(s);
  s := vToday.Format('dddd');
  mmoDates.Lines.Add(s);
  var vAnotherDay: TDateTime;
  vAnotherDay := Today.IncWeek(-12);
  s := vAnotherDay.Format('dddd - yyyymmdd');
  mmoDates.Lines.Add(s);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  btnArcher.OnClick := AddArcherToMemo;
//  btnArcher.OnClick := AddArcherToMemoStep2;
//  btnArcher.OnClick := AddArcherToMemoStep3;
//  //Now - Introduction to RTTI
//  btnArcher.OnClick := AddArcherToMemoStep4;
end;

end.
