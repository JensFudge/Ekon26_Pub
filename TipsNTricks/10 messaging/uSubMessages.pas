unit uSubMessages;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Messaging,
  FMX.EditBox, FMX.SpinBox, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmSub = class(TForm)
    btnStringMessage: TButton;
    btnIntegerMessage: TButton;
    Edit1: TEdit;
    SpinBox1: TSpinBox;
    procedure btnIntegerMessageClick(Sender: TObject);
    procedure btnStringMessageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSub: TfrmSub;

implementation

{$R *.fmx}

procedure TfrmSub.btnIntegerMessageClick(Sender: TObject);
var
  MessageManager : TMessageManager;  //Uses System.Messaging
  aMessage : TMessage;
begin
  MessageManager := TMessageManager.DefaultManager; //Use the default manager
  aMessage := TMessage<integer>.Create(Trunc(SpinBox1.Value)); //Create the message
  MessageManager.SendMessage(Sender, aMessage, true); //and send it, pass true to automatically free the message
end;

procedure TfrmSub.btnStringMessageClick(Sender: TObject);
var
  MessageManager : TMessageManager;
  aMessage : TMessage;
begin
  MessageManager := TMessageManager.DefaultManager;
  aMessage := TMessage<UnicodeString>.Create(Edit1.Text);
  MessageManager.SendMessage(Sender, aMessage, true);
end;

end.
