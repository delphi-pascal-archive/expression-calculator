program calculate;

uses
  Forms,
  umain in 'umain.pas' {FMain},
  expression in 'expression.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
