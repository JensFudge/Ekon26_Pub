program RTTIDemo;

uses
  FMX.Forms,
  uMainRTTI in 'uMainRTTI.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
