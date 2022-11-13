program MessagingDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainMessages in 'uMainMessages.pas' {frmMain},
  uSubMessages in 'uSubMessages.pas' {frmSub};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSub, frmSub);
  Application.Run;
end.
