unit FCambioNoFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids;

type
  TFCambio_Factura = class(TForm)
    Label1: TLabel;
    GridFactura: TDBGrid;
    factura: TEdit;
    Label2: TLabel;
    Button1: TButton;
    ZQfactura: TZQuery;
    ZQcfactura: TZQuery;
    DSFactura: TDataSource;
    Salir: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCambio_Factura: TFCambio_Factura;

implementation

{$R *.dfm}

procedure TFCambio_Factura.Button1Click(Sender: TObject);
begin
   if factura.Text <> '' then
      begin
        ZQcfactura.Close;
        ZQcfactura.SQL.Clear;
        ZQcfactura.SQL.Add('Select factura from t_control_facturas where factura="'+factura.Text+'"');
        ZQcfactura.ExecSQL;
        ZQcfactura.Open;
         if ZQcfactura.FieldByName('factura').IsNull = TRUE then
            begin
        ZQcfactura.Close;
        ZQcfactura.SQL.Clear;
        ZQcfactura.SQL.Add('Update t_cancelacion SET factura = '+factura.Text+',cambiar_factura=0 Where nosubscripcion ='+GridFactura.Fields[1].AsString);
        ZQcfactura.ExecSQL;
        ZQcfactura.Close;
        ZQcfactura.SQL.Clear;
        ZQcfactura.SQL.Add('Insert into t_control_facturas (factura) VALUES("'+factura.Text+'")');
        ZQcfactura.ExecSQL;
        ZQFactura.Refresh;
        GridFactura.Refresh;
            end
        else begin
          ShowMessage('Ese numero de factura ya se esta usando');
        end;
      end;
end;

procedure TFCambio_Factura.SalirClick(Sender: TObject);
begin
FCambio_Factura.Close;
end;

end.
