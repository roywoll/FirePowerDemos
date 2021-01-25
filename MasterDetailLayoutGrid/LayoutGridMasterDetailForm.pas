unit LayoutGridMasterDetailForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.wwDataGrid, FMX.wwLayouts,
  FMX.wwBaseGrid, FMX.Controls.Presentation, FMX.StdCtrls,
  Generics.Collections, Generics.Defaults,
  FMX.wwRecPanel, FMX.Layouts, FMX.ScrollBox, FMX.Memo, FMX.wwMemo,
  Data.DB, System.Rtti, FMX.Grid, FMX.wwColumnTypes, Data.Bind.GenData,
  FMX.wwLayoutGrid, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.ImageList,
  FMX.ImgList, FMX.TabControl;

type
  TMemoryBindingForm = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    wwLayoutGrid1: TwwLayoutGrid;
    Line1Label: TLabel;
    Line2Label: TLabel;
    BindingsList1: TBindingsList;
    Layout1: TLayout;
    MiscIcons: TImageList;
    TitleLayout: TLayout;
    TitleCaption: TLabel;
    tcMasterDetail: TTabControl;
    tiAll: TTabItem;
    tiRecordDetail: TTabItem;
    wwRecordViewPanel1: TwwRecordViewPanel;
    wwRecordViewPanel1DetailName: TwwRecordViewItem;
    wwRecordViewPanel1DetailDate: TwwRecordViewItem;
    wwRecordViewPanel1DetailCity: TwwRecordViewItem;
    wwRecordViewPanel1DetailCountry: TwwRecordViewItem;
    Layout2: TLayout;
    Label1: TLabel;
    Layout8: TLayout;
    Button5: TButton;
    Button7: TButton;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormShow(Sender: TObject);
    procedure wwLayoutGrid1CustomDrawControl(Sender: TObject;
      CellAttributes: TwwCustomDrawControlAttributes);
    procedure wwLayoutGrid1CustomDrawRecordBackground(Sender: TObject;
      CellAttributes: TwwCustomDrawControlAttributes);
    procedure wwLayoutGrid1ItemControlClick(Sender: TObject;
      Region: TwwLayoutClickRegion; Control: TFmxObject; DataSet: TDataSet;
      RelativeRow, AbsoluteRow: Integer);
    procedure Button7Click(Sender: TObject);
  private
    procedure InitializeData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MemoryBindingForm: TMemoryBindingForm;

implementation

{$R *.fmx}

uses LayoutGridMasterDetailData;

procedure TMemoryBindingForm.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  // Connect to our CustomerList data structure
  ABindSourceAdapter := TListBindSourceAdapter<TMasterDetailData>.Create(PrototypeBindSource1, MasterDetailList, False);
end;

function wwTextHeight(Control: TStyledControl;
  const AFont: TFont;
  const AText: string): Single;
var
  MeasureRect: TRectF;
begin
  MeasureRect:= RectF(0, 0, Control.Width, Control.Height);
  TCanvasManager.MeasureCanvas.Font.Assign(AFont);

  TCanvasManager.MeasureCanvas.MeasureText(MeasureRect, AText, true,
    [], TTextAlign.Leading);
  result:= MeasureRect.Height;
end;

procedure TMemoryBindingForm.wwLayoutGrid1CustomDrawControl(Sender: TObject;
  CellAttributes: TwwCustomDrawControlAttributes);
var
  th: Single;
  masterTitle: string;
begin

  if CellAttributes.GetValue('IsMaster').ToString = 'True' then
  begin
     if CellAttributes.Control is TwwLayoutGridAccessory then
       CellAttributes.DoDefaultDrawContents:= false
     else if CellAttributes.Control = Line2Label then
     begin
       CellAttributes.DoDefaultDrawContents:= false;
     end;
     if CellAttributes.Control = Line1Label then
     begin
       MasterTitle:=
         CellAttributes.GetValue('MasterTitle').ToString;

       // Center label in record panel
       th:= wwTextHeight(Line1Label, Line1Label.ResultingTextSettings.Font, MasterTitle);
       CellAttributes.DrawRect.Offset(0,
          (TwwLayoutGrid(Sender).RecordPanel.height-th)/2); // center
       TLabel(CellAttributes.CloneControl).ResultingTextSettings.FontColor:= TAlphaColorRec.Darkblue;

       TLabel(CellAttributes.CloneControl).Text:=
         CellAttributes.GetValue('MasterTitle').ToString;
     end;
  end
  else begin
     if CellAttributes.Control is TwwLayoutGridAccessory then
     begin
        CellAttributes.Opacity:= 0.25;
        exit;
     end;

     // Indent all controls except accessory icon
     CellAttributes.DrawRect.Offset(50, 0);

     if CellAttributes.Control = Line1Label then
     begin
        TLabel(CellAttributes.CloneControl).ResultingTextSettings.FontColor:= TAlphaColorRec.Black;
        TLabel(CellAttributes.CloneControl).Text:=
         CellAttributes.GetValue('DetailName').ToString;
     end;

     if CellAttributes.Control = Line2Label then
     begin
       TLabel(CellAttributes.CloneControl).Text:=
         CellAttributes.GetValue('DetailDate').ToString;
     end;
  end;
end;

procedure TMemoryBindingForm.wwLayoutGrid1CustomDrawRecordBackground(
  Sender: TObject; CellAttributes: TwwCustomDrawControlAttributes);
begin
  if CellAttributes.GetValue('IsMaster').AsBoolean then
  begin
    CellAttributes.BackColor:= TAlphaColorRec.LightGrey;
    CellAttributes.Opacity:= 0.25;
  end;
end;

procedure TMemoryBindingForm.wwLayoutGrid1ItemControlClick(Sender: TObject;
  Region: TwwLayoutClickRegion; Control: TFmxObject; DataSet: TDataSet;
  RelativeRow, AbsoluteRow: Integer);
begin
  if Region = TwwLayoutClickRegion.MoreIcon then
  begin
    if AbsoluteRow<0 then exit;
    if MasterDetailList[AbsoluteRow].IsMaster then exit; // only click for detail records
    tcMasterDetail.SetActiveTabWithTransition(tiRecordDetail, TTabTransition.Slide);
  end;

end;

procedure TMemoryBindingForm.Button7Click(Sender: TObject);
begin
  tcMasterDetail.SetActiveTabWithTransition(tiAll, TTabTransition.Slide,
    TTabTransitionDirection.Reversed);
end;

procedure TMemoryBindingForm.FormShow(Sender: TObject);
begin
  InitializeData;
end;

procedure TMemoryBindingForm.InitializeData;
var
    customer:TMasterDetailData;
    i,j : integer;
    mydate: TDateTime;
begin
  // Initialize data
  for i := 0 to 1000 do
  begin
    customer := TMasterDetailData.Create;
    if (i mod 3) =0 then
    begin
      customer.IsMaster:= true;
      j:= 0;
    end
    else begin
      customer.IsMaster:= false;
    end;

    //mydate:= StrToDateTime('1/1/1945') + Random(365*70); // 70 year range
    mydate:= (Date-(365*70)) + Random(365*70); // 70 year range
    customer.DetailDate:= myDate;
    customer.MasterTitle := 'Master ' + inttostr(i div 3);
    customer.DetailName := 'DetailName' + inttostr(j);
    customer.DetailCity:= 'City' + inttostr(j);
    customer.DetailCountry:= 'Country' + inttostr(j);
    MasterDetailList.Add(customer);
    inc(j);
  end;
end;

end.
