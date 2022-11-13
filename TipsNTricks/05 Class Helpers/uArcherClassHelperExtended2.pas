unit uArcherClassHelperExtended2;

interface

uses
  uArcherClass, uArcherClassHelper, uArcherClassHelperExtended, RTTI;

Type
   TArcherClassExtendedHelper2 = class helper (TArcherClassExtendedHelper) for TArcher
    function GetTotalPoints: integer;
    function GetPointEntryCount: integer;
  private
    function getFieldValue(aFieldName: string): TValue;
  end;


implementation

{ TArcherClassExtendedHelper2 }

function TArcherClassExtendedHelper2.getFieldValue(aFieldName: string): TValue;
var
  Context : TRTTIContext;
  ttype : TRTTIType;
  f : TRTTIfield;
begin
  ttype := Context.GetType(TArcher.ClassInfo);
  f := ttype.GetField(aFieldName);
  if assigned(f) then
    Result := f.GetValue(self)
  else
    Result := 0;
end;

function TArcherClassExtendedHelper2.GetPointEntryCount: integer;
begin
  Result := getFieldValue('FNumberOfAddedPoints').AsInteger;
end;

function TArcherClassExtendedHelper2.GetTotalPoints: integer;
begin
  Result := getFieldValue('FTotalPoints').AsInteger;
end;

end.
