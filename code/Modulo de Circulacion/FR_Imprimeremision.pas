unit FR_Imprimeremision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, QuickRpt, QRCtrls, ExtCtrls;

type
  TFR_Imprime_remision = class(TForm)
    QRRemision: TQuickRep;
    TitleBand1: TQRBand;
    QRImage1: TQRImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FR_Imprime_remision: TFR_Imprime_remision;

implementation

{$R *.dfm}

end.
