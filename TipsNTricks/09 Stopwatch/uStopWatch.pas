unit uStopWatch;

interface

uses
 System.Classes, Vcl.ExtCtrls;

type

  TEKON26ValueChangedEvent = procedure (sender: TObject; newVal: integer) of Object;

  TEKON26Watch = class(TObject)
    private
    fTimer : TTimer;
    FOnValueChanged: TNotifyEvent;
 //   FOnValueChanged: TEKON26ValueChangedEvent;
    FValue: integer;
    FisRunning: Boolean;
    procedure SetOnValueChanged(const Value: TNotifyEvent);
//    procedure SetOnValueChanged(const Value: TEKON26ValueChangedEvent);
    procedure fTimerClick(sender: TObject);
    procedure SetValue(const Value: integer);
    public
    procedure Start;
    procedure Stop;
    property OnValueChanged : TNotifyEvent read FOnValueChanged write SetOnValueChanged;
 //   property OnValueChanged : TEKON26ValueChangedEvent read FOnValueChanged write SetOnValueChanged;
    property Value : integer read FValue write SetValue;
    property isRunning : Boolean read FisRunning;
    constructor Create(aOwner : TComponent); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TNohauWatch }

constructor TEKON26Watch.Create(aOwner : TComponent);
begin
  inherited Create;
  fTimer := TTimer.Create(aOwner);
  fTimer.Enabled := false;
  fTimer.Interval := 1000;
  fTimer.OnTimer := fTimerClick;
  fValue := 0;
end;

procedure TEKON26Watch.fTimerClick(sender : TObject);
begin
  fTimer.Enabled := false;
  fValue := fValue + 1;
  if assigned(FOnValueChanged) then
    FOnValueChanged(self);
  //  FOnValueChanged(self, fValue);
  fTimer.Enabled := true;
end;

destructor TEKON26Watch.Destroy;
begin
  fTimer.Free;
end;

//procedure TEKON26Watch.SetOnValueChanged(const Value: TEKON26ValueChangedEvent);
//begin
//  FOnValueChanged := Value;
//end;

procedure TEKON26Watch.SetOnValueChanged(const Value: TNotifyEvent);
begin
  FOnValueChanged := Value;
end;

procedure TEKON26Watch.SetValue(const Value: integer);
begin
  FValue := Value;
end;

procedure TEKON26Watch.Start;
begin
  self.fTimer.Enabled := true;
  fisRunning := true;
end;

procedure TEKON26Watch.Stop;
begin
  self.fTimer.Enabled := false;
  fisRunning := false;
end;

end.
