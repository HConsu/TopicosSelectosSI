unit FBuscar_codigo_vendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFbuscarcodigo = class(TForm)
    ZQbuscar: TZQuery;
    Label1: TLabel;
    Label2: TLabel;
    Nombre: TEdit;
    titular: TEdit;
    Label3: TLabel;
    codigo: TLabel;
    GridBuscar: TDBGrid;
    aceptar: TButton;
    Image1: TImage;
    Label4: TLabel;
    cnombre: TCheckBox;
    ctitular: TCheckBox;
    DSbuscar: TDataSource;
    procedure cnombreClick(Sender: TObject);
    procedure ctitularClick(Sender: TObject);
    procedure NombreKeyPress(Sender: TObject; var Key: Char);
    procedure GridBuscarCellClick(Column: TColumn);
    procedure aceptarClick(Sender: TObject);
    procedure titularKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
     quienllama:integer;
     {sirve para determinar que formulario lo llamo 0= devoluciones 1=pagos}
    { Public declarations }
  end;

var
  Fbuscarcodigo: TFbuscarcodigo;

implementation

{$R *.dfm}
Uses
FCaptura_pagos,FCaptura_devoluciones;

procedure TFbuscarcodigo.aceptarClick(Sender: TObject);
begin
   if quienllama = 0 then
     begin
       FCaptura_devoluciones.Fdevoluciones.codigo.Text:=codigo.Caption;
       Fbuscarcodigo.Close;
     end;
   if quienllama = 1 then
      begin
     FCaptura_pagos.FCapturaPagos.codigo.Text:=codigo.Caption;
     Fbuscarcodigo.Close;
      end;
end;

procedure TFbuscarcodigo.cnombreClick(Sender: TObject);
begin
   if cnombre.Checked=TRUE then
      begin
        nombre.Enabled:=TRUE;
        ctitular.Checked:=FALSE;
        titular.Text:='';
        titular.Enabled:=FALSE;
      end;
   if cnombre.Checked=FALSE then
      begin
        nombre.Enabled:=FALSE;
        nombre.Text:='';
      end;
end;

procedure TFbuscarcodigo.ctitularClick(Sender: TObject);
begin
    if ctitular.Checked=TRUE then
       begin
         cnombre.Checked:=FALSE;
         nombre.Enabled:=FALSE;
         nombre.Text:='';
         titular.Enabled:=TRUE;
       end;
    if ctitular.Checked=FALSE then
        begin
          titular.Text:='';
          titular.Enabled:=FALSE;
        end;

end;

procedure TFbuscarcodigo.GridBuscarCellClick(Column: TColumn);
begin
   codigo.Caption:=GridBuscar.Fields[0].AsString;
end;

procedure TFbuscarcodigo.NombreKeyPress(Sender: TObject; var Key: Char);
begin
    ZQbuscar.Close;
    ZQbuscar.SQL.Clear;
    ZQbuscar.SQL.Add('Select id_proveedor as codigo,Nombre from c_proveedores where nombre like "%'+nombre.Text+'%"');
    ZQbuscar.ExecSQL;
    ZQbuscar.Open;
    ZQbuscar.Active:=TRUE;
    Gridbuscar.Refresh;

 end;

procedure TFbuscarcodigo.titularKeyPress(Sender: TObject; var Key: Char);
begin
    ZQbuscar.Close;
    ZQbuscar.SQL.Clear;
    ZQbuscar.SQL.Add('Select id_proveedor as codigo,Titular from c_proveedores where titular like "%'+titular.Text+'%"');
    ZQbuscar.ExecSQL;
    ZQbuscar.Open;
    ZQbuscar.Active:=TRUE;
    Gridbuscar.Refresh;
end;

end.
