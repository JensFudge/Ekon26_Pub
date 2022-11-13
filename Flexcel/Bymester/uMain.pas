unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uArcherClass,

  VCL.FlexCel.Core,
  FlexCel.XlsAdapter,
  FlexCel.Report,
  FlexCel.Render;

type
  TForm1 = class(TForm)
    btnOpenEntries: TButton;
    od: TOpenDialog;
    btnOpenScoresheet: TButton;
    edDate: TEdit;
    edRoundNo: TEdit;
    btnMerge: TButton;
    SD: TSaveDialog;
    btnArcherID: TButton;
    edText1: TEdit;
    edText2: TEdit;
    btnMergeID: TButton;
    procedure btnOpenEntriesClick(Sender: TObject);
    procedure btnOpenScoresheetClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure btnMergeIDClick(Sender: TObject);
    procedure btnArcherIDClick(Sender: TObject);
  private
    { Private declarations }
    fArchers : TArchers;
    fLanes: TLanes;
    fScoresheetFilename: string;
    fArcherIDFilename: string;
    procedure adjustNameColumn(axlsFile: TXlsFile);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.btnArcherIDClick(Sender: TObject);
begin
  OD.Filter := 'Excel Template filer (*.Template.Xlsx *.Template.xls)|*.Template.xlsx;*.Template.xls|Alle filer (*.*)|*.*' ;
  OD.DefaultExt := 'xlsx';
  if OD.Execute then
  begin
    fArcherIDFilename := OD.FileName;
  end;
end;

procedure TForm1.btnMergeClick(Sender: TObject);
begin
  SD.Filter := 'pdf files (*.pdf)|*.pdf';
  SD.DefaultExt := 'pdf';
  if SD.Execute then
    begin
      var xls := TXlsFile.Create(fScoresheetFilename, true);
      var report := TFlexCelReport.Create(true);
      var pdf := TFlexCelPdfExport.Create(xls, true);
      try
          report.SetValue('Date',edDate.Text);
          report.SetValue('RundeNr',edRoundNo.Text);
          report.AddTable<TLane>('A', fLanes, TDisposeMode.DoNotDispose);
          report.Run(xls);

          pdf.ExportAllVisibleSheets(SD.FileName, false, '');
          ShowMessage('Done');
       finally
         xls.Free;
         report.Free;
         pdf.Free;
       end;
    end;

end;

procedure TForm1.adjustNameColumn(axlsFile : TXlsFile);
begin
  var aVal : TCellValue;
  var xf : integer;
  var aStr : string;
  var RowName: integer;

  RowName := 6;

  if RowName > 0 then
  begin
    for var I := 1 to axlsFile.SheetCount do
    begin
       aVal := axlsFile.GetCellValue(I,RowName, 1, xf);
       aStr := aVal.ToString;
       if Length(aStr) > 17 then
       begin
         var lFormat : TFlxFormat := axlsFile.GetFormat(axlsFile.GetCellFormat(I, RowName, 1));
         lFormat.Font.Size20 := 20 * 40;
         if Length(aStr) > 22 then
           lFormat.Font.Size20 := 20 * 30;
         if Length(aStr) > 30 then
           lFormat.Font.Size20 := 20 * 25;
         if Length(aStr) > 40 then
           lFormat.Font.Size20 := 20 * 20;
         lFormat.Font.Scheme := TFontScheme.None;
         var formatIDX : integer := axlsFile.AddFormat(lFormat);
        axlsFile.ActiveSheet := I;
        axlsFile.SetCellFormat(RowName,1, formatIdx);
       end;

    end;
  end;
end;


procedure TForm1.btnMergeIDClick(Sender: TObject);
begin
  SD.Filter := 'pdf files (*.pdf)|*.pdf';
  SD.DefaultExt := 'pdf';
  if SD.Execute then
    begin
      var xls := TXlsFile.Create(fArcherIdFilename, true);
      var report := TFlexCelReport.Create(true);
      var pdf := TFlexCelPdfExport.Create(xls, true);
      try
          report.SetValue('Text1',edText1.Text);
          report.SetValue('Text2',edText2.Text);
          report.AddTable<TArcher>('A', fArchers, TDisposeMode.DoNotDispose);
          report.Run(xls);
          adjustNameColumn(xls);

          pdf.ExportAllVisibleSheets(SD.FileName, false, '');
          ShowMessage('Done');
       finally
         xls.Free;
         report.Free;
         pdf.Free;
       end;
    end;

end;

procedure TForm1.btnOpenEntriesClick(Sender: TObject);
begin

  OD.Filter := 'Excel  filer (*.Xlsx *.xls)|*.xlsx;*.xls|Alle filer (*.*)|*.*' ;
  OD.DefaultExt := 'xlsx';
  if OD.Execute then
  begin
    if not assigned(fArchers) then
      fArchers := TArchers.Create(true);
    fArchers.LoadFromExcelFile(OD.FileName);
    if not assigned(fLanes) then
      fLanes := TLanes.Create(true);
    fLanes.LoadFromArchers(fArchers);
//    ShowMessage(format('%d archers loaded',[fArchers.Count]));
//    ShowMessage(format('%d lanes loaded',[fLanes.Count]));

  end;
end;

procedure TForm1.btnOpenScoresheetClick(Sender: TObject);
begin
  OD.Filter := 'Excel Template filer (*.Template.Xlsx *.Template.xls)|*.Template.xlsx;*.Template.xls|Alle filer (*.*)|*.*' ;
  OD.DefaultExt := 'xlsx';
  if OD.Execute then
  begin
    fScoresheetFilename := OD.FileName;
  end;
end;

end.
