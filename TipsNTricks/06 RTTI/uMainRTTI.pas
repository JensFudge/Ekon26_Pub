unit uMainRTTI;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Rtti,
  FMX.Layouts, FMX.Memo, System.TypInfo, FMX.ScrollBox,
  FMX.Controls.Presentation, FMX.Memo.Types;

type
  DisplayTextAttribute = class(TCustomAttribute)
    private
    FDisplayText: string;
    procedure SetDisplayText(const Value: string);
    public
    constructor Create(aDisplayText :string);
    property DisplayText : string read FDisplayText write SetDisplayText;
  end;






type
  TPerson = class(Tobject)
    private
    FLastName: string;
    FFirstName: string;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    public
      [DisplayText('Fornavn')]
      property FirstName : string read FFirstName write SetFirstName;
      [DisplayText('Efternavn')]
      property LastName : string read FLastName write SetLastName;
  end;


type
  TRTTIDemoClass = class(TObject)
    strict Private
      FVeryVeryPrivate : integer;
    private
      FPrivateField : integer;
      FPublicProperty: string;
      FDefaultProperty: integer;
      function PrivateMethod : string;
    procedure SetPublicProperty(const Value: string);
    procedure SetDefaultProperty(const Value: integer);
    protected
      function ProtectedMethod : string;
    public
      PublicField : string;
      function PublicMethod : string;
      function PublicMethodWithParams(aInt : integer; aStr : string) : string;
      property  PublicProperty : string read FPublicProperty write SetPublicProperty;
      property DefaultProperty : integer  read FDefaultProperty write SetDefaultProperty default 42;
      constructor Create; reintroduce;
  end;


type
  TForm1 = class(TForm)
    btnRTTIClass: TButton;
    Memo1: TMemo;
    btnRTTIObj: TButton;
    btnAttributes: TButton;
    Button1: TButton;
    procedure btnRTTIClassClick(Sender: TObject);
    procedure btnRTTIObjClick(Sender: TObject);
    procedure btnAttributesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function GetDisplayTextForProperty(aProperty: TRTTIProperty): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TRTTIDemoClass }

constructor TRTTIDemoClass.Create;
begin
//  self.FDefaultProperty := 42;
  inherited create;
end;

function TRTTIDemoClass.PrivateMethod : string;
begin
  result := 'This method is private';
end;

function TRTTIDemoClass.ProtectedMethod: string;
begin
  result := 'This method is protected';
end;

function TRTTIDemoClass.PublicMethod: string;
begin
  result := 'This method is public';
end;

function TRTTIDemoClass.PublicMethodWithParams(aInt: integer; aStr: string): string;
begin
  result := format('%d - %s',[aInt, aStr]);
end;

procedure TRTTIDemoClass.SetDefaultProperty(const Value: integer);
begin
  FDefaultProperty := Value;
end;

procedure TRTTIDemoClass.SetPublicProperty(const Value: string);
begin
  FPublicProperty := Value;
end;



function TForm1.GetDisplayTextForProperty(aProperty : TRTTIProperty) : string;
var
  tmpAttr : TCustomAttribute;
begin
  Result := '';
  if aProperty <> nil then
  begin
    for tmpAttr in aProperty.GetAttributes do
    begin
      if tmpAttr is DisplayTextAttribute then
      begin
        Result := DisplayTextAttribute(tmpAttr).DisplayText;
      end;
    end;
  end;
end;

procedure TForm1.btnAttributesClick(Sender: TObject);
var
  aP : TPerson;
  Context : TRTTIContext;
  ttype : TRTTIType;
  p : TRttiProperty;
  firstNamelbl, lastNameLbl : string;
begin

  ttype := Context.GetType(TPerson.ClassInfo);

  p := ttype.GetProperty('FirstName');
  firstNamelbl := GetDisplayTextForProperty(p);
  p := ttype.GetProperty('LastName');
  lastNamelbl := GetDisplayTextForProperty(p);

  aP := TPerson.Create;
  aP.FirstName := 'Jens';
  aP.LastName := 'Fudge';

  memo1.Lines.Add(format('%s: %s',[firstNamelbl, aP.FirstName]));
  memo1.Lines.Add(format('%s: %s',[LastNamelbl, aP.LastName]));
  memo1.Lines.Add('');

  ap.FirstName := 'Arthur';
  ap.LastName := 'Dent';
  memo1.Lines.Add(format('%s: %s',[firstNamelbl, aP.FirstName]));
  memo1.Lines.Add(format('%s: %s',[LastNamelbl, aP.LastName]));
  memo1.Lines.Add('');

  ap.Free;

end;

procedure TForm1.btnRTTIClassClick(Sender: TObject);
var
  Context : TRTTIContext;
  ttype : TRTTIType;
  f : TRTTIField;
  p : TRttiProperty;
  m : TRTTIMethod;
  pa : TRttiParameter;
begin

  ttype := Context.GetType(TRTTIDemoClass.ClassInfo);

  Memo1.Lines.Add('Fields:');
  for f in ttype.GetFields do
  begin
    Memo1.Lines.Add(Format('%s has visibility %s',[f.Name , GetEnumName(TypeInfo(TMemberVisibility),Integer(f.Visibility)) ]));
  end;

  Memo1.Lines.Add('');
  Memo1.Lines.Add('Properties');
  for p in ttype.GetProperties do
  begin
    Memo1.Lines.Add(Format('%s has visibility %s',[p.Name , GetEnumName(TypeInfo(TMemberVisibility),Integer(p.Visibility)) ]));
    if p is TRttiInstanceProperty then
      Memo1.Lines.Add(format('%s has a  defaultvalue: %s',[p.name, TRttiInstanceProperty(p).Default.ToString]));
  end;

  Memo1.Lines.Add('');
  Memo1.Lines.Add('Methods');
  for m in ttype.GetMethods do
  begin
    Memo1.Lines.Add(Format('%s has visibility %s',[m.Name , GetEnumName(TypeInfo(TMemberVisibility),Integer(m.Visibility)) ]));
    for pa in m.GetParameters do
    begin
      Memo1.Lines.Add('    ' + pa.ToString);
    end;
  end;





end;

procedure TForm1.btnRTTIObjClick(Sender: TObject);
var
  aRDC : TRTTIDemoClass;
  aVal : TValue;
  aRes : TValue;
  Context : TRTTIContext;
  ttype : TRTTIType;
  f : TRTTIField;
  p : TRttiProperty;
  m : TRTTIMethod;
  pas : TArray<TRttiParameter>;
  pa : TRttiParameter;
  paramValues: array[0..1] of TValue;
  i : integer;
begin
  aRDC := TRTTIDemoClass.Create;
  ttype := Context.GetType(TRTTIDemoClass.ClassInfo);


  {FIELDS}
  f := ttype.GetField('FPrivateField');
  Memo1.Lines.Add('Private fields...');
  aVal := 42;
  Memo1.Lines.Add(format('Set the value on the field: %s',[aVal.ToString]));
  if assigned(f) then
    f.SetValue(aRDC,aVal);

  Memo1.Lines.Add(format('And we can get the value with RTTI again: %s',[f.GetValue(aRDC).ToString]));
  Memo1.Lines.Add(format('And from the object: %s',[ aRDC.FPrivateField.ToString]));
  //If the field is strict private, or defined in another unit?
  Memo1.Lines.Add('') ;

  {PROPERTIES}
  p := ttype.GetProperty('PublicProperty');
  Memo1.Lines.Add('Properties work like fields...');
  aVal := 'The quick brown fox jumped over the lazy dog';
  Memo1.Lines.Add(format('Set the value on a property: %s',[aVal.ToString]));
  p.SetValue(aRDC, aVal);
  Memo1.Lines.Add(format('According to RTTI the value is: %s',[p.GetValue(aRDC).ToString]));
  Memo1.Lines.Add('') ;


  {METHODS}
  Memo1.Lines.Add('Public Methods...');
  m := ttype.GetMethod('PublicMethod');
  Memo1.Lines.Add(format('Calling %s',[m.ToString]));
  aRes := m.Invoke(aRDC,[]);
  Memo1.Lines.Add(format('Result is %s',[aRes.ToString])) ;
  Memo1.Lines.Add('');

  {METHODS WITH PARAMETERS}
  Memo1.Lines.Add('Public Methods with parameters...');
  m := ttype.GetMethod('PublicMethodWithParams');
  pas := m.GetParameters;
  i := 0;
  //You can ask how many paramters there are with
  // length(pa), But in this case I know there are two
  for pa in pas do
  begin
    case pa.ParamType.TypeKind of
      tkUnknown: ;
      tkInteger: aVal := 42;
      tkChar: ;
      tkEnumeration: ;
      tkFloat: ;
      tkString: ;
      tkSet: ;
      tkClass: ;
      tkMethod: ;
      tkWChar: ;
      tkLString: ;
      tkWString: ;
      tkVariant: ;
      tkArray: ;
      tkRecord: ;
      tkInterface: ;
      tkInt64: ;
      tkDynArray: ;
      tkUString: aVal := 'Don''t Panick';
      tkClassRef: ;
      tkPointer: ;
      tkProcedure: ;
    end; //case
    paramValues[i] := aVal;
    inc(i);
  end;
  Memo1.Lines.Add(format('Calling %s with %s and %s',[m.ToString,'42', 'Don''t Panick']));

  aRes := m.Invoke(aRDC, [paramValues[0], paramValues[1]]);
  Memo1.Lines.Add(format('Result is %s',[  aRes.ToString]));


  Memo1.Lines.Add(format('The value of defaultProperty is %d',[aRdc.FDefaultProperty]));

end;


procedure TForm1.Button1Click(Sender: TObject);
var
  aTest : TRTTIDemoClass;
begin
  aTest := TRTTIDemoClass.Create;
  showMessage(IntToStr(aTest.DefaultProperty));
end;

{ DisplayTextAttribute }

constructor DisplayTextAttribute.Create(aDisplayText: string);
begin
  FDisplayText := aDisplayText;
end;

procedure DisplayTextAttribute.SetDisplayText(const Value: string);
begin
  FDisplayText := Value;
end;

{ TPerson }

procedure TPerson.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TPerson.SetLastName(const Value: string);
begin
  FLastName := Value;
end;



end.
