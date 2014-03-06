unit FR_reporte_edo_cuenta_imp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, qrpctrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFR_Edo_cuenta = class(TForm)
    ReporteEdoCuenta: TQuickRep;
    TitleBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    codigo: TQRLabel;
    Nombre: TQRLabel;
    fechai: TQRLabel;
    fechaf: TQRLabel;
    DetailBand1: TQRBand;
    edicion: TQRDBText;
    Fecha: TQRDBText;
    Dotacion: TQRDBText;
    devolucion: TQRDBText;
    Pago: TQRDBText;
    vendidos: TQRDBText;
    adeudo: TQRDBText;
    QRExpr1: TQRExpr;
    SumaD: TQRExpr;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    SumaDev: TQRExpr;
    Sumav: TQRExpr;
    QRLabel19: TQRLabel;
    ventas: TQRDBText;
    SumaVentas: TQRExpr;
    totaldev: TQRLabel;
    totaldot: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    tarifa: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel24: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FR_Edo_cuenta: TFR_Edo_cuenta;

implementation

{$R *.dfm}
Uses
FREstado_de_cuenta;

end.
