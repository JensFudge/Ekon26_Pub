unit uArcherClass;

interface



Type
  TArcher = class(TObject)
  private
    FName: string;
    fTotPoints: integer;
    function getTotalPoints: integer;
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property TotalPoints: integer read getTotalPoints;
    Procedure AddPoints(aPoint: integer);

  end;

implementation

{ TArcher }

procedure TArcher.AddPoints(aPoint: integer);
begin
  fTotPoints := fTotPoints + aPoint;
end;

function TArcher.getTotalPoints: integer;
begin
  if fTotPoints > 100 then
    Result := 42
  else
    Result := fTotPoints;
end;

procedure TArcher.SetName(const Value: string);
begin
  FName := Value;
end;

end.
