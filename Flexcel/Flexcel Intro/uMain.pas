unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnCreateFile: TButton;
    btnAddSheet: TButton;
    btnRead: TButton;
    btnColumnWidth: TButton;
    btnAutofit: TButton;
    btnFormat: TButton;
    btnFreeze: TButton;
    procedure btnCreateFileClick(Sender: TObject);
    procedure btnAddSheetClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnColumnWidthClick(Sender: TObject);
    procedure btnAutofitClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnFreezeClick(Sender: TObject);
  private
    fxlFileName : string;
    procedure FormatRange(Sheetidx, firstCol, firstRow, lastCol,
      lastRow: integer);
    procedure CreateExcelFile;
    procedure AddSheet;
    procedure ReadFromFile;
    procedure ColumnWidth;
    procedure AutoFit;
    procedure FormatCells;
    procedure FreezePanes;
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses
  System.IOUtils, VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Render;


procedure TForm1.CreateExcelFile;
var
  xls: TXlsFile;
begin

  //Create a new empty Excel file, with default formatting as if it was created by Excel 2019.
  //Different Excel versions can have different formatting when they create
  //an empty file, so for example
  //Excel 2003 will have a default font of Arial, and 2019 will use Calibri.
  xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try

 {   https://doc.tmssoftware.com/flexcel/vcl/api/FlexCel.Core/index.html  }

    //Enters a string into A1  on sheet 1  (-1 is leaving format as it is)
    xls.SetCellValue(1 ,1, 1, 'aString!', -1);



    //Enters a number into A2.
    //Note that xls.SetCellValue(2, 1, '7') would enter a string.
    xls.SetCellValue(1, 2, 1, 7, -1);

    //Enter another floating point number.
    //All numbers in Excel are floating point,
    //so even if you enter an integer, it will be stored as double.
    xls.SetCellValue(1, 3, 1, 11.3, -1);

    //Enters a formula into A4.
    xls.SetCellValue(1, 4, 1, TFormula.Create('=Sum(A2:A3)'), -1);


    //Saves the file to the "Documents" folder.
    xls.Save(fxlFileName);


  finally
    xls.Free;
  end;
end;



procedure TForm1.AddSheet;
var
  xls : TXlsFile;
begin
  xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
    xls.AddSheet;
    xls.ActiveSheet := xls.SheetCount;
    xls.SheetName := 'The one I added';
    xls.SetCellValue(2 ,1, 1, 'This string is added to the new sheet', -1);
    xls.Save(fxlFileName);
  finally
    xls.Free;
  end;
end;

procedure TForm1.ReadFromFile;
var
  xls : TXlsFile;
  lxf : Integer;
begin
  xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
    for var j := 1 to xls.SheetCount do
    begin
      ShowMessage(xls.GetSheetName(j));
    end;

    var aVal := xls.GetCellValue(1, 1, 1,lxf); //AsString can raise an exception if its not a string
    var s  := aVal.AsString;
    ShowMessage(s);

    aVal := xls.GetCellValue(1, 2, 1,lxf); //AsString can raise an exception if its not a string
   // s  := aVal.AsString;   //This will raise an exception
    s  := aVal.ToString;
    ShowMessage(s);

  finally
    xls.Free;
  end;
end;

procedure TForm1.ColumnWidth;
begin
  var xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
  //  https://doc.tmssoftware.com/flexcel/vcl/api/FlexCel.XlsAdapter/TXlsFile/SetColWidth.html#overloads
    xls.SetColWidth(1, 25, 3*256);     //Excel internal units
    xls.Save(fxlFileName);
  finally
    xls.Free;
  end;
end;

procedure TForm1.AutoFit;
begin
  var xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
    xls.SetCellValue(2 ,5, 5, 'Hello from FlexCel! This is quite a long string that has to fit in the cell', -1);

//    https://doc.tmssoftware.com/flexcel/vcl/api/FlexCel.Core/TExcelFile/AutofitCol.html#overloads
    xls.AutofitCol(5,5, false, 1.1, 0, 0, 0);

    xls.Save(fxlFileName);
  finally
    xls.Free;
  end;
end;

procedure TForm1.FormatCells;
begin

  var xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
    xls.AddSheet;
    xls.ActiveSheet := xls.SheetCount;
    xls.SheetName := 'Formatted';
    var s : string;
    for  var I := 3 to 8 do
      for var j  := 3 to 8 do
      begin
        s := format('Row %d, Col %d',[i,j]);
        xls.SetCellValue(i, j, s );
      end;

    for var I := 5 to 7 do
    begin
      for var j := 4 to 7 do
      begin
        var lFormat : TFlxFormat := xls.GetFormat(xls.GetCellFormat(i, j));
        lFormat.Font.Name :=   'Arial';
        lFormat.Font.Size20 := 200;
        lFormat.Font.Style := [TFlxFontStyles.Bold];
        lFormat.Font.Underline := TFlxUnderline.Single;
        lFormat.Font.Scheme := TFontScheme.None; //Note https://doc.tmssoftware.com/flexcel/vcl/tips/changing-the-font-name.html
        lFormat.HAlignment := THFlxAlignment.left;
        lFormat.VAlignment := TVFlxAlignment.bottom;
        var formatIDX : integer := xls.AddFormat(lFormat);

        xls.SetCellFormat(i, j, formatIdx);
      end;
    end;

    xls.Save(fxlFileName);
  finally
    xls.Free;
  end;
end;

procedure TForm1.FreezePanes;
begin
  var xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    xls.Open(fxlFileName);
    var lcell := TCellAddress.Create(3,1);
    lcell.Sheet := 'The One I added';
    xls.ActiveSheet := 2;
    xls.FreezePanes(lcell); //Det er active sheet der bliver frossen
    xls.Save(fxlFileName);
  finally
    xls.Free;
  end;



end;

procedure TForm1.btnColumnWidthClick(Sender: TObject);
begin
  ColumnWidth;
end;

procedure TForm1.btnCreateFileClick(Sender: TObject);
begin
  CreateExcelFile;
end;

procedure TForm1.btnFormatClick(Sender: TObject);
begin
  FormatCells;
end;

procedure TForm1.btnFreezeClick(Sender: TObject);
begin
  FreezePanes;
end;

procedure TForm1.btnAddSheetClick(Sender: TObject);
begin
   AddSheet;
end;

procedure TForm1.btnAutofitClick(Sender: TObject);
begin
  Autofit;
end;

procedure TForm1.btnReadClick(Sender: TObject);


begin
  ReadFromFile;
end;



procedure TForm1.FormatRange(Sheetidx, firstCol, firstRow, lastCol, lastRow : integer);
var
  xls : TXlsFile;
  filename : string;
  i, j : integer;
  lFormat : TFlxFormat;
  formatIDX : integer;
begin
  xls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  filename := TPath.Combine(TPath.GetDocumentsPath, 'testFormat.xlsx');

  xls.Open(filename);

//  lFormat := xls.GetDefaultFormat;


  xls.ActiveSheet := Sheetidx;

  for I := firstRow to lastRow do
  begin
    for j := firstCol to lastCol do
    begin
      lFormat := xls.GetFormat(xls.GetCellFormat(i, j));
      lFormat.Font.Name :=   'Arial';   //'Times New Roman';//
      lFormat.Font.Size20 := 200;
      lFormat.Font.Style := [TFlxFontStyles.Bold];
      lFormat.Font.Underline := TFlxUnderline.Single;
      lFormat.Font.Scheme := TFontScheme.None;
      lFormat.HAlignment := THFlxAlignment.left;
      lFormat.VAlignment := TVFlxAlignment.bottom;
      formatIDX := xls.AddFormat(lFormat);

      xls.SetCellFormat(i, j, formatIdx);
    end;
  end;

  xls.Save(filename);

end;




procedure TForm1.FormCreate(Sender: TObject);
begin
  fxlFileName := TPath.Combine(TPath.GetDocumentsPath, 'test.xls') ;
end;

end.
