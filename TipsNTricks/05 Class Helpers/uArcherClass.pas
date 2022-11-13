unit uArcherClass;

interface

Type

 TArcher = class(TObject)
    private
    FTotalPoints: integer;
    FNumberOfAddedPoints: integer;
    FLastName: String;
    FFirstName: String;
    FBowType: String;
    procedure SetBowType(const Value: String);
    procedure SetFirstName(const Value: String);
    procedure SetLastName(const Value: String);
    public
      property FirstName: String read FFirstName write SetFirstName;
      property LastName: String read FLastName write SetLastName;
      property BowType: String read FBowType write SetBowType;
      function AddPoints(aPoint: integer) : integer;
      constructor Create; reintroduce;
  end;



implementation

function TArcher.AddPoints(aPoint: integer): integer;
begin
  self.FTotalPoints := self.FTotalPoints + aPoint;
  inc(self.FNumberOfAddedPoints);
  result :=  self.FTotalPoints;
end;

constructor TArcher.Create;
begin
  FTotalPoints := 0;
  FNumberOfAddedPoints := 0;
end;

procedure TArcher.SetBowType(const Value: String);
begin
  FBowType := Value;
end;

procedure TArcher.SetFirstName(const Value: String);
begin
  FFirstName := Value;
end;

procedure TArcher.SetLastName(const Value: String);
begin
  FLastName := Value;
end;

end.
