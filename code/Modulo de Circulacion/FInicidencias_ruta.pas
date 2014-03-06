unit FInicidencias_ruta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset,OleServer, Excel2000;

type
  TFIncidencias = class(TForm)
    gridincidencias: TDBGrid;
    DSincidencias: TDataSource;
    ZQincidencias: TZQuery;
    Label1: TLabel;
    total: TLabel;
    Button1: TButton;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIncidencias: TFIncidencias;

implementation

{$R *.dfm}
Uses
FEstadisticas_rutas,Fprincipal;

procedure TFIncidencias.Button1Click(Sender: TObject);
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
 Hoja.Cells.Item[2,2]:='Suscripciones que faltaron de entregar en ruta '+FEstadisticasRutas.gridestadisticas.Fields[2].AsString+'el '+FEstadisticasRutas.gridestadisticas.Fields[1].AsString;
 Hoja.Cells.Item[2,2].font.size:=16;
 Hoja.Cells.Item[4,3]:='Direccion';
 Hoja.Cells.Item[4,3].ColumnWidth := 50;
 Hoja.Cells.Item[4,4]:='Atencion A';
 Hoja.Cells.Item[4,4].ColumnWidth := 50;


  i:=4;
 with ZQincidencias do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=gridincidencias.Fields[0].AsString;
       Hoja.Cells.Item[i,4]:=gridincidencias.Fields[1].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQincidencias.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;

end;

procedure TFIncidencias.FormShow(Sender: TObject);
begin
   ZQincidencias.Close;
   ZQincidencias.SQL.Clear;
   ZQIncidencias.SQL.Add('Select Domicilio as Direccion,Atenciona,(Select motivo from c_motivonoentrega where c_motivonoentrega.id=id_motivo)as Motivo from t_incidencias_final where id_estadistica='+FEstadisticasRutas.gridestadisticas.Fields[0].AsString);
   ZQincidencias.ExecSQL;
   ZQincidencias.Open;
   gridincidencias.Refresh;
   total.Caption:=IntToStr(ZQIncidencias.RecordCount);
end;

end.
