unit FRImprime_Poliza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, qrpctrls;

type
  TFRImprimePoliza = class(TForm)
    QRpoliza: TQuickRep;
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRImage1: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRExpr1: TQRExpr;
    nopoliza: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    codigo: TQRDBText;
    nombre: TQRDBText;
    ejemplares: TQRDBText;
    tarifa: TQRDBText;
    fechas: TQRDBText;
    Pago: TQRDBText;
    QRLabel13: TQRLabel;
    Concepto: TQRLabel;
    QRLabel10: TQRLabel;
    SumEjemplares: TQRExpr;
    QRLabel11: TQRLabel;
    sumtotal: TQRExpr;
    QRLabel12: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRImprimePoliza: TFRImprimePoliza;

implementation

{$R *.dfm}

end.
