unit FFCodigos_Agrupados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset,OleServer, Excel2000;

type
  TFGrupos_codigos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    gridcodigos: TDBGrid;
    gridsubscripciones: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    ZQCodigos: TZQuery;
    DScodigos: TDataSource;
    ZQagrupados: TZQuery;
    DSagrupados: TDataSource;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure ZQCodigosAfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGrupos_codigos: TFGrupos_codigos;

implementation

{$R *.dfm}

Uses
FPrincipal;



procedure TFGrupos_codigos.Button1Click(Sender: TObject);
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
 Hoja.Cells.Item[2,2]:='Suscripciones agrapadas en el codigo '+gridcodigos.Fields[0].AsString;
 Hoja.Cells.Item[2,2].font.size:=16;
 Hoja.Cells.Item[4,3]:='Subscripcion';
 Hoja.Cells.Item[4,3].ColumnWidth := 8;
 Hoja.Cells.Item[4,4]:='Calle o Área';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Colonia';
 Hoja.Cells.Item[4,5].ColumnWidth := 20;
 Hoja.Cells.Item[4,6]:='Titular';
 Hoja.Cells.Item[4,6].ColumnWidth := 40;
 Hoja.Cells.Item[4,7]:='Ruta';
 Hoja.Cells.Item[4,7].ColumnWidth := 8;


  i:=4;
 with ZQagrupados do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=gridsubscripciones.Fields[0].AsString;
       Hoja.Cells.Item[i,4]:=gridsubscripciones.Fields[1].AsString;
       if gridcodigos.Fields[2].AsString<>'' then
         begin

         end
         else begin
       Hoja.Cells.Item[i,5]:=gridsubscripciones.Fields[2].AsString;
       Hoja.Cells.Item[i,7]:=gridsubscripciones.Fields[3].AsString;
         end;
       Hoja.Cells.Item[i,6]:=gridsubscripciones.Fields[4].AsString;

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
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total agrupados '+IntToStr(ZQagrupados.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;

end;

procedure TFGrupos_codigos.Button2Click(Sender: TObject);
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
 Hoja.Cells.Item[2,2]:='Codigos que tienen mas de una subscripcion';
 Hoja.Cells.Item[2,2].font.size:=16;
 Hoja.Cells.Item[4,3]:='Codigo';
 Hoja.Cells.Item[4,3].ColumnWidth := 20;
 Hoja.Cells.Item[4,4]:='Ruta';
 Hoja.Cells.Item[4,4].ColumnWidth := 8;
 Hoja.Cells.Item[4,5]:='Edificio';
 Hoja.Cells.Item[4,5].ColumnWidth := 30;


  i:=4;
 with ZQCodigos do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:='"'+gridcodigos.Fields[0].AsString+'"';
       Hoja.Cells.Item[i,4]:=gridcodigos.Fields[1].AsString;
       if gridcodigos.Fields[2].AsString<>'' then
         begin
         Hoja.Cells.Item[i,5]:=gridcodigos.Fields[2].AsString;
         end
         else begin

         end;

       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total agrupados '+IntToStr(ZQCodigos.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFGrupos_codigos.FormShow(Sender: TObject);
begin
   ZQcodigos.Close;
   ZQcodigos.SQL.Clear;
   ZQcodigos.SQL.Add('Select * from v_codigos_agrupados where total>1 order by codigo');
   ZQcodigos.ExecSQL;
   ZQcodigos.Open;
end;

procedure TFGrupos_codigos.ZQCodigosAfterScroll(DataSet: TDataSet);
begin
if gridcodigos.Fields[0].AsString<>'' then
  begin
    if gridcodigos.Fields[2].AsString='' then
      begin
     ZQagrupados.Close;
     ZQagrupados.SQL.Clear;
     ZQagrupados.SQL.add('Select Nosubscripcion as NoSubs,Atenciona AS Titular,Ruta,Calle,Colonia from t_subscripcion inner join t_descripcion_rutas ON nosubscripcion=no_de_subscripcion where codigo='+gridcodigos.Fields[0].AsString);
     ZQagrupados.ExecSQL;
     ZQAgrupados.Open;
      end
    else begin
     ZQagrupados.Close;
     ZQagrupados.SQL.Clear;
     ZQagrupados.SQL.add('Select t_subscripcion.Nosubscripcion as NoSubs,Atenciona AS Titular,Area AS Calle from t_subscripcion inner join t_descripcion_ruta_edificio ON t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion  where codigo='+gridcodigos.Fields[0].AsString);
     ZQagrupados.ExecSQL;
     ZQAgrupados.Open;
    end;
  end;
end;

end.
