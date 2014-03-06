unit FIncidencia_global_circulacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFIncidenciaGlobal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    fecha: TEdit;
    edicion: TEdit;
    Descripcion: TMemo;
    Image1: TImage;
    Label3: TLabel;
    Aceptar: TButton;
    Cancelar: TButton;
    ZQincidencia: TZQuery;
    codigo: TEdit;
    procedure CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIncidenciaGlobal: TFIncidenciaGlobal;

implementation

{$R *.dfm}
Uses
Fprincipal,FCaptura_Pagos_x_distribuidor;


procedure TFIncidenciaGlobal.AceptarClick(Sender: TObject);
begin
try
  ZQIncidencia.Close;
  ZQincidencia.SQL.Clear;
  ZQIncidencia.SQL.Add('Insert into t_incidencias_circulacion (fecha_incidencia,edicion_incidencia,codigo,descripcion) VALUES ("'+fecha.Text+'",'+edicion.Text+',1000,"'+descripcion.Text+'")');
  ZQIncidencia.ExecSQL;
  ZQIncidencia.Close;
  ZQincidencia.SQL.Clear;
  ZQIncidencia.SQL.Add('Update t_remision_rutas SET incidencia=1 where edicion='+edicion.Text);
  ZQIncidencia.ExecSQL;
  ShowMessage('Se agrego la descripcion del incidente de forma correcta');
  FIncidenciaGlobal.Close;
except
    ShowMessage('Ocurrio un error al agregar la información');
end;
end;

procedure TFIncidenciaGlobal.CancelarClick(Sender: TObject);
begin
  FIncidenciaGlobal.Close;
end;

procedure TFIncidenciaGlobal.FormShow(Sender: TObject);
begin
 if FCapturaXdistribuidor.GridDis.Fields[9].AsInteger=0 then
   begin
  fecha.Text:= FCapturaXdistribuidor.GridDis.Fields[1].AsString;
  edicion.Text:= FCapturaXdistribuidor.GridDis.Fields[2].AsString;
  codigo.Text := FCapturaXdistribuidor.GridDis.Fields[3].AsString;
   end
else begin
   ZQincidencia.Close;
   ZQincidencia.SQL.Clear;
   ZQIncidencia.SQL.Add('Select descripcion from t_incidencias_circulacion where edicion_incidencia='+FCapturaXdistribuidor.GridDis.Fields[2].AsString+' AND codigo=1000');
   ZQincidencia.ExecSQL;
   ZQIncidencia.Open;

  fecha.Text:= FCapturaXdistribuidor.GridDis.Fields[1].AsString;
  edicion.Text:= FCapturaXdistribuidor.GridDis.Fields[2].AsString;
  codigo.Text := FCapturaXdistribuidor.GridDis.Fields[3].AsString;
   descripcion.Text:=ZQIncidencia.FieldByName('descripcion').AsString;
  end;

end;

end.
