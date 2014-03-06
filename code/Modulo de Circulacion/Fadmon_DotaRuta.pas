unit Fadmon_DotaRuta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFChoferDot = class(TForm)
    DSrutas: TDataSource;
    ZQrutas: TZQuery;
    Crutas: TDBLookupComboBox;
    Label1: TLabel;
    gridruta: TDBGrid;
    gridsinruta: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Vendedores: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ltotal: TLabel;
    ZQvendedores: TZQuery;
    DSvendedores: TDataSource;
    DSsinruta: TDataSource;
    ZQsinruta: TZQuery;
    ZQtotal: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure CrutasCloseUp(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FChoferDot: TFChoferDot;

implementation

{$R *.dfm}

uses
Fprincipal;

procedure TFChoferDot.Button1Click(Sender: TObject);
begin
    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Update c_proveedores SET ruta='+IntToStr(Crutas.KeyValue)+' where id_proveedor='+gridsinruta.Fields[0].AsString);
    ZQtotal.ExecSQL;

    ZQvendedores.Refresh;
    ZQsinruta.Refresh;

    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from c_proveedores where ruta='+IntToStr(Crutas.KeyValue));
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;


end;

procedure TFChoferDot.Button2Click(Sender: TObject);
begin
  ZQtotal.Close;
  ZQtotal.SQL.Clear;
  ZQtotal.SQL.Add('Update c_proveedores SET ruta=0 where id_proveedor='+gridruta.Fields[0].asString);
  ZQtotal.ExecSQL;
  ZQvendedores.Refresh;
  ZQsinruta.Refresh;

    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from c_proveedores where ruta='+IntToStr(Crutas.KeyValue));
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;

end;

procedure TFChoferDot.CrutasCloseUp(Sender: TObject);
begin
    ZQvendedores.Close;
    ZQvendedores.SQL.Clear;
    ZQvendedores.SQL.Add('Select id_proveedor as Codigo,Nombre,Municipio,Dotacion from c_proveedores where ruta='+IntToStr(Crutas.KeyValue));
    ZQvendedores.ExecSQL;
    ZQvendedores.Open;

    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from c_proveedores where ruta='+IntToStr(Crutas.KeyValue));
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;
end;

procedure TFChoferDot.FormShow(Sender: TObject);
begin
   ZQrutas.Close;
   ZQrutas.SQL.Clear;
   ZQrutas.SQL.Add('Select Nombre_ruta,id_ruta from c_rutas_foraneas');
   ZQrutas.ExecSQL;
   ZQrutas.Open;
   Crutas.ListField:='Nombre_ruta';
   Crutas.KeyField:='id_ruta';

    ZQsinruta.Close;
    ZQsinruta.SQL.Clear;
    ZQsinruta.SQL.Add('Select id_proveedor as Codigo,Nombre,Municipio,Dotacion from c_proveedores where ruta=0');
    ZQsinruta.ExecSQL;
    ZQsinruta.Open;

end;

end.
