unit FAdmonCodigosVendedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, pBarcode, pCode128, pEAN128,OleServer, Excel2000;

type
  TFCod_vendedores = class(TForm)
    gridpuntos: TDBGrid;
    gridruta: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Cruta: TDBLookupComboBox;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ZQpuntos: TZQuery;
    ZQruta: TZQuery;
    ZQvendedores: TZQuery;
    DSpuntos: TDataSource;
    DSvendedores: TDataSource;
    DSruta: TDataSource;
    ZQactualiza: TZQuery;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ZQinserta: TZQuery;
    Barcode: TBarcode_EAN128;
    Excel: TExcelApplication;
    procedure FormShow(Sender: TObject);
    procedure CrutaCloseUp(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    function asignarcodigo:boolean;
    function GridSelectAll(gridruta: TDBGrid): Longint;
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCod_vendedores: TFCod_vendedores;

implementation

{$R *.dfm}
uses
Fprincipal;


function TFCod_vendedores.GridSelectAll(gridruta: TDBGrid): Longint;
begin
  Result := 0;
  gridruta.SelectedRows.Clear;
  with gridruta.Datasource.DataSet do
  begin
    First;
    DisableControls;
    try
      while not EOF do
      begin
        gridruta.SelectedRows.CurrentRowSelected := True;
        inc(Result);
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;


function TFCod_vendedores.asignarcodigo:boolean;
  var
codigo:String;
i,consecutivo,j:Integer;
consec:String;
begin
if gridruta.SelectedRows.Count > 0 then
  begin
    for j := 0 to gridruta.SelectedRows.Count - 1 do
    begin
    gridruta.DataSource.DataSet.GotoBookmark(pointer(gridruta.SelectedRows.Items[j]));


  Consecutivo:=gridruta.Fields[0].ASinteger;
  consec:=IntToStr(Consecutivo);

    if Length(Consec)=5 then
      begin
        consec:=Consec;
      end;
   if Length(Consec)=1 then
      begin
        consec:='0000'+Consec;
      end;
   if Length(Consec)=2 then
      begin
        consec:='000'+Consec;
      end;
   if Length(Consec)=3 then
      begin
        consec:='00'+Consec;
      end;
   if Length(Consec)=4 then
      begin
        consec:='0'+Consec;
      end;

    Codigo:=consec;
    barcode.Barcode:=codigo;
    codigo:=barcode.FullEncoded;
    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Update c_proveedores SET codigo="'+Codigo+'" where id_proveedor ='+gridruta.Fields[0].AsString);
    ZQInserta.ExecSQL;
    end;
  end;

end;


procedure TFCod_vendedores.Button1Click(Sender: TObject);
  var
i,consecutivo,j:Integer;
begin
 // ShowMessage(IntToStr(gridpuntos.SelectedRows.Count));
if cruta.Text<>'' then
   begin
   j:=0;
   if  gridpuntos.SelectedRows.Count >0 then
     begin
       while  j < gridpuntos.SelectedRows.Count do
        begin
          gridpuntos.DataSource.DataSet.GotoBookmark(pointer(gridpuntos.SelectedRows.Items[j]));
          ZQactualiza.Close;
          ZQactualiza.SQL.Clear;
          ZQactualiza.SQL.Add('Update c_proveedores SET ruta='+FloatToStr(Cruta.KeyValue)+' where id_proveedor='+gridpuntos.Fields[0].AsString);
          ZQactualiza.ExecSQL;
          ZQpuntos.Refresh;
          ZQvendedores.Refresh;
          j:=j+1;
        end;
     end;
    gridpuntos.SelectedRows.Clear;
   end
  else begin
    ShowMessage('Primero seleccione una ruta');
  end;
end;

procedure TFCod_vendedores.Button2Click(Sender: TObject);
  var
i,consecutivo,j:Integer;
begin
 j:=0;
 if  gridruta.SelectedRows.Count >0 then
     begin
       while  j < gridruta.SelectedRows.Count do
        begin
          gridruta.DataSource.DataSet.GotoBookmark(pointer(gridruta.SelectedRows.Items[j]));
          ZQactualiza.Close;
          ZQactualiza.SQL.Clear;
          ZQactualiza.SQL.Add('Update c_proveedores  SET ruta=0 where id_proveedor='+gridruta.Fields[0].AsString);
          ZQactualiza.ExecSQL;
          j:=j+1;
          ZQpuntos.Refresh;
          ZQvendedores.Refresh;
        end;
     end;
    gridruta.SelectedRows.Clear;
end;

procedure TFCod_vendedores.Button3Click(Sender: TObject);
begin
 asignarcodigo();
 ZQvendedores.Refresh;
end;

procedure TFCod_vendedores.Button4Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
tall:Integer;
edificio:String;
begin
  i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
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

 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Listado de codigos de '+cruta.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='Codigo vendedor';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Nombre';
 Hoja.Cells.Item[4,3].ColumnWidth := 50;
 Hoja.Cells.Item[4,4]:='Dotacion';
 Hoja.Cells.Item[4,4].ColumnWidth := 8;
 Hoja.Cells.Item[4,5]:='Codigo';
 Hoja.Cells.Item[4,5].ColumnWidth := 20;



with ZQvendedores do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=gridruta.Fields[0].AsString;
       Hoja.Cells.Item[i,3].WrapText:=TRUE;
       Hoja.Cells.Item[i,3].font.size:=16;
       Hoja.Cells.Item[i,3]:=gridruta.Fields[1].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,4].font.size:=16;
       Hoja.Cells.Item[i,4]:=gridruta.Fields[2].AsString;
       Hoja.Cells.Item[i,5].font.size:=16;
       Hoja.Cells.Item[i,5]:='"'+gridruta.Fields[3].AsString+'"';
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQruta.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFCod_vendedores.Button5Click(Sender: TObject);
var
i:Integer;
cod:STRING;
begin
  if gridruta.SelectedRows.Count > 0 then
  begin
    for i := 0 to gridruta.SelectedRows.Count - 1 do
    begin

    gridruta.DataSource.DataSet.GotoBookmark(pointer(gridruta.SelectedRows.Items[i]));
    ZQinserta.Close;
    ZQinserta.SQL.Clear;
    ZQinserta.SQL.Add('INSERT INTO t_codigos_imprimir (Codigo) Values("'+gridruta.Fields[3].AsString+'")');
    ZQinserta.ExecSQL;
    ZQinserta.Close;
    end;
  ShowMessage('Los codigos de los registros seleccionados se guardaron correctamente en la tabla para imprimir');
  end
end;

procedure TFCod_vendedores.Button6Click(Sender: TObject);
begin
   ZQinserta.Close;
   ZQinserta.SQL.Clear;
   ZQinserta.SQL.Add('Delete from t_codigos_imprimir');
   Zqinserta.ExecSQL;
   ShowMessage('Hecho');
end;

procedure TFCod_vendedores.Button7Click(Sender: TObject);
begin
   GridSelectAll(gridruta);
end;

procedure TFCod_vendedores.CrutaCloseUp(Sender: TObject);
begin
   ZQvendedores.Close;
   ZQVendedores.SQL.Clear;
   ZQvendedores.SQL.Add('Select id_proveedor as Cod,Nombre,Dotacion,Codigo from c_proveedores where ruta='+FloatToStr(Cruta.KeyValue)+' AND activo="S"');
   ZQvendedores.ExecSQL;
   ZQVendedores.Open;

end;

procedure TFCod_vendedores.FormShow(Sender: TObject);
begin
  ZQpuntos.Close;
  ZQpuntos.SQL.Clear;
  Zqpuntos.SQL.Add('Select id_proveedor as Cod,Nombre,Municipio,Dotacion from c_proveedores where ruta=0');
  ZQpuntos.ExecSQL;
  ZQpuntos.Open;

  ZQruta.Close;
  ZQruta.SQL.Clear;
  ZQruta.SQL.Add('Select id_ruta,Nombre_ruta from c_rutas_foraneas');
  ZQruta.ExecSQL;
  ZQruta.Open;

  Cruta.ListField:='Nombre_ruta';
  Cruta.keyField:='id_ruta';


end;

end.
