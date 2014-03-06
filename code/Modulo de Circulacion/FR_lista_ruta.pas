unit FR_lista_ruta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, grimgctrl, qrFramelines;

type
  TFRHojadeRuta = class(TForm)
    Qlistado: TQuickRep;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    noruta: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    total: TQRLabel;
    QRLabel5: TQRLabel;
    Nosubscripcion: TQRDBText;
    Atenciona: TQRDBText;
    calle: TQRDBText;
    Colonia: TQRDBText;
    Descripcion: TQRDBText;
    QRHRule1: TQRHRule;
    QRFrameline1: TQRFrameline;
    QRFrameline2: TQRFrameline;
    QRFrameline3: TQRFrameline;
    QRFrameline4: TQRFrameline;
    fecha: TQRExpr;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRHojadeRuta: TFRHojadeRuta;

implementation

{$R *.dfm}
Uses Fprincipal;

end.
