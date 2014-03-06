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
    Label12: TLabel;
    ruta: TEdit;
    Label13: TLabel;
    responsable: TEdit;
    Button4: TButton;
    Button5: TButton;
    Label14: TLabel;
    direccion: TMemo;
    ZQbitacora: TZQuery;
    Label15: TLabel;
    lresuelto: TLabel;
    procedure Salir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridQuejasCellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure estatusClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure impreporteatencionClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ZQuejasAfterScroll(DataSet: TDataSet);
    procedure GridQuejasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    quienllamah:Integer;
  end;

var
  FSeguimientoQ: TFSeguimientoQ;

implementation

{$R *.dfm}
Uses
FR_Reporte_seguimiento_queja,FAutorizacion,Fprincipal,FQuejas_Cerradas,FHistorial_quejas,
Floginpass,FComentarios_quejas,FCerra_ConActa;

procedure TFSeguimientoQ.Button2Click(Sender: TObject);
begin

   if estatus.KeyValue <= 2 then        {Determinamos si el estatus se esta cambiando a solucionado}
   begin
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Update t_quejas SET status='+FloatToStr(Estatus.KeyValue)+' where id_queja='+Folio.Text);
   ZQuejas.ExecSQL;
   ZQuejas.Close;
    {---------------Bitacora movimeintos quejas-------------------}
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Insert into b_movimientos_quejas (id_queja,Movimiento,Usuario,id_usuario) VALUES('+folio.Text+',"Se modifico el estatus a '+estatus.Text+'","'+Flogin.nombre.Text+'",40)');
   ZQuejas.ExecSQL;
   {-------------------------------------------------------------}
   ZQuejas.Close;
   ShowMessage('Se actualizo el estatus de la queja');


  { ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",(Select estatus from c_estatus_quejas where id=t_quejas.Status)AS Estatus');
   ZQuejas.SQL.Add(',Otromotivo AS "Otro motivo",Descripcion AS "Descripcion",ruta From t_quejas where (status >=1 AND Status <= 3)');
   ZQuejas.ExecSQL;
   ZQuejas.Open;             }
   ZQuejas.Refresh;
   GridQuejas.Refresh;
   end;


     if estatus.KeyValue = 3 then  {el estatus es resuelto}
      begin
    if FprincipalCirculacion.permiso('203') then
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
         ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",(Select estatus from c_estatus_quejas where id=t_quejas.Status)AS Estatus');
         ZQuejas.SQL.Add(',Otromotivo AS "Otro motivo",Descripcion AS "Descripcion",ruta From t_quejas where (status >=1 AND Status <= 2)');
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
        end
    else begin
      ShowMessage('No tiene permiso para marcar como resuelta la queja');
    end;
      end;

  if estatus.KeyValue >= 4 then  {el estatus es resuelto}
    begin
       if FprincipalCirculacion.permiso('204') then
        begin
         ZQuejas.Close;
         ZQuejas.SQL.Clear;
         {Actualizamos el estatus y la solucion}
         ZQuejas.SQL.Add('Update t_quejas SET status='+FloatToStr(Estatus.KeyValue)+',solucion="'+solucion.Text+'", where id_queja='+Folio.Text);
         ZQuejas.ExecSQL;
         ZQuejas.Close;
         ZQuejas.SQL.Clear;
         ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",(Select estatus from c_estatus_quejas where id=t_quejas.Status)AS Estatus');
         ZQuejas.SQL.Add(',Otromotivo AS "Otro motivo",Descripcion AS "Descripcion",ruta From t_quejas where (status >=1 AND Status <= 2)');
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
        end
    else begin
      ShowMessage('No tiene permiso para marcar como cerrada la queja');
    end;
  end;

end;

procedure TFSeguimientoQ.Button3Click(Sender: TObject);
begin
   FSeguimientoQ.Close;
end;

procedure TFSeguimientoQ.Button4Click(Sender: TObject);
begin
  FQuejasCerradas.Enabled:=FALSE;
  FQuejasCerradas :=TFQuejasCerradas.Create(self);
  FQuejasCerradas.ShowModal;
end;

procedure TFSeguimientoQ.Button5Click(Sender: TObject);
begin
 if gridquejas.Fields[1].IsNull=FALSE then
    begin
      quienllamah:=2;
      FHistorialQueja.Enabled:=FALSE;
      FHistorialQueja := TFHistorialQueja.Create(self);
      FHistorialQueja.ShowModal;
    end;
end;

procedure TFSeguimientoQ.estatusClick(Sender: TObject);
begin
 if Estatus.KeyValue =3 then
     begin
     if FprincipalCirculacion.permiso('203') then
      begin
     Solucion.Enabled:=TRUE;
     fechaa.Enabled:=TRUE;
      end
     else begin
       ShowMessage('No tiene permiso para marcar como resuelta una queja');
     end;
     end;
  if Estatus.KeyValue =4 then
     begin
     if FPrincipalCirculacion.permiso('204') then
        begin
         Solucion.Enabled:=TRUE;
         fechaa.Enabled:=TRUE;
         FComentariosQuejas.Enabled:=FALSE;
         FcomentariosQuejas := TFComentariosQuejas.Create(self);
         FComentariosQuejas.ShowModal;
        end
       else begin
        ShowMessage('No tiene permiso para marcar como cerrada una queja');
       end;
     end;

  if Estatus.KeyValue =5 then
     begin
     if FPrincipalCirculacion.permiso('205') then
        begin
         Solucion.Enabled:=TRUE;
         fechaa.Enabled:=TRUE;
         FCierreConActa.Enabled:=FALSE;
         FCierreConActa := TFCierreConActa.Create(self);
         FCierreConActa.ShowModal;
        end
       else begin
        ShowMessage('No tiene permiso para cerrar con acta una queja');
       end;
     end;

  if estatus.KeyValue <=2 then
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
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion As "No. Subscripcion",Motivo_queja AS Motivo,fecha_queja As "Fecha de queja",(Select estatus from c_estatus_quejas where id=t_quejas.Status)AS Estatus');
   ZQuejas.SQL.Add(',Otromotivo AS "Otro motivo",Descripcion AS "Descripcion",ruta From t_quejas where (status >=1 AND Status <= 2)');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   ZQuejas.Active:=TRUE;
   GridQuejas.Refresh;
   fechaa.Date:=now()+1;


end;

procedure TFSeguimientoQ.GridQuejasCellClick(Column: TColumn);
var
ruta2,edificio:Integer;
nombreedif,direccionedif,area,telefono:String;
begin
   if GridQuejas.Fields[1].IsNull=FALSE then
       begin
    Nosubscripcion.Text:= GridQuejas.Fields[1].AsString;
    Folio.Text:=GridQuejas.Fields[0].AsString;
    Motivo.Text:=GridQuejas.Fields[2].AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select solucion from t_quejas where id_queja='+GridQuejas.Fields[0].AsString);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Solucion.Text:=ZQtmp.FieldByName('Solucion').AsString;
    {-----------------------------------------}
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select id from c_estatus_quejas where estatus="'+GridQuejas.Fields[4].AsString+'"');
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Estatus.KeyValue:=ZQtmp.FieldByName('id').AsFloat;
    {-----------------------------------------}
    otro.Text:=GridQuejas.Fields[5].AsString;
    descripcion.Text:=Gridquejas.Fields[6].AsString;
    fecha.Text:=GridQuejas.Fields[3].AsString;
    ruta.Text:=GridQuejas.Fields[7].AsString;
    //estatus.KeyValue:=GridQuejas.Fields[4].AsFloat;
    //Solucion.Text:='';
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select no_ruta,id_responsable_ruta as id_responsable,(Select nombre from c_repartidores_choferes where id_repartidor=id_responsable) as nombre from c_rutas where no_ruta='+ruta.Text);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    responsable.Text:=Zqtmp.FieldByName('nombre').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+Nosubscripcion.text);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    Titular.Text:=ZQtmp.FieldByName('atenciona').AsString;
    ZQtmp.Close;

        {------------Mostrar direccion de la subscripcion-------------------------------------}
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select edificio,ruta,telefono from t_subscripcion where nosubscripcion='+Nosubscripcion.Text);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     ruta2:=ZQtmp.FieldByName('ruta').AsInteger;
     edificio:=ZQtmp.FieldByName('edificio').AsInteger;
     telefono:=ZQtmp.FieldByName('telefono').AsString;

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
         direccion.Text:=direccionedif+','+nombreedif+','+area;
         END;

        if edificio = 0 then
         begin
         //showmessage('ruta');
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select no_ruta,calle,colonia,cp,ciudad,descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion.Text);
         ZQtmp.ExecSQL;
         ZQtmp.Open;
         direccion.Text:=ZQtmp.FieldByName('Calle').AsString+','+ZQtmp.FieldByName('Colonia').AsString+','+ZQtmp.FieldByName('descripcion_domicilio').AsString+','+ZQtmp.FieldByName('Ciudad').AsString;
        END;

     {------------------------------------------------------------------------------------}

       end;

end;

procedure TFSeguimientoQ.GridQuejasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if (((GridQuejas.Fields[3].AsDateTime)<=now()-FprincipalCirculacion.diasadvertenciaqueja) )then
        begin
          GridQuejas.Canvas.Brush.Color := FprincipalCirculacion.coloradvertenciaqueja;
          GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((GridQuejas.Fields[3].AsDateTime)<=now()-FprincipalCirculacion.diasincidenciaqueja) )then
    begin
      GridQuejas.Canvas.Brush.Color := FprincipalCirculacion.colorincidenciaqueja;
      GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
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
         //FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=DateToStr(fechaa.Date);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_repSegQueja.Ruta.Caption:=IntToStr(ruta);
        // FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.PrinterSettings.ColorOption
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
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.Motivo.Caption:=Motivo.Text;
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.descripcion.Caption:=Descripcion.Text;
         //FR_Reporte_seguimiento_queja.FR_RepSegQueja.fechaa.Caption:=DateToStr(fechaa.Date);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.solucion.Caption:=Solucion.Text;
         FR_Reporte_seguimiento_queja.FR_repSegQueja.Ruta.Caption:=IntToStr(ruta);
         FR_Reporte_seguimiento_queja.FR_RepSegQueja.reporte.Preview;
       end;

   //FR_Reporte_seguimiento_queja.FR_RepSegQueja.ZQquejas.SQL.Add('Select * from t_quejas where nosubscripcion');
end;


end;

procedure TFSeguimientoQ.Salir1Click(Sender: TObject);
begin
    FSeguimientoQ.Close;
end;

procedure TFSeguimientoQ.ZQuejasAfterScroll(DataSet: TDataSet);
var
ruta2,edificio:Integer;
nombreedif,direccionedif,area,telefono:String;
begin
   if GridQuejas.Fields[1].IsNull=FALSE then
       begin
    Nosubscripcion.Text:= GridQuejas.Fields[1].AsString;
    Folio.Text:=GridQuejas.Fields[0].AsString;
    Motivo.Text:=GridQuejas.Fields[2].AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select solucion,fecha_resuelto from t_quejas where id_queja='+GridQuejas.Fields[0].AsString);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Solucion.Text:=ZQtmp.FieldByName('Solucion').AsString;
    if ZQtmp.FieldByName('fecha_resuelto').IsNull=FALSE then
       begin
        lresuelto.Caption:=ZQtmp.FieldByName('fecha_resuelto').AsString;
       end
       else begin
        lresuelto.Caption:='';
       end;
    {-----------------------------------------}
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select id from c_estatus_quejas where estatus="'+GridQuejas.Fields[4].AsString+'"');
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    Estatus.KeyValue:=ZQtmp.FieldByName('id').AsFloat;
    {-----------------------------------------}
    otro.Text:=GridQuejas.Fields[5].AsString;
    descripcion.Text:=Gridquejas.Fields[6].AsString;
    fecha.Text:=GridQuejas.Fields[3].AsString;
    ruta.Text:=GridQuejas.Fields[7].AsString;
    //estatus.KeyValue:=GridQuejas.Fields[4].AsFloat;
    //Solucion.Text:='';
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select no_ruta,id_responsable_ruta as id_responsable,(Select nombre from c_repartidores_choferes where id_repartidor=id_responsable) as nombre from c_rutas where no_ruta='+ruta.Text);
    Zqtmp.ExecSQL;
    ZQtmp.Open;
    responsable.Text:=Zqtmp.FieldByName('nombre').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+Nosubscripcion.text);
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    Titular.Text:=ZQtmp.FieldByName('atenciona').AsString;
    ZQtmp.Close;

        {------------Mostrar direccion de la subscripcion-------------------------------------}
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select edificio,ruta,telefono from t_subscripcion where nosubscripcion='+Nosubscripcion.Text);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     ruta2:=ZQtmp.FieldByName('ruta').AsInteger;
     edificio:=ZQtmp.FieldByName('edificio').AsInteger;
     telefono:=ZQtmp.FieldByName('telefono').AsString;

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
         direccion.Text:=direccionedif+','+nombreedif+','+area;
         END;

        if edificio = 0 then
         begin
         //showmessage('ruta');
         ZQtmp.SQL.Clear;
         ZQtmp.SQL.Add('Select no_ruta,calle,colonia,cp,ciudad,descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion.Text);
         ZQtmp.ExecSQL;
         ZQtmp.Open;
         direccion.Text:=ZQtmp.FieldByName('Calle').AsString+','+ZQtmp.FieldByName('Colonia').AsString+','+ZQtmp.FieldByName('descripcion_domicilio').AsString+','+ZQtmp.FieldByName('Ciudad').AsString;
        END;

     {------------------------------------------------------------------------------------}

       end;

end;

end.
