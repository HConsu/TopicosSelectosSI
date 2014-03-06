unit FHistorial_entrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFHistorialEntrega = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DShistorial: TDataSource;
    ZQhistorial: TZQuery;
    lnosubs: TLabel;
    DBGrid2: TDBGrid;
    Entregas: TLabel;
    Incidencias: TLabel;
    ZQincidencia: TZQuery;
    DSincidencia: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHistorialEntrega: TFHistorialEntrega;

implementation

{$R *.dfm}
Uses
FAlta_de_queja,Fprincipal;

procedure TFHistorialEntrega.FormShow(Sender: TObject);
var
nosubscripcion,codigo:String;
begin
    lnosubs.Caption:=FaltaQueja.NoSubscripcion.Text;
    codigo:=FaltaQueja.codigo;
    ZQhistorial.Close;
    ZQHistorial.SQL.Clear;
    ZQHistorial.SQL.Add('Select Fecha,Hora from t_datos_scaner_final where codigo="'+codigo+'" group by fecha');
    ZQHistorial.ExecSQL;
    ZQHistorial.Open;

    ZQincidencia.Close;
    ZQincidencia.SQL.Clear;
    ZQincidencia.SQL.Add('Select Fecha,(Select motivo from c_motivonoentrega where t_incidencias_final.id_motivo=c_motivonoentrega.id) AS Motivo from t_incidencias_final inner join t_estadisticas_ruta ON');
    ZQincidencia.SQL.Add('t_incidencias_final.id_estadistica = t_estadisticas_ruta.id_estadistica where nosubscripcion='+lnosubs.Caption);
    ZQincidencia.ExecSQL;
    ZQincidencia.Open;

end;

end.
