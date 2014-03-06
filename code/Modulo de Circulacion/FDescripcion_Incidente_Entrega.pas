unit FDescripcion_Incidente_Entrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFDescripcionIncidente = class(TForm)
    Memo1: TMemo;
    Aceptar: TButton;
    Label1: TLabel;
    ZQincidente: TZQuery;
    DSincidente: TDataSource;
    procedure AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDescripcionIncidente: TFDescripcionIncidente;

implementation

{$R *.dfm}

Uses
FEntregaRutaVenta,FPrincipal;

procedure TFDescripcionIncidente.AceptarClick(Sender: TObject);
var
fecha:String;
Codigo,Municipio,Motivo:String;
begin

   codigo:=FEntregaRutaVentas.gridnoentregados.Fields[3].AsString;
   Municipio:=FEntregaRutaVentas.gridnoentregados.Fields[2].AsString;
   Motivo:=FEntregaRutaVentas.gridnoentregados.Fields[4].AsString;
   fecha:=FEntregaRutaVentas.hoy;


   Zqincidente.Close;
   ZQincidente.SQL.Clear;
   ZQIncidente.SQL.Add('Insert into t_incidencias_ventas (Codigo,municipio,motivo,fecha,descripcion) values("'+codigo+'","'+municipio+'","'+motivo+'","'+fecha+'","'+memo1.Text+'")');
   ZQincidente.ExecSQL;

  FDescripcionIncidente.Close;

end;

end.
