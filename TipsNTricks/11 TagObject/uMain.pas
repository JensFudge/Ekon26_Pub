unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView, uArcherClass;

type
  TForm1 = class(TForm)
    lvArchers: TListView;
    btnAddArchers: TButton;
    lblArcher: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddArchersClick(Sender: TObject);
    procedure lvArchersItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    fArchers : TArchers;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnAddArchersClick(Sender: TObject);
begin
  var llvItem : TListViewItem;
  for var lArcher in fArchers do
    begin
       llvItem := lvArchers.Items.Add;
       llvItem.Text := lArcher.Name;
       llvItem.Tag := Integer(lArcher);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fArchers := TArchers.Create;
  fArchers.AddSomeArchers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fArchers.free;
end;

procedure TForm1.lvArchersItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  lblArcher.Text := format('%s shoots the %s and has %d points',
                     [TArcher(aItem.Tag).Name,
                      TArcher(aItem.Tag).BowType,
                      TArcher(aItem.Tag).Points]);
end;

end.
