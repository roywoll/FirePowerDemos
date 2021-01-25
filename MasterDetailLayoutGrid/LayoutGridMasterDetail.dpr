program LayoutGridMasterDetail;

uses
  System.StartUpCopy,
  FMX.Forms,
  LayoutGridMasterDetailForm in 'LayoutGridMasterDetailForm.pas' {MemoryBindingForm},
  LayoutGridMasterDetailData in 'LayoutGridMasterDetailData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMemoryBindingForm, MemoryBindingForm);
  Application.Run;
end.
