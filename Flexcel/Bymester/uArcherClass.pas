unit uArcherClass;

interface

uses
   System.Generics.Collections, System.SysUtils;

Type
  TArcher = class(TObject)
  private
    FLastName: string;
    FAgeClass: string;
    FFirstName: string;
    FBowType: string;
    FLane: string;
    FLaneNo: string;
    FLaneLetter: string;
    FClub: string;
    Fsex: string;
    function getFullName: string;
    procedure SetAgeClass(const Value: string);
    procedure SetBowType(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetLane(const Value: string);
    procedure SetLaneLetter(const Value: string);
    procedure SetLaneNo(const Value: string);
    procedure SetClub(const Value: string);
    function getShootClass: string;
    procedure Setsex(const Value: string);
  public
    property FirstName: string read FFirstName write SetFirstName;
    property LastName: string read FLastName write SetLastName;
    property BowType: string read FBowType write SetBowType;
    property AgeClass: string read FAgeClass write SetAgeClass;
    property sex: string read Fsex write Setsex;
    property FullName: string read getFullName;
    property Lane: string read FLane write SetLane;
    property LaneNo: string read FLaneNo write SetLaneNo;
    property LaneLetter: string read FLaneLetter write SetLaneLetter;
    property Club: string read FClub write SetClub;
    property shootClass: string read getShootClass;
    property Name: string read getFullName;
  end;

  TArchers = class(TObjectList<TArcher>)
    procedure LoadFromExcelFile(aFileName: string);
  private
    function isLane(aLane: string;  var aLaneNo, aLaneLetter : string): boolean;
  end;

  TLane = class(TObject)
    private
    FLaneNo: string;
    FArcherB: TArcher;
    FArcherC: TArcher;
    FArcherA: TArcher;
    function getAgeClassA: string;
    function getAgeClassB: string;
    function getAgeClassC: string;
    function getBowtypeA: string;
    function getBowtypeB: string;
    function getBowtypeC: string;
    function getClubA: string;
    function getClubB: string;
    function getClubC: string;
    function getLaneA: string;
    function getLaneB: string;
    function getLaneC: string;
    function getNameA: string;
    function getNameB: string;
    function getNameC: string;
    procedure SetArcherA(const Value: TArcher);
    procedure SetArcherB(const Value: TArcher);
    procedure SetArcherC(const Value: TArcher);
    procedure SetLane(const Value: string);
    function getClassA: string;
    function getClassB: string;
    function getClassC: string;
    function getSexA: string;
    function getSexB: string;
    function getSexC: string;
    public
      property LaneNo: string read FLaneNo write SetLane;
      property ArcherA: TArcher read FArcherA write SetArcherA;
      property ArcherB: TArcher read FArcherB write SetArcherB;
      property ArcherC: TArcher read FArcherC write SetArcherC;
      property LaneA: string read getLaneA;
      property LaneB: string read getLaneB;
      property LaneC: string read getLaneC;
      property NameA: string read getNameA;
      property NameB: string read getNameB;
      property NameC: string read getNameC;
      property ClubA: string read getClubA;
      property ClubB: string read getClubB;
      property ClubC: string read getClubC;
      property BowtypeA: string read getBowtypeA;
      property BowtypeB: string read getBowtypeB;
      property BowtypeC: string read getBowtypeC;
      property AgeClassA: string read getAgeClassA;
      property AgeClassB: string read getAgeClassB;
      property AgeClassC: string read getAgeClassC;
      property SexA: string read getSexA;
      property SexB: string read getSexB;
      property SexC: string read getSexC;
      property ClassA: string read getClassA;
      property ClassB: string read getClassB;
      property ClassC: string read getClassC;
  end;

  TLanes = class(TObjectList<TLane>)
    private
      procedure AddArcher(aArcher: TArcher);
      function FindLane(aLaneNo: string): TLane;
    public
      procedure LoadFromArchers(aArchers : TArchers);

  end;

implementation

uses
  VCL.FlexCel.Core,
  FlexCel.XlsAdapter,
  FlexCel.Report,
  FlexCel.Render;

{ TArcher }

function TArcher.getFullName: string;
begin
  result := FFirstName +' ' + FLastName;
end;

function TArcher.getShootClass: string;
begin
  result := self.sex+self.AgeClass+self.FBowType;
end;

procedure TArcher.SetAgeClass(const Value: string);
begin
  FAgeClass := Value;
end;

procedure TArcher.SetBowType(const Value: string);
begin
  FBowType := Value;
end;

procedure TArcher.SetClub(const Value: string);
begin
  FClub := Value;
end;

procedure TArcher.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TArcher.SetLane(const Value: string);
begin
  FLane := Value;
end;

procedure TArcher.SetLaneLetter(const Value: string);
begin
  FLaneLetter := Value;
end;

procedure TArcher.SetLaneNo(const Value: string);
begin
  FLaneNo := Value;
end;

procedure TArcher.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

procedure TArcher.Setsex(const Value: string);
begin
  Fsex := Value;
end;

{ TArchers }

function TArchers.isLane(aLane: String; var aLaneNo, aLaneLetter : string): boolean;
begin
  if Trim(aLane) = '' then
  begin
     Result := false;
     exit;
  end;
  var sNumber: string;

  for var I := 1 to length(aLane) - 1  do
    begin
      if aLane[i] in ['0'..'9'] then
        sNumber := sNumber + aLane[i];
    end;

   var sLetter: string;
   sLetter := aLane[length(aLane)];

   if (sNumber <> '') and (sLetter <> '') then
   begin
     aLaneNo := sNumber;
     aLaneLetter := sLetter;
     Result := true;
   end
   else
     Result := false;

end;

procedure TArchers.LoadFromExcelFile(aFileName: string);
begin
  self.Clear;
  var lxls : TXlsFile;
  lxls := TXlsFile.Create(1, TExcelFileFormat.v2019, true);
  try
    lxls.Open(aFileName);
    var SheetIdx := lxls.GetSheetIndex('Resultater og banefordeling');
    var LineIdx: Integer := 3;
    var ColIdx: Integer := 1;
    var MoreData: Boolean := true;
    var lxf : Integer;
    var lVal : TCellValue;
    var lArcher : TArcher;
    var lLaneNo: string;
    var lLaneLetter: string;
    lxls.ActiveSheet := SheetIdx;
    while MoreData do
    begin
      lVal := lxls.GetCellValue(LineIdx, ColIdx, lxf);
      if isLane(lVal.ToString, lLaneNo, lLaneLetter) then
      begin
        lArcher := TArcher.Create;
        lArcher.Lane := lVal.ToString;
        lArcher.LaneNo := lLaneNo;
        lArcher.LaneLetter := lLaneLetter;
        lArcher.LastName := lxls.GetCellValue(LineIdx, ColIdx + 2, lxf).ToString;
        lArcher.FirstName := lxls.GetCellValue(LineIdx, ColIdx +1, lxf).ToString;
        lArcher.Club := lxls.GetCellValue(LineIdx, ColIdx +3, lxf).ToString;
        lArcher.BowType := lxls.GetCellValue(LineIdx, ColIdx +4, lxf).ToString;
        lArcher.AgeClass := lxls.GetCellValue(LineIdx, ColIdx +5, lxf).ToString;
        lArcher.sex := lxls.GetCellValue(LineIdx, ColIdx +6, lxf).ToString;
        self.Add(lArcher);
      end
      else
      if (Trim(lVal.ToString)) = '' then
      begin
        MoreData := False;
      end;
      Inc(LineIdx);
    end;
  finally
    lxls.Free;
  end;
end;

{ TLane }

function TLane.getAgeClassA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.AgeClass
   else
     result := '';
end;

function TLane.getAgeClassB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.AgeClass
   else
     result := '';
end;

function TLane.getAgeClassC: string;
begin
     if assigned(FArcherC) then
     result := FArcherC.AgeClass
   else
     result := '';
end;

function TLane.getBowtypeA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.BowType
   else
     result := '';
end;

function TLane.getBowtypeB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.BowType
   else
     result := '';

end;

function TLane.getBowtypeC: string;
begin
   if assigned(FArcherC) then
     result := FArcherC.BowType
   else
     result := '';

end;

function TLane.getClassA: string;
begin
  if assigned(FArcherA) then
     result := FArcherA.ShootClass
   else
     result := '';
end;

function TLane.getClassB: string;
begin
  if assigned(FArcherB) then
     result := FArcherB.ShootClass
   else
     result := '';
end;

function TLane.getClassC: string;
begin
  if assigned(FArcherC) then
     result := FArcherC.ShootClass
   else
     result := '';
end;

function TLane.getClubA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.Club
   else
     result := '';

end;

function TLane.getClubB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.Club
   else
     result := '';

end;

function TLane.getClubC: string;
begin
   if assigned(FArcherC) then
     result := FArcherC.Club
   else
     result := '';

end;

function TLane.getLaneA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.Lane
   else
     result := '';

end;

function TLane.getLaneB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.Lane
   else
     result := '';

end;

function TLane.getLaneC: string;
begin
   if assigned(FArcherC) then
     result := FArcherC.Lane
   else
     result := '';

end;

function TLane.getNameA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.FullName
   else
     result := '';

end;

function TLane.getNameB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.FullName
   else
     result := '';

end;

function TLane.getNameC: string;
begin
   if assigned(FArcherC) then
     result := FArcherC.FullName
   else
     result := '';

end;

function TLane.getSexA: string;
begin
   if assigned(FArcherA) then
     result := FArcherA.Sex
   else
     result := '';

end;

function TLane.getSexB: string;
begin
   if assigned(FArcherB) then
     result := FArcherB.Sex
   else
     result := '';

end;

function TLane.getSexC: string;
begin
   if assigned(FArcherC) then
     result := FArcherC.Sex
   else
     result := '';

end;

procedure TLane.SetArcherA(const Value: TArcher);
begin
  FArcherA := Value;
end;

procedure TLane.SetArcherB(const Value: TArcher);
begin
  FArcherB := Value;
end;

procedure TLane.SetArcherC(const Value: TArcher);
begin
  FArcherC := Value;
end;

procedure TLane.SetLane(const Value: string);
begin
  FLaneNo := Value;
end;

{ TLanes }

procedure TLanes.AddArcher(aArcher: TArcher);
begin
  var lLane: TLane;
  lLane := self.FindLane(aArcher.LaneNo);
  if AnsiUpperCase(aArcher.LaneLetter) = 'A' then
    lLane.FArcherA := aArcher
  else
  if AnsiUpperCase(aArcher.LaneLetter) = 'B' then
    lLane.FArcherB := aArcher
  else
  if AnsiUpperCase(aArcher.LaneLetter) = 'C' then
    lLane.FArcherC := aArcher;
end;

function TLanes.FindLane(aLaneNo: string): TLane;
begin
  result := nil;
  if self.Count = 0 then
  begin
    result := TLane.Create;
    result.LaneNo := aLaneNo;
    self.Add(result);
  end
  else
  begin
    for var I: integer := 0 to self.Count - 1 do
    begin
      if self[i].LaneNo = aLaneNo then
      begin
        result := self[i];
        break;
      end;
    end;
    if not assigned(result) then
      begin
        result := TLane.Create;
        result.LaneNo := aLaneNo;
        self.Add(result);
      end;
  end;
end;

procedure TLanes.LoadFromArchers(aArchers: TArchers);
begin
  for var archer: TArcher in aArchers do
    begin
      self.addArcher(archer);
    end;
end;

end.
