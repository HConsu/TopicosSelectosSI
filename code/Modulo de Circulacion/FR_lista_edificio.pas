unit FR_lista_edificio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, grimgctrl, qrFramelines;

type
  TFRlistaedificio = class(TForm)
    QRlista: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    edificio: TQRLabel;
    fecha: TQRExpr;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Nosubscripcion: TQRDBText;
    atenciona: TQRDBText;
    area: TQRDBText;
    QRFrameline1: TQRFrameline;
    QRFrameline2: TQRFrameline;
    QRFrameline3: TQRFrameline;
    QRFrameline4: TQRFrameline;
    QRHRule1: TQRHRule;
    QRLabel6: TQRLabel;
    total: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRlistaedificio: TFRlistaedificio;

implementation

{$R *.dfm}

end.
