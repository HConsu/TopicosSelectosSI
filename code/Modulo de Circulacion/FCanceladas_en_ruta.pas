unit FCanceladas_en_ruta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  OleServer, Excel2000,ZDataset;

type
  TFCanceladasR = class(TForm)
    gridcancelados: TDBGrid;
    Button1: TButton;
    ZQcancelados: TZQuery;
    DSCancelados: TDataSource;
    Button2: TButton;
    mostrando: TLabel;
    Excel: TExcelApplication;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCanceladasR: TFCanceladasR;

implementation

{$R *.dfm}
Uses
Fprincipal,FAdministracion_rutas;

procedure TFCanceladasR.Button1Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Cancelados en los ultimos siete dias en la ruta '+IntToStr(FAdmon_rutas.rutap);
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 5;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Calle';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Colonia';
 Hoja.Cells.Item[4,5].ColumnWidth := 40;
 Hoja.Cells.Item[4,6]:='descripcion';
 Hoja.Cells.Item[4,6].ColumnWidth := 40;
 Hoja.Cells.Item[4,7]:='Fecha de cancelacion';
 Hoja.Cells.Item[4,7].ColumnWidth := 40;


 with ZQcancelados do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridcancelados.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=gridcancelados.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=gridcancelados.Fields[2].AsString;
       Hoja.Cells.Item[i,5]:=gridcancelados.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=gridcancelados.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=gridcancelados.Fields[6].AsString;
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
      Hoja.Cells.Item[i,2]:='Total de cancelados en los ultimos siete dias: '+IntToStr(ZQcancelados.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;

end;

procedure TFCanceladasR.Button2Click(Sender: TObject);
begin
   mostrando.Caption:='Mostrando todos los cancelados en la ruta';
   ZQcancelados.Close;
   ZQCancelados.SQL.Clear;
   ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,(Select Nobre from cmotivos_cancelaciones where id_motivo=Motivo)AS Motivo,Fecha_sol_cancelacion');
   ZQCAncelados.SQL.Add(' from t_cancelacion where (ruta='+IntToStr(FAdmon_rutas.rutap)+' AND edificio='+IntToStr(FAdmon_rutas.edificiop)+')');
   ZQCancelados.ExecSQL;
   ZQCancelados.Open;
   gridcancelados.Refresh;
end;

procedure TFCanceladasR.FormCreate(Sender: TObject);
begin
 SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TFCanceladasR.FormShow(Sender: TObject);
var fechahoy,fechasiete:String;
begin
   fechahoy:=FormatDateTime('yyyy-mm-dd',now());
   fechasiete:=FormatDateTime('yyyy-mm-dd',now()-7);

   ZQcancelados.Close;
   ZQCancelados.SQL.Clear;
   ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,(Select Nobre from cmotivos_cancelaciones where id_motivo=Motivo)AS Motivo,Fecha_sol_cancelacion');
   ZQCAncelados.SQL.Add(' from t_cancelacion where fecha_sol_cancelacion between "2011-11-02 00:00:00" AND "2011-11-11 23:59:59" AND (ruta='+IntToStr(FAdmon_rutas.rutap)+' AND edificio='+IntToStr(FAdmon_rutas.edificiop)+')');
   ZQCancelados.ExecSQL;
   ZQCancelados.Open;
   gridcancelados.Refresh;


end;

end.
