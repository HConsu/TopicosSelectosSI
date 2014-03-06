unit FCancelar_subscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComCtrls, jpeg, ExtCtrls;

type
  TFCancelaciones = class(TForm)
    Label1: TLabel;
    NoSubscripcion: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    NoSubscriptor: TEdit;
    atenciona: TEdit;
    Label4: TLabel;
    Motivo: TDBLookupComboBox;
    DBGridPagos: TDBGrid;
    Label5: TLabel;
    Label6: TLabel;
    CancelarSubscripcion: TButton;
    Regresar: TButton;
    DBGridSubscripciones: TDBGrid;
    Label7: TLabel;
    ZQCancelar: TZQuery;
    DSSubscripciones: TDataSource;
    ZQIntercambio: TZQuery;
    ZQMotivos: TZQuery;
    DSMotivos: TDataSource;
    LAdeudo: TLabel;
    Label8: TLabel;
    fecha_ultimo: TDateTimePicker;
    DSpagos: TDataSource;
    ZQpagos: TZQuery;
    ZQAdeudo: TZQuery;
    Image1: TImage;
    Label9: TLabel;
    Label10: TLabel;
    adeudo: TLabel;
    costo: TLabel;
    tiposubs: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    descripcion: TMemo;
    ZQb: TZQuery;
    procedure NoSubscriptorKeyPress(Sender: TObject; var Key: Char);
    procedure NoSubscriptorExit(Sender: TObject);
    procedure NoSubscripcionExit(Sender: TObject);
    procedure atencionaExit(Sender: TObject);
    procedure CancelarSubscripcionClick(Sender: TObject);
    procedure DBGridSubscripcionesCellClick(Column: TColumn);
    procedure RegresarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCancelaciones: TFCancelaciones;

implementation

{$R *.dfm}
Uses
FPrincipal,FAutorizacion,FCambioNoFactura;

procedure TFCancelaciones.atencionaExit(Sender: TObject);
begin
  if(atenciona.Text <> '') then
    begin
   ZQIntercambio.Close;
   ZQIntercambio.SQL.Clear;
   ZQIntercambio.SQL.Add('Select * from t_subscripcion where atenciona like "%'+atenciona.Text+'%"');
   ZQIntercambio.ExecSQL;
   ZQIntercambio.Open;
   ZQIntercambio.Refresh;
   DBGridSubscripciones.Refresh;
    end;
end;

procedure TFCancelaciones.CancelarSubscripcionClick(Sender: TObject);
var
ruta,factura,cambiof,ultimoejemplar,nomedif:string;
edificio:integer;
calle,colonia,descripcion_dir,area:String;
begin
  if Motivo.Text = ''  then
     begin
       ShowMessage('Es  necesario especificar  el motivo de la cancelación');
     end
  else begin
     if application.MessageBox (pchar('¿Esta seguro que desea cancelar la subscripción?'), pchar('Confirmar cancelación'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
          FPrincipalCirculacion.autorizacionquerida:=2;
          FPassword.Enabled:=FALSE;
          FPassword := TFPassword.Create(Self);
          FPassword.ShowModal;
         if FPassword.autorizado=1 then
                begin
           if StrToFloat(adeudo.Caption)>0 then
              begin
                 cambiof:='1';
              end
           else begin
               cambiof:='0';
           end;

          {leemos la ruta que se debe de ordenar despues de borrar}
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select edificio,ruta,factura from t_subscripcion where nosubscripcion='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
          edificio:=ZQCancelar.FieldByName('edificio').AsInteger;
          ruta:=ZQCancelar.FieldByName('ruta').AsString;
          factura:=ZQCancelar.FieldByName('factura').AsString;
          ultimoejemplar:= FormatDateTime('yyyy-mm-dd',fecha_ultimo.Date)+' 00:00:00';
          {----------------Obtenemos la direccion de entrega para copiarla a cancelados-----------------------}
          if edificio=0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select Calle,Colonia,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
          calle:=ZQCancelar.FieldByName('Calle').AsString;
          Colonia:=ZQCancelar.FieldByName('Colonia').AsString;
          Descripcion_dir:=ZQCancelar.FieldByName('Descripcion_domicilio').AsString;
             end;
          if edificio>0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
          area:=ZQCancelar.FieldByName('area').AsString;

          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select descripcion from c_edificios where id_edificio='+IntToStr(edificio));
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
          nomedif:=ZQCancelar.FieldByName('descripcion').AsString;
             end;

          {---------------------------------------------------------------------------------------------------}
          {insertamos los datos de la cancelacion en la tabla de cancelaciones}
          if edificio=0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Insert into t_cancelacion (nosubscripcion,nosubscriptor,motivo,fecha_ultimo_ejemplar,descripcion,adeudo_de_subscripcion,factura,cambiar_factura,ruta,atenciona,edificio,calle,colonia,descripcion_dir) VALUES ');
          ZQCancelar.SQL.Add('('+nosubscripcion.Text+','+NoSubscriptor.text+','+FloatToStr(motivo.KeyValue)+',"'+ultimoejemplar+'","'+descripcion.Text+'",'+adeudo.Caption+',"'+factura+'",'+cambiof+','+ruta+',"'+atenciona.Text+'",'+IntToStr(edificio)+',"'+calle+'","'+colonia+'","'+descripcion_dir+'")');
          ZQCancelar.ExecSQL;
             end;
          if edificio>0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Insert into t_cancelacion (nosubscripcion,nosubscriptor,motivo,fecha_ultimo_ejemplar,descripcion,adeudo_de_subscripcion,factura,cambiar_factura,ruta,atenciona,edificio,area,calle) VALUES ('+nosubscripcion.Text+','+NoSubscriptor.text+','+FloatToStr(motivo.KeyValue)+',"'+ultimoejemplar+'","'+descripcion.Text+'",'+adeudo.Caption+',"'+factura+'",'+cambiof+','+ruta+',"'+atenciona.Text+'",'+IntToStr(edificio)+',"'+area+'","'+nomedif+'")');
          ZQCancelar.ExecSQL;
             end;

          {buscamos si la subscripcion esta dada de alta en alguna y lo eliminamos}
          {Si la fecha de cancelacion es la misma que la fecha actual lo eliminamos de las rutas}
          if DateToStr(fecha_ultimo.Date)=DateToStr(now()) then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Delete from t_descripcion_ruta_edificio where nosubscripcion ='+nosubscripcion.text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Delete from t_descripcion_rutas where no_de_subscripcion ='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Delete from t_subscripcion where nosubscripcion ='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Delete from t_beneficios_subscripcion where nosubscripcion ='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
            ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Delete from t_saldos where nosubscripcion ='+nosubscripcion.Text);
          ZQCancelar.ExecSQL;
          {verificamos el si el subscriptor tiene mas subscripciones para etiquetar su estatus}
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select nosubscripcion from t_subscripcion where nosubscriptor ='+Nosubscriptor.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
             end
          {Si la fecha de ultimo ejemplar no es igual a la fecha actual modificamos la fecha de fin para que el script lo borre en la fecha indicada}
          else  begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Update t_subscripcion SET fecha_termino="'+DateToStr(fecha_ultimo.Date)+'" where nosubscripcion ='+nosubscripcion.text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Close;
          end;
          {------------------------------------------------------------------------------------------}
          if StrToFloat(adeudo.Caption)>0 then
              begin
                if application.MessageBox (pchar('Se debera cancelar la factura y asignar una nueva ya que el importe total de la subscripcion no esta cubierto, ¿Desa hacerlo ahora?'), pchar('Cambio no factura'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
                   begin
                     FCambio_Factura.Enabled:=FALSE;
                     FCambio_Factura := TFCambio_Factura.Create(self);
                     FCambio_Factura.ShowModal;
                   end;
              end;


          {------------------------------------------------------------------------------------------}
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('Select nosubscripcion from t_subscripcion where nosubscriptor ='+Nosubscriptor.Text);
          ZQCancelar.ExecSQL;
          ZQCancelar.Open;
            if ZQCancelar.FieldByName('nosubscripcion').IsNull=TRUE then
                 begin
                   ZQCancelar.Close;
                   ZQCancelar.SQL.Clear;
                   ZQCancelar.SQL.Add('Update t_cliente_subscriptor SET estatus="inactivo" where id_subscriptor ='+Nosubscriptor.Text);
                   ZQCancelar.ExecSQL;
                 end;

          {fin de verificacion para el estatus----------------------------------------------}

          {llamamos el procedimiento almacenado de ordenamiento despues de eliminar un registro}
         if edificio=0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('CALL Orden_de_reparto('+ruta+')');
          ZQCancelar.ExecSQL;
             end;
         if edificio>0 then
             begin
          ZQCancelar.Close;
          ZQCancelar.SQL.Clear;
          ZQCancelar.SQL.Add('CALL Orden_reparto_metro('+ruta+')');
          ZQCancelar.ExecSQL;
             end;
       {------------Bitacora-----------------------------------------}
        ZQb.Close;
        ZQb.SQL.Clear;
        ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se cancelo la subscripcion:'+nosubscripcion.Text+'","Jefe de circulacion")');
        ZQb.ExecSQL;
        ZQb.Close;
       {------------Bitacora-----------------------------------------}
          ShowMessage('La subscripcion fue cancelada; se actualizaron las rutas');
          FCancelaciones.Close;
          end;
      end;
  end;

end;

procedure TFCancelaciones.DBGridSubscripcionesCellClick(Column: TColumn);
var
nodesubscripcion:string;
begin
   Nodesubscripcion:=DBGridSubscripciones.Fields[0].AsString;
   NoSubscripcion.Text:=DBGridSubscripciones.Fields[0].AsString;
   NoSubscriptor.Text:=DBGridSubscripciones.Fields[1].AsString;
   Atenciona.Text:=DBGridSubscripciones.Fields[2].AsString;
   ZQPagos.Close;
   ZQPagos.SQL.Clear;
   ZQpagos.SQL.Add('Select fechapago as "fecha de pago",montopago AS "Cantidad pagada",Concepto from t_pagos where nosubscripcion ='+nodesubscripcion);
   ZQPagos.ExecSQL;
   ZQPagos.Open;
   ZQPagos.Active:=TRUE;
   DBGridPagos.Refresh;
   ZQAdeudo.Close;
   ZQAdeudo.SQL.Clear;
   ZQAdeudo.SQL.Add('Select resta from t_saldos where nosubscripcion='+nodesubscripcion);
   ZQAdeudo.ExecSQL;
   ZQAdeudo.Open;
   Adeudo.caption:=ZQAdeudo.FieldByName('resta').AsString;
   ZQAdeudo.Close;
   ZQAdeudo.SQL.Clear;
   ZQAdeudo.SQL.Add('Select tipo_subscripcion,(Select tipo from c_tipo_de_subscripcion where id_subscripcion=tipo_subscripcion) AS nombre from t_subscripcion where nosubscripcion='+nodesubscripcion);
   ZQAdeudo.ExecSQL;
   ZQAdeudo.Open;
   tiposubs.Caption:=ZQAdeudo.FieldByName('nombre').AsString;
end;

procedure TFCancelaciones.FormShow(Sender: TObject);
begin
    fecha_ultimo.Date:= now();
end;

procedure TFCancelaciones.NoSubscripcionExit(Sender: TObject);
var
Nodesubscripcion:String;
begin
  if(Nosubscripcion.Text <> '') then
    begin
   ZQIntercambio.Close;
   ZQIntercambio.SQL.Clear;
   ZQIntercambio.SQL.Add('Select * from t_subscripcion where NoSubscripcion = '+NoSubscripcion.Text);
   ZQIntercambio.ExecSQL;
   ZQIntercambio.Open;
   ZQIntercambio.Refresh;
   DBGridSubscripciones.Refresh;
   NoSubscriptor.Text:= ZQIntercambio.FieldByName('nosubscriptor').AsString;
   Atenciona.Text:=ZQIntercambio.FieldByName('Atenciona').AsString;
   Nodesubscripcion:=DBGridSubscripciones.Fields[0].AsString;
   NoSubscripcion.Text:=DBGridSubscripciones.Fields[0].AsString;
   NoSubscriptor.Text:=DBGridSubscripciones.Fields[1].AsString;
   Atenciona.Text:=DBGridSubscripciones.Fields[2].AsString;
   ZQPagos.Close;
   ZQPagos.SQL.Clear;
   ZQpagos.SQL.Add('Select fechapago as "fecha de pago",montopago AS "Cantidad pagada",Concepto from t_pagos where nosubscripcion ='+nodesubscripcion);
   ZQPagos.ExecSQL;
   ZQPagos.Open;
   ZQPagos.Active:=TRUE;
   DBGridPagos.Refresh;
   ZQAdeudo.Close;
   ZQAdeudo.SQL.Clear;
   ZQAdeudo.SQL.Add('Select resta from t_saldos where nosubscripcion='+nodesubscripcion);
   ZQAdeudo.ExecSQL;
   ZQAdeudo.Open;
   Adeudo.caption:=ZQAdeudo.FieldByName('resta').AsString;
   ZQAdeudo.Close;
   ZQAdeudo.SQL.Clear;
   ZQAdeudo.SQL.Add('Select tipo_subscripcion,(Select tipo from c_tipo_de_subscripcion where id_subscripcion=tipo_subscripcion) AS nombre from t_subscripcion where nosubscripcion='+nodesubscripcion);
   ZQAdeudo.ExecSQL;
   ZQAdeudo.Open;
   tiposubs.Caption:=ZQAdeudo.FieldByName('nombre').AsString;
   ZQAdeudo.Close;
   ZQAdeudo.SQL.Clear;
   ZQAdeudo.SQL.Add('Select tipo_subscripcion,(Select costo from c_tipo_de_subscripcion where id_subscripcion=tipo_subscripcion) AS costo from t_subscripcion where nosubscripcion='+nodesubscripcion);
   ZQAdeudo.ExecSQL;
   ZQAdeudo.Open;
   costo.Caption:=ZQAdeudo.FieldByName('costo').AsString;
   DBGridSubscripciones.Refresh;
    end;
end;

procedure TFCancelaciones.NoSubscriptorExit(Sender: TObject);
begin
  if(NoSubscriptor.Text <> '') then
   Begin
   ZQIntercambio.Close;
   ZQIntercambio.SQL.Clear;
   ZQIntercambio.SQL.Add('Select * from t_subscripcion where NoSubscriptor = '+Nosubscriptor.Text);
   ZQIntercambio.ExecSQL;
   ZQIntercambio.Open;
   ZQIntercambio.Refresh;
   DBGridSubscripciones.Refresh;
   End;
end;

procedure TFCancelaciones.NoSubscriptorKeyPress(Sender: TObject; var Key: Char);
begin
     {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
  end;

   

end;

procedure TFCancelaciones.RegresarClick(Sender: TObject);
begin
    FCancelaciones.Close;
end;

end.
