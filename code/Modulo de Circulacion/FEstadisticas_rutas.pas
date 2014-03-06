unit FEstadisticas_rutas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  DBCtrls, Grids, DBGrids,OleServer, Excel2000;

type
  TFEstadisticasRutas = class(TForm)
    DSEstadisticas: TDataSource;
    DSrutas: TDataSource;
    gridestadisticas: TDBGrid;
    crutas: TDBLookupComboBox;
    Label1: TLabel;
    responsable: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ZQestadisticas: TZQuery;
    ZQrutas: TZQuery;
    ZQtmp: TZQuery;
    Button4: TButton;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure crutasCloseUp(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEstadisticasRutas: TFEstadisticasRutas;

implementation

{$R *.dfm}
Uses
Fprincipal,Finicidencias_ruta,FOrden_Entrega;

procedure TFEstadisticasRutas.Button1Click(Sender: TObject);
begin
   FOrdenEntrega.Enabled:=FALSE;
   FOrdenEntrega := TFOrdenEntrega.Create(self);
   FOrdenEntrega.ShowModal;
end;

procedure TFEstadisticasRutas.Button2Click(Sender: TObject);
begin
  ShowMessage('Esta opcion aun no esta activada');
end;

procedure TFEstadisticasRutas.Button3Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 i:=4;

  Hoja.Cells.Item[1,1].ColumnWidth := 14;
 Hoja.Cells.Item[2,3]:='Estadisticas de entregas ';
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,3]:='Fecha';
 Hoja.Cells.Item[4,4]:='Ruta';
 Hoja.Cells.Item[4,5]:='Entregadas';
 Hoja.Cells.Item[4,6]:='No entregadas';
 Hoja.Cells.Item[4,7]:='Duplicadas';
 Hoja.Cells.Item[4,8]:='Hora inicio';
 Hoja.Cells.Item[4,9]:='Hora fin';
 Hoja.Cells.Item[4,10]:='Tiempo de ruta';



 with ZQestadisticas do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=gridestadisticas.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=gridestadisticas.Fields[2].AsString;
       Hoja.Cells.Item[i,5]:=gridestadisticas.Fields[3].AsString;
       Hoja.Cells.Item[i,6]:=gridestadisticas.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=gridestadisticas.Fields[5].AsString;
       Hoja.Cells.Item[i,8]:=gridestadisticas.Fields[6].AsString;
       Hoja.Cells.Item[i,9]:=gridestadisticas.Fields[7].AsString;
       Hoja.Cells.Item[i,10]:=gridestadisticas.Fields[8].AsString;

       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['i'+IntToStr(b),'i'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['j'+IntToStr(b),'j'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQestadisticas.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;

end;

procedure TFEstadisticasRutas.Button4Click(Sender: TObject);
begin
  FIncidencias.Enabled:=FALSE;
  FIncidencias := TFincidencias.Create(self);
  Fincidencias.Show;
end;

procedure TFEstadisticasRutas.crutasCloseUp(Sender: TObject);
begin
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select Nombre from c_repartidores_choferes where id_repartidor= (Select id_responsable_ruta from c_rutas where no_ruta='+FloatToStr(crutas.KeyValue)+')');
   ZQtmp.ExecSQL;
   ZQtmp.Open;

  ZQestadisticas.Close;
  ZQestadisticas.SQL.Clear;
  ZQestadisticas.SQL.Add('Select id_estadistica AS ID,Fecha,Ruta,Entregadas,Noentregadas,Duplicadas,Inicio AS "Hora Inicio",Fin AS "Hora Fin",Tiempo AS "Tiempo de ruta" from t_estadisticas_ruta where ruta='+FloatToStr(crutas.KeyValue)+' order by id_estadistica ');
  ZQestadisticas.ExecSQL;
  ZQestadisticas.Open;
  gridestadisticas.Refresh;

   responsable.Caption:=ZQtmp.FieldByName('Nombre').AsString;
end;

procedure TFEstadisticasRutas.FormShow(Sender: TObject);
begin
  ZQrutas.Close;
  ZQrutas.SQL.Clear;
  ZQrutas.SQL.Add('Select id_ruta,Nombre_ruta from c_rutas');
  ZQrutas.ExecSQL;
  ZQRutas.Open;
  crutas.ListField:='Nombre_ruta';
  crutas.KeyField:='id_ruta';

  ZQestadisticas.Close;
  ZQestadisticas.SQL.Clear;
  ZQestadisticas.SQL.Add('Select id_estadistica AS ID,Fecha,Ruta,Entregadas,Noentregadas,Duplicadas,Inicio AS "Hora Inicio",Fin AS "Hora Fin",Tiempo AS "Tiempo de ruta" from t_estadisticas_ruta order by id_estadistica');
  ZQestadisticas.ExecSQL;
  ZQestadisticas.Open;
  gridestadisticas.Refresh;





end;

end.
