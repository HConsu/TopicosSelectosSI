unit FR_Notificacion_alta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, grimgctrl;

type
  TFRNotificacionalta = class(TForm)
    Notificacion: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel2: TQRLabel;
    nosubscriptor: TQRLabel;
    QRLabel3: TQRLabel;
    fechainicio: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    nombre: TQRLabel;
    QRHRule1: TQRHRule;
    telefono: TQRLabel;
    QRHRule6: TQRHRule;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    ruta: TQRLabel;
    QRHRule7: TQRHRule;
    calle: TQRLabel;
    QRHRule2: TQRHRule;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    colonia: TQRLabel;
    QRHRule3: TQRHRule;
    QRLabel10: TQRLabel;
    cp: TQRLabel;
    QRHRule8: TQRHRule;
    QRLabel11: TQRLabel;
    ciudad: TQRLabel;
    QRHRule4: TQRHRule;
    QRLabel13: TQRLabel;
    observaciones: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    descripcion: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRHRule5: TQRHRule;
    QRLabel19: TQRLabel;
    QRHRule9: TQRHRule;
    QRLabel20: TQRLabel;
    QRHRule10: TQRHRule;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel12: TQRLabel;
    folio: TQRLabel;
    QRLabel25: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel26: TQRLabel;
    user: TQRLabel;
    QRLabel27: TQRLabel;
    nosubscripcion: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRNotificacionalta: TFRNotificacionalta;

implementation

{$R *.dfm}

end.
