unit FCaptura_Pagos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls, StdCtrls, Grids, DBGrids, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFCapturaPagos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    fecha: TEdit;
    edicion: TEdit;
    GridPagos: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    codigo: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    dotacion: TEdit;
    Label6: TLabel;
    devueltos: TEdit;
    Button3: TButton;
    Label7: TLabel;
    vendidos: TEdit;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Label8: TLabel;
    Label9: TLabel;
    pago: TEdit;
    captura: TButton;
    ZQfecha: TZQuery;
    Aceptar: TButton;
    Button5: TButton;
    Label10: TLabel;
    Adeudo: TEdit;
    Label11: TLabel;
    tarifa: TEdit;
    ZQpagos: TZQuery;
    DSpagos: TDataSource;
    Label12: TLabel;
    totaladeudo: TEdit;
    Label13: TLabel;
    pagado: TEdit;
    procedure fechaExit(Sender: TObject);
    procedure edicionExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure capturaClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure fechaKeyPress(Sender: TObject; var Key: Char);
    procedure edicionKeyPress(Sender: TObject; var Key: Char);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure pagoKeyPress(Sender: TObject; var Key: Char);
    procedure codigoExit(Sender: TObject);
    procedure AdeudoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCapturaPagos: TFCapturaPagos;

implementation

uses FBuscar_codigo_vendedor;

{$R *.dfm}

procedure TFCapturaPagos.AceptarClick(Sender: TObject);
var
fechacaptura:String;
begin
  if application.MessageBox (pchar('¿Esta seguro de querer registrar este pago?'), pchar('Registro de pago'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
       begin
   fechacaptura:=DateToStr(now());
   Aceptar.Enabled:=FALSE;
   ZQFecha.Close;
   ZQFecha.SQL.Clear;
   {Insertamos el pago en la tabla de pagos}
   ZQFecha.SQL.Add('Insert into t_pagos_proveedores (id_proveedor,monto,fechae,fechac,edicion) ');
   ZQFecha.SQL.Add('VALUES ('+codigo.Text+','+pago.Text+',"'+fecha.Text+'","'+fechacaptura+'",'+edicion.Text+')');
   ZQFEcha.ExecSQL;
   {Actualizamos la tabla de remision en el campo adeudo}
   ZQFecha.Close;
   ZQFecha.SQL.Clear;
   ZQFecha.SQL.Add('Update t_remision_rutas Set adeudo=('+FloatToStr(StrToFloat(Adeudo.Text)-StrToFloat(pago.Text))+') Where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
   ZQFecha.ExecSQL;
   ZQFecha.Close;
   ZQFecha.SQL.Clear;
   ZQFecha.SQL.Add('Select dotacion,tarifa,adeudo from t_remision_rutas where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
   ZQFecha.ExecSQL;
   ZQFecha.Open;
   adeudo.Text:=ZQFecha.FieldByName('adeudo').AsString;
   ZQFecha.Close;
   ZQpagos.Close;
   ZQPagos.SQL.Clear;
   ZQPagos.SQL.Add('Select Monto,Fechae AS "Fecha Edicion",Fechac AS "Fecha Captura",edicion AS "Edición" from t_pagos_proveedores Where id_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
   ZQPAgos.ExecSQL;
   ZQPagos.Open;
   ZQPAgos.Active:=TRUE;
   GRidPagos.Refresh;
       end;


end;

procedure TFCapturaPagos.AdeudoChange(Sender: TObject);
begin
  if (StrToFloat(adeudo.Text)>0) then
      begin
        Adeudo.Color:=ClRed;
        Adeudo.Font.Style:=[fsBold];
      end;
  if  (StrToFloat(adeudo.Text)=0) then
      begin
        Adeudo.Color:=ClGreen;
        Adeudo.Font.Style:=[fsBold];
      end;

end;

procedure TFCapturaPagos.Button1Click(Sender: TObject);
begin
    Fbuscarcodigo.Enabled:=FALSE;
    Fbuscarcodigo := TFbuscarcodigo.Create(self);
    Fbuscarcodigo.ShowModal;
end;

procedure TFCapturaPagos.capturaClick(Sender: TObject);
begin
   fecha.Text:='dd/mm/yyyy';
   edicion.Text:='';
   codigo.Text:='';
   dotacion.Text:='';
   vendidos.Text:='';
   devueltos.Text:='';
   Adeudo.Color:=clWindow;
   Adeudo.Font.Style:=[];
   Aceptar.Enabled:=TRUE;
end;

procedure TFCapturaPagos.Button5Click(Sender: TObject);
begin
   FCapturaPagos.Close;
end;

procedure TFCapturaPagos.codigoExit(Sender: TObject);
begin
  if ((fecha.Text<>'') AND (codigo.text <>'000') AND (codigo.text <>'00') AND (codigo.text <>'0'))  then
       begin
  ZQFecha.Close;
  ZQFecha.SQL.Clear;
  ZQFecha.SQL.Add('Select fechac,devolucion from t_devoluciones where codigo='+codigo.Text+' AND edicion='+edicion.Text);
  ZQFecha.ExecSQL;
  ZQFecha.Open;
  devueltos.Text:=ZQFecha.FieldByName('devolucion').AsString;
  ZQFecha.Close;
  ZQFecha.SQL.Clear;
  ZQFecha.SQL.Add('Select dotacion,tarifa,adeudo from t_remision_rutas where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
  ZQFecha.ExecSQL;
  ZQFecha.Open;
  Dotacion.Text:=ZQFecha.FieldByName('dotacion').AsString;
  adeudo.Text:=ZQFecha.FieldByName('adeudo').AsString;
  tarifa.Text:=ZQFecha.FieldByName('tarifa').AsString;
  ZQFecha.Close;
  vendidos.Text:=FloatToStr(StrToFloat(dotacion.Text)-StrToFloat(devueltos.Text));
  totaladeudo.Text:=FloatToStr(StrToFloat(vendidos.Text)*StrToFloat(tarifa.Text));
  ZQFecha.Close;
  ZQFecha.SQL.Clear;
  ZQFecha.SQL.Add('Select SUM(monto) AS Pagado from t_pagos_proveedores Where edicion='+edicion.Text+' and id_proveedor='+codigo.Text);
  ZQFecha.ExecSQL;
  ZQFecha.Open;
  Pagado.Text:=ZQFecha.FieldByName('Pagado').AsString;
  ZQpagos.Close;
  ZQPagos.SQL.Clear;
  ZQPagos.SQL.Add('Select Monto,Fechae AS "Fecha Edicion",Fechac AS "Fecha Captura",edicion AS "Edición" from t_pagos_proveedores Where id_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
  ZQPAgos.ExecSQL;
  ZQPagos.Open;
  ZQPAgos.Active:=TRUE;
  GRidPagos.Refresh;
       end;


end;

procedure TFCapturaPagos.codigoKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCapturaPagos.edicionExit(Sender: TObject);
begin
   ZQFecha.Close;
   ZQFecha.SQL.Clear;
   ZQFecha.SQL.Add('Select fecha from t_remision_rutas where edicion="'+edicion.Text+'" limit 1');
   ZQFecha.ExecSQL;
   ZQfecha.Open;
   fecha.Text:=ZQFecha.FieldByName('fecha').AsString;
   ZQfecha.Close;
   ZQfecha.SQL.Clear;


end;

procedure TFCapturaPagos.edicionKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCapturaPagos.fechaExit(Sender: TObject);
begin
   ZQFecha.Close;
   ZQFecha.SQL.Clear;
   ZQFecha.SQL.Add('Select edicion from t_remision_rutas where fecha="'+fecha.Text+'" limit 1');
   ZQFecha.ExecSQL;
   ZQfecha.Open;
   edicion.Text:=ZQFecha.FieldByName('edicion').AsString;
   ZQfecha.Close;
   ZQfecha.SQL.Clear;
   if edicion.Text='' then
      begin
        edicion.Text:='0';
      end;

end;

procedure TFCapturaPagos.fechaKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789/'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCapturaPagos.pagoKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789.'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCapturaPagos.Salir1Click(Sender: TObject);
begin
   FCapturaPagos.Close;
end;

end.
