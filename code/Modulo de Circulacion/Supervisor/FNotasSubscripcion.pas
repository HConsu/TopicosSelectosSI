unit FNotasSubscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  ComCtrls;

type
  TFNotas = class(TForm)
    ZQnota: TZQuery;
    Label1: TLabel;
    nosubscripcion: TLabel;
    nota: TMemo;
    Button1: TButton;
    Button2: TButton;
    ZQbitacora: TZQuery;
    Label2: TLabel;
    fechaa: TDateTimePicker;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNotas: TFNotas;

implementation

{$R *.dfm}
Uses
FPrincipal,FSeguimientoAltas,FSeguimiento_Cambios;

procedure TFNotas.Button1Click(Sender: TObject);
begin
  {--------------Bitacora------------------------}
  ZQBitacora.Close;
  ZQBitacora.SQL.Clear;
  ZQbitacora.SQL.Add('Insert into b_supervisor_circulacion (descripcion) VALUES ("Se agrego una nota a la subscripcion '+nosubscripcion.Caption+'")');
  ZQbitacora.ExecSQL;
  {---------------Bitacora--------------------------}

  if FprincipalCirculacion.quienllamanotas=1 then
    begin
     FSeguimientoA.ZQatendido.Close;
     FSeguimientoA.ZQAtendido.SQL.Clear;
     FSeguimientoA.ZQAtendido.SQL.Add('Update t_altas SET atendido="S",fecha_atencion="'+FormatDateTime('yyyy-mm-dd',fechaa.Date)+' 00:00:00" where nosubscripcion='+FSeguimientoA.GridSubs.Fields[0].AsString);
     FSeguimientoA.ZQAtendido.ExecSQL;
    end;
  if FprincipalCirculacion.quienllamanotas=2 then
    begin
   FSeguimientoA.ZQAtendido.Close;
   FSeguimientoA.ZQatendido.SQL.Clear;
   FSeguimientoA.ZQatendido.SQL.Add('Update t_cambios_domicilio SET atendido="S",fecha_atencion="'+FormatDateTime('yyyy-mm-dd',fechaa.Date)+' 00:00:00" where nosubscripcion='+FSeguimientoCambios.gridsubs.Fields[0].AsString);
   FSeguimientoA.ZQatendido.ExecSQL;
    end;


  ZQnota.Close;
  ZQNota.SQL.Clear;
  ZQNota.SQL.Add('Insert into t_notas_subscripciones(Nosubscripcion,Nota) VALUES('+nosubscripcion.Caption+',"'+nota.Text+'")');
  ZQNota.ExecSQL;
  FNotas.Close;
end;

procedure TFNotas.Button2Click(Sender: TObject);
begin
   Fnotas.Close;
end;

procedure TFNotas.FormShow(Sender: TObject);
begin
   nota.Text:='';

     if FprincipalCirculacion.quienllamanotas=1 then
    begin
    nosubscripcion.Caption:= FSeguimientoA.gridsubs.Fields[0].AsString;
    end;
  if FprincipalCirculacion.quienllamanotas=2 then
    begin
    nosubscripcion.Caption:= FSeguimientoCambios.gridsubs.Fields[0].AsString;
    end;

   fechaa.Date:=now();
end;

end.
