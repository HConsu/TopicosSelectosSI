unit FNotificarEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  Grids, DBGrids, StdCtrls;

type
  TFactivarEntrega = class(TForm)
    activo: TCheckBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ZTable1: TZTable;
    ZQactivo: TZQuery;
    Button1: TButton;
    ZQbitacora: TZQuery;
    procedure activoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FactivarEntrega: TFactivarEntrega;

implementation

{$R *.dfm}

Uses FLoginpass,FPrincipal;

procedure TFactivarEntrega.activoClick(Sender: TObject);
begin
     if activo.Checked=TRUE then
       begin
         ZQactivo.Close;
         ZQactivo.SQL.Clear;
         ZQactivo.SQL.Add('Update t_estatus_envio SET estatus=2 where tipo=2');
         ZQactivo.ExecSQL;

         ZQbitacora.Close;
         ZQbitacora.SQL.Clear;
         ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Se activo la notificacion por correo","'+FPrincipalCirculacion.usuarioapp+'")');
         ZQBitacora.ExecSQL;
         ZQBitacora.Close;
         ShowMessage('Se activo la notificacion');
       end;
     if activo.Checked=FALSE then
       begin
         ZQactivo.Close;
         ZQactivo.SQL.Clear;
         ZQactivo.SQL.Add('Update t_estatus_envio SET estatus=1 where tipo=2');
         ZQactivo.ExecSQL;

         ZQbitacora.Close;
         ZQbitacora.SQL.Clear;
         ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Se desactivo la notificacion por correo","'+FPrincipalCirculacion.usuarioapp+'")');
         ZQBitacora.ExecSQL;
         ZQBitacora.Close;
         ShowMessage('Se desactivo la notificacion');
       end;



end;

procedure TFactivarEntrega.Button1Click(Sender: TObject);
begin
  FactivarEntrega.Close;
end;

procedure TFactivarEntrega.FormShow(Sender: TObject);
begin
         ZQactivo.Close;
         ZQactivo.SQL.Clear;
         ZQactivo.SQL.Add('Select estatus from t_estatus_envio where tipo=2');
         ZQactivo.ExecSQL;
         ZQactivo.Open;
         if ZQactivo.FieldByName('estatus').AsInteger=1 then
            begin
             activo.Checked:=FALSE;
            end;
         if ZQactivo.FieldByName('estatus').AsInteger=2 then
            begin
             activo.Checked:=TRUE;
            end;

end;

end.


