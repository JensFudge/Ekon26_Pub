unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure DoSQLStuff;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DoSQLStuff;
end;

procedure TForm1.DoSQLStuff;
var
  lQry: TFDQuery;
begin
  //if we have a qeuery component that we want to fill in runtime,
  //this would be an approach...
  lQry.SQL.Add('SELECT Field1, Field2');
  lQry.SQL.Add('FROM');
  lQry.SQL.Add('TABLE');
  //.... and so forth

  //We could have a SQL from our favourite SQL editor
  //Or get it from the web somewhere
//  https://stackoverflow.com/questions/591382/is-it-possible-to-use-the-select-into-clause-with-union-all
  //This is just an example

  //Edit->Multipaste will be a great help


end;

end.
