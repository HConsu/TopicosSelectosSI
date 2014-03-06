unit FSeguimientoAltas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, jpeg,
  ExtCtrls, Grids, DBGrids, DBCtrls, OleServer, Excel2000;

type
  TFSeguimientoA = class(TForm)
    gridsubs: TDBGrid;
    Image1: TImage;
    Label1: TLabel;
    ZQSubs: TZQuery;
    DSsubs: TDataSource;
    Button1: TButton;
    Button3: TButton;
    ZQatendido: TZQuery;
    ZQbitacora: TZQuery;
    tipo: TLabel;
    nueva: TLabel;
    Label3: TLabel;
    Button5: TButton;
    ya: TButton;
    ZQtmp: TZQuery;
    Label2: TLabel;
    ruta: TDBLookupComboBox;
    Button4: TButton;
    DSrutas: TDataSource;
    ZQrutas: TZQuery;
    Button7: TButton;
    Excel: TExcelApplication;
    total: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridsubsDblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure gridsubsCellClick(Column: TColumn);
    procedure ZQSubsAfterScroll(DataSet: TDataSet);
    procedure Button5Click(Sender: TObject);
    procedure yaClick(Sender: TObject);
    procedure rutaCloseUp(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DSsubsDataChange(Sender: TObject; Field: TField);
    procedure gridsubsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    no_de_subscripcion_public:String;
  end;

var
  FSeguimientoA: TFSeguimientoA;

implementation

{$R *.dfm}
Uses
FPrincipal,FNotasSubscripcion,FverNotas,FR_Notificacion_alta,FR_Alta_subscripcion;

procedure TFSeguimientoA.Button1Click(Sender: TObject);
var
atendido:String;
fechahoy,fechasiete:String;
begin
FprincipalCirculacion.quienllamanotas:=1;

fechahoy:= (FormatDateTime('yyyy-mm-dd',Now()));
fechasiete:=(FormatDateTime('yyyy-mm-dd',Now()-60));


if application.MessageBox (pchar('�Esta seguro de querer marcar como atendida la subscripcion '+gridsubs.Fields[0].AsString+'?'), pchar('Confirmar "Atendido"'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
        atendido:=(FormatDateTime('yyyy-mm-dd',Now()-61));
        ZQatendido.Close;
        ZQAtendido.SQL.Clear;
        ZQAtendido.SQL.Add('Update t_subscripcion SET fechamodif="'+atendido+' 00:00:00" where nosubscripcion='+GridSubs.Fields[0].AsString);
        ZQAtendido.ExecSQL;

   {---Marcamos como atendida la subscripcion en t_altas}

   FNotas.Enabled:=FALSE;
   Fnotas := TFnotas.Create(self);
   Fnotas.ShowModal;

  {--------------Bitacora------------------------}
  ZQBitacora.Close;
  ZQBitacora.SQL.Clear;
  ZQbitacora.SQL.Add('Insert into b_supervisor_circulacion (descripcion) VALUES ("Se marco como atendida la subscripcion '+gridsubs.Fields[0].AsString+' que estaba como modificada")');
  ZQbitacora.ExecSQL;
  {---------------Bitacora--------------------------}
       {----Actualizar el grid-------}
        ZQSubs.Close;
        ZQSubs.SQL.Clear;
        ZQsubs.SQL.Add('Select t_altas.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)AS Atenciona');
        ZQsubs.SQL.Add(',Direccion,(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion) AS  Ruta,fecha_alta AS Fecha_Alta,Fecha_Atencion from t_altas where atendido="N"');
        ZQSubs.ExecSQL;
        ZQSubs.Open;
        ZQSubs.Active:=TRUE;
        GridSubs.Refresh;
        {-----------------------------}

           end;


end;

procedure TFSeguimientoA.Button2Click(Sender: TObject);
begin
   FNotas.Enabled:=FALSE;
   Fnotas := TFnotas.Create(self);
   Fnotas.ShowModal;

end;

procedure TFSeguimientoA.Button3Click(Sender: TObject);
begin
 FVer.Enabled:=FALSE;
 FVer:= TFver.Create(self);
 FVer.ShowModal;
end;

procedure TFSeguimientoA.Button4Click(Sender: TObject);
begin
ZQsubs.Filtered:=FALSE;
end;

procedure TFSeguimientoA.Button5Click(Sender: TObject);
var
edif:String;
begin

 no_de_subscripcion_public := gridsubs.Fields[0].AsString;
 ZQtmp.Close;
 ZQtmp.SQL.Clear;
 ZQtmp.SQL.Add('Select NoSubscripcion,Edificio,Ruta from t_subscripcion where nosubscripcion='+no_de_subscripcion_public);
 ZQtmp.ExecSQL;
 ZQtmp.Open;


  if ZQtmp.FieldByName('Edificio').AsInteger=0 then
    begin
    FRAltaSubscripcion.descripcion.Caption:='';
   //ShowMessage(ZQtmp.FieldByName('Edificio').AsString);
   ZQatendido.Close;
   ZQatendido.SQL.Clear;
   ZQatendido.SQL.Add('Select nosubscripcion,nosubscriptor,Atenciona,Ruta,edificio,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
   ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
   ZQatendido.ExecSQL;
   ZQatendido.Open;

  FRAltaSubscripcion.fechainicio.Caption:=ZQatendido.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQatendido.FieldByName('nosubscriptor').AsString;
  FRAltaSubscripcion.nosubscripcion.Caption:=ZQatendido.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQatendido.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQatendido.FieldByName('telefono').AsString;
  FRAltaSubscripcion.calle.Caption:=ZQatendido.FieldByName('calle').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQatendido.FieldByName('ruta').AsString;
  FRAltaSubscripcion.colonia.Caption:=ZQatendido.FieldByName('colonia').AsString;
  FRAltaSubscripcion.cp.Caption:=ZQatendido.FieldByName('cp').AsString;
  FRAltaSubscripcion.ciudad.Caption:=ZQatendido.FieldByName('ciudad').AsString;
  FRAltaSubscripcion.observaciones.Caption:=ZQatendido.FieldByName('observaciones').AsString;
  FRAltaSubscripcion.descripcion.Caption:=ZQatendido.FieldByName('descripcion_domicilio').AsString;
  //FRAltaSubscripcion.user.Caption:='Supervisor';
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;
    end;
 if ZQtmp.FieldByName('Edificio').AsInteger>0 then
    begin
   FRAltaSubscripcion.descripcion.Caption:='';
   edif:=ZQtmp.FieldByName('Edificio').AsString;
   ZQatendido.Close;
   ZQatendido.SQL.Clear;
   ZQatendido.SQL.Add('Select descripcion from c_edificios where id_edificio='+edif);
   ZQatendido.ExecSQL;
   ZQatendido.Open;
   FRAltaSubscripcion.calle.Caption:=ZQatendido.FieldByName('descripcion').AsString;

   ZQatendido.Close;
   ZQatendido.SQL.Clear;
   ZQatendido.SQL.Add('Select t_subscripcion.nosubscripcion,nosubscriptor,Atenciona,Ruta,Fecha_inicio,Telefono,observaciones,area from t_subscripcion JOIN t_descripcion_ruta_edificio ON ');
   ZQatendido.SQL.Add('(t_subscripcion.nosubscripcion = t_descripcion_ruta_edificio.nosubscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public );
   ZQatendido.ExecSQL;
   ZQatendido.Open;

  FRAltaSubscripcion.colonia.Caption:=ZQatendido.FieldByName('area').AsString;
  FRAltaSubscripcion.fechainicio.Caption:=ZQatendido.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQatendido.FieldByName('nosubscriptor').AsString;
  FRAltaSubscripcion.nosubscripcion.Caption:=ZQatendido.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQatendido.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQatendido.FieldByName('telefono').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQatendido.FieldByName('ruta').AsString;
  //FRAltaSubscripcion.user.Caption:='Supervisor';
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;
    end;

end;

procedure TFSeguimientoA.Button7Click(Sender: TObject);
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
    Hoja.Cells.Item[2,3]:='Listado de altas ';
     end;
   if ruta.Text<>'ruta' then
     begin
    Hoja.Cells.Item[2,3]:='Listado de altas en ruta '+ruta.Text;
     end;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Direcci�n';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Ruta';
 Hoja.Cells.Item[4,5].ColumnWidth := 15;
 Hoja.Cells.Item[4,6]:='Fecha Alta';
 Hoja.Cells.Item[4,6].ColumnWidth := 25;
 Hoja.Cells.Item[4,7]:='Fecha Atenci�n';
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

procedure TFSeguimientoA.DSsubsDataChange(Sender: TObject; Field: TField);
begin
total.Caption:='Total mostrados:'+IntToStr(ZQsubs.RecordCount);
end;

procedure TFSeguimientoA.yaClick(Sender: TObject);
begin
if ya.Caption='Ver Altas ya atendidas' then
  begin
       {----Actualizar el grid-------}
         ZQSubs.Close;
          ZQSubs.SQL.Clear;
          ZQsubs.SQL.Add('Select t_altas.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)AS Atenciona');
          ZQsubs.SQL.Add(',(Select Calle from t_descripcion_rutas where t_descripcion_rutas.no_de_subscripcion=t_altas.nosubscripcion) AS Direccion,(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)');
          ZQsubs.SQL.Add(' AS  Ruta,fecha_alta AS Fecha_Alta,Fecha_Atencion from t_altas where atendido="S"');
          ZQSubs.ExecSQL;
          ZQSubs.Open;
          ZQSubs.Active:=TRUE;
          GridSubs.Refresh;

        ya.Caption:='Ver no atendidos';
        {-----------------------------}
  end
  else begin
          {----Actualizar el grid-------}
                 ZQSubs.Close;
          ZQSubs.SQL.Clear;
          ZQsubs.SQL.Add('Select t_altas.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)AS Atenciona');
          ZQsubs.SQL.Add(',(Select Calle from t_descripcion_rutas where t_descripcion_rutas.no_de_subscripcion=t_altas.nosubscripcion) AS Direccion,(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)');
          ZQsubs.SQL.Add(' AS  Ruta,fecha_alta AS Fecha_Alta,Fecha_Atencion from t_altas where atendido="N"');
          ZQSubs.ExecSQL;
        ZQSubs.Open;
        ZQSubs.Active:=TRUE;
        GridSubs.Refresh;
        ya.Caption:='Ver ya atendidos';
        {-----------------------------}
  end;
end;

procedure TFSeguimientoA.rutaCloseUp(Sender: TObject);
begin
  ZQSubs.Filter:='Ruta='+FloatToStr(ruta.KeyValue);
  ZQSubs.Filtered:=TRUE;
  GridSubs.Refresh;

  {----------------------------------------------------------------}

  if gridsubs.Fields[0].AsString<>'' then
    begin
  no_de_subscripcion_public := gridsubs.Fields[0].AsString;
  if gridsubs.Fields[2].AsString<>'' then
      begin

        ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
        ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('ruta').AsString+','+ZQatendido.FieldByName('calle').AsString+','+ZQatendido.FieldByName('colonia').AsString+','+ZQatendido.FieldByName('descripcion_domicilio').AsString;
      end
    else begin
         ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select no_ruta,(Select descripcion from c_edificios ');
        ZQatendido.SQL.Add(' where t_descripcion_ruta_edificio.id_edificio=c_edificios.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('no_ruta').AsString+', Edificio: '+ZQatendido.FieldByName('Edificio').AsString+','+ZQatendido.FieldByName('area').AsString;
    end;
 // Anterior.Caption:='Ruta:'+ZQAtendido.FieldByName('Rutao').AsString+','+ZQAtendido.FieldByName('direccion').AsString;
  tipo.Caption:='Nueva subscripcion';
    end;
 {----------------------------------------------------------------}
end;

procedure TFSeguimientoA.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFSeguimientoA.FormShow(Sender: TObject);
var
fechahoy,fechasiete,folio:String;
begin
  fechahoy:= (FormatDateTime('yyyy-mm-dd',Now()));
  fechasiete:=(FormatDateTime('yyyy-mm-dd',Now()-60));


  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQsubs.SQL.Add('Select t_altas.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)AS Atenciona');
  ZQsubs.SQL.Add(',(Select Calle from t_descripcion_rutas where t_descripcion_rutas.no_de_subscripcion=t_altas.nosubscripcion) AS Direccion,(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)');
  ZQsubs.SQL.Add(' AS  Ruta,fecha_alta AS Fecha_Alta,Fecha_Atencion from t_altas where atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;

 {----------------------------------------------------------------}

  no_de_subscripcion_public := gridsubs.Fields[0].AsString;
  ZQatendido.Close;
  ZQatendido.SQL.Clear;
  ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
  ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQatendido.ExecSQL;
  ZQatendido.Open;

  Nueva.Caption:='Ruta'+ZQatendido.FieldByName('ruta').AsString+','+ZQatendido.FieldByName('calle').AsString+','+ZQatendido.FieldByName('colonia').AsString+','+ZQatendido.FieldByName('descripcion_domicilio').AsString;


 // Anterior.Caption:='Ruta:'+ZQAtendido.FieldByName('Rutao').AsString+','+ZQAtendido.FieldByName('direccion').AsString;
  tipo.Caption:='Nueva subscripcion';
 {----------------------------------------------------------------}

end;

procedure TFSeguimientoA.gridsubsCellClick(Column: TColumn);
begin
{----------------------------------------------------------------}
  nueva.Caption:='';

  tipo.Font.Color:=clBlue;
  tipo.Caption:='Nueva subscripcion';
  {----------------------------------------------------------------}

  if gridsubs.Fields[0].AsString<>'' then
    begin
  no_de_subscripcion_public := gridsubs.Fields[0].AsString;

    if gridsubs.Fields[2].AsString<>'' then
      begin

        ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
        ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('ruta').AsString+','+ZQatendido.FieldByName('calle').AsString+','+ZQatendido.FieldByName('colonia').AsString+','+ZQatendido.FieldByName('descripcion_domicilio').AsString;
      end
    else begin
         ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select no_ruta,(Select descripcion from c_edificios ');
        ZQatendido.SQL.Add(' where t_descripcion_ruta_edificio.id_edificio=c_edificios.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('no_ruta').AsString+', Edificio: '+ZQatendido.FieldByName('Edificio').AsString+','+ZQatendido.FieldByName('area').AsString;
    end;


 // Anterior.Caption:='Ruta:'+ZQAtendido.FieldByName('Rutao').AsString+','+ZQAtendido.FieldByName('direccion').AsString;
  tipo.Caption:='Nueva subscripcion';
    end;
 {----------------------------------------------------------------}
end;

procedure TFSeguimientoA.gridsubsDblClick(Sender: TObject);
begin
if gridsubs.Fields[0].AsString<>'' then
  begin
 FVer.Enabled:=FALSE;
 FVer:= TFver.Create(self);
 FVer.ShowModal;
  end;
end;

procedure TFSeguimientoA.gridsubsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (((gridsubs.Fields[4].AsDateTime)<=now()-FprincipalCirculacion.diasadverenciaaltas) )then
        begin
          gridsubs.Canvas.Brush.Color := FprincipalCirculacion.coloradvertenciaalta;
          gridsubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((gridsubs.Fields[4].AsDateTime)<=now()-FprincipalCirculacion.diasadverenciaaltas) )then
    begin
      gridsubs.Canvas.Brush.Color := FprincipalCirculacion.colorincidenciaalta;
      gridsubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end;
end;

procedure TFSeguimientoA.ZQSubsAfterScroll(DataSet: TDataSet);
begin
{----------------------------------------------------------------}
  nueva.Caption:='';

  tipo.Font.Color:=clBlue;
  tipo.Caption:='Nueva subscripcion';
  {----------------------------------------------------------------}

  if gridsubs.Fields[0].AsString<>'' then
    begin
  no_de_subscripcion_public := gridsubs.Fields[0].AsString;

    if gridsubs.Fields[2].AsString<>'' then
      begin

        ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
        ZQatendido.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('ruta').AsString+','+ZQatendido.FieldByName('calle').AsString+','+ZQatendido.FieldByName('colonia').AsString+','+ZQatendido.FieldByName('descripcion_domicilio').AsString;
      end
    else begin
         ZQatendido.Close;
        ZQatendido.SQL.Clear;
        ZQatendido.SQL.Add('Select no_ruta,(Select descripcion from c_edificios ');
        ZQatendido.SQL.Add(' where t_descripcion_ruta_edificio.id_edificio=c_edificios.id_edificio)AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+no_de_subscripcion_public);
        ZQatendido.ExecSQL;
        ZQatendido.Open;

        Nueva.Caption:='Ruta'+ZQatendido.FieldByName('no_ruta').AsString+', Edificio: '+ZQatendido.FieldByName('Edificio').AsString+','+ZQatendido.FieldByName('area').AsString;
    end;


 // Anterior.Caption:='Ruta:'+ZQAtendido.FieldByName('Rutao').AsString+','+ZQAtendido.FieldByName('direccion').AsString;
  tipo.Caption:='Nueva subscripcion';
    end;
 {----------------------------------------------------------------}
end;

end.