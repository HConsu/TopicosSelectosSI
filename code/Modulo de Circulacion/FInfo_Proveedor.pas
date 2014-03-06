unit FInfo_Proveedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFInfoProveedor = class(TForm)
    LProveedor: TLabel;
    lnom: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    nombre: TLabel;
    municipio: TLabel;
    dotacion: TLabel;
    ruta: TLabel;
    calle: TLabel;
    colonia: TLabel;
    ZQdatos: TZQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInfoProveedor: TFInfoProveedor;

implementation

{$R *.dfm}
Uses
Fprincipal,FCaptura_pagos_x_distribuidor;

procedure TFInfoProveedor.FormShow(Sender: TObject);
begin
  lproveedor.Caption:=FCapturaXdistribuidor.GridDis.Fields[0].AsString;

  ZQdatos.close;
  ZQdatos.SQL.Clear;
  ZQdatos.SQL.Add('Select nombre,dotacion,ruta,municipio,calle,colonia from c_proveedores where id_proveedor='+FCapturaXdistribuidor.GridDis.Fields[3].ASString);
  ZQdatos.ExecSQL;
  ZQdatos.Open;

  nombre.Caption:=ZQdatos.FieldByName('nombre').AsString;
  municipio.Caption:=ZQdatos.FieldByName('municipio').AsString;
  dotacion.Caption:=ZQdatos.FieldByName('dotacion').AsString;
  ruta.Caption:=ZQdatos.FieldByName('ruta').AsString;
  calle.Caption:=ZQdatos.FieldByName('calle').AsString;
  colonia.Caption:=ZQdatos.FieldByName('colonia').AsString;

end;

end.
