program InterfaceCompletion;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uInterfaceDef in 'uInterfaceDef.pas',
  uClassDef in 'uClassDef.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
