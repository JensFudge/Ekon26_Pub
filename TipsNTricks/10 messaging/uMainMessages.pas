unit uMainMessages;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Messaging,
  FMX.Controls.Presentation, FMX.StdCtrls, uSubMessages;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    btnShowSubForm: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnShowSubFormClick(Sender: TObject);
  private
    procedure StringMessageHandler(const Sender: TObject; const M: TMessage);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

//A method to handle string messages
procedure  TfrmMain.StringMessageHandler(const Sender : TObject; const M : TMessage);
begin
  Label1.Text := TMessage<UnicodeString>(M).Value;
end;

procedure TfrmMain.btnShowSubFormClick(Sender: TObject);
begin
  frmSub.Show;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  MessageManager : TMessageManager;  //Uses System.Messaging
  i : integer;
begin
  MessageManager := TMessageManager.DefaultManager;
  //Subscribe to integer messages with an anonymous method
  MessageManager.SubscribeToMessage(TMessage<integer>,
                   procedure (const Sender : TObject; const M : TMessage)
                   begin
                     i := TMessage<integer>(M).Value;
                     label1.Text := IntToStr(i);
                   end);

  //subscribe to string messages using a procedure of Object
  MessageManager.SubscribeToMessage(TMessage<UnicodeString>,
                      StringMessageHandler);

end;

end.
