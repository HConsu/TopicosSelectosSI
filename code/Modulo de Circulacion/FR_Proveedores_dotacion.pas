unit FR_Proveedores_dotacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, jpeg, QuickRpt, ExtCtrls;

type
  TFR_Proveedoresdotacion = class(TForm)
    QuickRep1: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    TitleBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    ZTProveedores: TZTable;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FR_Proveedoresdotacion: TFR_Proveedoresdotacion;

implementation

{$R *.dfm}

end.
