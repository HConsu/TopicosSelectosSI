unit FSeguimientoCancelados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  jpeg, ExtCtrls, StdCtrls;

type
  TFCancelados = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    DScancelados: TDataSource;
    gridcancelados: TDBGrid;
    ZQcancelados: TZQuery;
    Button1: TButton;
    ZQatendido: TZQuery;
    ZQbitacora: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCancelados: TFCancelados;

implementation

{$R *.dfm}
Uses
FPrincipal;

procedure TFCancelados.Button1Click(Sender: TObject);
begin
  {--------------Bitacora------------------------
  ZQBitacora.Close;
  ZQBitacora.SQL.Clear;
  ZQbitacora.SQL.Add('Insert into b_supervisor_circulacion (descripcion) VALUES ("Se marco como atendida la subscripcion '+gridcancelados.Fields[0].AsString+' cancelada")');
  ZQbitacora.ExecSQL;
  ---------------Bitacora--------------------------}

if application.MessageBox (pchar('�Esta seguro de querer marcar como atendida la subscripcion '+gridcancelados.Fields[0].AsString+'?'), pchar('Confirmar "Atendido"'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
        ZQatendido.Close;
        ZQAtendido.SQL.Clear;
        ZQAtendido.SQL.Add('Update t_cancelacion SET atendido=1 where nosubscripcion='+gridcancelados.Fields[0].AsString);
        ZQAtendido.ExecSQL;

       {----Actualizar el grid-------}
  ZQCancelados.Close;
  ZQCancelados.SQL.Clear;
  ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,Ruta,Fecha_sol_cancelacion,Fecha_ultimo_ejemplar from t_cancelacion where fecha_ultimo_ejemplar between "'+FormatDateTime('yyyy-mm-dd',now()-59)+'" AND "'+FormatDateTime('yyyy-mm-dd',now())+' 23:59:59" AND atendido=0');
  ZQCancelados.ExecSQL;
  ZQCancelados.Open;
  GridCancelados.Refresh;
        {-----------------------------}

           end;

end;

procedure TFCancelados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FPrincipalCirculacion.ZQCancelados.Close;
  FPrincipalCirculacion.ZQCancelados.SQL.Clear;
  FPrincipalCirculacion.ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,Ruta,Fecha_sol_cancelacion,Fecha_ultimo_ejemplar from t_cancelacion where fecha_ultimo_ejemplar between "'+FormatDateTime('yyyy-mm-dd',now()-59)+'" AND "'+FormatDateTime('yyyy-mm-dd',now())+' 23:59:59" AND atendido=0');
  FPrincipalCirculacion.ZQCancelados.ExecSQL;
  FPrincipalCirculacion.ZQCancelados.Open;
  FPrincipalCirculacion.GridCancelados.Refresh;
end;

procedure TFCancelados.FormShow(Sender: TObject);
begin
  ZQCancelados.Close;
  ZQCancelados.SQL.Clear;
  ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,Ruta,Fecha_sol_cancelacion,Fecha_ultimo_ejemplar from t_cancelacion where fecha_ultimo_ejemplar between "'+FormatDateTime('yyyy-mm-dd',now()-59)+'" AND "'+FormatDateTime('yyyy-mm-dd',now())+' 23:59:59" AND atendido=0');
  ZQCancelados.ExecSQL;
  ZQCancelados.Open;
  GridCancelados.Refresh;

end;

end.
