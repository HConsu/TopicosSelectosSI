unit Acerca_de_Subs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFAcercade = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ver: TLabel;
    Label5: TLabel;
    Servidor: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAcercade: TFAcercade;

implementation

{$R *.dfm}
Uses
Fprincipal;

procedure TFAcercade.FormShow(Sender: TObject);
var
rutaapp,aplicacion,version,URL:string;
current:String;
Size,Size2 : DWord;
Pt, Pt2   : Pointer;
begin


       Size := GetFileVersionInfoSize(PChar('Circulacion.exe'), Size2);

  if Size > 0 then
  begin
    GetMem(Pt, Size);
    try
      GetFileVersionInfo (PChar(Aplicacion), 0, Size, Pt);
      VerQueryValue (Pt, '', Pt2, Size2);
      with TVSFixedFileInfo (Pt2^) do
        version:= Format('%d.%d',[ HiWord(dwFileVersionMS),LoWord(dwFileVersionMS)]);
    finally
      FreeMem (Pt);
    end;
  end;
   ver.Caption:=version;
   Servidor.Caption:='Conectado a:'+FPrincipalCirculacion.ZConexion.Database;

end;

end.
