unit FReporteRemisionesRutas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ComCtrls, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset,OleServer, Excel2000;

type
  TFRemisionRutas = class(TForm)
    gridremision: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    fecha: TDateTimePicker;
    Crutas: TDBLookupComboBox;
    Button1: TButton;
    Label3: TLabel;
    ltotal: TLabel;
    ZQrutas: TZQuery;
    ZQremision: TZQuery;
    DSrutas: TDataSource;
    Dsremision: TDataSource;
    ZQvendedores: TZQuery;
    ZQtotal: TZQuery;
    Excel: TExcelApplication;
    Label4: TLabel;
    responsable: TLabel;
    ZQresponsable: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure fechaChange(Sender: TObject);
    procedure CrutasCloseUp(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRemisionRutas: TFRemisionRutas;

implementation

{$R *.dfm}
Uses
Fprincipal;

procedure TFRemisionRutas.Button1Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;

 Hoja.Cells.Item[2,3]:='Listado de entrega en ruta '+Crutas.Text +' el '+DateToStr(fecha.Date);
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[3,3].font.size:=15;
 Hoja.Cells.Item[3,3]:='Responsable: '+responsable.Caption;
 Hoja.Cells.Item[4,2]:='Edicion';
 Hoja.Cells.Item[4,2].ColumnWidth := 10;
 Hoja.Cells.Item[4,3]:='Fecha';
 Hoja.Cells.Item[4,3].ColumnWidth := 10;
 Hoja.Cells.Item[4,4]:='Codigo';
 Hoja.Cells.Item[4,4].ColumnWidth := 10;
 Hoja.Cells.Item[4,5]:='Nombre';
 Hoja.Cells.Item[4,5].ColumnWidth := 40;
 Hoja.Cells.Item[4,6]:='Dotacion';
 Hoja.Cells.Item[4,6].ColumnWidth := 10;




 with ZQremision do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridremision.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=gridremision.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=gridremision.Fields[2].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=gridremision.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=gridremision.Fields[4].AsString;
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
     end;

      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total dotado en la ruta '+ltotal.Caption;
   //   Hoja.Cells.Item[i,2].Formula:='SUMA()';
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFRemisionRutas.CrutasCloseUp(Sender: TObject);
begin
    if crutas.Text<>'' then
     begin

     ZQremision.Filtered:=FALSE;
     ZQremision.Filter:='ruta='+IntToStr(crutas.KeyValue);
     ZQremision.Filtered:=TRUE;
     ZQremision.Refresh;

    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from t_remision_rutas where fecha="'+DateToStr(fecha.Date)+'" AND ruta='+IntToStr(Crutas.KeyValue)+'');
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;

    Zqresponsable.Close;
    ZQresponsable.SQL.Clear;
    ZQresponsable.SQL.Add('Select nombre from c_repartidores_choferes inner join c_rutas_foraneas ON c_rutas_foraneas.nochofer=c_repartidores_choferes.id_repartidor where c_rutas_foraneas.id_ruta='+IntToStr(Crutas.KeyValue));
    ZQresponsable.ExecSQL;
    ZQresponsable.Open;

    responsable.Caption:=Zqresponsable.FieldByName('nombre').AsString;

     end;

end;

procedure TFRemisionRutas.fechaChange(Sender: TObject);
begin
   ZQremision.Close;
   ZQremision.SQL.Clear;
   ZQremision.SQL.Add('Select Edicion,Codigo_proveedor as Codigo,Plaza as Nombre,Dotacion,Fecha,ruta from t_remision_rutas where fecha="'+DateToStr(fecha.Date)+'"');
   ZQremision.ExecSQL;
   ZQremision.Open;
   gridremision.Refresh;

    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from t_remision_rutas where fecha="'+DateToStr(fecha.Date)+'"');
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;


end;

procedure TFRemisionRutas.FormShow(Sender: TObject);
begin
   fecha.Date:=now();
   ZQrutas.Close;
   ZQrutas.SQL.Clear;
   ZQrutas.SQL.Add('Select Nombre_ruta,id_ruta from c_rutas_foraneas');
   ZQrutas.ExecSQL;
   ZQrutas.Open;
   Crutas.ListField:='Nombre_ruta';
   Crutas.KeyField:='id_ruta';

   ZQremision.Close;
   ZQremision.SQL.Clear;
   ZQremision.SQL.Add('Select Edicion,codigo_proveedor as Codigo,Plaza as Nombre,Dotacion,Fecha,ruta from t_remision_rutas where fecha="'+DateToStr(fecha.Date)+'"');
   ZQremision.ExecSQL;
   ZQremision.Open;
   gridremision.Refresh;


    ZQtotal.Close;
    ZQtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select Sum(Dotacion) AS dotacion from t_remision_rutas where fecha="'+DateToStr(fecha.Date)+'"');
    ZQtotal.ExecSQL;
    ZQtotal.Open;
    ltotal.Caption:=ZQtotal.FieldByName('dotacion').AsString;

end;

end.
