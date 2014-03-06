unit FR_Reporte_seguimiento_queja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ExtCtrls, grimgctrl;

type
  TFR_RepSegQueja = class(TForm)
    reporte: TQuickRep;
    ZQquejas: TZQuery;
    TitleBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    fecha: TQRLabel;
    Nosubscriptor: TQRLabel;
    Folio: TQRLabel;
    Ruta: TQRLabel;
    titular: TQRLabel;
    calle: TQRLabel;
    Colonia: TQRLabel;
    cp: TQRLabel;
    Municipio: TQRLabel;
    Telefono: TQRLabel;
    Motivo: TQRLabel;
    descripcion: TQRLabel;
    solucion: TQRMemo;
    QRLabel20: TQRLabel;
    QRHRule1: TQRHRule;
    QRHRule2: TQRHRule;
    QRHRule3: TQRHRule;
    QRHRule4: TQRHRule;
    QRHRule5: TQRHRule;
    QRLabel21: TQRLabel;
    QRHRule6: TQRHRule;
    QRHRule7: TQRHRule;
    QRLabel22: TQRLabel;
    Conyugue: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRHRule8: TQRHRule;
    QRHRule9: TQRHRule;
    QRHRule10: TQRHRule;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FR_RepSegQueja: TFR_RepSegQueja;

implementation

{$R *.dfm}

end.
