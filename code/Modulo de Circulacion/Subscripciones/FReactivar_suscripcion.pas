unit FReactivar_suscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFReactivar = class(TForm)
    ZQreactiva: TZQuery;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DSreactiva: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReactivar: TFReactivar;

implementation

{$R *.dfm}

Uses
Fprincipal,FAlta_subscripciones,FnuevaSubscripcion;

procedure TFReactivar.DBGrid1DblClick(Sender: TObject);
begin
  if DBGrid1.Fields[0].AsString<>'' then
     begin
    if application.MessageBox (pchar('�Esta seguro que desea reactivar esta suscripci�n?'), pchar('Confirmar reactivaci�n'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
             FPrincipalCirculacion.quienllamanueva:=2;
               ShowMessage('Se abrir� la ventana de nueva suscripcion, para terminar la reinserci�n de la suscripci�n en la ruta, si cancela el proceso, la suscripci�n no se reactivara y no aparecer� en ruta de entrega.');
             FNueva_Subscripcion.Enabled:=FALSE;
             FNueva_subscripcion := TFNueva_Subscripcion.Create(self);
             FNueva_Subscripcion.ShowModal;
           end;
     end
   else begin
     ShowMessage('No hay suscripcion que reactivar');
   end;

end;

procedure TFReactivar.FormShow(Sender: TObject);
begin
  ZQreactiva.Close;
  ZQreactiva.SQL.Clear;
  ZQreactiva.SQL.Add('Select id_cancelacion AS ID,Nosubscripcion,Descripcion as Motivo,Atenciona,Calle,Colonia,Descripcion_dir,Edificio,Area,Ruta,Fecha_sol_cancelacion,Fecha_ultimo_ejemplar from t_cancelacion where nosubscriptor='+FSubscripciones.DBGridSubscriptor.Fields[0].AsString+' AND reactivado="n"');
  ZQreactiva.ExecSQL;
  ZQreactiva.open;

end;

end.
