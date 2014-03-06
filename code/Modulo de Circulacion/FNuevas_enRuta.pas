unit FNuevas_enRuta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGrids,OleServer, Excel2000;

type
  TFNuevosR = class(TForm)
    mostrando: TLabel;
    gridnuevas: TDBGrid;
    Button1: TButton;
    DSNuevas: TDataSource;
    ZQnuevas: TZQuery;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNuevosR: TFNuevosR;

implementation

{$R *.dfm}
Uses
FPrincipal,FAdministracion_rutas;

procedure TFNuevosR.Button1Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Sbscripciones nuevas de los ultimos siete dias en la ruta '+IntToStr(FAdmon_rutas.rutap);
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 5;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Edificio';
 Hoja.Cells.Item[4,4].ColumnWidth := 20;
 Hoja.Cells.Item[4,5]:='Ruta';
 Hoja.Cells.Item[4,5].ColumnWidth := 10;
 Hoja.Cells.Item[4,6]:='Fecha Alta';
 Hoja.Cells.Item[4,6].ColumnWidth := 30;
 Hoja.Cells.Item[4,7]:='Observaciones';
 Hoja.Cells.Item[4,7].ColumnWidth := 30;


 with ZQNuevas do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridnuevas.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=gridnuevas.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=gridnuevas.Fields[2].AsString;
       Hoja.Cells.Item[i,5]:=gridnuevas.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=gridnuevas.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=gridnuevas.Fields[5].AsString;
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
         Hoja.Range['g'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total de subscripciones nuevas en los ultimos siete dias: '+IntToStr(ZQNuevas.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFNuevosR.FormShow(Sender: TObject);
var
fechahoy,fechasiete:String;
begin
   fechahoy:=FormatDateTime('yyyy-mm-dd',now());
   fechasiete:=FormatDateTime('yyyy-mm-dd',now()-7);

   ZQNuevas.Close;
   ZQNuevas.SQL.Clear;
   ZQNuevas.SQL.Add('Select NoSubscripcion,AtencionA,(Select Descripcion from c_edificios where id_edificio=edificio) AS Edificio,Ruta,Fecha_Alta,Observaciones,Inconsistencias from t_subscripcion where fecha_alta="'+DateToStr(now())+'" OR ');
   ZQNuevas.SQL.add(' (fechamodif between "'+fechasiete+' 00:00:00" AND "'+fechahoy+' 23:59:59") AND (ruta='+IntToStr(FAdmon_rutas.rutap)+')');
   ZQnuevas.ExecSQL;
   ZQNuevas.Open;
   gridnuevas.Refresh;
end;

end.
