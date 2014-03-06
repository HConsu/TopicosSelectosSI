unit F_Incidencias_descripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFIncidenciasDescripcion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    proveedor: TEdit;
    Image1: TImage;
    Descripcion: TMemo;
    Cancelar: TButton;
    Aceptar: TButton;
    fecha: TEdit;
    edicion: TEdit;
    Codigo: TEdit;
    ZQincidencia: TZQuery;
    procedure CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIncidenciasDescripcion: TFIncidenciasDescripcion;

implementation

{$R *.dfm}
Uses
FCaptura_Pagos_x_distribuidor,Fprincipal;

procedure TFIncidenciasDescripcion.AceptarClick(Sender: TObject);
begin
try
  ZQIncidencia.Close;
  ZQincidencia.SQL.Clear;
  ZQIncidencia.SQL.Add('Insert into t_incidencias_circulacion (fecha_incidencia,edicion_incidencia,codigo,descripcion) VALUES ("'+fecha.Text+'",'+edicion.Text+','+codigo.Text+',"'+descripcion.Text+'")');
  ZQIncidencia.ExecSQL;
  ZQIncidencia.Close;
  ZQincidencia.SQL.Clear;
  ZQIncidencia.SQL.Add('Update t_remision_rutas SET incidencia=1 where edicion='+edicion.Text+' AND codigo_proveedor='+codigo.Text);
  ZQIncidencia.ExecSQL;
  ShowMessage('Se agrego la descripcion del incidente de forma correcta');
  FIncidenciasDescripcion.Close;
except
    ShowMessage('Ocurrio un error al agregar la información');
end;
end;

procedure TFIncidenciasDescripcion.CancelarClick(Sender: TObject);
begin
   Fincidenciasdescripcion.Close;
end;

procedure TFIncidenciasDescripcion.FormShow(Sender: TObject);
begin
 if FCapturaXdistribuidor.GridDis.Fields[9].AsInteger=0 then
   begin
  fecha.Text:= FCapturaXdistribuidor.GridDis.Fields[1].AsString;
  edicion.Text:= FCapturaXdistribuidor.GridDis.Fields[2].AsString;
  proveedor.Text := FCapturaXdistribuidor.GridDis.Fields[0].AsString;
  codigo.Text := FCapturaXdistribuidor.GridDis.Fields[3].AsString;
   end
else begin
   ZQincidencia.Close;
   ZQincidencia.SQL.Clear;
   ZQIncidencia.SQL.Add('Select descripcion from t_incidencias_circulacion where edicion_incidencia='+FCapturaXdistribuidor.GridDis.Fields[2].AsString+' AND codigo='+FCapturaXdistribuidor.GridDis.Fields[3].AsString);
   ZQincidencia.ExecSQL;
   ZQIncidencia.Open;

  fecha.Text:= FCapturaXdistribuidor.GridDis.Fields[1].AsString;
  edicion.Text:= FCapturaXdistribuidor.GridDis.Fields[2].AsString;
  proveedor.Text := FCapturaXdistribuidor.GridDis.Fields[0].AsString;
  codigo.Text := FCapturaXdistribuidor.GridDis.Fields[3].AsString;
   descripcion.Text:=ZQIncidencia.FieldByName('descripcion').AsString;

  //,,codigo,descripcion
end;
end;

end.
