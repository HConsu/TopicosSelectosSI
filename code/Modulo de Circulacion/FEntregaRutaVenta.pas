unit FEntregaRutaVenta;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, StdCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, jpeg, ExtCtrls, Menus,ShellAPI, ComCtrls,
  OleServer, Excel2000,  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, AppEvnts, ZAbstractTable;

type
  TFEntregaRutaVentas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    responsable: TLabel;
    Label4: TLabel;
    nodesubs: TLabel;
    Label5: TLabel;
    nonoentregadas: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    noduplicados: TLabel;
    Label8: TLabel;
    tiempototal: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    horai: TLabel;
    horaf: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    hinicioedificio: TLabel;
    hfinedificio: TLabel;
    cargar: TButton;
    ruta: TDBLookupComboBox;
    GridEntregados: TDBGrid;
    gridnoentregados: TDBGrid;
    cerrar: TButton;
    Button1: TButton;
    lfecha: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    masuno: TCheckBox;
    GridEntrega: TDBGrid;
    StatusBar1: TStatusBar;
    Button2: TButton;
    Button4: TButton;
    Motivo: TDBLookupComboBox;
    ZQimportar: TZQuery;
    ZQtrans: TZQuery;
    ZQrutas: TZQuery;
    DSrutas: TDataSource;
    DSEntregados: TDataSource;
    DSNoentregados: TDataSource;
    ZQnoentregados: TZQuery;
    ZQentregados: TZQuery;
    ZQtmp: TZQuery;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Datos1: TMenuItem;
    Volveracargardatosderuta1: TMenuItem;
    ZQdireccion: TZQuery;
    Excel: TExcelApplication;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    DSentrega: TDataSource;
    ZQentrega: TZQuery;
    ZQcorreos: TZQuery;
    motivos: TPopupMenu;
    Nuevasuscripcion1: TMenuItem;
    Codigodaado1: TMenuItem;
    CodigoFaltante1: TMenuItem;
    Sinaccesoaldomicilio1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    DSmotivos: TDataSource;
    CAtMotivos: TZTable;
    ZQhoras: TZQuery;
    Button3: TButton;
    ActivarDesactivarnotificacin1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cargarClick(Sender: TObject);
    procedure cerrarClick(Sender: TObject);
    procedure Nuevasuscripcion1Click(Sender: TObject);
    procedure Codigodaado1Click(Sender: TObject);
    procedure CodigoFaltante1Click(Sender: TObject);
    procedure Sinaccesoaldomicilio1Click(Sender: TObject);
    procedure Seestaimplementando1Click(Sender: TObject);
    procedure Olvidodeentrega1Click(Sender: TObject);
    procedure Fuerzamayor1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ActivarDesactivarnotificacin1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure gridnoentregadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    type THackDBGrid = class(TDBGrid);
  private
    { Private declarations }
  public
    { Public declarations }
    hoy:String;
  end;

var
  FEntregaRutaVentas: TFEntregaRutaVentas;

implementation

{$R *.dfm}
Uses FNotificarEntrega,FDescripcion_Incidente_Entrega;

procedure TFEntregaRutaVentas.ActivarDesactivarnotificacin1Click(
  Sender: TObject);
begin
  FActivarEntrega.enabled:=FALSE;
  FActivarEntrega := TFActivarEntrega.create(self);
  FActivarEntrega.Showmodal;
end;

procedure TFEntregaRutaVentas.Button1Click(Sender: TObject);
begin
     if masuno.Checked=TRUE then
       begin
        SysUtils.DeleteFile('BI300_ScanData.txt');
       end;

  ShellExecute(FEntregaRutaVentas.Handle,nil,PChar('\Escaner\PidionScan.exe'),'','',SW_SHOWNORMAL);
end;

procedure TFEntregaRutaVentas.Button2Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
  if motivo.Text<>'' then
    begin
   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;

  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo='+IntToStr(motivo.KeyValue));
  Zqtmp.ExecSQL;

       ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
    end
    else begin
      ShowMessage('Indique un motivo');
    end;
end;

procedure TFEntregaRutaVentas.Button3Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 i:=1;
 Hoja.PageSetup.Orientation:=2;
  // Ajustar margenes
 Hoja.PageSetup.LeftMargin  := 15;
 Hoja.PageSetup.RightMargin := -5;
 Hoja.PageSetup.TopMargin:=  Excel.InchesToPoints(0.2);
 Hoja.PageSetup.HeaderMargin:= Excel.InchesToPoints(0.2);
 Hoja.PageSetup.BottomMargin:=Excel.InchesToPoints(0.2);
 Hoja.PageSetup.FooterMargin:=Excel.InchesToPoints(0.2);

  Hoja.PageSetup.Zoom:=FALSE;
  Hoja.PageSetup.FitToPagesWide:=1;


 Hoja.Cells.Item[1,1].ColumnWidth := 14;
 Hoja.Cells.Item[2,2]:='Puntos de venta con incidencias en '+ruta.Text;
 Hoja.Cells.Item[2,2].font.size:=16;
 Hoja.Cells.Item[4,3]:='Nombre';
 Hoja.Cells.Item[4,3].ColumnWidth := 50;
 Hoja.Cells.Item[4,4]:='Dotacion';
 Hoja.Cells.Item[4,4].ColumnWidth := 50;
 Hoja.Cells.Item[4,5]:='Municipio';
 Hoja.Cells.Item[4,5].ColumnWidth := 50;
 i:=4;


 with ZQnoentregados do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=gridnoentregados.Fields[0].AsString;
       Hoja.Cells.Item[i,4]:=gridnoentregados.Fields[1].AsString;
       Hoja.Cells.Item[i,5]:=gridnoentregados.Fields[2].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQNoentregados.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFEntregaRutaVentas.Button4Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
 if motivo.Text<>'' then
   begin
   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;

  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo='+IntToStr(Motivo.KeyValue)+' where id_motivo=1');
  Zqtmp.ExecSQL;

       ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
   end
   else begin
     ShowMessage('Seleccione un motivo');
   end;
end;

procedure TFEntregaRutaVentas.cargarClick(Sender: TObject);
var
a,i,duplicados:integer;
no,fecha,hora,codigo,cadena,dupli:string;
inicio,fin,tiempo:ttime;
nosubscripcion,nosubscriptor,atenciona,edificio,direccion:String;
begin

 if masuno.Checked=FALSE then
       begin
   {----Limpiamos la tabla de datos iniciales-------------------}
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner_ventas');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_incidencias_tmp_ventas');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_entregadas_tmp_ventas');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_datos_scaner_ventas');
       ZQImportar.ExecSQL;

  {-------------------------------------------------------------}
       end;


  ZQimportar.Close;
  ZQimportar.SQL.Clear;
  ZQImportar.SQL.Add('LOAD DATA LOCAL INFILE "BI300_ScanData.txt" INTO TABLE t_archivo_scaner_ventas FIELDS TERMINATED BY "" (campocompleto)');
  ZQImportar.ExecSQL;
  ZQImportar.close;
  ZQImportar.SQL.Clear;
  ZQImportar.SQL.Add('Select campocompleto from t_archivo_scaner_ventas');
  ZQImportar.ExecSQL;
  ZQimportar.Open;


   // separamos los datos y los ponemos en el campo que corresponde
  while a<= ZQimportar.RecordCount do
     begin
       cadena:=ZQImportar.FieldByName('campocompleto').AsString;
       no:=copy(cadena,0,6);
       fecha:=copy(cadena,8,10);
       hora:=copy(cadena,19,8);
       codigo:=copy(cadena,28,6);
       //hora de inicio del recorrido
       if a=1 then
         begin
           fin:=StrToTime(hora);
         end;
       //hora de fin del recorrido
       if a=ZQimportar.RecordCount then
         begin
           inicio:=StrToTime(hora);
         end;

       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Insert into t_datos_scaner_ventas (id_scan,fecha,hora,codigo,ruta) VALUES('+no+',"'+fecha+'","'+hora+'","'+codigo+'",'+FloatToStr(ruta.KeyValue)+')');
       ZQtrans.ExecSQL;

       ZQimportar.Next;
       a:=a+1;

     end; {fin del while}


     if masuno.Checked=TRUE then
        begin
       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MIN(Hora)AS Hora from t_datos_scaner_ventas');
       ZQtrans.ExecSQL;
       ZQtrans.Open;

       inicio:=StrToTime(ZQtrans.FieldByName('Hora').AsString);

       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MAX(Hora)AS Hora from t_datos_scaner_ventas');
       ZQtrans.ExecSQL;
       ZQtrans.Open;

       fin:=StrToTime(ZQtrans.FieldByName('Hora').AsString);

        end;

      hoy:=FormatDateTime('yyyy-mm-dd',lfecha.Date);
       LongTimeFormat:='hh:mm:ss';
       horai.Caption:=TimeToStr(inicio);
       horaf.Caption:=TimeToStr(fin);
       tiempototal.Caption:=TimeToStr((fin-inicio));

       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select count(*)AS duplicados from v_entrega_ruta_duplicados_ventas where ruta='+FloatToStr(ruta.KeyValue)+' and duplicado>1 AND fecha="'+hoy+'"');
       ZQtrans.ExecSQL;
       ZQtrans.Open;
       dupli:=ZQTrans.FieldByName('Duplicados').AsString;

       {-------------------Refrescamos la tabla de entregados--------------------}
       ZQentregados.Close;
       ZQEntregados.SQL.Clear;
       ZQEntregados.SQL.Add('Select * from t_datos_scaner_ventas Where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'" group by codigo');
       ZQEntregados.ExecSQL;
       ZQentregados.Open;
       GridEntregados.Refresh;
       //nodesubs.Caption:=IntToStr(ZQentregados.RecordCount-StrToInt(dupli));
       nodesubs.Caption:=IntToStr(ZQentregados.RecordCount);
       noduplicados.Caption:=dupli;

      {-------------------Refrescamos la tabla de Entregados  ------------------}
       Dsentrega.Enabled:=TRUE;
       ZQentrega.Close;
       ZQentrega.SQL.Clear;
       ZQentrega.SQL.Add('Select Nombre,Dotacion,Municipio,Codigo from c_proveedores Where ruta='+FloatToStr(ruta.KeyValue)+' AND activo="S" AND codigo IN (Select codigo from t_datos_scaner_ventas where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQentrega.ExecSQL;
       ZQentrega.Open;
       GridEntrega.Refresh;
        i:=1;
        //////////////// no entregados ///////////////////////////////////
       Dsnoentregados.Enabled:=FALSE;
       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select Nombre,Dotacion,Municipio,Codigo from c_proveedores Where ruta='+FloatToStr(ruta.KeyValue)+' AND activo="S" AND codigo NOT IN (Select codigo from t_datos_scaner_ventas where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;
       nonoentregadas.Caption:=IntToStr(ZQnoentregados.RecordCount);
        i:=1;

          while i<=ZQnoentregados.RecordCount do
           begin
          nosubscripcion:=ZQnoentregados.FieldByName('Nombre').AsString;
          nosubscriptor:=ZQnoentregados.FieldByName('Dotacion').AsString;
          atenciona:=ZQnoentregados.FieldByName('Municipio').AsString;
          edificio:=ZQnoentregados.FieldByName('codigo').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_incidencias_tmp_ventas (Nombre,Dotacion,Municipio,codigo) VALUES("'+nosubscripcion+'",'+nosubscriptor+',"'+atenciona+'",'+edificio+')');
                   ZQimportar.ExecSQL;
              i:=i+1;
              ZQnoentregados.Next;
           end;

       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select Nombre,Dotacion,Municipio,Codigo,(Select motivo from c_motivonoentrega_ventas where c_motivonoentrega_ventas.id=t_incidencias_tmp_ventas.id_motivo) AS Motivo from t_incidencias_tmp_ventas');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;
       Dsnoentregados.Enabled:=TRUE;

end;

procedure TFEntregaRutaVentas.cerrarClick(Sender: TObject);
var
hoy,id,nosubscripcion,atenciona,domicilio,correos,idmotivo,motivoletra:String;
i:Integer;
nmotivo,correo,hiedificio,hfedificio,hicasa,hfcasa,ttotaledificio,ttotal:String;
begin

  if application.MessageBox(pchar('¿Esta seguro que desea cerrar la entrega de la ruta '+ruta.Text+'?'),pchar('Confirmar cierre de entrega'),(MB_YESNO + MB_ICONQUESTION)) =IDYES  then
    begin
       hoy:=FormatDateTime('yyyy-mm-dd',lfecha.Date);
    //   ShowMessage(hoy);

       LongTimeFormat:='hh:mm:ss';
        {----------------------Verificamos que este indicado el motivo de no entrega en todas las subscripciones----------}
       ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Select Codigo from t_incidencias_tmp_ventas where id_motivo=1 limit 1');
       ZQimportar.ExecSQL;
       ZQImportar.Open;

         if ZQimportar.FieldByName('Codigo').IsNull=TRUE then
            begin               //Si s falso significa que todas las incidencias tienen un motivo

    {------------------------------------------------------------------------------------------}


       {--------------Verificamos que la ruta no haya sido cerrada ya-------------------}
       ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Select id_scan from t_datos_scaner_final_ventas where fecha="'+hoy+'" AND ruta='+FloatToStr(ruta.KeyValue)+' limit 1');
       ZQimportar.ExecSQL;
       ZQImportar.Open;
       if ZQimportar.FieldByName('id_scan').IsNull=FALSE then
          begin
         ShowMessage('Ya esta cerrada esa ruta para el dia indicado');
          end
       else
           begin
      ZQcorreos.close;
      ZQCorreos.sql.clear;
      ZQcorreos.SQL.Add('Select estatus from t_estatus_envio where tipo=2');
      ZQcorreos.ExecSQL;
      ZQcorreos.Open;
      correo:=ZQcorreos.FieldByName('estatus').AsString;

      if correo='2' then
         begin
         {------------ Iniciamos los datos para el envio del correo --------------------}

        ZQcorreos.close;
        ZQcorreos.SQL.Clear;
        ZQcorreos.SQL.Add('Select correo from t_correo_notificacion_ruta_ventas');
        ZQcorreos.ExecSQL;
        ZQCorreos.Open;

        i:=1;
        while i<=ZQcorreos.RecordCount do
          begin
            if ZQcorreos.RecordCount>1 then
              begin
            if i=1 then
               begin correos:=ZQcorreos.FieldByName('correo').AsString;   end
            else
               begin correos:=correos+','+ZQcorreos.FieldByName('correo').AsString; end;
              end
            else  begin
               correos:=ZQcorreos.FieldByName('correo').AsString;
            end;
          i:=i+1;
          ZQcorreos.Next;
          end;

            // IdMessage1.Recipients.EMailAddresses := edtRecipients.Text;
        IdMessage1.Recipients.EMailAddresses := correos;
        IdMessage1.From.Address := 'angcartagena@gmail.com';
        idMessage1.Subject:='Informe de ruta '+ruta.Text+' el '+DateToStr(lfecha.Date);
        idMessage1.Body.Text:='DEPARTAMENTO DE CIRCULACIÓN'+#13#13+'Informe de entrega de ruta de venta '+#13+ ruta.Text +#13+'  Entregadas: '+nodesubs.Caption+' '+#13+' Incidencias: '+nonoentregadas.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Tiempo total de ruta:'+tiempototal.Caption+#13+'Hora de Inicio:'+horai.Caption+#13+'Hora de fin:'+horaf.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Hora inicio:'+horai.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Hora fin:'+horaf.Caption+#13#13;


        // IdMessage1.CCList.EMailAddresses := edtCC.Text;
        //IdMessage1.CCList.EMailAddresses := '';
        // IdMessage1.BccList.EMailAddresses := edtBCC.Text;
        //IdMessage1.BccList.EMailAddresses := '';

        idMessage1.Body.Text:=idMessage1.Body.Text+'Los puntos de venta que no fueron entregadas son:'+#13#13;

        end;
        {----------------Fin de iniciar los datos del Email----------------------------}






               {-------------Pasamos los datos a la tabla de estadisticas----------------------}
       ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Insert into t_estadisticas_ruta_ventas (fecha,ruta,entregadas,noentregadas,duplicadas,inicio,fin,tiempo) values');
       ZQImportar.SQL.Add('("'+hoy+'",'+FloatToStr(ruta.KeyValue)+','+nodesubs.Caption+','+nonoentregadas.Caption+','+noduplicados.Caption+',"'+horai.Caption+'","'+horaf.Caption+'","'+tiempototal.Caption+'")');
       ZQimportar.ExecSQL;
      {--------------------------------------------------------------------------------}
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQtrans.SQL.Add('Insert into t_datos_scaner_final_ventas (id_scan,fecha,hora,codigo,ruta) (Select id_scan,fecha,hora,codigo,ruta from t_datos_scaner_ventas where fecha="'+hoy+'")');
      ZQtrans.ExecSQL;
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQTrans.SQL.Add('Delete from t_datos_scaner_ventas');
      ZQtrans.ExecSQL;
      ZQentregados.Refresh;
      {-------------------Copiamos las inicidencias a la tabla de incidencia con el id de estadistica correspondiente-----------------------}
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQTrans.SQL.Add('Select max(id_estadistica)AS id from t_estadisticas_ruta_ventas');
      ZQtrans.ExecSQL;
      ZQtrans.Open;
      id:=ZQtrans.FieldByName('id').AsString;


       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select Nombre,Dotacion,Municipio,id_motivo,(Select motivo from c_motivonoentrega_ventas where c_motivonoentrega_ventas.id=t_incidencias_tmp_ventas.id_motivo)AS Motivo,codigo from t_incidencias_tmp_ventas');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;


       i:=0;
       ZQNoentregados.RecNo:=0;
       while i < ZQnoentregados.RecordCount do
          begin
              nosubscripcion:=ZQnoentregados.FieldByName('Nombre').AsString;
              domicilio:=ZQnoentregados.FieldByName('Dotacion').AsString;
              atenciona:=ZQnoentregados.FieldByName('Municipio').AsString;
              idmotivo:=ZQnoentregados.FieldByName('id_motivo').AsString;
              motivoletra:=ZQnoentregados.FieldByName('codigo').AsString;
              nmotivo:=ZQnoentregados.FieldByName('motivo').AsString;

              if correo='2' then
                 begin
              idMessage1.Body.Text:=idMessage1.Body.Text+Nosubscripcion+#13+'Dotacion:'+domicilio+#13+'Municipio:'+atenciona+#13+'Motivo:'+nmotivo+#13#13;
                 end;
              ZQtrans.Close;
              ZQtrans.SQL.Clear;
              ZQtrans.SQL.Add('Insert into t_incidencias_final_ventas (id_estadistica,Nombre,Dotacion,Municipio,Codigo,id_motivo) VALUES ('+id+',"'+nosubscripcion+'",'+domicilio+',"'+atenciona+'","'+motivoletra+'",'+idmotivo+')');
              ZQtrans.ExecSQL;
              i:=i+1;
              ZQnoentregados.Next;
          end;  // fin del while ZQnoentregados

      if correo='2' then
          begin
    {-----------Enviamos el correo electronico con la informacion -------------------}
       idMessage1.Body.Text:=idMessage1.Body.Text+#13#13#13+'Este correo electrónico contiene información confidencial la cual por ningún motivo deberá ser divulgada a personas no autorizadas.';
       idMessage1.Body.Text:=idMessage1.Body.Text+#13+'EL INDEPENDIENTE DE HIDALGO';


       IdSMTP1.Connect();

    if IdSMTP1.Connected then
    begin

    try
    IdSMTP1.Send(IdMessage1);
    finally
    IdSMTP1.Disconnect;
    end;
    //ShowMessage('Message sent successfully!');
    end
    else
    MessageDlg('Error en la conexion al servidor de correo!',mtConfirmation,[mbOK],0);

    IdSMTP1.Disconnect;
    Sleep(1000);
          end;

   {------------------Fin del envio del correo -----------------------------------------}



        //SysUtils.DeleteFile('BI300_ScanData.txt');
        ShowMessage('Se guardó la informacion de la ruta');
           end;
         end    //
       else begin
          ShowMessage('No se puede cerrar la ruta hasta que indique un motivo de no entrega para todas las suscripciones faltantes');
       end;
    end;    //fin del if



end;

procedure TFEntregaRutaVentas.Codigodaado1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;


  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=3 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.CodigoFaltante1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   FDescripcionIncidente.Enabled:=FALSE;
   FDescripcionIncidente :=TFDescripcionIncidente.Create(self);
   FDescripcionIncidente.ShowModal;

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;


  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=4 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.FormShow(Sender: TObject);
begin
  lfecha.Date:=now();
end;

procedure TFEntregaRutaVentas.Fuerzamayor1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=8 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.gridnoentregadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if gridnoentregados.Fields[4].AsString='NO ESPECIFICADO' then
        begin
          gridnoentregados.Canvas.Brush.Color := clRed;
          gridnoentregados.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end
  else begin
       gridnoentregados.Canvas.Brush.Color := clWhite;
          gridnoentregados.DefaultDrawColumnCell(rect,DataCol,Column,State);
  end;
end;

procedure TFEntregaRutaVentas.Nuevasuscripcion1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;

  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=2 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

       ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.Olvidodeentrega1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=7 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.Seestaimplementando1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=6 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

procedure TFEntregaRutaVentas.Sinaccesoaldomicilio1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   FDescripcionIncidente.Enabled:=FALSE;
   FDescripcionIncidente :=TFDescripcionIncidente.Create(self);
   FDescripcionIncidente.ShowModal;

   ds := THackDBGrid(gridnoentregados).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridnoentregados).Row;
   row := ds.RecNo;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_incidencias_tmp_ventas SET id_motivo=5 where codigo='+gridnoentregados.Fields[3].ASString);
  Zqtmp.ExecSQL;

  ZQnoentregados.Refresh;

  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
end;

end.
