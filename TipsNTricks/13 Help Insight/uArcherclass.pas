unit uArcherclass;

interface

Type
  TArcher = class(TObject)
    private
    FLastName: string;
    FFirstName: string;
    function getFullName: string;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    public
      ///<summary>
      ///  Firstname is the firstname
      ///</summary>
      property FirstName: string read FFirstName write SetFirstName;
      property LastName: string read FLastName write SetLastName;
      property FullName: string read getFullName;
      ///<summary>
      ///  GetPoints returns the points
      ///</summary>
      ///<param name="allPoints">A boolean to be able to include all points
      /// </param>
      /// <remarks>
      /// This is just a demo
      /// </remarks>
      /// <returns> The ultimate number
      /// </returns>
      function GetPoints (allPoints: Boolean) : integer;

  end;

implementation

{ TArcher }

function TArcher.getFullName: string;
begin
  result := self.FFirstName + ' ' + self.FLastName;
end;

function TArcher.GetPoints(allPoints: Boolean): integer;
begin
  Result := 42;
end;

procedure TArcher.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TArcher.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

end.
