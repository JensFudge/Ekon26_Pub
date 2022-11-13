unit uArcherClassHelper;

interface

uses
  uArcherClass;

Type
  TArcherClassHelper = class helper for TArcher
    Function GetFullname : string;
  end;

implementation

{ TArcherClassHelper }

function TArcherClassHelper.GetFullname: string;
begin
  Result := self.FirstName + ' ' + self.LastName;
end;


end.
