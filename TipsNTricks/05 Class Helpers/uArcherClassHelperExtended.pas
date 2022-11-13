unit uArcherClassHelperExtended;

interface

uses
  uArcherClass, uArcherClassHelper;

Type
   TArcherClassExtendedHelper = class helper (TArcherClassHelper) for TArcher
//  TArcherClassExtendedHelper = class helper for TArcher
    function GetNameReversed: string;
  end;

implementation


function TArcherClassExtendedHelper.GetNameReversed: string;
begin
  Result := self.LastName +', ' + self.FirstName;
end;


end.
