unit LayoutGridMasterDetailData;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Generics.Collections, Generics.Defaults,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type

  TMasterDetailData = class
  public
    IsMaster: boolean;
    MasterTitle: string;
    DetailName: string;
    DetailDate: TDateTime;
    DetailCity: string;
    DetailCountry: string;
    DetailID: integer;
  end;


var MasterDetailList: TObjectList<TMasterDetailData>;

implementation

initialization
   MasterDetailList := TObjectList<TMasterDetailData>.Create;
finalization
   MasterDetailList.Free;
end.
