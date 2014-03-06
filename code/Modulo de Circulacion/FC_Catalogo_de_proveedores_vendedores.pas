unit FC_Catalogo_de_proveedores_vendedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Grids, DBGrids, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Menus, ComCtrls, OleServer, Excel2000,
  jpeg;

type
  TFC_Catalogo_proveedores_y_vendedores = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBGrid: TDBGrid;
    Alta: TButton;
    Codigo: TEdit;
    Nombre: TEdit;
    Dotacion: TEdit;
    tarifa: TEdit;
    calle: TEdit;
    colonia: TEdit;
    telefono: TEdit;
    titular: TEdit;
    ZQuery1: TZQuery;
    Ruta: TDBLookupComboBox;
    DataSource1: TDataSource;
    TipoCirculacion: TDBLookupComboBox;
    ZQuery2: TZQuery;
    DataSource2: TDataSource;
    Aceptar: TButton;
    Cancelar: TButton;
    ZQueryGrid: TZQuery;
    DataSource3: TDataSource;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    ZQAlta_proveedor: TZQuery;
    StatusBar1: TStatusBar;
    Label12: TLabel;
    tipoenpaque: TComboBox;
    comboMunicipio: TDBLookupComboBox;
    DSMunicipio: TDataSource;
    ZQMunicipio: TZQuery;
    modificar: TButton;
    ZQtmp: TZQuery;
    Aceptarm: TButton;
    Button2: TButton;
    Image1: TImage;
    Button3: TButton;
    Label13: TLabel;
    total: TEdit;
    ZQtotal: TZQuery;
    PopupMenu1: TPopupMenu;
    Verdistribucindecortesias1: TMenuItem;
    Button4: TButton;
    Excel: TExcelApplication;
    procedure AltaClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure DotacionKeyPress(Sender: TObject; var Key: Char);
    procedure tarifaKeyPress(Sender: TObject; var Key: Char);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridCellClick(Column: TColumn);
    procedure DBGridTitleClick(Column: TColumn);
    procedure modificarClick(Sender: TObject);
    procedure AceptarmClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CodigoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure DataSource3DataChange(Sender: TObject; Field: TField);
    procedure ZQueryGridAfterScroll(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FC_Catalogo_proveedores_y_vendedores: TFC_Catalogo_proveedores_y_vendedores;

implementation

uses F_Buscar_Proveedor;

{$R *.dfm}

procedure TFC_Catalogo_proveedores_y_vendedores.AceptarmClick(Sender: TObject);
begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_proveedores SET Nombre="'+nombre.Text+'",dotacion='+dotacion.Text+',tipo_circulacion='+FloatToStr(tipocirculacion.KeyValue)+',ruta='+FloatToStr(ruta.KeyValue)+',municipio="'+combomunicipio.Text+'",tarifa='+tarifa.Text+',calle="'+calle.Text+'",colonia="'+colonia.Text+'",telefono="'+telefono.Text+'",titular="'+titular.Text+'",kmunicipio="'+FloatToStr(combomunicipio.KeyValue)+'" where id_proveedor='+codigo.Text);
    ZQtmp.ExecSQL;
    DBGrid.Refresh;
    ShowMessage('Se actualizaron los datos del distribuidor');
    Modificar.Enabled:=FALSE;
    Aceptarm.Visible:=FALSE;
    alta.Visible:=TRUE;
    ZQueryGrid.Refresh;
//    ZQueryGrid.SQL.Clear;
//    ZQueryGrid.SQL.Add('Select id_proveedor as "Codigo", nombre as Nombre, dotacion as "Dotación",nombre_tipo as "Tipo de circulación",');
//    ZQueryGrid.SQL.Add('Ruta as "No ruta foranea", Municipio, Tarifa,calle,colonia,telefono,titular from c_proveedores JOIN c_tipo_circulacion');
//    ZQueryGrid.SQL.Add(' ON c_tipo_circulacion.id_tipo = tipo_circulacion ORDER BY codigo ');
//    ZQueryGrid.ExecSQL;
//    ZQueryGrid.Open;
    DBGrid.Refresh;

    Nombre.Enabled:=FALSE;
    Dotacion.Enabled:=FALSE;
    Tipocirculacion.Enabled:=FALSE;
    Ruta.Enabled:=FALSE;
    Tarifa.Enabled:=FALSE;
    Tipoenpaque.Enabled:=FALSE;
    Combomunicipio.Enabled:=FALSE;
    calle.Enabled:=FALSE;
    colonia.Enabled:=FALSE;
    Telefono.Enabled:=FALSE;
    Titular.Enabled:=FALSE;
    Cancelar.Visible:=FALSE;
    Aceptarm.Visible:=FALSE;
    alta.Visible:=TRUE;


end;

procedure TFC_Catalogo_proveedores_y_vendedores.AltaClick(Sender: TObject);
begin
    {habilitamos los campos para dar de alta al proveedor y limpiamos el contenido de los edits}
    {Codigo.Text := '';
    Codigo.Enabled := TRUE;}
    Codigo.Text:='';
    Nombre.Text := '';
    Nombre.Enabled := TRUE;
    Dotacion.Text := '';
    Dotacion.Enabled := TRUE;
    TipoCirculacion.Enabled := TRUE;
    Ruta.Enabled := TRUE;
    tarifa.Text := '';
    Tarifa.Enabled := TRUE;
    comboMunicipio.KeyValue :=1;
    comboMunicipio.Enabled := TRUE;
    Calle.Text :='';
    Calle.Enabled :=TRUE;
    Colonia.Text := '';
    Colonia.Enabled:=TRUE;
    Telefono.Text :='';
    Telefono.Enabled :=TRUE;
    Titular.Text:='';
    Titular.Enabled:=TRUE;
    {Ocultamos el boton de dar de alta y mostramos el de aceptar y cancelar}
    Alta.Visible :=FALSE;
    Aceptar.Visible := TRUE;
    Cancelar.Visible:=TRUE;
    tipoenpaque.Enabled:=TRUE;
    Aceptarm.Visible:=FALSE;


end;

procedure TFC_Catalogo_proveedores_y_vendedores.Button2Click(Sender: TObject);
begin
 if application.MessageBox (pchar('¿Esta seguro que desea eliminar el vendedor '+DBGrid.Fields[1].AsString+'?'), pchar('Confirmar eliminar vendedor'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
            ZQtmp.Close;
            ZQtmp.SQL.Clear;
            ZQtmp.SQL.Add('Insert into c_proveedores_eliminados (id_proveedor,nombre,dotacion,tipo_circulacion,ruta,municipio,tarifa,calle,colonia,telefono,titular,Orden_enel_reparto,observaciones,empaque)');
            ZQtmp.SQL.Add(' Select id_proveedor,nombre,dotacion,tipo_circulacion,ruta,municipio,tarifa,calle,colonia,telefono,titular,Orden_enel_reparto,observaciones,empaque from c_proveedores where id_proveedor='+DBGrid.Fields[0].AsString);
            ZQtmp.ExecSQL;
            ZQtmp.Close;
            ZQtmp.SQL.Clear;
            ZQtmp.SQL.Add('Update c_proveedores SET activo="N" where id_proveedor='+DBGrid.Fields[0].asString);
            ZQtmp.ExecSQL;
            ShowMessage('Se elimino el vendedor correctamente');
            ZQueryGrid.Refresh;

           end;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.Button3Click(Sender: TObject);
begin
  ZQueryGrid.Filtered:=FALSE;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.Button4Click(Sender: TObject);
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
 Hoja.Cells.Item[4,2]:='Codigo';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Nombre';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Dotación';
 Hoja.Cells.Item[4,4].ColumnWidth := 8;
 Hoja.Cells.Item[4,5]:='Ruta';
 Hoja.Cells.Item[4,5].ColumnWidth := 8;
 Hoja.Cells.Item[4,6]:='Municipio';
 Hoja.Cells.Item[4,6].ColumnWidth := 40;
 Hoja.Cells.Item[4,7]:='Tarifa';
 Hoja.Cells.Item[4,7].ColumnWidth := 8;
  Hoja.Cells.Item[4,8]:='Tipo de circulación';
 Hoja.Cells.Item[4,8].ColumnWidth := 25;



 with ZQueryGrid do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=DBGrid.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=DBGrid.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=DBGrid.Fields[2].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=DBGrid.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=DBGrid.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=DBGrid.Fields[5].AsString;
       Hoja.Cells.Item[i,8]:=DBGrid.Fields[10].AsString;
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
         Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total  '+IntToStr(ZQueryGrid.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.CancelarClick(
  Sender: TObject);
begin
   {deshabilitamos los campos de edit para evitar el ingreso de datos erroneo}
    Nombre.Enabled := FALSE;
    Dotacion.Enabled := FALSE;
    TipoCirculacion.Enabled := FALSE;
    Ruta.Enabled := FALSE;
    Tarifa.Enabled := FALSE;
    comboMunicipio.Enabled := FALSE;
    Calle.Enabled :=FALSE;
    Colonia.Enabled:=FALSE;
    Telefono.Enabled :=FALSe;
    Titular.Enabled:=FALSE;
    Alta.Visible :=TRUE;
    Aceptar.Visible := FALSE;
    Cancelar.Visible :=FALSE;
    tipoenpaque.Enabled:=FALSE;
    Modificar.Enabled:=FALSE;
    Aceptarm.Visible:=FALSE;
    Alta.Visible:=TRUE;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.CodigoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
filtro:String;
begin
  if codigo.Text<>'' then
     begin
   filtro:='Codigo = '+codigo.Text;
   ZQueryGrid.Filter:=filtro;
   ZQueryGrid.Filtered:=TRUE;
     end
   else begin
     ZQueryGrid.Filtered:=FALSE;
   end;


 //  codigo.Text:=DBGrid.Fields[0].AsString;
   Nombre.Text:=DBGRid.Fields[1].AsString;
   Dotacion.Text:=DBGrid.Fields[2].AsString;
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select id_tipo from c_tipo_circulacion where nombre_tipo="'+DBGrid.Fields[10].AsString+'"');
   ZQtmp.ExecSQL;
   ZQtmp.Open;
   TipoCirculacion.KeyValue:=ZQtmp.FieldByName('id_tipo').AsFloat;
   ZQtmp.Close;

   Ruta.KeyValue:=DBGrid.Fields[3].AsFloat;
   tarifa.Text:=DBGrid.Fields[5].AsString;
   //combomunicipio.KeyValue:=DBGrid.Fields[5].AsString;
   calle.Text:=DBGrid.Fields[6].AsString;
   colonia.Text:=DBGrid.Fields[7].AsString;
   telefono.Text:=DBGrid.Fields[8].AsString;
   titular.Text:=DBGrid.Fields[9].AsString;
   Modificar.Enabled:=TRUE;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.DataSource3DataChange(
  Sender: TObject; Field: TField);
begin
   ZQtotal.Close;
   ZQtotal.SQL.Clear;
   ZQTotal.SQL.Add('Select SUM(dotacion)AS Total from c_proveedores where activo="S"');
   ZQtotal.ExecSQL;
   ZQtotal.Open;
   total.Text:=ZQtotal.FieldByName('Total').AsString;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.DBGridCellClick(
  Column: TColumn);
begin
   codigo.Text:=DBGrid.Fields[0].AsString;
   Nombre.Text:=DBGRid.Fields[1].AsString;
   Dotacion.Text:=DBGrid.Fields[2].AsString;
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select id_tipo from c_tipo_circulacion where nombre_tipo="'+DBGrid.Fields[10].AsString+'"');
   ZQtmp.ExecSQL;
   ZQtmp.Open;
   TipoCirculacion.KeyValue:=ZQtmp.FieldByName('id_tipo').AsFloat;
   ZQtmp.Close;

   Ruta.KeyValue:=DBGrid.Fields[3].AsFloat;
   tarifa.Text:=DBGrid.Fields[5].AsString;
   //combomunicipio.KeyValue:=DBGrid.Fields[5].AsString;
   calle.Text:=DBGrid.Fields[6].AsString;
   colonia.Text:=DBGrid.Fields[7].AsString;
   telefono.Text:=DBGrid.Fields[8].AsString;
   titular.Text:=DBGrid.Fields[9].AsString;
   Modificar.Enabled:=TRUE;

end;

procedure TFC_Catalogo_proveedores_y_vendedores.DBGridKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key=#13) then
     begin
       //  ZQtmp.Close;
       //  ZQtmp.SQL.Clear;
       //  ZQtmp.SQL.Add('Update c_proveedores SET nombre='++',');
     end;  // fin del if de tecla precionada es Enter
end;

procedure TFC_Catalogo_proveedores_y_vendedores.DBGridTitleClick(
  Column: TColumn);
  var
  orden:String;
begin
   //ShowMessage('Columna:'+Column.Title.Caption);
   if Column.Title.Caption = 'Codigo' then
       orden:='id_proveedor';
   if Column.Title.Caption = 'Nombre' then
       orden:='nombre';
   if Column.Title.Caption = 'Dotación' then
       orden:='dotacion';
   if Column.Title.Caption = 'No ruta foranea' then
       orden:='Ruta';
   if Column.Title.Caption = 'Municipio' then
       orden:='Municipio';
   if Column.Title.Caption = 'Tarifa' then
       orden:='Tarifa';
   if Column.Title.Caption = 'calle' then
       orden:='calle';
   if Column.Title.Caption = 'colonia' then
       orden:='colonia';
   if Column.Title.Caption = 'telefono' then
       orden:='telefono';
   if Column.Title.Caption = 'titular' then
       orden:='titular';
   if Column.Title.Caption = 'Tipo_circulacion' then
       orden:='Tipo_circulacion';


      ZQueryGrid.Close;
      ZQueryGrid.SQL.Clear;
 //(Select Nombre_tipo from c_tipo_circulacion where c_tipo_circulacion.id_tipo=c_proveedores.tipo_circulacion) AS Tipo_circulacion from c_proveedores ORDER BY codigo;
      ZQueryGrid.SQL.Add('Select id_proveedor as "Codigo", nombre as Nombre, dotacion as "Dotación", Ruta as "No ruta foranea", Municipio, Tarifa,calle,colonia,telefono,titular,');
      ZQueryGrid.SQL.Add('(Select Nombre_tipo from c_tipo_circulacion where c_tipo_circulacion.id_tipo=c_proveedores.tipo_circulacion) AS Tipo_circulacion from c_proveedores ORDER BY '+orden);
      ZQueryGrid.ExecSQL;
      ZQueryGrid.Open;
      DBGrid.Refresh;

end;

procedure TFC_Catalogo_proveedores_y_vendedores.DotacionKeyPress(
  Sender: TObject; var Key: Char);
begin
     {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789,'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.modificarClick(Sender: TObject);
begin
    Nombre.Enabled:=TRUE;
    Dotacion.Enabled:=TRUE;
    Tipocirculacion.Enabled:=TRUE;
    Ruta.Enabled:=TRUE;
    Tarifa.Enabled:=TRUE;
    Tipoenpaque.Enabled:=TRUE;
    Combomunicipio.Enabled:=TRUE;
    calle.Enabled:=TRUE;
    colonia.Enabled:=TRUE;
    Telefono.Enabled:=TRUE;
    Titular.Enabled:=TRUE;
    Cancelar.Visible:=TRUE;
    Aceptarm.Visible:=TRUE;
    alta.Visible:=FALSE;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.Salir1Click(
  Sender: TObject);
begin
   FC_Catalogo_proveedores_y_vendedores.Close;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.tarifaKeyPress(Sender: TObject;
  var Key: Char);
begin
 {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789.'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.telefonoKeyPress(
  Sender: TObject; var Key: Char);
begin
 {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFC_Catalogo_proveedores_y_vendedores.ZQueryGridAfterScroll(
  DataSet: TDataSet);
begin
    if DBGrid.Fields[0].AsInteger=82 then
       begin
         Verdistribucindecortesias1.Visible:=TRUE;
       end
    else begin
       Verdistribucindecortesias1.Visible:=FALSE;
    end;


end;

procedure TFC_Catalogo_proveedores_y_vendedores.AceptarClick(
  Sender: TObject);
begin
 if tarifa.Text<>'' then
    begin
  {lipiamos el Zquery y realizamos la consulta de insertar datos a la tabla}
  ZQAlta_proveedor.Close;
  ZQAlta_proveedor.SQL.Clear;
  {ShowMessage('El id en tipo de circulación es: '+IntToStr(tipocirculacion.KeyValue));}
  ZQAlta_proveedor.SQL.Add('insert into c_proveedores (nombre,dotacion,tipo_circulacion,ruta,tarifa,municipio,calle,colonia,telefono,titular,empaque,kmunicipio) VALUES ("'+nombre.Text+'",'+dotacion.Text+','+FloatToStr(tipoCirculacion.KeyValue)+','+FloatToStr(ruta.KeyValue)+','+tarifa.Text+',"'+combomunicipio.Text+'","'+calle.Text+'","'+Colonia.Text+'","'+Telefono.Text+'","'+titular.Text+'","'+tipoenpaque.Text+'",'+FloatToStr(combomunicipio.KeyValue)+')');
  ZQAlta_proveedor.ExecSQL;
  ShowMessage('Se dio de alta el proveedor satisfactoriamente');
  ZqueryGrid.Active :=False;
  zqueryGrid.Active := TRUE;
  {Limpiamos los Edit y los desactivamos}
    Nombre.Text := '';
    Dotacion.Text := '';
    tarifa.Text := '';
    //comboMunicipio :='';
    Calle.Text :='';
    Colonia.Text := '';
    Telefono.Text :='';
    Titular.Text:='';
    Nombre.Enabled := FALSE;
    Dotacion.Enabled := FALSE;
    TipoCirculacion.Enabled := FALSE;
    Ruta.Enabled := FALSE;
    Tarifa.Enabled := FALSE;
    comboMunicipio.Enabled := FALSE;
    Calle.Enabled :=FALSE;
    Colonia.Enabled:=FALSE;
    Telefono.Enabled :=FALSe;
    Titular.Enabled:=FALSE;
    Alta.Visible :=TRUE;
    Aceptar.Visible := FALSE;
    Cancelar.Visible :=FALSE;
    tipoenpaque.Enabled:=FALSE;
    end
    else begin
      ShowMessage('Falta indicar la tarifa');
    end;

end;

end.
