unit FHistorial_Quejas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TFHistorialQueja = class(TForm)
    DShistorial: TDataSource;
    gridhistorial: TDBGrid;
    ZQhistorial: TZQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHistorialQueja: TFHistorialQueja;

implementation

{$R *.dfm}
Uses
FPrincipal,FQuejas_cerradas,FSeguimiento_quejas,FQuejasReporte;

procedure TFHistorialQueja.FormShow(Sender: TObject);
begin
  if FSeguimientoQ.quienllamah=1 then
    begin
   ZQhistorial.Close;
   ZQHistorial.SQL.Clear;
   ZQhistorial.SQL.Add('Select Fecha,Movimiento,Usuario from b_movimientos_quejas where id_queja='+FQuejasCerradas.GridQuejas.Fields[0].AsString);
   ZQHistorial.ExecSQL;
   ZQHistorial.Open;
   gridhistorial.Refresh;
    end;
  if FSeguimientoQ.quienllamah=2 then
    begin
   ZQhistorial.Close;
   ZQHistorial.SQL.Clear;
   ZQhistorial.SQL.Add('Select Fecha,Movimiento,Usuario from b_movimientos_quejas where id_queja='+FSeguimientoQ.GridQuejas.Fields[0].AsString);
   ZQHistorial.ExecSQL;
   ZQHistorial.Open;
   gridhistorial.Refresh;
    end;
if FSeguimientoQ.quienllamah=3 then
    begin
   ZQhistorial.Close;
   ZQHistorial.SQL.Clear;
   ZQhistorial.SQL.Add('Select Fecha,Movimiento,Usuario from b_movimientos_quejas where id_queja='+FQuejasR.GridQuejas.Fields[0].AsString);
   ZQHistorial.ExecSQL;
   ZQHistorial.Open;
   gridhistorial.Refresh;
    end;

end;

end.
