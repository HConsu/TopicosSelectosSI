unit FSeguimiento_Quejas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, Menus, jpeg, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ComCtrls;

type
  TFSeguimientoQ = class(TForm)
    Label1: TLabel;
    GridQuejas: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    estatus: TDBLookupComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Descripcion: TMemo;
    Solucion: TMemo;
    impreporteatencion: TButton;
    Button1: TButton;
    Nosubscripcion: TEdit;
    folio: TEdit;
    Motivo: TEdit;
    fecha: TEdit;
    otro: TEdit;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    ZQuejas: TZQuery;
    ZQestatus: TZQuery;
    DSquejas: TDataSource;
    DSestatus: TDataSource;
    Button2: TButton;
    Button3: TButton;
    Label10: TLabel;
    titular: TEdit;
    ZQtmp: TZQuery;
    Label11: TLabel;
    fechaa: TDateTimePicker;
    procedure Salir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridQuejasCellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure estatusClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure impreporteatencionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSeguimientoQ: TFSeguimientoQ;

implementation

{$R *.dfm}
Uses
FR_Reporte_seguimiento_queja,FAutorizacion,Fprincipal_subscripciones;

procedure TFSeguimientoQ.Button2Click(Sender: TObject);
begin
  FPrincipal.autorizacionquerida:=3;
  FPassword.Enabled:=FALSE;
  FPassword := TFpassword.Create(Self);
  FPassword.ShowModal;
    if FPassword.autorizado=1 then
        begin
   if estatus.KeyValue < 2 then        {Determinamos si el estatus se esta cambiando a solucionado}
   begin
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Update t_quejas SET status='+FloatToStr(Estatus.KeyValue)+' where id_queja='+Folio.Text);
   ZQuejas.ExecSQL;
   ZQuejas.Close;
   ShowMessage('Se actualizo el estatus de la queja');
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",Status AS Estatus,Otromotivo AS "Otro motivo",Descripcion AS "Descripcion" From t_quejas where (status >=0 AND Status <= 1)');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   ZQuejas.Active:=TRUE;
   GridQuejas.Refresh;
   end;
   if estatus.KeyValue = 2 then  {el estatus es resuelto}
      begin
       if Solucion.Text = '' then
          begin
             {verificamos que se haya introducido una solucion}
            ShowMessage('Debe especificar una solución');
          end
       else begin
         ZQuejas.Close;
         ZQuejas.SQL.Clear;
         {Actualizamos el estatus y la solucion}
         ZQuejas.SQL.Add('Update t_quejas SET status='+FloatToStr(Estatus.KeyValue)+',solucion="'+solucion.Text+'" where id_queja='+Folio.Text);
         ZQuejas.ExecSQL;
         ZQuejas.Close;
         ZQuejas.SQL.Clear;
         ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",Status AS Estatus,Otromotivo AS "Otro motivo",Descripcion AS "Descripcion" From t_quejas where (status >=0 AND Status <= 1)');
         ZQuejas.ExecSQL;
         ZQuejas.Open;
         ZQuejas.Active:=TRUE;
         GridQuejas.Refresh;
         ShowMessage('Se actualizo el estatus de la queja y la solución');
         {Reseteamos los datos de solucion}
          Nosubscripcion.Text:= '';
          Folio.Text:='';
          Motivo.Text:='';
          otro.Text:='';
          descripcion.Text:='';
          fecha.Text:='';
          Solucion.Text:='';
          Solucion.Enabled:=FALSE;
         end; {Final del else y el if}
      end;
  end
 else begin
   ShowMessage('No esta autorizado para modificar datos en esta queja');
 end;

end;

procedure TFSeguimientoQ.Button3Click(Sender: TObject);
begin
   FSeguimientoQ.Close;
end;

procedure TFSeguimientoQ.estatusClick(Sender: TObject);
begin
  if Estatus.KeyValue =2 then
     begin
     Solucion.Enabled:=TRUE;
     fechaa.Enabled:=TRUE;
     end;
  if estatus.KeyValue <2 then
       begin
       Solucion.Enabled:=FALSE;
       Fechaa.Enabled:=FALSE;
       Solucion.Text:='';
       end;
end;

procedure TFSeguimientoQ.FormShow(Sender: TObject);
begin
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",Status AS Estatus,Otromotivo AS "Otro motivo",Descripcion AS "Descripcion" From t_quejas where (status >=0 AND Status <= 1)');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   ZQuejas.Active:=TRUE;
   GridQuejas.Refresh;

end;

procedure TFSeguimientoQ.GridQuejasCellClick(Column: TColumn);
begin
  if  GridQuejas.Fields[1].IsNull=FALSE then
     begin
    Nosubscripcion.Text:= GridQuejas.Fields[1].AsString;
    Folio.Text:=GridQuejas.Fields[0].AsString;
    Motivo.Text:=GridQuejas.Fields[2].AsString;
    Estatus.KeyValue:=GridQuejas.Fields[4].AsFloat;
    otro.Text:=GridQuejas.Fields[5].AsString;
    descripcion.Text:=Gridquejas.Fields[6].AsString;
    fecha.Text:=GridQuejas.Fields[3].AsString;
    Solucion.Text:='';
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+Nosubscripcion.text);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    Titular.Text:=ZQtmp.FieldByName('atenciona').AsString;
    ZQtmp.Close;
     end;
end;

procedure TFSeguimientoQ.impreporteatencionClick(Sender: TObject);
var
ruta,edificio:Integer;
nombreedif,direccionedif,area,telefono:String;
begin
 if  GridQuejas.Fields[1].IsNull=FALSE then
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
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Motivo.Caption:=Motivo.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=Descripcion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=DateToStr(fechaa.Date);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.Preview;
         end;
       if edificio = 0 then
         begin
         //showmessage('ruta');
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select no_ruta,calle,colonia,cp,ciudad,descripcion_domicilio from t_descripcion_rutas where nosubscripcion='+nosubscripcion.Text);
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
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Motivo.Caption:=Motivo.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=Descripcion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=DateToStr(fechaa.Date);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.Preview;
       end;

   //FR_Reporte_seguimiento_queja.FR_RepSegQueja.ZQquejas.SQL.Add('Select * from t_quejas where nosubscripcion');
end;


end;

procedure TFSeguimientoQ.Salir1Click(Sender: TObject);
begin
    FSeguimientoQ.Close;
end;

end.
