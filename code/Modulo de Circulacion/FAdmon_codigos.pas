unit FAdmon_codigos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids, DBCtrls, ExtCtrls,OleServer, Excel2000, ComCtrls;

type
  TFAdmonCodigos = class(TForm)
    Label1: TLabel;
    gridsubscripciones: TDBGrid;
    DSSubscripciones: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ZQSubscripciones: TZQuery;
    ZQPrepara: TZQuery;
    DataSource1: TDataSource;
    ruta: TDBLookupComboBox;
    ZQruta: TZQuery;
    DSruta: TDataSource;
    Button4: TButton;
    nosubscripcionb: TEdit;
    atencionab: TEdit;
    Label2: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button5: TButton;
    Panel1: TPanel;
    Label3: TLabel;
    direccion: TLabel;
    ZQdireccion: TZQuery;
    Button8: TButton;
    Excel: TExcelApplication;
    ZQsubscripcionese: TZQuery;
    ZQdireccione: TZQuery;
    ZQinsertar: TZQuery;
    ZQentregas: TZQuery;
    gridentregas: TDBGrid;
    Dentregas: TDataSource;
    progreso: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure rutaCloseUp(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure nosubscripcionbKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure atencionabKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ZQSubscripcionesAfterScroll(DataSet: TDataSet);
    procedure Button8Click(Sender: TObject);
    type THackDBGrid = class(TDBGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAdmonCodigos: TFAdmonCodigos;

implementation

{$R *.dfm}
Uses
FPrincipal,FAsignar_C_Edificio,FNuevo_Codigo,FAgrupar_codigos;

procedure TFAdmonCodigos.rutaCloseUp(Sender: TObject);
begin
  if ruta.Text<>'' then
     begin
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion where ruta='+FloatToStr(ruta.KeyValue));
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;
     end;
end;

procedure TFAdmonCodigos.ZQSubscripcionesAfterScroll(DataSet: TDataSet);
begin

   if gridsubscripciones.Fields[3].AsInteger>0 then
      begin
         ZQdireccion.Close;
         ZQdireccion.SQL.Clear;
         ZQdireccion.SQL.Add('Select (Select Descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio) AS Edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+gridsubscripciones.Fields[0].ASString);
         ZQdireccion.ExecSQL;
         ZQdireccion.Open;

         direccion.Caption:='Edificio: '+ZQdireccion.FieldByName('Edificio').AsString+', Área: '+ZQdireccion.FieldByName('area').AsString;

      end;
   if gridsubscripciones.Fields[3].AsInteger=0 then
      begin
         ZQdireccion.Close;
         ZQdireccion.SQL.Clear;
         ZQdireccion.SQL.Add('Select Calle,Colonia,CP,Ciudad,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+gridsubscripciones.Fields[0].ASString);
         ZQdireccion.ExecSQL;
         ZQdireccion.Open;

         direccion.Caption:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+',C.P.'+ZQdireccion.FieldByName('ciudad').AsString+','+ZQdireccion.FieldByName('descripcion_domicilio').AsString;
      end;


end;

procedure TFAdmonCodigos.atencionabKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
valor,filtro:String;
begin
if atencionab.Text<>'' then
  begin
    filtro:='Atenciona LIKE '+quotedstr('*'+atencionab.Text+'*');
    ZQSubscripciones.Filter:=filtro;
    ZQSubscripciones.Filtered:=TRUE;
  end
  else begin
    ZQSubscripciones.Filtered:=FALSE;
  end;
end;

procedure TFAdmonCodigos.Button1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
 {----Para mantener el focus del grid------------------------------}
   ds := THackDBGrid(gridsubscripciones).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridsubscripciones).Row;
   row := ds.RecNo;
   ds.Refresh;
 {-------------fin mantener el foco--------------------------------}
   FNuevoCodigo.Enabled:=FALSE;
   FNuevoCodigo := TFNuevoCodigo.Create(self);
   FNuevoCodigo.ShowModal;
 //Refrescamos el grid despues de hacer una asignacion
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

 ///////Mantenemos el focus //////////////////////
  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;


end;

procedure TFAdmonCodigos.Button2Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
 {----Para mantener el focus del grid------------------------------}
   ds := THackDBGrid(gridsubscripciones).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridsubscripciones).Row;
   row := ds.RecNo;
   ds.Refresh;
 {-------------fin mantener el foco--------------------------------}

     FAsignarCEdificio.Enabled:=FALSE;
     FAsignarCEdificio := TFAsignarCEdificio.Create(self);
     FASignarCEdificio.ShowModal;
  //Refrescamos el grid despues de hacer una asignacion
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;
  ///////Mantenemos el focus //////////////////////
  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;

end;

procedure TFAdmonCodigos.Button3Click(Sender: TObject);
var
i:Integer;
code:String;
begin
progreso.Min:=0;
progreso.Max:=100;
progreso.Position:=0;

 code:=ZQSubscripciones.FieldByName('Codigo').AsString;

    {   verificamos que el codigo no este insertado ya }
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Select Codigo from t_codigos_imprimir where codigo="'+Code+'"');
       ZQPrepara.ExecSQL;
       ZQprepara.Open;

       if ZQPrepara.FieldByName('Codigo').IsNull=TRUE then
          begin
      { insertamos el codigo en la tabla para imprimir  }
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Insert into t_codigos_imprimir (Codigo) Values("'+Code+'")');
       ZQPrepara.ExecSQL;
           end;

      progreso.Visible:=TRUE;
      for i := 0 to 100 do
          begin
            progreso.Position:=progreso.Position+1;
            sleep(10);
          end;
      progreso.Visible:=FALSE;

end;

procedure TFAdmonCodigos.Button4Click(Sender: TObject);
var
i:integer;
code:String;
begin
if application.MessageBox (pchar('¿Esta seguro que desea limpiar la tabla de codigos para imprimir?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Delete from  t_codigos_imprimir');
       ZQPrepara.ExecSQL;
           end;
end;

procedure TFAdmonCodigos.Button5Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
  {----Para mantener el focus del grid------------------------------}
   ds := THackDBGrid(gridsubscripciones).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridsubscripciones).Row;
   row := ds.RecNo;
   ds.Refresh;
 {-------------fin mantener el foco--------------------------------}

  FAgruparCodigos.Enabled:=FALSE;
  FAgruparCodigos := TFAgruparCodigos.Create(self);
  FAgruparCodigos.ShowModal;

   //Refrescamos el grid despues de hacer una asignacion
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

 ///////Mantenemos el focus //////////////////////
  with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;



end;

procedure TFAdmonCodigos.Button6Click(Sender: TObject);
var
i:Integer;
code,orden:String;
begin
   ShowMessage('NOTA:Solo se agregaran aquellas subscripciones que no se entreguen en edificio');
   {---Consultamos nuevamente para imprimir solo los que no se entreguen en edificio-----}
    ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta,Orden_en_el_reparto from t_subscripcion inner join t_descripcion_rutas ON t_subscripcion.nosubscripcion=no_de_subscripcion where ruta='+FloatToStr(ruta.KeyValue)+' AND edificio=0 Group by Codigo order by Orden_en_el_reparto');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

   {-----------------------------Fin de consulta-----------------------------------------}
  i:=0;
   while i<=ZQSubscripciones.RecordCount do
      begin
       code:=ZQSubscripciones.FieldByName('Codigo').AsString;
       orden:=ZQSubscripciones.FieldByName('Orden_en_el_reparto').AsString;
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Insert into t_codigos_imprimir (Codigo,Orden) Values("'+Code+'",'+orden+')');
       ZQPrepara.ExecSQL;
       ZQSubscripciones.Next;
       i:=i+1;
      end;
end;

procedure TFAdmonCodigos.Button7Click(Sender: TObject);
begin
    ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;
end;

procedure TFAdmonCodigos.Button8Click(Sender: TObject);
var
i:integer;
nosubscripcion:String;
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
b:Integer;
tall:Integer;
edificio,codigo,direccione:String;
begin
     ZQsubscripcionese.Close;
     ZQsubscripcionese.SQL.Clear;
     ZQSubscripcionese.SQL.Add('delete from t_excel_direcciones_codigos');
     ZQsubscripcionese.ExecSQL;


     ZQsubscripcionese.Close;
     ZQsubscripcionese.SQL.Clear;
     ZQSubscripcionese.SQL.Add('Select nosubscripcion,edificio,t_subscripcion.codigo from t_subscripcion inner join t_codigos_imprimir ON t_subscripcion.codigo=t_codigos_imprimir.codigo order by orden');
     ZQsubscripcionese.ExecSQL;
     ZQsubscripcionese.Open;
        i:=1;
        while i<=ZQsubscripcionese.RecordCount do
           begin
             if ZQsubscripcionese.FieldByName('edificio').AsInteger=0 then
                begin
                      codigo:=ZQsubscripcionese.FieldByName('codigo').AsString;
                      nosubscripcion:=ZQsubscripcionese.FieldByName('nosubscripcion').AsString;
                      ZQdireccione.Close;
                      ZQdireccione.SQL.Clear;
                      ZQdireccione.SQL.Add('Select Calle,Colonia,Ciudad,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                      ZQdireccione.ExecSQL;
                      ZQdireccione.Open;
                      direccione:=ZQdireccione.FieldByName('Calle').AsString+','+ZQdireccione.FieldByName('Colonia').AsString+','+ZQdireccione.FieldByName('Ciudad').AsString+','+ZQdireccione.FieldByName('descripcion_domicilio').AsString;

                      ZQinsertar.Close;
                      ZQinsertar.SQL.Clear;
                      ZQinsertar.SQL.Add('Insert into t_excel_direcciones_codigos (direccion,codigo) VALUES("'+direccione+'","'+codigo+'")');
                      ZQinsertar.ExecSQL;


                end;         // fin del if, se entrega en domicilio
              if ZQsubscripciones.FieldByName('edificio').AsInteger>0 then
                begin
                      codigo:=ZQsubscripcionese.FieldByName('codigo').AsString;
                      nosubscripcion:=ZQsubscripciones.FieldByName('nosubscripcion').AsString;
                      ZQdireccione.Close;
                      ZQdireccione.SQL.Clear;
                      ZQdireccione.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                      ZQdireccione.ExecSQL;
                      ZQdireccione.Open;
                      direccione:=ZQdireccione.FieldByName('Edificio').AsString+','+ZQdireccione.FieldByName('area').AsString;

                      ZQinsertar.Close;
                      ZQinsertar.SQL.Clear;
                      ZQinsertar.SQL.Add('Insert into t_excel_direcciones_codigos (direccion,codigo) VALUES("'+direccione+'","'+codigo+'")');
                      ZQinsertar.ExecSQL;


                end;              //fin del if se entrega en edificio
           ZQsubscripcionese.Next;
          i:=i+1;
           end;              // fin del while itera en el numero de subscripciones

      /// cargamos los datos en el grid para mostrar el orden en el que se entregaron.

    Zqentregas.close;
    ZQentregas.SQL.Clear;
    ZQEntregas.SQL.Add('Select * from t_excel_direcciones_codigos');
    ZQentregas.ExecSQL;
    ZQentregas.Open;
    GridEntregas.Refresh;

  // Comenzamos a exportar al excel los datos
 i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;

 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Hoja de direcciones impresas en codigos '+ruta.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='Codigo';
 Hoja.Cells.Item[4,2].ColumnWidth := 50;
 Hoja.Cells.Item[4,3]:='Direccion';
 Hoja.Cells.Item[4,3].ColumnWidth := 15;


 with ZQentregas do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridentregas.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:='"'+gridentregas.Fields[1].AsString+'"';
       Next;
       end;//while
    end;//with

  For b:=4 to i do
        begin
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;

       Excel.Visible[1]:=true;


end;

procedure TFAdmonCodigos.nosubscripcionbKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
valor,filtro:String;
begin
if nosubscripcionb.Text<>'' then
  begin
    filtro:='"NoSubscripcion" = '+nosubscripcionb.Text;
    ZQSubscripciones.Filter:=filtro;
    ZQSubscripciones.Filtered:=TRUE;
  end
  else begin
    ZQSubscripciones.Filtered:=FALSE;
  end;
end;

procedure TFAdmonCodigos.FormShow(Sender: TObject);
begin
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA,Edificio,Ruta from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

   ZQruta.Close;
   ZQruta.SQL.Clear;
   ZQruta.SQL.Add('Select Nombre_ruta,id_ruta from c_rutas');
   ZQruta.ExecSQL;
   ZQruta.Open;

   ruta.ListField:='Nombre_ruta';
   ruta.KeyField:='id_ruta';


end;

end.
