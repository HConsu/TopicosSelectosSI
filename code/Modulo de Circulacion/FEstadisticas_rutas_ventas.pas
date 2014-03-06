unit FEstadisticas_rutas_ventas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  DBCtrls, Grids, DBGrids;

type
  TFestadisticasVEntas = class(TForm)
    Label1: TLabel;
    responsable: TLabel;
    gridestadisticas: TDBGrid;
    crutas: TDBLookupComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DSEstadisticas: TDataSource;
    DSrutas: TDataSource;
    ZQestadisticas: TZQuery;
    ZQrutas: TZQuery;
    ZQtmp: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure crutasCloseUp(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FestadisticasVEntas: TFestadisticasVEntas;

implementation

{$R *.dfm}
Uses Fprincipal,FOrden_Entrega_ventas;

procedure TFestadisticasVEntas.Button1Click(Sender: TObject);
begin
   FOrdenEntregaVentas.Enabled:=FALSE;
   FOrdenEntregaVentas :=TFOrdenEntregaVentas.Create(self);
   FOrdenEntregaVentas.ShowModal;
end;

procedure TFestadisticasVEntas.crutasCloseUp(Sender: TObject);
begin
  ZQestadisticas.Close;
  ZQestadisticas.SQL.Clear;
  ZQestadisticas.SQL.Add('Select id_estadistica AS ID,Fecha,Ruta,Entregadas,Noentregadas,Duplicadas,Inicio AS "Hora Inicio",Fin AS "Hora Fin",Tiempo AS "Tiempo de ruta" from t_estadisticas_ruta_ventas where ruta='+FloatToStr(crutas.KeyValue)+' order by id_estadistica ');
  ZQestadisticas.ExecSQL;
  ZQestadisticas.Open;
  gridestadisticas.Refresh;

end;

procedure TFestadisticasVEntas.FormShow(Sender: TObject);
begin
  ZQrutas.Close;
  ZQrutas.SQL.Clear;
  ZQrutas.SQL.Add('Select id_ruta,Nombre_ruta from c_rutas_foraneas');
  ZQrutas.ExecSQL;
  ZQRutas.Open;
  crutas.ListField:='Nombre_ruta';
  crutas.KeyField:='id_ruta';

  ZQestadisticas.Close;
  ZQestadisticas.SQL.Clear;
  ZQestadisticas.SQL.Add('Select id_estadistica AS ID,Fecha,Ruta,Entregadas,Noentregadas,Duplicadas,Inicio AS "Hora Inicio",Fin AS "Hora Fin",Tiempo AS "Tiempo de ruta" from t_estadisticas_ruta_ventas order by id_estadistica');
  ZQestadisticas.ExecSQL;
  ZQestadisticas.Open;
  gridestadisticas.Refresh;

end;

end.
