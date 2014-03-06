unit FSeguimiento_Cambios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  StdCtrls, jpeg, ExtCtrls, DBCtrls,OleServer, Excel2000;

type
  TFSeguimientoCambios = class(TForm)
    gridsubs: TDBGrid;
    ZQsubs: TZQuery;
    DSsubs: TDataSource;
    ZQAtendido: TZQuery;
    Button3: TButton;
    Button4: TButton;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    direccionn: TLabel;
    direcciona: TLabel;
    ZQdir: TZQuery;
    ya: TButton;
    Label4: TLabel;
    Button6: TButton;
    ruta: TDBLookupComboBox;
    ZQtmp: TZQuery;
    ZQruta: TZQuery;
    DSruta: TDataSource;
    Button7: TButton;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ZQsubsAfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure yaClick(Sender: TObject);
    procedure rutaCloseUp(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridsubsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
     diasadverenciaaltas:integer;
   coloradvertenciaalta:Tcolor;

   diasincidenciaaltas:integer;
   colorincidenciaalta:Tcolor;

   diasadvertenciaqueja:integer;
   coloradvertenciaqueja:Tcolor;

   diasincidenciaqueja:integer;
   colorincidenciaqueja:Tcolor;

   diasadvertenciacambio:integer;
   coloradvertenciacambio:Tcolor;

   diasincidenciacambio:integer;
   colorincidenciacambio:Tcolor;

        no_de_subscripcion_public:String;
  end;

var
  FSeguimientoCambios: TFSeguimientoCambios;

implementation

{$R *.dfm}
Uses
FPrincipal,FNotasSubscripcion,FverNotas,FR_Notificacion_alta,FR_Alta_subscripcion;

procedure TFSeguimientoCambios.Button1Click(Sender: TObject);
begin
if application.MessageBox (pchar('¿Esta seguro de querer marcar como atendida la subscripcion '+gridsubs.Fields[0].AsString+'?'), pchar('Confirmar "Atendido"'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
  FprincipalCirculacion.quienllamanotas:=2;

   FNotas.Enabled:=FALSE;
   Fnotas := TFnotas.Create(self);
   Fnotas.ShowModal;

  {----  Refrescamos el grid ------}
   ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS Atenciona,Direccion,Fecha_Cambio,Fecha_Atencion from t_cambios_domicilio Where Atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;
           end;

end;

procedure TFSeguimientoCambios.Button2Click(Sender: TObject);
begin
     FNotas.Enabled:=FALSE;
   Fnotas := TFnotas.Create(self);
   Fnotas.ShowModal;
end;

procedure TFSeguimientoCambios.Button3Click(Sender: TObject);
begin
  FVer.Enabled:=FALSE;
 FVer:= TFver.Create(self);
 FVer.ShowModal;
end;

procedure TFSeguimientoCambios.Button4Click(Sender: TObject);
var
folio:String;
edif:String;
begin

  no_de_subscripcion_public:= gridsubs.Fields[0].AsString;
  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select Max(Folio)AS folio from t_cambio_domicilio where NoSubscripcion='+gridsubs.Fields[0].ASString);
  ZQatendido.ExecSQL;
  ZQatendido.Open;

   ZQtmp.Close;
 ZQtmp.SQL.Clear;
 ZQtmp.SQL.Add('Select NoSubscripcion,Edificio,Ruta from t_subscripcion where nosubscripcion='+no_de_subscripcion_public);
 ZQtmp.ExecSQL;
 ZQtmp.Open;


  if ZQatendido.FieldByName('folio').IsNull=FALSE then
     begin
   folio:=ZQatendido.FieldByName('folio').AsString;
   FRNotificacionalta.Enabled:=FALSE;
   FRNotificacionalta := TFRNotificacionalta.Create(self);

 if ZQtmp.FieldByName('Edificio').AsInteger=0 then
    begin
  no_de_subscripcion_public := gridsubs.Fields[0].AsString;
  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
  ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQatendido.ExecSQL;
  ZQatendido.Open;

  FRNotificacionalta.fechainicio.Caption:=ZQatendido.FieldByName('fecha_inicio').AsString;
  FRNotificacionalta.nosubscriptor.Caption:=ZQatendido.FieldByName('nosubscripcion').AsString;
  FRNotificacionalta.nombre.Caption:=ZQatendido.FieldByName('atenciona').AsString;
  FRNotificacionalta.telefono.Caption:=ZQatendido.FieldByName('telefono').AsString;
  FRNotificacionalta.calle.Caption:=ZQatendido.FieldByName('calle').AsString;
  FRNotificacionalta.ruta.Caption:=ZQatendido.FieldByName('ruta').AsString;
  FRNotificacionalta.colonia.Caption:=ZQatendido.FieldByName('colonia').AsString;
  FRNotificacionalta.cp.Caption:=ZQatendido.FieldByName('cp').AsString;
  FRNotificacionalta.ciudad.Caption:=ZQatendido.FieldByName('ciudad').AsString;
  FRNotificacionalta.observaciones.Caption:=ZQatendido.FieldByName('observaciones').AsString;
  FRNotificacionalta.descripcion.Caption:=ZQatendido.FieldByName('descripcion_domicilio').AsString;
  FRNotificacionalta.folio.caption:=folio;
  FRNotificacionalta.Notificacion.Prepare;
  FRNotificacionalta.Notificacion.Preview;
       end;
 if ZQtmp.FieldByName('Edificio').AsInteger>0 then
    begin
   // ShowMessage('Se cambio el domicilio a un edificio');
    no_de_subscripcion_public := gridsubs.Fields[0].AsString;
  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select t_subscripcion.nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,area,(Select descripcion from c_edificios where c_edificios.id_edificio=');
  ZQatendido.SQL.Add('t_subscripcion.edificio)AS Edificio from t_subscripcion JOIN t_descripcion_ruta_edificio ON (t_subscripcion.nosubscripcion = t_descripcion_ruta_edificio.nosubscripcion)');
  ZQatendido.SQL.Add('where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQatendido.ExecSQL;
  ZQatendido.Open;

  FRNotificacionalta.fechainicio.Caption:=ZQatendido.FieldByName('fecha_inicio').AsString;
  FRNotificacionalta.nosubscriptor.Caption:=ZQatendido.FieldByName('nosubscripcion').AsString;
  FRNotificacionalta.nombre.Caption:=ZQatendido.FieldByName('atenciona').AsString;
  FRNotificacionalta.telefono.Caption:=ZQatendido.FieldByName('telefono').AsString;
  FRNotificacionalta.calle.Caption:=ZQatendido.FieldByName('Edificio').AsString;
  FRNotificacionalta.ruta.Caption:=ZQatendido.FieldByName('ruta').AsString;
  FRNotificacionalta.colonia.Caption:=ZQatendido.FieldByName('Area').AsString;
 // FRNotificacionalta.cp.Caption:=ZQAlta.FieldByName('cp').AsString;
 // FRNotificacionalta.ciudad.Caption:=ZQAlta.FieldByName('ciudad').AsString;
  FRNotificacionalta.observaciones.Caption:=ZQatendido.FieldByName('observaciones').AsString;
 // FRNotificacionalta.descripcion.Caption:=ZQAlta.FieldByName('descripcion_domicilio').AsString;
  FRNotificacionalta.folio.caption:=folio;
  //FRNotificacionalta.user.Caption:='Jefe circulación';
  FRNotificacionalta.Notificacion.Prepare;
  FRNotificacionalta.Notificacion.Preview;
   end;
      end
    else begin
      ShowMessage('No se han encontrado cambios de domicilio para esta dirección');
    end;
end;

procedure TFSeguimientoCambios.yaClick(Sender: TObject);
begin
if ya.Caption='Ver ya atendidos' then
  begin
  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS Atenciona,Direccion,Fecha_Cambio,Fecha_Atencion from t_cambios_domicilio Where Atendido="S"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;
  ya.Caption:='Ver no atendidos';
  end
 else begin
  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS Atenciona,Direccion,Fecha_Cambio,Fecha_Atencion from t_cambios_domicilio Where Atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;
  ya.Caption:='Ver ya atendidos';
 end;
end;

procedure TFSeguimientoCambios.Button6Click(Sender: TObject);
begin
    ZQsubs.Filtered:=FALSE;
end;

procedure TFSeguimientoCambios.Button7Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;
   if ruta.Text='ruta' then
     begin
    Hoja.Cells.Item[2,3]:='Listado de cambios de domicilio ';
     end;
   if ruta.Text<>'ruta' then
     begin
    Hoja.Cells.Item[2,3]:='Listado de cambios de domicilio en ruta '+ruta.Text;
     end;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Dirección';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Ruta';
 Hoja.Cells.Item[4,5].ColumnWidth := 15;
 Hoja.Cells.Item[4,6]:='Fecha Cambio';
 Hoja.Cells.Item[4,6].ColumnWidth := 25;
 Hoja.Cells.Item[4,7]:='Fecha Atención';
 Hoja.Cells.Item[4,7].ColumnWidth := 25;



 with ZQsubs do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=GridSubs.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=GridSubs.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=GridSubs.Fields[2].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=GridSubs.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=GridSubs.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=GridSubs.Fields[5].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total  '+IntToStr(ZQSubs.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;


end;

procedure TFSeguimientoCambios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     FPrincipalCirculacion.GridQuejas.Refresh;
     FPrincipalCirculacion.ZQQuejas.Refresh;
     FPrincipalCirculacion.GridSubs.Refresh;
     FPrincipalCirculacion.ZQSubs.Refresh;
     FPrincipalCirculacion.ZQAltas.Refresh;
     FPrincipalCirculacion.GridAltas.Refresh;
     FPrincipalCirculacion.GridCancelados.Refresh;
     FPrincipalCirculacion.ZQCancelados.Refresh;
end;

procedure TFSeguimientoCambios.FormShow(Sender: TObject);
var
fechahoy,fechasiete,folio:String;
begin
  fechahoy:= (FormatDateTime('yyyy-mm-dd',Now()));
  fechasiete:=(FormatDateTime('yyyy-mm-dd',Now()-60));

  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS Atenciona,Direccion,');
  ZQsubs.SQL.Add('(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS  Ruta,Fecha_Cambio,Fecha_Atencion from t_cambios_domicilio Where Atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;

 {----------------------------------------------------------------}
  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select Max(Folio)AS folio from t_cambio_domicilio where NoSubscripcion='+gridsubs.Fields[0].ASString);
  ZQatendido.ExecSQL;
  ZQatendido.Open;
  if ZQatendido.FieldByName('folio').IsNull=FALSE then
     begin
  //ipo.Caption:='Cambio de domicilio';
   folio:=ZQatendido.FieldByName('folio').AsString;
   FRNotificacionalta.Enabled:=FALSE;
   FRNotificacionalta := TFRNotificacionalta.Create(self);

//no_de_subscripcion_public := gridsubs.Fields[0].AsString;
{  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
  ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQatendido.ExecSQL;
  ZQatendido.Open;          }

//Nueva.Caption:='Ruta'+ZQatendido.FieldByName('ruta').AsString+','+ZQatendido.FieldByName('calle').AsString+','+ZQatendido.FieldByName('colonia').AsString+','+ZQatendido.FieldByName('descripcion_domicilio').AsString;

    ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select rutao,direccion from t_cambio_domicilio where folio='+folio);
  ZQatendido.ExecSQL;
  ZQatendido.Open;

//Anterior.Caption:='Ruta:'+ZQAtendido.FieldByName('Rutao').AsString+','+ZQAtendido.FieldByName('direccion').AsString;

      end
    else begin
 //  tipo.Caption:='Nueva subscripcion';
    end;

 {----------------------------------------------------------------}
end;

procedure TFSeguimientoCambios.gridsubsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if (((GridSubs.Fields[4].AsDateTime)<=now()-FprincipalCirculacion.diasadvertenciacambio) )then
        begin
          GridSubs.Canvas.Brush.Color := FprincipalCirculacion.coloradvertenciaalta;
          GridSubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((GridSubs.Fields[4].AsDateTime)<=now()-FprincipalCirculacion.diasincidenciacambio) )then
    begin
      GridSubs.Canvas.Brush.Color := FprincipalCirculacion.colorincidenciaalta;
      GridSubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end;
end;

procedure TFSeguimientoCambios.rutaCloseUp(Sender: TObject);
begin
 ZQSubs.Filter:='Ruta='+FloatToStr(ruta.KeyValue);
  ZQSubs.Filtered:=TRUE;
  GridSubs.Refresh;

  {----------------------------------------------------------------}

  if gridsubs.Fields[0].AsString<>'' then
    begin
   ZQdir.Close;
   ZQdir.SQL.Clear;
   ZQdir.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_cambio_domicilio.edificio) AS Edificio,Direccion from t_cambio_domicilio where nosubscripcion='+gridsubs.Fields[0].AsString);
   ZQDir.ExecSQL;
   ZQdir.Open;
   no_de_subscripcion_public:= gridsubs.Fields[0].AsString;
   direcciona.Caption:=ZQdir.FieldByName('Edificio').AsString+','+ZQdir.FieldByName('Direccion').AsString;
   direccionn.Caption:=gridsubs.Fields[2].AsString;
    end;
 {----------------------------------------------------------------}
end;

procedure TFSeguimientoCambios.ZQsubsAfterScroll(DataSet: TDataSet);
begin
   ZQdir.Close;
   ZQdir.SQL.Clear;
   ZQdir.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_cambio_domicilio.edificio) AS Edificio,Direccion from t_cambio_domicilio where nosubscripcion='+gridsubs.Fields[0].AsString);
   ZQDir.ExecSQL;
   ZQdir.Open;
   no_de_subscripcion_public:= gridsubs.Fields[0].AsString;
   direcciona.Caption:=ZQdir.FieldByName('Edificio').AsString+','+ZQdir.FieldByName('Direccion').AsString;
   direccionn.Caption:=gridsubs.Fields[2].AsString;
end;

end.
