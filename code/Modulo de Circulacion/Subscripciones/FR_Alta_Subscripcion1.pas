unit FR_Alta_Subscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, jpeg, grimgctrl, StdCtrls;

type
  TFRAltaSubscripcion = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
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
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRHRule1: TQRHRule;
    QRHRule2: TQRHRule;
    QRHRule3: TQRHRule;
    QRHRule4: TQRHRule;
    QRHRule6: TQRHRule;
    QRHRule7: TQRHRule;
    QRHRule8: TQRHRule;
    nombre: TQRLabel;
    telefono: TQRLabel;
    calle: TQRLabel;
    ruta: TQRLabel;
    colonia: TQRLabel;
    cp: TQRLabel;
    ciudad: TQRLabel;
    observaciones: TQRLabel;
    descripcion: TQRLabel;
    nosubscriptor: TQRLabel;
    fechainicio: TQRLabel;
    QRHRule5: TQRHRule;
    QRHRule9: TQRHRule;
    QRHRule10: TQRHRule;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRAltaSubscripcion: TFRAltaSubscripcion;

implementation

{$R *.dfm}

end.
