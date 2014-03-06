unit FSuspender_Entrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  ComCtrls, Grids, DBGrids,OleServer, Excel2000, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP;

type
  TFSuspenderEntrega = class(TForm)
    gridsubscripciones: TDBGrid;
    DSsubscripciones: TDataSource;
    DataSource2: TDataSource;
    calendario: TMonthCalendar;
    listafechas: TListBox;
    Button1: TButton;
    Button2: TButton;
    ZQtmp: TZQuery;
    bsubs: TEdit;
    batencion: TEdit;
    ZQsubscripciones: TZQuery;
    Label1: TLabel;
    sabados: TCheckBox;
    de: TDateTimePicker;
    a: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Aceptar: TButton;
    periodo: TCheckBox;
    domingos: TCheckBox;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    Label5: TLabel;
    gridfechas: TDBGrid;
    Button5: TButton;
    Button6: TButton;
    DSfechas: TDataSource;
    ZQfechas: TZQuery;
    programados: TCheckBox;
    exportar: TButton;
    Excel: TExcelApplication;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    ZQcorreos: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure sabadosClick(Sender: TObject);
    procedure domingosClick(Sender: TObject);
    procedure periodoClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure listafechasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bsubsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure batencionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridsubscripcionesCellClick(Column: TColumn);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure programadosClick(Sender: TObject);
    procedure exportarClick(Sender: TObject);
  private
    { Private declarations }
    seleccionado:integer;
    punto:tpoint;
  public
    { Public declarations }
  end;

var
  FSuspenderEntrega: TFSuspenderEntrega;

implementation

{$R *.dfm}
Uses
Fprincipal;


procedure TFSuspenderEntrega.AceptarClick(Sender: TObject);
var
i:integer;
fecha,correos,suscripcion,Direccion,Ruta,atenciona:String;
finicio,ffin:String;
begin
   if listafechas.Count=0 then
     begin
       ShowMessage('Debe indicar almenos una fecha en la que suspendera la entrega.');
     end
 else begin
if application.MessageBox(pchar('¿Esta seguro que desea suspender la entrega de la subscripción no:'+gridsubscripciones.Fields[0].AsString+' en los dias indicados?'),pchar('Confirmar suspender entrega'),(MB_YESNO + MB_ICONQUESTION)) =IDYES  then
    begin
   i:=0;
   punto.X:=1;
   punto.Y:=1;
   listafechas.ItemAtPos(punto,True);  //nos colocamos al inicio de la lista

   {-------------Para enviar el correo al supervisor------------------}
       ZQcorreos.close;
        ZQcorreos.SQL.Clear;
        ZQcorreos.SQL.Add('Select correo from c_correos_notificacion_noentrega');
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

     Suscripcion:=gridsubscripciones.Fields[0].AsString;
     direccion:=gridsubscripciones.Fields[4].AsString+','+gridsubscripciones.Fields[5].AsString;
     ruta:=gridsubscripciones.Fields[2].AsString;
     atenciona:=gridsubscripciones.Fields[1].AsString;

     IdMessage1.Recipients.EMailAddresses := correos;
     IdMessage1.From.Address := 'angcartagena@gmail.com';
     idMessage1.Subject:='Notificación de suspención de entrega de suscripcion';
     idMessage1.Body.Text:='Se le notifica que se suspendera la entrega de la suscripcion:'+suscripcion+#13+atenciona+#13+direccion+#13+'Ruta:'+ruta+#13+'En el periodo del ';

   i:=0;
  while i<=(listafechas.Count-1) do
     begin
   fecha:=listafechas.Items.Strings[i];

   {--- determinamos la fecha de inicio y la fecha de fin --------}
    if i=0 then
       begin
       finicio:=listafechas.Items.Strings[i];
       end;
    if i=(listafechas.Count-1) then
       begin
       ffin:=listafechas.Items.Strings[i];
      end;
  {--------------------------------------------------------------}

   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Insert into t_fechas_no_entrega_subscripcion (nosubscripcion,fecha) VALUES ('+gridsubscripciones.Fields[0].AsString+',"'+fecha+'")');
   ZQtmp.ExecSQL;

   if (punto.X <= listafechas.Count) then
       begin
       punto.X:=punto.x+1;
       end;
      i:=i+1;
     end;  // fin del while numero de fechas
    listafechas.Items.Clear;
    {----------------- envio del correo ------------------------}
    idMessage1.Body.Text:=idMessage1.Body.Text+finicio+' a '+ffin;
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

    ShowMessage('Se agregaron las fechas de suspensión correctamente');
   end;  // fin del if confirmar suspender entrega
 end;  // fin del else deben existir fechas en la lista

end;

procedure TFSuspenderEntrega.Button1Click(Sender: TObject);
var
i,dup:Integer;
begin
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select fecha,motivo from c_fechas_no_circulacion where fecha="'+ DateToStr(calendario.Date)+'"');
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  i:=0;
  dup:=0;
   if ZQtmp.FieldByName('fecha').IsNull=TRUE then
       begin
         while i<=listafechas.Items.Count-1 do
            begin
              if listafechas.Items[i]=DateToStr(calendario.Date) then
                 begin
                   dup:=1;
                   break;
                 end;
              i:=i+1;
          end;

      if dup=0 then
        begin
        listafechas.Items.Add(DateToStr(calendario.Date));
        end
      else begin
         ShowMessage('Esa fecha ya esta dada de alta');
      end;
     end
   Else begin
      ShowMessage('El dia indicado no se circula, Motivo:'+ZQtmp.FieldByName('motivo').AsString);
   end;

end;

procedure TFSuspenderEntrega.Button2Click(Sender: TObject);
begin
listafechas.Items.Delete(seleccionado);
end;

procedure TFSuspenderEntrega.Button3Click(Sender: TObject);
var
fechaactual,fechafin:TDateTime;
  i:integer;
const
  DiasSemana: array[1..7] of String = ('Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' );
const
  Mes: array[1..12] of String = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
begin
 fechaactual:=now();
 fechafin:=now()+365;

 if ((sabados.Checked= FALSE) AND (domingos.Checked=FALSE) AND (periodo.Checked=FALSE))  then
    begin
    ShowMessage('debe indicar almenos una condicion');
    end   // fin del if de checks vacios
   else begin

  if periodo.Checked=TRUE then
     begin
       while de.Date<=a.Date do
          begin
            listafechas.Items.Add(DateToStr(de.Date));
            de.Date:=de.Date+1;
          end; //fin del while periodo
     end  // fin del check periodo
   else begin
   ShowMessage('Se calcularan las fechas de un año apartir del dia de hoy');
     while fechaactual<=fechafin do
       begin
         if sabados.Checked=TRUE then
             begin
                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Sabado' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;
             end;   // fin del if sabado

         if domingos.Checked=TRUE then
               begin
                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Domingo' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;
               end; // fin del if domingo
        fechaactual:=fechaactual+1;
       end; //fin del while fecha actual<fechafin
     end;



   end;  //fin del else de checks vacios

end;  procedure TFSuspenderEntrega.Button4Click(Sender: TObject);
begin
  listafechas.Items.Clear;
end;

procedure TFSuspenderEntrega.Button5Click(Sender: TObject);
begin
if application.MessageBox(pchar('¿Esta seguro que desea eliminar todas las fechas de suspensión?'),pchar('Confirmar eliminar listado de fechas'),(MB_YESNO + MB_ICONQUESTION)) =IDYES  then
    begin
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Delete from t_fechas_no_entrega_subscripcion where nosubscripcion='+gridsubscripciones.Fields[0].AsString+' AND fecha="'+gridfechas.Fields[0].AsString+'"');
   ZQtmp.ExecSQL;
   ZQfechas.Close;
   ZQfechas.SQL.Clear;
   ZQfechas.SQL.Add('Select fecha from t_fechas_no_entrega_subscripcion where nosubscripcion='+gridsubscripciones.Fields[0].AsString);
   ZQfechas.ExecSQL;
   ZQfechas.Open;
   gridfechas.Refresh;
    end;
end;

procedure TFSuspenderEntrega.Button6Click(Sender: TObject);
begin
if application.MessageBox(pchar('¿Esta seguro que desea eliminar esta ficha del listado?'),pchar('Eliminar fecha'),(MB_YESNO + MB_ICONQUESTION)) =IDYES  then
    begin
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Delete from t_fechas_no_entrega_subscripcion where nosubscripcion='+gridsubscripciones.Fields[0].AsString);
   ZQtmp.ExecSQL;
   ZQfechas.Close;
   ZQfechas.SQL.Clear;
   ZQfechas.SQL.Add('Select fecha from t_fechas_no_entrega_subscripcion where nosubscripcion='+gridsubscripciones.Fields[0].AsString);
   ZQfechas.ExecSQL;
   ZQfechas.Open;
   gridfechas.Refresh;
    end;
end;

procedure TFSuspenderEntrega.exportarClick(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Listado de suscripciones con suspencion de entrega ';
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Dirección';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Ruta';
 Hoja.Cells.Item[4,5].ColumnWidth := 15;



 with ZQsubscripciones do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridsubscripciones.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=gridsubscripciones.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=gridsubscripciones.Fields[4].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=gridsubscripciones.Fields[2].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
        end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total  '+IntToStr(ZQsubscripciones.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;


end;

procedure TFSuspenderEntrega.programadosClick(Sender: TObject);
begin
    if programados.Checked=FALSE then
       begin
           Exportar.Enabled:=FALSE;
           ZQSubscripciones.Close;
           ZQSubscripciones.SQL.Clear;
           ZQSubscripciones.SQL.Add('Select Nosubscripcion,AtencionA,ruta,(Select descripcion from c_edificios where edificio=id_edificio)AS Edificio,Telefono,Observaciones,(Select calle from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)');
           ZQSubscripciones.SQL.Add('AS calle,(Select colonia from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)AS Colonia, (Select descripcion_domicilio from t_descripcion_rutas');
           ZQSubscripciones.SQL.Add(' where no_de_subscripcion=nosubscripcion)AS Descripcion from t_subscripcion');
           ZQSubscripciones.ExecSQL;
           ZQSubscripciones.Open;
           gridsubscripciones.Refresh;
       end;
    if programados.Checked=TRUE then
       begin
            exportar.Enabled:=TRUE;
           ZQSubscripciones.Close;
           ZQSubscripciones.SQL.Clear;
           ZQSubscripciones.SQL.Add('Select * from v_suspendida_entrega');
           ZQSubscripciones.ExecSQL;
           ZQSubscripciones.Open;
           gridsubscripciones.Refresh;
       end;

end;

procedure TFSuspenderEntrega.domingosClick(Sender: TObject);
begin
   periodo.Checked:=FALSE;
end;

procedure TFSuspenderEntrega.batencionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  filtro:String;
begin
 if batencion.text<>'' then
   begin
  filtro:='"Atenciona" LIKE '+quotedstr('*'+batencion.Text+'*');
  ZQsubscripciones.Filter:=filtro;
  ZQsubscripciones.Filtered:=TRUE;
   end
   else begin
    ZQsubscripciones.Filtered:=FALSE;
   end;
end;

procedure TFSuspenderEntrega.bsubsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  filtro:String;
begin
 if bsubs.Text<>'' then
   begin
  filtro:='nosubscripcion = '+bsubs.Text;
  ZQsubscripciones.Filter:=filtro;
  ZQsubscripciones.Filtered:=TRUE;
   end
   else begin
    ZQsubscripciones.Filtered:=FALSE;
   end;
end;

procedure TFSuspenderEntrega.FormShow(Sender: TObject);
begin
  de.Date:=now();
  a.Date:=now();
  calendario.Date:=now();
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select Nosubscripcion,AtencionA,ruta,(Select descripcion from c_edificios where edificio=id_edificio)AS Edificio,Telefono,Observaciones,(Select calle from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)');
   ZQSubscripciones.SQL.Add('AS calle,(Select colonia from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)AS Colonia, (Select descripcion_domicilio from t_descripcion_rutas');
   ZQSubscripciones.SQL.Add(' where no_de_subscripcion=nosubscripcion)AS Descripcion from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

end;

procedure TFSuspenderEntrega.gridsubscripcionesCellClick(Column: TColumn);
begin
   ZQfechas.Close;
   ZQfechas.SQL.Clear;
   ZQfechas.SQL.Add('Select fecha from t_fechas_no_entrega_subscripcion where nosubscripcion='+gridsubscripciones.Fields[0].AsString);
   ZQfechas.ExecSQL;
   ZQfechas.Open;
   gridfechas.Refresh;
end;

procedure TFSuspenderEntrega.listafechasMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
punto.x:=x;
punto.y:=y;
seleccionado:=listafechas.ItemAtPos(punto, True);
end;

procedure TFSuspenderEntrega.periodoClick(Sender: TObject);
begin
    sabados.Checked:=FALSE;
    domingos.Checked:=FALSE;
end;

procedure TFSuspenderEntrega.sabadosClick(Sender: TObject);
begin
   periodo.Checked:=FALSE;
end;


//Fin del boton aceptar

end.
