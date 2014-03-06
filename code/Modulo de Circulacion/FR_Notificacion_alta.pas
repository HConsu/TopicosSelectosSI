unit FR_Notificacion_alta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls;

type
  TFRNotificacionalta = class(TForm)
    Notificacion: TQuickRep;
    PageHeaderBand1: TQRBand;
    TitleBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
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
