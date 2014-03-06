unit FRHojadeModifiacionRuta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, grimgctrl, jpeg;

type
  TFhoja_modif_ruta = class(TForm)
    Notificaciones: TQuickRep;
    DetailBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    Nosubscripcionb: TQRDBText;
    QRLabel3: TQRLabel;
    QRHRule1: TQRHRule;
    QRImage3: TQRImage;
    QRLabel4: TQRLabel;
    fechaimpb: TQRLabel;
    QRLabel6: TQRLabel;
    foliob: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    Nosubscripciona: TQRDBText;
    QRLabel9: TQRLabel;
    label8: TQRLabel;
    titularb: TQRDBText;
    direccionb: TQRLabel;
    direcciona: TQRLabel;
    QRLabel5: TQRLabel;
    titulara: TQRDBText;
    QRHRule2: TQRHRule;
    QRHRule3: TQRHRule;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    Folioa: TQRLabel;
    fechaimpa: TQRLabel;
    rutaanterior: TQRLabel;
    rutanueva: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fhoja_modif_ruta: TFhoja_modif_ruta;

implementation

{$R *.dfm}

end.
