unit FQuejasReporte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Grids, DBGrids,OleServer, Excel2000, DBCtrls;

type
  TFQuejasR = class(TForm)
    Label1: TLabel;
    finicio: TDateTimePicker;
    ffin: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    DSQuejas: TDataSource;
    GridQuejas: TDBGrid;
    ZQuejas: TZQuery;
    Button1: TButton;
    Button2: TButton;
    Excel: TExcelApplication;
    Checkrutas: TCheckBox;
    rutas: TDBLookupComboBox;
    DSrutas: TDataSource;
    ZQrutas: TZQuery;
    Label4: TLabel;
    total: TLabel;
    Button3: TButton;
    Button4: TButton;
    estatus: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ZQdatos: TZQuery;
    atenciona: TLabel;
    direccion: TLabel;
    tquejas: TLabel;
    tquejasa: TLabel;
    procedure FormShow(Sender: TObject);
    procedure finicioChange(Sender: TObject);
    procedure ffinChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckrutasClick(Sender: TObject);
    procedure rutasCloseUp(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GridQuejasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridQuejasCellClick(Column: TColumn);
    procedure Button4Click(Sender: TObject);
    procedure ZQuejasAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FQuejasR: TFQuejasR;

implementation

{$R *.dfm}
Uses
FPrincipal,Fseguimiento_quejas,FHistorial_quejas,Fquejas_Subscripciones;

procedure TFQuejasR.Button2Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
if Checkrutas.Checked=FALSE then
   begin
   i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[2,3]:='Quejas en el periodo '+DateToStr(finicio.Date)+' al '+dateToStr(ffin.date);
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,1]:='Folio';
 Hoja.Cells.Item[4,2]:='No.Subscripcion';
 Hoja.Cells.Item[4,3]:='Motivo';
 Hoja.Cells.Item[4,4]:='Ruta';
 Hoja.Cells.Item[4,5]:='Responsable';
 Hoja.Cells.Item[4,6]:='Fecha';
 Hoja.Cells.Item[4,7]:='Descripcion';
 Hoja.Cells.Item[4,8]:='Solucion';
 Hoja.Cells.Item[4,9]:='Status';
 Hoja.Cells.Item[4,10]:='Fecha de cierre';




    with ZQuejas do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,1]:=GridQuejas.Fields[0].AsString;
       Hoja.Cells.Item[i,2]:=GridQuejas.Fields[1].AsString;
       Hoja.Cells.Item[i,3]:=GridQuejas.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=GridQuejas.Fields[3].AsString;
       Hoja.Cells.Item[i,5]:=GridQuejas.Fields[4].AsString;
       Hoja.Cells.Item[i,6]:=GridQuejas.Fields[5].AsString;
       Hoja.Cells.Item[i,7]:=GridQuejas.Fields[6].AsString;
       Hoja.Cells.Item[i,8]:=GridQuejas.Fields[7].AsString;
       Hoja.Cells.Item[i,9]:=GridQuejas.Fields[8].AsString;
       Hoja.Cells.Item[i,10]:=GridQuejas.Fields[9].AsString;
       Next;
       end;//while
    end;//with

   For b:=4 to i do
        begin
         Hoja.Range['a'+IntToStr(b),'a'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['i'+IntToStr(b),'i'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['j'+IntToStr(b),'j'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
       Hoja.Cells.Item[i+3,3]:='Total de quejas: '+IntToStr(ZQuejas.RecordCount);
       Hoja.Cells.Item[i+3,3].font.size:=16;
      Excel.Visible[1]:=true;
   end
else begin
      i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[2,3]:='Quejas en el periodo '+DateToStr(finicio.Date)+' al '+dateToStr(ffin.date)+' de '+Rutas.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,1]:='Folio';
 Hoja.Cells.Item[4,2]:='No.Subscripcion';
 Hoja.Cells.Item[4,3]:='Motivo';
 Hoja.Cells.Item[4,4]:='Ruta';
 Hoja.Cells.Item[4,5]:='Responsable';
 Hoja.Cells.Item[4,6]:='Fecha';
 Hoja.Cells.Item[4,7]:='Descripcion';
 Hoja.Cells.Item[4,8]:='Solucion';
 Hoja.Cells.Item[4,9]:='Status';
 Hoja.Cells.Item[4,10]:='Fecha de cierre';




    with ZQuejas do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,1]:=GridQuejas.Fields[0].AsString;
       Hoja.Cells.Item[i,2]:=GridQuejas.Fields[1].AsString;
       Hoja.Cells.Item[i,3]:=GridQuejas.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=GridQuejas.Fields[3].AsString;
       Hoja.Cells.Item[i,5]:=GridQuejas.Fields[4].AsString;
       Hoja.Cells.Item[i,6]:=GridQuejas.Fields[5].AsString;
       Hoja.Cells.Item[i,7]:=GridQuejas.Fields[6].AsString;
       Hoja.Cells.Item[i,8]:=GridQuejas.Fields[7].AsString;
       Hoja.Cells.Item[i,9]:=GridQuejas.Fields[8].AsString;
       Hoja.Cells.Item[i,10]:=GridQuejas.Fields[9].AsString;
       Next;
       end;//while
    end;//with

   For b:=4 to i do
        begin
         Hoja.Range['a'+IntToStr(b),'a'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['i'+IntToStr(b),'i'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['j'+IntToStr(b),'j'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
       Hoja.Cells.Item[i+3,3]:='Total de quejas: '+IntToStr(ZQuejas.RecordCount);
       Hoja.Cells.Item[i+3,3].font.size:=16;
      Excel.Visible[1]:=true;
end;


end;

procedure TFQuejasR.Button3Click(Sender: TObject);
begin
   FSeguimientoQ.quienllamah:=3;
   FHistorialQueja.Enabled:=FALSE;
   FHistorialQueja := TFHistorialQueja.Create(self);
   FHistorialQueja.ShowModal;
end;

procedure TFQuejasR.Button4Click(Sender: TObject);
begin
  FPrincipalCirculacion.quienllamaquejasS:=1;
  FQuejasSubscripciones.Enabled:=FALSE;
  FQuejasSubscripciones :=TFQuejasSubscripciones.Create(self);
  FQuejasSubscripciones.ShowModal;
end;

procedure TFQuejasR.CheckrutasClick(Sender: TObject);
begin
   if checkrutas.Checked=TRUE then
     begin
       rutas.Enabled:=TRUE;
     end;
   if checkrutas.Checked=FALSE then
      begin
        rutas.Enabled:=FALSE;
      end;

end;

procedure TFQuejasR.ffinChange(Sender: TObject);
var
fechainicio,fechafin:String;
begin
   fechainicio:=FormatDateTime('yyyy-mm-dd',finicio.Date);
   fechafin:=FormatDateTime('yyyy-mm-dd',ffin.Date);
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
  ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion,Ruta,(Select nombre from c_repartidores_choferes  where id_repartidor =(Select id_responsable_ruta from c_rutas where no_ruta=Ruta))');
   ZQuejas.SQL.Add('AS Responsable,Motivo_queja AS Motivo,fecha_queja as Fecha,Descripcion,Solucion,t_quejas.status,fecha_cierre from t_quejas where  fecha_queja between "'+fechainicio+' 00:00:00" AND "'+fechafin+' 23:59:59"');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   total.Caption:=IntToStr(ZQuejas.RecordCount);
   GridQuejas.Refresh;

end;

procedure TFQuejasR.finicioChange(Sender: TObject);
var
fechainicio,fechafin:String;
begin
   fechainicio:=FormatDateTime('yyyy-mm-dd',finicio.Date);
   fechafin:=FormatDateTime('yyyy-mm-dd',ffin.Date);
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
  ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion,Ruta,(Select nombre from c_repartidores_choferes  where id_repartidor =(Select id_responsable_ruta from c_rutas where no_ruta=Ruta))');
   ZQuejas.SQL.Add('AS Responsable,Motivo_queja AS Motivo,fecha_queja as Fecha,Descripcion,Solucion,t_quejas.status,fecha_cierre from t_quejas where  fecha_queja between "'+fechainicio+' 00:00:00" AND "'+fechafin+' 23:59:59"');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   total.Caption:=IntToStr(ZQuejas.RecordCount);
   GridQuejas.Refresh;

end;

procedure TFQuejasR.FormShow(Sender: TObject);
var
fechainicio,fechafin:String;
begin
   finicio.Date:=now()-30;
   ffin.Date:=now();
   fechainicio:=FormatDateTime('yyyy-mm-dd',finicio.Date);
   fechafin:=FormatDateTime('yyyy-mm-dd',ffin.Date);
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion,Ruta,(Select nombre from c_repartidores_choferes  where id_repartidor =(Select id_responsable_ruta from c_rutas where no_ruta=Ruta))');
   ZQuejas.SQL.Add('AS Responsable,Motivo_queja AS Motivo,fecha_queja as Fecha,Descripcion,Solucion,t_quejas.status,fecha_cierre from t_quejas where  fecha_queja between "'+fechainicio+' 00:00:00" AND "'+fechafin+' 23:59:59"');
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   total.Caption:=IntToStr(ZQuejas.RecordCount);
   GridQuejas.Refresh;


end;

procedure TFQuejasR.GridQuejasCellClick(Column: TColumn);
var
dir,edif:String;

begin
   if GridQuejas.Fields[8].AsInteger=4 then
      begin
        estatus.Caption:='La queja ya fue atendida';
        estatus.Font.Color:=clGreen;
      end;
if ((GridQuejas.Fields[8].AsInteger>=2) AND (GridQuejas.Fields[8].AsInteger<=3)) then
      begin
        estatus.Caption:='La queja se esta atendiendo';
        estatus.Font.Color:=clOlive;
      end;
if ((GridQuejas.Fields[8].AsInteger=1)) then
      begin
        estatus.Caption:='La queja no se esta atendiendo';
        estatus.Font.Color:=clRed;
      end;
    ZQdatos.Close;
    ZQdatos.SQL.Clear;
    Zqdatos.SQL.Add('Select edificio from t_subscripcion where Nosubscripcion='+GridQuejas.Fields[1].AsString);
    ZQdatos.ExecSQL;
    ZQDatos.Open;
      if ZQdatos.FieldByName('edificio').AsInteger>0 then
         begin
          edif:=ZQdatos.FieldByName('edificio').AsString;
          ZQdatos.Close;
          ZQDatos.SQL.Clear;
          ZQdatos.SQL.Add('Select Area,(Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio) AS Direccion from t_descripcion_ruta_edificio where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQDatos.ExecSQL;
          ZQdatos.Open;
          direccion.Caption:=ZQdatos.FieldByName('Area').AsString+','+ZQdatos.FieldByName('Direccion').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select AtencionA from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          Zqdatos.Open;
          atenciona.Caption:=ZQdatos.FieldByName('AtencionA').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQDatos.SQL.Add('Select count(*)AS noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejas.Caption:=ZQdatos.FieldByName('noquejas').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select count(*) noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString+' AND Status<4');
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejasa.Caption:=ZQdatos.FieldByName('noquejas').AsString;
         end
      else begin
          ZQdatos.Close;
          ZQDatos.SQL.Clear;
          ZQdatos.SQL.Add('Select Calle,colonia,CP,Ciudad from t_descripcion_rutas where no_de_subscripcion='+GridQuejas.Fields[1].AsString);
          ZQDatos.ExecSQL;
          ZQdatos.Open;
          direccion.Caption:=ZQdatos.FieldByName('Calle').AsString+','+ZQdatos.FieldByName('Colonia').AsString+',C.P.:'+ZQdatos.FieldByName('CP').AsString+','+ZQdatos.FieldByName('Ciudad').AsString;

          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select AtencionA from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          atenciona.Caption:=ZQdatos.FieldByName('AtencionA').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQDatos.SQL.Add('Select count(*)AS noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejas.Caption:=ZQdatos.FieldByName('noquejas').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select count(*) noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString+' AND Status<4');
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejasa.Caption:=ZQdatos.FieldByName('noquejas').AsString;
      end;



end;

procedure TFQuejasR.GridQuejasDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if GridQuejas.Fields[8].AsInteger=4 then
      begin
         GridQuejas.Canvas.Brush.Color := clGreen;
         GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
      end;
{   if ((GridQuejas.Fields[8].AsInteger>=2) AND (GridQuejas.Fields[8].AsInteger<=3)) then
      begin
         GridQuejas.Canvas.Brush.Color := clYellow;
         GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
      end;                                           }
   if ((GridQuejas.Fields[8].AsInteger=1)) then
      begin
         GridQuejas.Canvas.Brush.Color := clRed;
         GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
      end;

end;

procedure TFQuejasR.rutasCloseUp(Sender: TObject);
var
fechainicio,fechafin:String;
begin
   fechainicio:=FormatDateTime('yyyy-mm-dd',finicio.Date);
   fechafin:=FormatDateTime('yyyy-mm-dd',ffin.Date);
   ZQuejas.Close;
   ZQuejas.SQL.Clear;
   ZQuejas.SQL.Add('Select id_queja as Folio,Nosubscripcion,Ruta,(Select nombre from c_repartidores_choferes  where id_repartidor =(Select id_responsable_ruta from c_rutas where no_ruta=Ruta))');
   ZQuejas.SQL.Add('AS Responsable,Motivo_queja AS Motivo,fecha_queja as Fecha,Descripcion,Solucion,t_quejas.status,fecha_cierre from t_quejas where  fecha_queja between "'+fechainicio+' 00:00:00" AND "'+fechafin+' 23:59:59" AND Ruta='+FloatToStr(rutas.KeyValue));
   ZQuejas.ExecSQL;
   ZQuejas.Open;
   total.Caption:=IntToStr(ZQuejas.RecordCount);
   GridQuejas.Refresh;
end;

procedure TFQuejasR.ZQuejasAfterScroll(DataSet: TDataSet);
var
dir,edif:String;

begin
   if GridQuejas.Fields[8].AsInteger=4 then
      begin
        estatus.Caption:='La queja ya fue atendida';
        estatus.Font.Color:=clGreen;
      end;
if ((GridQuejas.Fields[8].AsInteger>=2) AND (GridQuejas.Fields[8].AsInteger<=3)) then
      begin
        estatus.Caption:='La queja se esta atendiendo';
        estatus.Font.Color:=clOlive;
      end;
if ((GridQuejas.Fields[8].AsInteger=1)) then
      begin
        estatus.Caption:='La queja no se esta atendiendo';
        estatus.Font.Color:=clRed;
      end;
    ZQdatos.Close;
    ZQdatos.SQL.Clear;
    Zqdatos.SQL.Add('Select edificio from t_subscripcion where Nosubscripcion='+GridQuejas.Fields[1].AsString);
    ZQdatos.ExecSQL;
    ZQDatos.Open;
      if ZQdatos.FieldByName('edificio').AsInteger>0 then
         begin
          edif:=ZQdatos.FieldByName('edificio').AsString;
          ZQdatos.Close;
          ZQDatos.SQL.Clear;
          ZQdatos.SQL.Add('Select Area,(Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio) AS Direccion from t_descripcion_ruta_edificio where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQDatos.ExecSQL;
          ZQdatos.Open;
          direccion.Caption:=ZQdatos.FieldByName('Area').AsString+','+ZQdatos.FieldByName('Direccion').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select AtencionA from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          Zqdatos.Open;
          atenciona.Caption:=ZQdatos.FieldByName('AtencionA').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQDatos.SQL.Add('Select count(*)AS noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejas.Caption:=ZQdatos.FieldByName('noquejas').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select count(*) noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString+' AND Status<4');
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejasa.Caption:=ZQdatos.FieldByName('noquejas').AsString;
         end
      else begin
          ZQdatos.Close;
          ZQDatos.SQL.Clear;
          ZQdatos.SQL.Add('Select Calle,colonia,CP,Ciudad from t_descripcion_rutas where no_de_subscripcion='+GridQuejas.Fields[1].AsString);
          ZQDatos.ExecSQL;
          ZQdatos.Open;
          direccion.Caption:=ZQdatos.FieldByName('Calle').AsString+','+ZQdatos.FieldByName('Colonia').AsString+',C.P.:'+ZQdatos.FieldByName('CP').AsString+','+ZQdatos.FieldByName('Ciudad').AsString;

          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select AtencionA from t_subscripcion where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          atenciona.Caption:=ZQdatos.FieldByName('AtencionA').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQDatos.SQL.Add('Select count(*)AS noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString);
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejas.Caption:=ZQdatos.FieldByName('noquejas').AsString;
          ZQdatos.Close;
          ZQdatos.SQL.Clear;
          ZQdatos.SQL.Add('Select count(*) noquejas from t_quejas where nosubscripcion='+GridQuejas.Fields[1].AsString+' AND Status<4');
          ZQdatos.ExecSQL;
          ZQdatos.Open;
          tquejasa.Caption:=ZQdatos.FieldByName('noquejas').AsString;
      end;



end;
end.
