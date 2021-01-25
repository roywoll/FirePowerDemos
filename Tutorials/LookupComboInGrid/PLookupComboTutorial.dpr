program PLookupComboTutorial;

uses
  System.StartUpCopy,
  FMX.Forms,
  LookupComboTutorialUnit in 'LookupComboTutorialUnit.pas' {Form117};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm117, Form117);
  Application.Run;
end.
