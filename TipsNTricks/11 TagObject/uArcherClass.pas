unit uArcherClass;

interface

uses
  Generics.Collections;

Type
  TArcher = Class(TObject)
    private
    FName: string;
    FPoints: integer;
    FBowType: string;
    procedure SetBowType(const Value: string);
    procedure SetName(const Value: string);
    procedure SetPoints(const Value: integer);
    public
      property Name: string read FName write SetName;
      property BowType: string read FBowType write SetBowType;
      property Points: integer read FPoints write SetPoints;

  End;

  TArchers = class(TObjectList<TArcher>)
    public
      procedure AddSomeArchers;
  end;


implementation

{ TArcher }

procedure TArcher.SetBowType(const Value: string);
begin
  FBowType := Value;
end;

procedure TArcher.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TArcher.SetPoints(const Value: integer);
begin
  FPoints := Value;
end;

{ TArchers }

procedure TArchers.AddSomeArchers;
begin
  var lArcher: TArcher;
  lArcher := TArcher.Create;
  lArcher.Name := 'Jens Fudge';
  lArcher.BowType := 'Recurve';
  lArcher.Points := 575;
  self.Add(lArcher);

  lArcher := TArcher.Create;
  lArcher.Name := 'Jessica Fudge';
  lArcher.BowType := 'Recurve';
  lArcher.Points := 555;
  self.Add(lArcher);

  lArcher := TArcher.Create;
  lArcher.Name := 'Nicklas Bryld';
  lArcher.BowType := 'Compound';
  lArcher.Points := 598;
  self.Add(lArcher);

  lArcher := TArcher.Create;
  lArcher.Name := 'Kitt Lohman';
  lArcher.BowType := 'Longbow';
  lArcher.Points := 505;
  self.Add(lArcher);

end;

end.
