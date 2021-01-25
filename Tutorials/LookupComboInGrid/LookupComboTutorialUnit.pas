unit LookupComboTutorialUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Controls.Presentation, FMX.Edit, FMX.wwEdit, FMX.wwComboEdit,
  FMX.wwLookupComboEdit, Data.DB, FMX.wwColumnTypes, FMX.wwDataGrid,
  Data.Bind.Components, Data.Bind.DBScope, FMX.wwLayouts, FMX.wwBaseGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm117 = class(TForm)
    FPConnection: TFDConnection;
    OrdersTable: TFDTable;
    CustomerTable: TFDTable;
    wwDataGrid1: TwwDataGrid;
    bsOrders: TBindSourceDB;
    bsCustomers: TBindSourceDB;
    wwDataGrid1CustomerNo: TwwGridColumn;
    wwDataGrid1InvoiceNo: TwwGridColumn;
    wwDataGrid1PaymentMethod: TwwGridColumn;
    wwDataGrid1TotalInvoice: TwwGridColumn;
    wwDataGrid1PurchaseDate: TwwGridColumn;
    wwDataGrid1BalanceDue: TwwGridColumn;
    OrdersTableCustomerNo: TIntegerField;
    OrdersTableInvoiceNo: TIntegerField;
    OrdersTablePaymentMethod: TWideMemoField;
    OrdersTableTotalInvoice: TFloatField;
    OrdersTablePurchaseDate: TDateField;
    OrdersTableBalanceDue: TFloatField;
    OrdersTableLookupCompany: TStringField;
    wwDataGrid1LookupCompany: TwwGridColumn;
    lkCompanyName: TwwLookupComboEdit;
    lkCompanyCustomerNo: TwwGridColumn;
    lkCompanyCompanyName: TwwGridColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form117: TForm117;

implementation

{$R *.fmx}

end.
