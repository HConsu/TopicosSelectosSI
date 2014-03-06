unit FQuejas_Cerradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids;

type
  TFQuejasCerradas = class(TForm)
    GridQuejas: TDBGrid;
    Button1: TButton;
    ZQuejas: TZQuery;
    DSquejas: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    titular: TLabel;
    atenciona: TLabel;
    motivo: TLabel;
    descripcion: TLabel;
    solucion: TLabel;
    ZQtmp: TZQuery;
    Button2: TButton;
    Label6: TLabel;
    lfsolucion: TLabel;
    label20: TLabel;
    lfcierre: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GridQuejasCellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure ZQuejasAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FQuejasCerradas: TFQuejasCerradas;

implementation

{$R *.dfm}
Uses
FPrincipal,FSeguimiento_Quejas,FHistorial_Quejas;

procedure TFQuejasCerradas.Button1Click(Sender: TObject);
begin
   FQuejasCerradas.Close;
end;

procedure TFQuejasCerradas.Button2Click(Sender: TObject);
begin
 if gridquejas.Fields[1].IsNull=FALSE then
    begin
  FSeguimientoQ.quienllamah:=1;
  FHistorialQueja.Enabled:=FALSE;
  FHistorialQueja := TFHistorialQueja.Create(self);
  FHistorialQueja.ShowModal;
    end;
end;

procedure TFQuejasCerradas.FormShow(Sender: TObject);
begin
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",(Select estatus from c_estatus_quejas where id=t_quejas.Status)AS Estatus');
   ZQuejas.SQL.Add(',Otromotivo AS "Otro motivo",Descripcion AS "Descripcion",ruta,Fecha_resuelto,Fecha_cierre From t_quejas where (status >=4)');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   ZQuejas.Active:=TRUE;
   GridQuejas.Refresh;

end;

procedure TFQuejasCerradas.GridQuejasCellClick(Column: TColumn);
begin
    Motivo.Caption:=GridQuejas.Fields[2].AsString;
    Descripcion.Caption:=GridQuejas.Fields[6].AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select solucion from t_quejas where id_queja='+GridQuejas.Fields[0].AsString);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Solucion.caption:=ZQtmp.FieldByName('Solucion').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    atenciona.caption:=ZQtmp.FieldByName('atenciona').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select titular from t_cliente_subscriptor where id_subscriptor='+GridQuejas.Fields[1].AsString);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    titular.Caption:=ZQtmp.FieldByName('titular').AsString;

    lfsolucion.Caption:= GridQuejas.Fields[8].AsString;
    lfcierre.Caption:= GridQuejas.Fields[9].AsString;



end;

procedure TFQuejasCerradas.ZQuejasAfterScroll(DataSet: TDataSet);
begin
    Motivo.Caption:=GridQuejas.Fields[2].AsString;
    Descripcion.Caption:=GridQuejas.Fields[6].AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select solucion from t_quejas where id_queja='+GridQuejas.Fields[0].AsString);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Solucion.caption:=ZQtmp.FieldByName('Solucion').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    atenciona.caption:=ZQtmp.FieldByName('atenciona').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select titular from t_cliente_subscriptor where id_subscriptor='+GridQuejas.Fields[1].AsString);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    titular.Caption:=ZQtmp.FieldByName('titular').AsString;

    lfsolucion.Caption:= GridQuejas.Fields[8].AsString;
    lfcierre.Caption:= GridQuejas.Fields[9].AsString;



end;

end.
