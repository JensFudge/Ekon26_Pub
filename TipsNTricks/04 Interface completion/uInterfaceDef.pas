unit uInterfaceDef;

interface

Type
  IScoreVerifyLogger = interface(iInvokable)
     ['{3E37F082-84BF-4411-AB82-F212503AE215}']  //Ctrl-shift-G
        procedure Log(s: string);
        procedure LogToFile(s: string);
        procedure SetupScoring;
        function IsValidScore: Boolean;
      end;

   Type

   TScoreVeryfyLogger = Class(TInterfacedObject, IScoreVerifyLogger)
      private

   end;


implementation

end.
