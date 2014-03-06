unit Forden_Entrega_ventas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  StdCtrls;

type
  TFOrdenEntregaVentas = class(TForm)
    Label1: TLabel;
    Fecha: TLabel;
    Label2: TLabel;
    tiempo: TLabel;
    gridentregas: TDBGrid;
    ZQsubscripciones: TZQuery;
    ZQdireccion: TZQuery;
    ZQinsertar: TZQuery;
    ZQentregas: TZQuery;
    DSentregas: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOrdenEntregaVentas: TFOrdenEntregaVentas;

implementation

{$R *.dfm}
Uses FEstadisticas_rutas_ventas;

procedure TFOrdenEntregaVentas.FormShow(Sender: TObject);
var
ruta,nosubscripcion,direccion:string;
i:integer;
hora,atenciona:String;
begin
    { ZQsubscripciones.Close;
     ZQsubscripciones.SQL.Clear;
     ZQsubscripciones.SQL.Add('Delete from t_tiempos_ruta_ventas');
     ZQsubscripciones.ExecSQL;}

     fecha.Caption:=FormatDateTime('yyyy-mm-dd',(FestadisticasVEntas.gridestadisticas.Fields[1].AsDateTime));
     ruta:=FestadisticasVEntas.gridestadisticas.Fields[2].AsString;
     LongTimeFormat:='hh:mm:ss';
     tiempo.Caption:=FestadisticasVEntas.gridestadisticas.Fields[8].AsString;

     ZQsubscripciones.Close;
     ZQsubscripciones.SQL.Clear;
     ZQSubscripciones.SQL.Add('Select Nombre,Municipio,Hora,Fecha from t_datos_scaner_final_ventas inner join c_proveedores on t_datos_scaner_final_ventas.codigo=c_proveedores.codigo Where t_datos_scaner_final_ventas.ruta='+ruta+' AND fecha="'+fecha.Caption+'" group by t_datos_scaner_final_ventas.codigo order by id_scan desc');
     ZQsubscripciones.ExecSQL;
     ZQsubscripciones.Open;
      i:=1;



end;

end.
