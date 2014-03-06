unit FQuejas_Subscripciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TFQuejasSubscripciones = class(TForm)
    GridQuejas: TDBGrid;
    DSquejas: TDataSource;
    ZQquejas: TZQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FQuejasSubscripciones: TFQuejasSubscripciones;

implementation

{$R *.dfm}
Uses
FPrincipal,FQuejasReporte,FAlta_de_Queja;

procedure TFQuejasSubscripciones.FormShow(Sender: TObject);
begin
if FPrincipalCirculacion.quienllamaquejasS=1 then
   begin
   ZQQuejas.Close;
   ZQQuejas.SQL.Clear;
   ZQQuejas.SQL.Add('Select id_queja AS Folio,Motivo_queja AS Motivo,Fecha_queja as Fecha,Descripcion,Solucion from t_quejas where nosubscripcion='+FQuejasR.GridQuejas.Fields[1].AsString);
   ZQQuejas.ExecSQL;
   ZQQuejas.Open;
   GridQuejas.Refresh;
   end;

if FPrincipalCirculacion.quienllamaquejasS=2 then
   begin
   ZQQuejas.Close;
   ZQQuejas.SQL.Clear;
   ZQQuejas.SQL.Add('Select id_queja AS Folio,Motivo_queja AS Motivo,Fecha_queja as Fecha,Descripcion,Solucion from t_quejas where nosubscripcion='+FAltaQueja.DBGridSubscripciones.Fields[0].AsString);
   ZQQuejas.ExecSQL;
   ZQQuejas.Open;
   GridQuejas.Refresh;
   end;


end;

end.
