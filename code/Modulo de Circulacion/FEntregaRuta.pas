unit FEntregaRuta;

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
  TFEntregadeRuta = class(TForm)
    Label1: TLabel;
    cargar: TButton;
    ruta: TDBLookupComboBox;
    GridEntregados: TDBGrid;
    gridnoentregados: TDBGrid;
    Label2: TLabel;
    responsable: TLabel;
    ZQimportar: TZQuery;
    ZQtrans: TZQuery;
    ZQrutas: TZQuery;
    DSrutas: TDataSource;
    DSEntregados: TDataSource;
    DSNoentregados: TDataSource;
    ZQnoentregados: TZQuery;
    ZQentregados: TZQuery;
    Label4: TLabel;
    nodesubs: TLabel;
    Label5: TLabel;
    nonoentregadas: TLabel;
    ZQtmp: TZQuery;
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
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Datos1: TMenuItem;
    Volveracargardatosderuta1: TMenuItem;
    cerrar: TButton;
    Button1: TButton;
    lfecha: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    ZQdireccion: TZQuery;
    Button3: TButton;
    Excel: TExcelApplication;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    masuno: TCheckBox;
    GridEntrega: TDBGrid;
    DSentrega: TDataSource;
    ZQentrega: TZQuery;
    ZQcorreos: TZQuery;
    motivos: TPopupMenu;
    Nuevasuscripcion1: TMenuItem;
    CodigoFaltante1: TMenuItem;
    Sinaccesoaldomicilio1: TMenuItem;
    Seestaimplementando1: TMenuItem;
    Olvidodeentrega1: TMenuItem;
    Fuerzamayor1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    StatusBar1: TStatusBar;
    Codigodaado1: TMenuItem;
    Label9: TLabel;
    Button2: TButton;
    Button4: TButton;
    DSmotivos: TDataSource;
    CAtMotivos: TZTable;
    Motivo: TDBLookupComboBox;
    Label12: TLabel;
    Label13: TLabel;
    hinicioedificio: TLabel;
    hfinedificio: TLabel;
    ZQhoras: TZQuery;
    CodigoRobado1: TMenuItem;
    Casaabandonada1: TMenuItem;
    Button5: TButton;
    letra: TComboBox;
    Label14: TLabel;
    procedure cargarClick(Sender: TObject);
    procedure rutaCloseUp(Sender: TObject);
    procedure Volveracargardatosderuta1Click(Sender: TObject);
    procedure cerrarClick(Sender: TObject);
    procedure limpiarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salir1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure masunoClick(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Nuevasuscripcion1Click(Sender: TObject);
    procedure Codigodaniado1Click(Sender: TObject);
    procedure CodigoFaltante1Click(Sender: TObject);
    procedure Sinaccesoaldomicilio1Click(Sender: TObject);
    procedure Seestaimplementando1Click(Sender: TObject);
    procedure Olvidodeentrega1Click(Sender: TObject);
    procedure Fuerzamayor1Click(Sender: TObject);
    procedure gridnoentregadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Usarparatodos1Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado1Click(Sender: TObject);
    procedure Usarparatodos2Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado2Click(Sender: TObject);
    procedure Usarparatodos3Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado3Click(Sender: TObject);
    procedure Usarparatodos4Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado4Click(Sender: TObject);
    procedure Usarparatodos5Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado5Click(Sender: TObject);
    procedure Usarparatodos6Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado6Click(Sender: TObject);
    procedure Usarparatodos7Click(Sender: TObject);
    procedure Usarsoloparalosquenosehaindicado7Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Codigodaado1Click(Sender: TObject);
    procedure CodigoRobado1Click(Sender: TObject);
    procedure Casaabandonada1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    type THackDBGrid = class(TDBGrid);
  private
    { Private declarations }
    ultimadomicilio:String;
  public
    { Public declarations }
  end;

var
  FEntregadeRuta: TFEntregadeRuta;

implementation

{$R *.dfm}
Uses
FPrincipal;

procedure TFEntregadeRuta.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.SimpleText := Application.Hint;
  StatusBar1.SimplePanel := (Application.Hint <> '');
end;

procedure TFEntregadeRuta.Button1Click(Sender: TObject);
begin
    if masuno.Checked=TRUE then
       begin
        SysUtils.DeleteFile('BI300_ScanData.txt');
       end;

  ShellExecute(FEntregadeRuta.Handle,nil,PChar('\Escaner\PidionScan.exe'),'','',SW_SHOWNORMAL);
end;

procedure TFEntregadeRuta.Button2Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo='+IntToStr(motivo.KeyValue));
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

procedure TFEntregadeRuta.Button3Click(Sender: TObject);
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
 Hoja.Cells.Item[2,2]:='Suscripciones que faltaron de entregar en '+ruta.Text;
 Hoja.Cells.Item[2,2].font.size:=16;
 Hoja.Cells.Item[4,3]:='Direccion';
 Hoja.Cells.Item[4,3].ColumnWidth := 50;
 Hoja.Cells.Item[4,4]:='Atencion A';
 Hoja.Cells.Item[4,4].ColumnWidth := 50;
  i:=4;


 with ZQnoentregados do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=gridnoentregados.Fields[0].AsString;
       Hoja.Cells.Item[i,4]:=gridnoentregados.Fields[1].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQNoentregados.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;

end;

procedure TFEntregadeRuta.Button4Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo='+IntToStr(Motivo.KeyValue)+' where id_motivo=1');
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

procedure TFEntregadeRuta.Button5Click(Sender: TObject);
var
a,i,duplicados:integer;
no,fecha,hora,codigo,cadena,hoy,dupli:string;
inicio,fin,tiempo:ttime;
nosubscripcion,nosubscriptor,atenciona,edificio,direccion:String;
unidad:string;
begin
    // con este if verificamos si se estan agregando datos de mas de un PIDIO
   unidad:=letra.Text;

   if masuno.Checked=FALSE then
       begin
   {----Limpiamos la tabla de datos iniciales-------------------}
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_incidencias_tmp');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_entregadas_tmp');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_datos_scaner');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner_motorola');
       ZQImportar.ExecSQL;

  {-------------------------------------------------------------}
       end;

       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_incidencias_tmp');
       ZQImportar.ExecSQL;



  masuno.Enabled:=TRUE;
  if ruta.Text<>'' then
     begin
  a:=1;
  /// Cargamos los datos del archivo a la tabla temporal ------------------------- /
  try
  ZQimportar.Close;
  ZQimportar.SQL.Clear;
  ZQImportar.SQL.Add('LOAD DATA LOCAL INFILE "'+unidad+'\\BARCODES\\BARCODES.TXT" INTO TABLE t_archivo_scaner_motorola FIELDS TERMINATED BY "," (fecha,hora,control,codigo)');
  ZQImportar.ExecSQL;
  ZQImportar.close;
  ZQImportar.close;
  ZQImportar.SQL.Clear;
  ZQImportar.SQL.Add('Update t_archivo_scaner_motorola SET ruta='+IntToStr(ruta.KeyValue));
  ZQImportar.ExecSQL;
  Except
    ShowMessage('No se encuentra el achivo, verifique que la unidad sea la correcta');
  end;


  // separamos los datos y los ponemos en el campo que corresponde


  ZQImportar.close;
  ZQImportar.SQL.Clear;
  ZQImportar.SQL.Add('Select * from t_archivo_scaner_motorola');
  ZQImportar.ExecSQL;
  ZQimportar.Open;


  // separamos los datos y los ponemos en el campo que corresponde
  while a<= ZQimportar.RecordCount do
     begin
       no:=ZQImportar.FieldByName('id_scan').AsString;
       fecha:=FormatDateTime('yyyy-mm-dd',StrToDate(ZQImportar.FieldByName('fecha').AsString));
       hora:=ZQImportar.FieldByName('hora').AsString;
       codigo:=ZQImportar.FieldByName('codigo').AsString;
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
       ZQtrans.SQL.Add('Insert into t_datos_scaner (id_scan,fecha,hora,codigo,ruta) VALUES('+no+',"'+fecha+'","'+hora+'","'+codigo+'",'+FloatToStr(ruta.KeyValue)+')');
       ZQtrans.ExecSQL;

       ZQimportar.Next;
       a:=a+1;

     end; {fin del while}


      if masuno.Checked=TRUE then
        begin
       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MIN(Hora)AS Hora from t_datos_scaner');
       ZQtrans.ExecSQL;
       ZQtrans.Open;

       inicio:=StrToTime(ZQtrans.FieldByName('Hora').AsString);

       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MAX(Hora)AS Hora from t_datos_scaner');
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
       ZQtrans.SQL.Add('Select count(*)AS duplicados from v_entrega_ruta_duplicados where ruta='+FloatToStr(ruta.KeyValue)+' and duplicado>1 AND fecha="'+hoy+'"');
       ZQtrans.ExecSQL;
       ZQtrans.Open;
       dupli:=ZQTrans.FieldByName('Duplicados').AsString;

       {-------------------Refrescamos la tabla de entregados--------------------}
       ZQentregados.Close;
       ZQEntregados.SQL.Clear;
       ZQEntregados.SQL.Add('Select * from t_datos_scaner Where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'" group by codigo');
       ZQEntregados.ExecSQL;
       ZQentregados.Open;
       GridEntregados.Refresh;
       nodesubs.Caption:=IntToStr(ZQentregados.RecordCount);
       noduplicados.Caption:=dupli;

         {-------------------Refrescamos la tabla de Entregados  ------------------}
       Dsentrega.Enabled:=FALSE;
       ZQentrega.Close;
       ZQentrega.SQL.Clear;
       ZQentrega.SQL.Add('Select * from t_subscripcion Where ruta='+FloatToStr(ruta.KeyValue)+' AND entrega="S" AND codigo IN (Select codigo from t_datos_scaner where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQentrega.ExecSQL;
       ZQentrega.Open;
        i:=1;


          // necesario para poder mostrar la direccion completa de la subscripcion
         while i<=ZQentrega.RecordCount do
           begin
          nosubscripcion:=ZQentrega.FieldByName('Nosubscripcion').AsString;
          nosubscriptor:=ZQentrega.FieldByName('Nosubscriptor').AsString;
          atenciona:=ZQentrega.FieldByName('Atenciona').AsString;
          edificio:=ZQentrega.FieldByName('edificio').AsString;
              if StrToInt(edificio)>0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('edificio').AsString+','+ZQdireccion.FieldByName('Area').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_entregadas_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;

                 end;
                if StrToInt(edificio)=0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select Calle,Colonia,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+','+ZQdireccion.FieldByName('Descripcion_domicilio').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_entregadas_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;
                 end;

               ZQentrega.Next;
               i:=i+1;

           end;      // Fin del While

       Dsentrega.Enabled:=TRUE;
       ZQentrega.Close;
       ZQentrega.SQL.Clear;
       ZQentrega.SQL.Add('Select Direccion,Atenciona,nosubscripcion from t_entregadas_tmp');
       ZQentrega.ExecSQL;
       ZQentrega.Open;

       {-----hora de inicio edificio-----}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select min(hora) AS hora from t_datos_scaner where codigo in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       Hinicioedificio.Caption:=ZQhoras.FieldByName('hora').AsString;
       {------Hora de fin edificio------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Max(hora) AS hora from t_datos_scaner where codigo in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       Hfinedificio.Caption:=ZQHoras.FieldByName('hora').AsString;

       {-----Hora de inicio domicilio-------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Min(hora) AS hora from t_datos_scaner where codigo NOT in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       horai.Caption:=ZQhoras.FieldByName('hora').AsString;

       {-------Hora fin domicilio----------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Max(hora) AS hora from t_datos_scaner where codigo NOT in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;
       horaf.Caption:=ZQhoras.FieldByName('hora').AsString;
       ultimadomicilio:=ZQhoras.FieldByName('hora').AsString;

       {---------------------Fin de grid entregados con direccion-----------------}


       {-------------------Refrescamos la tabla de no entregados------------------}
       Dsnoentregados.Enabled:=FALSE;
       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select * from t_subscripcion Where ruta='+FloatToStr(ruta.KeyValue)+' AND entrega="S" AND codigo NOT IN (Select codigo from t_datos_scaner where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;
        i:=1;


          // necesario para poder mostrar la direccion completa de la subscripcion
         while i<=ZQnoentregados.RecordCount do
           begin
          nosubscripcion:=ZQnoentregados.FieldByName('Nosubscripcion').AsString;
          nosubscriptor:=ZQnoentregados.FieldByName('Nosubscriptor').AsString;
          atenciona:=ZQnoentregados.FieldByName('Atenciona').AsString;
          edificio:=ZQnoentregados.FieldByName('edificio').AsString;


              if StrToInt(edificio)>0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('edificio').AsString+','+ZQdireccion.FieldByName('Area').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_incidencias_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;

                 end;
                if StrToInt(edificio)=0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select Calle,Colonia,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+','+ZQdireccion.FieldByName('Descripcion_domicilio').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_incidencias_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;
                 end;

               ZQnoentregados.Next;
               i:=i+1;

           end;      // Fin del While

       DSNoentregados.Enabled:=TRUE;
       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select Direccion,Atenciona,(Select motivo from c_motivonoentrega where c_motivonoentrega.id=t_incidencias_tmp.id_motivo)AS Motivo,nosubscripcion,id_motivo from t_incidencias_tmp');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;

       nonoentregadas.Caption:=IntToStr(ZQNoentregados.RecordCount);
       gridnoentregados.Refresh;
        if ZQNoentregados.RecordCount>50 then
          begin
            ShowMessage('Ha faltado entregar mas de 50 subscripciones, ¿esta seguro que la ruta a procesar es la correcta?');
          end;

       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner');
       ZQImportar.ExecSQL;
       cerrar.Enabled:=TRUE;

  end
  else begin
    ShowMessage('Seleccione la ruta a procesar');
  end;




end;

procedure TFEntregadeRuta.cargarClick(Sender: TObject);
var
a,i,duplicados:integer;
no,fecha,hora,codigo,cadena,hoy,dupli:string;
inicio,fin,tiempo:ttime;
nosubscripcion,nosubscriptor,atenciona,edificio,direccion:String;
begin
    // con este if verificamos si se estan agregando datos de mas de un PIDIO
   if masuno.Checked=FALSE then
       begin
   {----Limpiamos la tabla de datos iniciales-------------------}
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_incidencias_tmp');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_entregadas_tmp');
       ZQImportar.ExecSQL;
       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_datos_scaner');
       ZQImportar.ExecSQL;

  {-------------------------------------------------------------}
       end;

       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_incidencias_tmp');
       ZQImportar.ExecSQL;



  masuno.Enabled:=TRUE;
  if ruta.Text<>'' then
     begin
  a:=1;
  /// Cargamos los datos del archivo a la tabla temporal ------------------------- /
  ZQimportar.Close;
  ZQimportar.SQL.Clear;
  ZQImportar.SQL.Add('LOAD DATA LOCAL INFILE "BI300_ScanData.txt" INTO TABLE t_archivo_scaner FIELDS TERMINATED BY "" (campocompleto)');
  ZQImportar.ExecSQL;
  ZQImportar.close;
  ZQImportar.SQL.Clear;
  ZQImportar.SQL.Add('Select campocompleto from t_archivo_scaner');
  ZQImportar.ExecSQL;
  ZQimportar.Open;


  // separamos los datos y los ponemos en el campo que corresponde
  while a<= ZQimportar.RecordCount do
     begin
       cadena:=ZQImportar.FieldByName('campocompleto').AsString;
       no:=copy(cadena,0,6);
       fecha:=copy(cadena,8,10);
       hora:=copy(cadena,19,8);
       codigo:=copy(cadena,28,14);
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
       ZQtrans.SQL.Add('Insert into t_datos_scaner (id_scan,fecha,hora,codigo,ruta) VALUES('+no+',"'+fecha+'","'+hora+'","'+codigo+'",'+FloatToStr(ruta.KeyValue)+')');
       ZQtrans.ExecSQL;


       ZQimportar.Next;
       a:=a+1;

     end; {fin del while}

      if masuno.Checked=TRUE then
        begin
       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MIN(Hora)AS Hora from t_datos_scaner');
       ZQtrans.ExecSQL;
       ZQtrans.Open;

       inicio:=StrToTime(ZQtrans.FieldByName('Hora').AsString);

       ZQtrans.Close;
       ZQTrans.SQL.Clear;
       ZQtrans.SQL.Add('Select MAX(Hora)AS Hora from t_datos_scaner');
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
       ZQtrans.SQL.Add('Select count(*)AS duplicados from v_entrega_ruta_duplicados where ruta='+FloatToStr(ruta.KeyValue)+' and duplicado>1 AND fecha="'+hoy+'"');
       ZQtrans.ExecSQL;
       ZQtrans.Open;
       dupli:=ZQTrans.FieldByName('Duplicados').AsString;

       {-------------------Refrescamos la tabla de entregados--------------------}
       ZQentregados.Close;
       ZQEntregados.SQL.Clear;
       ZQEntregados.SQL.Add('Select * from t_datos_scaner Where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'" group by codigo');
       ZQEntregados.ExecSQL;
       ZQentregados.Open;
       GridEntregados.Refresh;
       nodesubs.Caption:=IntToStr(ZQentregados.RecordCount);
       noduplicados.Caption:=dupli;

         {-------------------Refrescamos la tabla de Entregados  ------------------}
       Dsentrega.Enabled:=FALSE;
       ZQentrega.Close;
       ZQentrega.SQL.Clear;
       ZQentrega.SQL.Add('Select * from t_subscripcion Where ruta='+FloatToStr(ruta.KeyValue)+' AND entrega="S" AND codigo IN (Select codigo from t_datos_scaner where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQentrega.ExecSQL;
       ZQentrega.Open;
        i:=1;


          // necesario para poder mostrar la direccion completa de la subscripcion
         while i<=ZQentrega.RecordCount do
           begin
          nosubscripcion:=ZQentrega.FieldByName('Nosubscripcion').AsString;
          nosubscriptor:=ZQentrega.FieldByName('Nosubscriptor').AsString;
          atenciona:=ZQentrega.FieldByName('Atenciona').AsString;
          edificio:=ZQentrega.FieldByName('edificio').AsString;
              if StrToInt(edificio)>0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('edificio').AsString+','+ZQdireccion.FieldByName('Area').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_entregadas_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;

                 end;
                if StrToInt(edificio)=0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select Calle,Colonia,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+','+ZQdireccion.FieldByName('Descripcion_domicilio').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_entregadas_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;
                 end;

               ZQentrega.Next;
               i:=i+1;

           end;      // Fin del While

       Dsentrega.Enabled:=TRUE;
       ZQentrega.Close;
       ZQentrega.SQL.Clear;
       ZQentrega.SQL.Add('Select Direccion,Atenciona,nosubscripcion from t_entregadas_tmp');
       ZQentrega.ExecSQL;
       ZQentrega.Open;

       {-----hora de inicio edificio-----}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select min(hora) AS hora from t_datos_scaner where codigo in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       Hinicioedificio.Caption:=ZQhoras.FieldByName('hora').AsString;
       {------Hora de fin edificio------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Max(hora) AS hora from t_datos_scaner where codigo in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       Hfinedificio.Caption:=ZQHoras.FieldByName('hora').AsString;

       {-----Hora de inicio domicilio-------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Min(hora) AS hora from t_datos_scaner where codigo NOT in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;

       horai.Caption:=ZQhoras.FieldByName('hora').AsString;

       {-------Hora fin domicilio----------}
       ZQhoras.close;
       ZQhoras.SQL.Clear;
       ZQhoras.SQL.Add('Select Max(hora) AS hora from t_datos_scaner where codigo NOT in (select codigo from c_edificios)');
       ZQhoras.ExecSQL;
       ZQhoras.Open;
       horaf.Caption:=ZQhoras.FieldByName('hora').AsString;
       ultimadomicilio:=ZQhoras.FieldByName('hora').AsString;

       {---------------------Fin de grid entregados con direccion-----------------}


       {-------------------Refrescamos la tabla de no entregados------------------}
       Dsnoentregados.Enabled:=FALSE;
       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select * from t_subscripcion Where ruta='+FloatToStr(ruta.KeyValue)+' AND entrega="S" AND codigo NOT IN (Select codigo from t_datos_scaner where ruta='+FloatToStr(ruta.KeyValue)+' AND fecha="'+hoy+'")');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;
        i:=1;


          // necesario para poder mostrar la direccion completa de la subscripcion
         while i<=ZQnoentregados.RecordCount do
           begin
          nosubscripcion:=ZQnoentregados.FieldByName('Nosubscripcion').AsString;
          nosubscriptor:=ZQnoentregados.FieldByName('Nosubscriptor').AsString;
          atenciona:=ZQnoentregados.FieldByName('Atenciona').AsString;
          edificio:=ZQnoentregados.FieldByName('edificio').AsString;


              if StrToInt(edificio)>0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('edificio').AsString+','+ZQdireccion.FieldByName('Area').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_incidencias_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;

                 end;
                if StrToInt(edificio)=0 then
                 begin
                   ZQdireccion.Close;
                   ZQdireccion.SQL.Clear;
                   ZQdireccion.SQL.Add('Select Calle,Colonia,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                   ZQdireccion.ExecSQL;
                   ZQdireccion.Open;
                   direccion:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+','+ZQdireccion.FieldByName('Descripcion_domicilio').AsString;

                   ZQimportar.Close;
                   ZQimportar.SQL.Clear;
                   ZQimportar.SQL.Add('Insert into t_incidencias_tmp (Nosubscripcion,Nosubscriptor,Atenciona,direccion) VALUES('+nosubscripcion+','+nosubscriptor+',"'+atenciona+'","'+direccion+'")');
                   ZQimportar.ExecSQL;
                 end;

               ZQnoentregados.Next;
               i:=i+1;

           end;      // Fin del While

       DSNoentregados.Enabled:=TRUE;
       ZQnoentregados.Close;
       ZQnoentregados.SQL.Clear;
       ZQnoentregados.SQL.Add('Select Direccion,Atenciona,(Select motivo from c_motivonoentrega where c_motivonoentrega.id=t_incidencias_tmp.id_motivo)AS Motivo,nosubscripcion,id_motivo from t_incidencias_tmp');
       ZQNoentregados.ExecSQL;
       ZQNoentregados.Open;

       nonoentregadas.Caption:=IntToStr(ZQNoentregados.RecordCount);
       gridnoentregados.Refresh;
        if ZQNoentregados.RecordCount>50 then
          begin
            ShowMessage('Ha faltado entregar mas de 50 subscripciones, ¿esta seguro que la ruta a procesar es la correcta?');
          end;

       ZQImportar.close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Delete from t_archivo_scaner');
       ZQImportar.ExecSQL;
       cerrar.Enabled:=TRUE;

  end
  else begin
    ShowMessage('Seleccione la ruta a procesar');
  end;


end;

procedure TFEntregadeRuta.Casaabandonada1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=10 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.cerrarClick(Sender: TObject);
var
hoy,id,nosubscripcion,atenciona,domicilio,correos,idmotivo,motivoletra:String;
i:Integer;
hiedificio,hfedificio,hicasa,hfcasa,ttotaledificio,ttotal:String;
begin
if application.MessageBox(pchar('¿Esta seguro que desea cerrar la entrega de la ruta '+ruta.Text+'?'),pchar('Confirmar cierre de entrega'),(MB_YESNO + MB_ICONQUESTION)) =IDYES  then
    begin
       hoy:=FormatDateTime('yyyy-mm-dd',lfecha.Date);
    //   ShowMessage(hoy);

       LongTimeFormat:='hh:mm:ss';
       hiedificio:=hinicioedificio.Caption;
       hfedificio:=hfinedificio.Caption;
       ttotaledificio:=TimeToStr((StrToTime(hfedificio)-StrToTime(hiedificio)));
       ttotal:=TimeToStr(StrTotime(tiempototal.Caption)-StrToTime(ttotaledificio));

    {----------------------Verificamos que este indicado el motivo de no entrega en todas las subscripciones----------}
     ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Select NoSubscripcion from t_incidencias_tmp where id_motivo=1 limit 1');
       ZQimportar.ExecSQL;
       ZQImportar.Open;

         if ZQimportar.FieldByName('Nosubscripcion').IsNull=TRUE then
            begin               //Si s falso significa que todas las incidencias tienen un motivo

    {------------------------------------------------------------------------------------------}


       {--------------Verificamos que la ruta no haya sido cerrada ya-------------------}
       ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Select id_scan from t_datos_scaner_final where fecha="'+hoy+'" AND ruta='+FloatToStr(ruta.KeyValue)+' limit 1');
       ZQimportar.ExecSQL;
       ZQImportar.Open;
       if ZQimportar.FieldByName('id_scan').IsNull=FALSE then
          begin
         ShowMessage('Ya esta cerrada esa ruta para el dia indicado');
          end
       else
           begin
        {------------ Iniciamos los datos para el envio del correo --------------------}

        ZQcorreos.close;
        ZQcorreos.SQL.Clear;
        ZQcorreos.SQL.Add('Select correo from t_correo_notificacion_ruta');
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
        idMessage1.Body.Text:='DEPARTAMENTO DE SUSCRIPCIONES'+#13#13+'Informe de entrega de subscripciones '+#13+ ruta.Text +#13+'  Entregadas: '+nodesubs.Caption+' '+#13+' No Entregadas: '+nonoentregadas.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Tiempo total de ruta:'+tiempototal.Caption+#13+'Hora de Inicio:'+horai.Caption+#13+'Hora de fin:'+horaf.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Ultima entrega en domicilio:'+ultimadomicilio+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Ultima entrega en edificio:'+hfinedificio.Caption+#13#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Tiempo de entrega en domicilio:'+ttotal+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Tiempo de entrega de edificios:'+ttotaledificio+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Hora inicio de entrega en edificio:'+hinicioedificio.Caption+#13;
        idMessage1.Body.Text:=idMessage1.Body.Text+'Hora fin de entrega en edificio:'+hfinedificio.Caption+#13#13;


        // IdMessage1.CCList.EMailAddresses := edtCC.Text;
        //IdMessage1.CCList.EMailAddresses := '';
        // IdMessage1.BccList.EMailAddresses := edtBCC.Text;
        //IdMessage1.BccList.EMailAddresses := '';

        idMessage1.Body.Text:=idMessage1.Body.Text+'Las subscripciones que no fueron entregadas son:'+#13#13;

        {----------------Fin de iniciar los datos del Email----------------------------}

       {-------------Pasamos los datos a la tabla de estadisticas----------------------}
       ZQImportar.Close;
       ZQImportar.SQL.Clear;
       ZQImportar.SQL.Add('Insert into t_estadisticas_ruta (fecha,ruta,entregadas,noentregadas,duplicadas,inicio,fin,tiempo,realizo,Udomicilio) values');
       ZQImportar.SQL.Add('("'+hoy+'",'+FloatToStr(ruta.KeyValue)+','+nodesubs.Caption+','+nonoentregadas.Caption+','+noduplicados.Caption+',"'+horai.Caption+'","'+horaf.Caption+'","'+tiempototal.Caption+'","'+responsable.Caption+'","'+ultimadomicilio+'")');
       ZQimportar.ExecSQL;
      {--------------------------------------------------------------------------------}
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQtrans.SQL.Add('Insert into t_datos_scaner_final (id_scan,fecha,hora,codigo,ruta) (Select id_scan,fecha,hora,codigo,ruta from t_datos_scaner where fecha="'+hoy+'")');
      ZQtrans.ExecSQL;
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQTrans.SQL.Add('Delete from t_datos_scaner');
      ZQtrans.ExecSQL;
      ZQentregados.Refresh;
      {-------------------Copiamos las inicidencias a la tabla de incidencia con el id de estadistica correspondiente-----------------------}
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQTrans.SQL.Add('Select max(id_estadistica)AS id from t_estadisticas_ruta');
      ZQtrans.ExecSQL;
      ZQtrans.Open;
      id:=ZQtrans.FieldByName('id').AsString;
       i:=0;
       ZQNoentregados.RecNo:=0;
       while i < ZQnoentregados.RecordCount do
          begin
              nosubscripcion:=ZQnoentregados.FieldByName('nosubscripcion').AsString;
              atenciona:=ZQNoentregados.FieldByName('atenciona').AsString;
              domicilio:=ZQNoentregados.FieldByName('direccion').AsString;
              idmotivo:=ZQNoentregados.FieldByName('id_motivo').AsString;
              motivoletra:=ZQNoentregados.FieldByName('Motivo').AsString;

              idMessage1.Body.Text:=idMessage1.Body.Text+atenciona+#13+domicilio+#13+'Motivo:'+motivoletra+#13#13;
              ZQtrans.Close;
              ZQtrans.SQL.Clear;
              ZQtrans.SQL.Add('Insert into t_incidencias_final (id_estadistica,nosubscripcion,atenciona,domicilio,id_motivo) VALUES ('+id+','+nosubscripcion+',"'+atenciona+'","'+domicilio+'",'+idmotivo+')');
              ZQtrans.ExecSQL;
              i:=i+1;
              ZQnoentregados.Next;
          end;  // fin del while ZQnoentregados

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

   {------------------Fin del envio del correo -----------------------------------------}
     try
      SysUtils.DeleteFile('BI300_ScanData.txt');
      SysUtils.DeleteFile(letra.Text+'\\BARCODES\\BARCODES.TXT');
     Except

     end;

      masuno.Checked:=FALSE;
      masuno.Enabled:=FALSE;
      ShowMessage('Se guardaron las estadisticas y las incidencias');
   {--------------------------------------------------------------------------------}
         end; //fin del else
        end    //
       else begin
          ShowMessage('No se puede cerrar la ruta hasta que indique un motivo de no entrega para todas las suscripciones faltantes');
       end;
    end;    //fin del if

end;

procedure TFEntregadeRuta.Codigodaado1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=3 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.Codigodaniado1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=3 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.CodigoFaltante1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=4 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.CodigoRobado1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=9 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      ZQtrans.Close;
      ZQtrans.SQL.Clear;
      ZQTrans.SQL.Add('Delete from t_datos_scaner');
      ZQtrans.ExecSQL;
end;

procedure TFEntregadeRuta.FormShow(Sender: TObject);
begin
  lfecha.Date:=now();
end;

procedure TFEntregadeRuta.Fuerzamayor1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=8 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.gridnoentregadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gridnoentregados.Fields[2].AsString='NO ESPECIFICADO' then
        begin
          gridnoentregados.Canvas.Brush.Color := clRed;
          gridnoentregados.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end
  else begin
       gridnoentregados.Canvas.Brush.Color := clWhite;
          gridnoentregados.DefaultDrawColumnCell(rect,DataCol,Column,State);
  end;

end;

procedure TFEntregadeRuta.limpiarClick(Sender: TObject);
begin
  cerrar.Enabled:=FALSE;
end;

procedure TFEntregadeRuta.masunoClick(Sender: TObject);
begin
  if masuno.Checked=TRUE then
    begin
      ShowMessage('Haga clic en Leer PIDIO nuevamente y luego en cargar datos tantas veces como sea necesario, cuando haya terminado de agregar datos puede cerrar la entrega');
    end;
end;

procedure TFEntregadeRuta.Nuevasuscripcion1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=2 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.Olvidodeentrega1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=7 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.RadioButton1Click(Sender: TObject);
begin
     responsable.Caption:='Supervisor';
end;

procedure TFEntregadeRuta.RadioButton2Click(Sender: TObject);
begin
   responsable.Caption:='Volante';
end;

procedure TFEntregadeRuta.RadioButton3Click(Sender: TObject);
begin
   responsable.Caption:='Ruta 6';
end;

procedure TFEntregadeRuta.rutaCloseUp(Sender: TObject);
begin

 if RUTA.Text<>'' then
   begin
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select Nombre from c_repartidores_choferes where id_repartidor= (Select id_responsable_ruta from c_rutas where no_ruta='+FloatToStr(ruta.KeyValue)+')');
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  responsable.Caption:=ZQtmp.FieldByName('Nombre').AsString;
   end;

end;

procedure TFEntregadeRuta.Salir1Click(Sender: TObject);
begin
    FEntregadeRuta.Close;
end;

procedure TFEntregadeRuta.Seestaimplementando1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=6 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.Sinaccesoaldomicilio1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=5 where nosubscripcion='+gridnoentregados.Fields[3].ASString);
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

procedure TFEntregadeRuta.Usarparatodos1Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=2');
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

procedure TFEntregadeRuta.Usarparatodos2Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=3');
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

procedure TFEntregadeRuta.Usarparatodos3Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=4');
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

procedure TFEntregadeRuta.Usarparatodos4Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=5');
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

procedure TFEntregadeRuta.Usarparatodos5Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=6');
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

procedure TFEntregadeRuta.Usarparatodos6Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=7');
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

procedure TFEntregadeRuta.Usarparatodos7Click(Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=8');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado1Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=2 where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado2Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=3 where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado3Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=4 where where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado4Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=5 where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado5Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=6 where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado6Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=7 where id_motivo=1');
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

procedure TFEntregadeRuta.Usarsoloparalosquenosehaindicado7Click(
  Sender: TObject);
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
  ZQtmp.SQL.Add('Update t_incidencias_tmp SET id_motivo=8 where id_motivo=1');
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

procedure TFEntregadeRuta.Volveracargardatosderuta1Click(Sender: TObject);
var
hoy:String;
begin
if application.MessageBox (pchar('¿Esta seguro que desea eliminar los datos procesados del dia de hoy para la ruta '+FloatToStr(ruta.KeyValue)+'?, Solo deberia hacer esto si ocurrio algun error en el procesamiento de la ruta'), pchar('Confirmar eliminar datos de ruta'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
  hoy:=FormatDateTime('yyyy-mm-dd',now());
  ZQimportar.Close;
  ZQImportar.SQL.Clear;
  ZQImportar.SQL.Add('Delete from t_datos_scaner_final where fecha="'+hoy+'" AND ruta='+FloatToStr(ruta.KeyValue));
  ZQImportar.ExecSQL;
           end;
end;

end.

