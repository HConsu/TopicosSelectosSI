unit FR_lista_rutac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, qrFramelines, grimgctrl, QRCtrls, QuickRpt, ExtCtrls;

type
  TFRListaCancelados = class(TForm)
    Qcancelados: TQuickRep;
    TitleBand2: TQRBand;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    nosubc: TQRDBText;
    atencionac: TQRDBText;
    callec: TQRDBText;
    coloniac: TQRDBText;
    descripcionc: TQRDBText;
    QRHRule2: TQRHRule;
    QRFrameline5: TQRFrameline;
    QRFrameline6: TQRFrameline;
    QRFrameline7: TQRFrameline;
    QRFrameline8: TQRFrameline;
    QRBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRListaCancelados: TFRListaCancelados;

implementation

{$R *.dfm}

end.
