unit FAlta_de_queja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractTable, DBCtrls;

type
  TFAltaQueja = class(TForm)
    CheckSubscripcion: TCheckBox;
    CheckAtenciona: TCheckBox;
    NoSubscripcionb: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Nombre: TEdit;
    Buscar: TButton;
    DBGridSubscripciones: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    Direccion: TMemo;
    Atenciona: TEdit;
    NoSubscripcion: TEdit;
    Label5: TLabel;
    Folio: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    descripcion: TMemo;
    Aceptar: TButton;
    Cancelar: TButton;
    Label9: TLabel;
    Fecha: TEdit;
    ZQSubscripcion: TZQuery;
    DSSubscripciones: TDataSource;
    ZQQueja: TZQuery;
    MotivoQueja: TDBLookupComboBox;
    Label10: TLabel;
    DSMotivoqueja: TDataSource;
    ZQMotivoQueja: TZQuery;
    LDescripcion: TLabel;
    Descripcionmotivo: TEdit;
    Label11: TLabel;
    ruta: TEdit;
    Label12: TLabel;
    titular: TEdit;
    Button1: TButton;
    Imprimir: TButton;
    ZQtmp: TZQuery;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure CheckSubscripcionClick(Sender: TObject);
    procedure CheckAtencionaClick(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
    procedure DBGridSubscripcionesCellClick(Column: TColumn);
    procedure CancelarClick(Sender: TObject);
    procedure MotivoQuejaClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure NoSubscripcionbKeyPress(Sender: TObject; var Key: Char);
    procedure NombreKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
	  procedure ImprimirClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    codigo:String;
  end;

var
  FAltaQueja: TFAltaQueja;

implementation

{$R *.dfm}
Uses
FQuejas_Subscripciones,FPrincipal,FR_Reporte_seguimiento_queja,Floginpass,FHistorial_Entrega;

procedure TFAltaQueja.BuscarClick(Sender: TObject);
begin
     {Buscamos los clientes subscriptores en base al criterio de busqueda}
   if Checkatenciona.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion,(Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=');
     ZQSubscripcion.SQL.Add('t_subscripcion.nosubscriptor) as Titular from t_subscripcion where atenciona LIKE "%'+nombre.Text+'%" OR (Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=t_subscripcion.nosubscriptor ) like "%'+nombre.Text+'%"');
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
  if CheckSubscripcion.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion,(Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=');
     ZQSubscripcion.SQL.Add('t_subscripcion.nosubscriptor) as Titular from t_subscripcion where nosubscripcion='+NoSubscripcionb.Text);
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
end;

procedure TFAltaQueja.Button1Click(Sender: TObject);
begin
   FPrincipalCirculacion.quienllamaquejasS:=2;
   FQuejasSubscripciones.Enabled:=FALSE;
   FQuejasSubscripciones := TFQuejasSubscripciones.Create(self);
   FQuejasSubscripciones.ShowModal;
end;

procedure TFAltaQueja.Button2Click(Sender: TObject);
begin
   FHistorialEntrega.Show;
end;

procedure TFAltaQueja.AceptarClick(Sender: TObject);
begin
if application.MessageBox (pchar('¿Esta seguro de querer dar de alta esta queja del subscriptor '+Nosubscripcion.Text+'?'), pchar('Confirmar alta de queja'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
if motivoqueja.Text<>'' then
    begin

  if motivoqueja.Text = 'Otro' then
      begin
  ZQQueja.Close;
  ZQQueja.SQL.Clear;
  ZQQueja.SQL.Add('Insert into t_quejas (NoSubscripcion,descripcion,otromotivo,status,ruta) VALUES('+NOSUBSCRIPCION.Text+',"'+descripcion.Text+'","'+descripcionmotivo.Text+'",1,'+ruta.Text+')');
  ZQQueja.ExecSQL;
  {------------Bitacora quejas---------------------------}
  ZQQueja.Close;
  ZQQueja.SQL.Clear;
  ZQQueja.SQL.Add('Insert into b_movimientos_quejas (id_queja,Movimiento,Usuario,id_usuario) VALUES('+folio.Text+',"Se dio de alta la queja","'+Flogin.nombre.Text+'",40)');
  ZQQueja.ExecSQL;
  {------------------------------------------------------}
  ShowMessage('La queja fue dada de alta con el folio: '+folio.Text);
  Aceptar.Enabled:=FALSE;
  Cancelar.Caption:='Salir';
      end
  else begin
   ZQQueja.Close;
   ZQQueja.SQL.Clear;
   ZQQueja.SQL.Add('Insert into t_quejas (NoSubscripcion,Motivo_queja,descripcion,status,ruta) VALUES('+NOSUBSCRIPCION.Text+',"'+motivoqueja.Text+'","'+descripcion.Text+'",1,'+ruta.Text+')');
   ZQQueja.ExecSQL;
   {------------Bitacora quejas---------------------------}
  ZQQueja.Close;
  ZQQueja.SQL.Clear;
  ZQQueja.SQL.Add('Insert into b_movimientos_quejas (id_queja,Movimiento,Usuario,id_usuario) VALUES('+folio.Text+',"Se dio de alta la queja","'+Flogin.nombre.Text+'",40)');
  ZQQueja.ExecSQL;
  {------------------------------------------------------}
   ShowMessage('La queja fue dada de alta con el folio: '+folio.Text);
   Aceptar.Enabled:=FALSE;
   Cancelar.Caption:='Salir';
   imprimir.Enabled:=TRUE;
       end;
      end
  else begin
     ShowMessage('Es  necesario especificar  el motivo de la queja');
  end;
     end;


end;

procedure TFAltaQueja.CancelarClick(Sender: TObject);
begin
    FAltaQueja.Close;
end;

procedure TFAltaQueja.CheckAtencionaClick(Sender: TObject);
begin
   if CheckAtenciona.Checked = TRUE then
      begin
      Nombre.Enabled:=TRUE;
      NoSubscripcionb.Enabled :=FALSE;
      Nosubscripcionb.Text:='';
      CheckSubscripcion.Checked:=FALSE;
      end;
 if CheckAtenciona.Checked = FALSE then
      begin
      Nombre.Enabled:=FALSE;
      end;
end;

procedure TFAltaQueja.CheckSubscripcionClick(Sender: TObject);
begin
   if CheckSubscripcion.Checked = TRUE then
      begin
      NoSubscripcionb.Enabled:=TRUE;
      Nombre.Enabled :=FALSE;
      Nombre.Text:='';
      CheckAtenciona.Checked:=FALSE;
      end;
 if CheckSubscripcion.Checked = FALSE then
      begin
      NoSubscripcionb.Enabled:=FALSE;
      end;
end;

procedure TFAltaQueja.DBGridSubscripcionesCellClick(Column: TColumn);
var
valor,direccionentrega,area,edificio:String;
a,edif:integer;
begin
   {tomamos el valor seleccionado en el primer grid  para mostrar los datos de las subscripciones en el segundo}
    valor:=DBGridSubscripciones.Fields[0].AsString;
   {no_de_subscriptor_public:=DBGridSubscriptor.Fields[0].AsString;}
   ZQQueja.Close;
   ZQQueja.SQL.Clear;
   ZQQueja.SQL.Add('Select * from t_subscripcion where nosubscripcion = '+valor);
   ZQQueja.ExecSQL;
   ZQQueja.Open;
   NoSubscripcion.Text := ZQQueja.FieldByName('NoSubscripcion').AsString;
   Atenciona.Text:= ZQQueja.FieldByName('AtencionA').AsString;
   edif:=ZQQueja.FieldByName('edificio').AsInteger;
   ruta.Text:=ZQQueja.FieldByName('ruta').AsString;
   titular.Text:=DBGridSubscripciones.Fields[8].AsString;
   codigo:=ZQqueja.FieldByName('codigo').AsString;
   Aceptar.Enabled:=TRUE;


    if edif > 0  then
      begin
         ZQQueja.Close;
         ZQQueja.SQL.Clear;
         ZQQUeja.SQL.Add('Select * from t_descripcion_ruta_edificio where nosubscripcion ='+IntToStr(edif));
         ZQQueja.ExecSQL;
         ZQQueja.Open;
         direccionentrega:= ZQQueja.FieldByName('area').AsString;
         ZQQueja.Close;
         ZQQueja.SQL.Clear;
         ZQQUeja.SQL.Add('Select descripcion from c_edificios where id_edificio='+IntToStr(edif));
         ZQQueja.ExecSQL;
         ZQQueja.Open;
         direccionentrega := ','+ZQQueja.FieldByName('descripcion').AsString;
         Direccion.Text:=direccionentrega;
      end
   else begin
        ZQQueja.Close;
        ZQQueja.SQL.Clear;
        ZQQueja.SQL.Add('Select * from t_descripcion_rutas where no_de_subscripcion ='+nosubscripcion.Text);
        ZQQueja.ExecSQL;
        ZQQueja.Open;
        Direccion.Text:= ZQQueja.FieldByName('calle').AsString+','+ZQQueja.FieldByName('colonia').AsString+','+ZQQueja.FieldByName('descripcion_domicilio').AsString+',C.P. '+ZQQueja.FieldByName('CP').AsString;

   end;


end;

procedure TFAltaQueja.FormShow(Sender: TObject);
begin

   Fecha.Text:= DateToStr(now);
   ZQMotivoQueja.ExecSQL;
   ZQMotivoQueja.Open;
   ZQMotivoQueja.Active:=TRUE;
   ZQQueja.Close;
   ZQQueja.SQL.Clear;
   ZQQueja.SQL.Add('Select Max(id_queja)+1 As Folio from t_quejas');
   ZQQueja.ExecSQL;
   ZQQueja.Open;
   Folio.text :=ZQQueja.FieldByName('folio').AsString;
   ZQQueja.Close;
   ZQQueja.SQL.Clear;

end;

procedure TFAltaQueja.ImprimirClick(Sender: TObject);
var
ruta,edificio:Integer;
nombreedif,direccionedif,area,telefono:String;
begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select edificio,ruta,telefono from t_subscripcion where nosubscripcion='+Nosubscripcion.Text);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     ruta:=ZQtmp.FieldByName('ruta').AsInteger;
     edificio:=ZQtmp.FieldByName('edificio').AsInteger;
     telefono:=ZQtmp.FieldByName('telefono').AsString;
     ZQtmp.Close;
       if edificio >=1  then
         begin
         //showmessage('Edificio');
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion.Text);
         ZQtmp.ExecSQL;
         ZQtmp.Open;
         area:=ZQtmp.FieldByName('area').AsString;
         ZQtmp.Close;
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select descripcion,direccion from c_edificios where id_edificio='+IntToStr(edificio));
         ZQtmp.ExecSQL;
         ZQtmp.Open;
         nombreedif:=ZQtmp.FieldByName('descripcion').AsString;
         direccionedif:=ZQtmp.FieldByName('direccion').AsString;
         ZQtmp.Close;
         {pasamos los datos al reporte para que sea impreso}
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.fecha.Caption:=fecha.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Nosubscriptor.Caption:=Nosubscripcion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Folio.Caption:=Folio.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.titular.Caption:=Titular.Text;
         //FR_Reporte_seguimiento_queja.FR_RepSegQueja.Ruta.Caption:=ruta.text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.calle.Caption:=nombreedif+', '+direccionedif;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Telefono.Caption:=telefono;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Motivo.Caption:=MotivoQueja.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=Descripcion.Text;
//         FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=fecha.Text;
         //FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_repSegQueja.Ruta.Caption:=IntToStr(ruta);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.Preview;
         end;
       if edificio = 0 then
         begin
         //showmessage('ruta');
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select no_ruta,calle,colonia,cp,ciudad,descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion.Text);
         ZQtmp.ExecSQL;
         ZQtmp.Open;
         {pasamos los datos al reporte para que sea impreso}
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.fecha.Caption:=fecha.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Nosubscriptor.Caption:=Nosubscripcion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Folio.Caption:=Folio.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.titular.Caption:=Titular.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Ruta.Caption:=IntToStr(ruta);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.calle.Caption:=ZQtmp.FieldByName('calle').AsString;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Colonia.Caption:=ZQtmp.FieldByName('colonia').AsString;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.cp.Caption:=ZQtmp.FieldByName('cp').AsString;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Municipio.Caption:=ZQtmp.FieldByName('ciudad').AsString;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=ZQtmp.FieldByName('descripcion_domicilio').AsString;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Telefono.Caption:=telefono;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Motivo.Caption:=Motivoqueja.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=Descripcion.Text;
     //    FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=fecha.Text;
         //FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_repSegQueja.Ruta.Caption:=IntToStr(ruta);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.Preview;
       end;

   //FR_Reporte_seguimiento_queja.FR_RepSegQueja.ZQquejas.SQL.Add('Select * from t_quejas where nosubscripcion');
end;




procedure TFAltaQueja.MotivoQuejaClick(Sender: TObject);
begin
   if motivoqueja.Text = 'Otro' then
      begin
        LDescripcion.Visible:=TRUE;
        Descripcionmotivo.Visible:=TRUE;
      end;
   if motivoqueja.Text <> 'Otro' then
       begin
        LDescripcion.Visible:=FALSE;
        Descripcionmotivo.Visible:=FALSE;
       end;
end;

procedure TFAltaQueja.NombreKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
      begin
     if Checkatenciona.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion,(Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=');
     ZQSubscripcion.SQL.Add('t_subscripcion.nosubscriptor) as Titular from t_subscripcion where atenciona LIKE "%'+nombre.Text+'%" OR (Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=t_subscripcion.nosubscriptor ) like "%'+nombre.Text+'%"');
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
     if CheckSubscripcion.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion from t_subscripcion where NoSubscripcion ='+NoSubscripcionb.Text);
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
      end;
end;

procedure TFAltaQueja.NoSubscripcionbKeyPress(Sender: TObject; var Key: Char);
begin
    if key=#13 then
      begin
     if Checkatenciona.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion,(Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=');
     ZQSubscripcion.SQL.Add('t_subscripcion.nosubscriptor) as Titular from t_subscripcion where atenciona LIKE "%'+nombre.Text+'%" OR (Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=t_subscripcion.nosubscriptor ) like "%'+nombre.Text+'%"');
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
     if CheckSubscripcion.Checked = TRUE then
      begin
     ZQSubscripcion.Close;
     ZQSubscripcion.SQL.Clear;
     ZQSubscripcion.SQL.Add('Select nosubscripcion AS "No Subscripción", Atenciona AS "Atención a",Fecha_alta,fecha_inicio,fecha_fin,telefono,Observaciones,tipo_subscripcion,(Select titular from t_cliente_subscriptor where t_cliente_subscriptor.id_subscriptor=');
     ZQSubscripcion.SQL.Add('t_subscripcion.nosubscriptor) as Titular from t_subscripcion where nosubscripcion='+NoSubscripcionb.Text);
     ZQSubscripcion.ExecSQL;
     ZQSubscripcion.Open;
      end;
      end;
end;

end.

