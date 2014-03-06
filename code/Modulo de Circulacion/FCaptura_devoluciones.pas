unit FCaptura_devoluciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, jpeg, ExtCtrls,
  StdCtrls, Grids, DBGrids, Menus;

type
  TFdevoluciones = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    fecha: TEdit;
    edicion: TEdit;
    codigo: TEdit;
    dotacion: TEdit;
    devueltos: TEdit;
    vendidos: TEdit;
    modificard: TButton;
    buscar: TButton;
    Image1: TImage;
    ZQfecha: TZQuery;
    Button1: TButton;
    Aceptar: TButton;
    Salir: TButton;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    capturarpago: TButton;
    procedure fechaExit(Sender: TObject);
    procedure buscarClick(Sender: TObject);
    procedure edicionExit(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure codigoExit(Sender: TObject);
    procedure fechaKeyPress(Sender: TObject; var Key: Char);
    procedure edicionKeyPress(Sender: TObject; var Key: Char);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure devueltosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fdevoluciones: TFdevoluciones;

implementation

{$R *.dfm}
Uses
FBuscar_codigo_vendedor;

procedure TFdevoluciones.buscarClick(Sender: TObject);
begin
    Fbuscarcodigo.Enabled:=FALSE;
    Fbuscarcodigo := TFbuscarcodigo.Create(self);
    FBuscarcodigo.quienllama:=0;
    Fbuscarcodigo.ShowModal;
end;

procedure TFdevoluciones.Button1Click(Sender: TObject);
begin
   fecha.Text:='dd/mm/yyyy';
   edicion.Text:='';
   codigo.Text:='';
   dotacion.Text:='';
   vendidos.Text:='';
   devueltos.Text:='';
   Aceptar.Enabled:=TRUE;
end;

procedure TFdevoluciones.codigoExit(Sender: TObject);
begin
  ZQFecha.Close;
  ZQFecha.SQL.Clear;
  ZQFecha.SQL.Add('Select fechac,devolucion from t_devoluciones where codigo='+codigo.Text+' AND edicion='+edicion.Text+' AND fechae="'+fecha.Text+'"');
  ZQFecha.ExecSQL;
  ZQFecha.Open;
  devueltos.Text:=ZQFecha.FieldByName('devolucion').AsString;
    if ZQFecha.FieldByName('fechac').AsString <> ''  then
       begin
         ShowMessage('Las devoluciones para este proveedor ya fueron capturadas se requiere autorización para modificarlas');
         Aceptar.Enabled:=FALSE;
       end
    else begin
     ZQFecha.Close;
     ZQFecha.SQL.Clear;
     ZQFecha.SQL.Add('Select dotacion,tarifa,adeudo from t_remision_rutas where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
     ZQFecha.ExecSQL;
     ZQFecha.Open;
     Dotacion.Text:=ZQFecha.FieldByName('dotacion').AsString;
     ZQFecha.Close;
     vendidos.Text:=IntToStr(StrToInt(dotacion.Text)-StrToInt(devueltos.Text));
    end;



end;

procedure TFdevoluciones.codigoKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFdevoluciones.devueltosKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFdevoluciones.AceptarClick(Sender: TObject);
var
fechae,fechac:String;
adeudo:double;
begin
if application.MessageBox (pchar('¿Esta seguro de querer registrar '+devueltos.Text+' devoluciones?'), pchar('Registro devoluciones'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
       begin
       fechac:=DateToStr(now());
       ZQFecha.Close;
       ZQFecha.SQL.Clear;
       {Actualizamos las devoluciones del proveedor}
       ZQFecha.SQL.Add('UPDATE t_devoluciones SET fechac="'+fechac+'", devolucion='+devueltos.Text+' Where (codigo='+codigo.Text+' AND edicion='+edicion.Text+')');
       ZQFecha.ExecSQL;
       ZQFecha.Close;
       ZQFecha.SQL.Clear;
       ZQFecha.SQL.Add('Select dotacion,tarifa,adeudo from t_remision_rutas where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
       ZQFecha.ExecSQL;
       ZQFecha.Open;
       adeudo:=(ZQFecha.FieldByName('dotacion').AsFloat-StrToFloat(devueltos.Text))*ZQFecha.FieldByName('tarifa').AsFloat;
       ZQFecha.Close;
       ZQFecha.SQL.Clear;
       {Actualizamos la deuda del proveedor}
       ZQFecha.SQL.Add('UPDATE t_remision_rutas SET adeudo='+FloatToStr(adeudo)+' Where codigo_proveedor='+codigo.Text+' AND edicion='+edicion.Text);
       ZQFecha.ExecSQL;

       //ShowMessage('Adeudo anterior:'+ZQFecha.FieldByName('adeudo').AsString+' Adeudo nuevo:'+FloatToStr(adeudo));
       vendidos.Text:=IntToStr(StrToInt(dotacion.Text)-StrToInt(devueltos.Text));
       ShowMessage('Se actualizaron las devoluciones, cualquier cambio requerira autorización');
       Aceptar.Enabled:=FALSE;
       capturarpago.Visible:=TRUE;
       end;


end;

procedure TFdevoluciones.edicionExit(Sender: TObject);
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

procedure TFdevoluciones.edicionKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFdevoluciones.fechaExit(Sender: TObject);
begin
  ZQFecha.Close;
   ZQFecha.SQL.Clear;
   ZQFecha.SQL.Add('Select edicion from t_remision_rutas where fecha="'+fecha.Text+'" limit 1');
   ZQFecha.ExecSQL;
   ZQfecha.Open;
   edicion.Text:=ZQFecha.FieldByName('edicion').AsString;
   ZQfecha.Close;
   ZQfecha.SQL.Clear;

end;

procedure TFdevoluciones.fechaKeyPress(Sender: TObject; var Key: Char);
begin
    {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789/'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFdevoluciones.Salir1Click(Sender: TObject);
begin
   FDevoluciones.Close;
end;

procedure TFdevoluciones.SalirClick(Sender: TObject);
begin
   FDevoluciones.Close;
end;

end.
