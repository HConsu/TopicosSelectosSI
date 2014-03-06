unit FR_Hoja_Corte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls;

type
  TFR_HojaCorte = class(TForm)
    QRHojaCorte: TQuickRep;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    TitleBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    fechacorte: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    codigo: TQRDBText;
    Nombre: TQRDBText;
    Fechasquepaga: TQRDBText;
    pago: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel14: TQRLabel;
    QRLabel6: TQRLabel;
    sumTotal: TQRExpr;
    QRLabel15: TQRLabel;
    labelformato: TQRLabel;
    formato: TQRLabel;
    QRLabel16: TQRLabel;
    nocorte: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FR_HojaCorte: TFR_HojaCorte;

implementation

{$R *.dfm}
Uses
FCorte_circulacion;

end.
