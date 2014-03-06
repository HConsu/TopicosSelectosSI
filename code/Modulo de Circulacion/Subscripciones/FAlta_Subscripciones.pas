unit FAlta_Subscripciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGrids, StdCtrls, ZAbstractTable, jpeg, ExtCtrls, Menus,OleServer, Excel2000;

type
  TFSubscripciones = class(TForm)
    DBGridSubscriptor: TDBGrid;
    ZQSubscriptores: TZQuery;
    subscriptores: TDataSource;
    ZQSubscripciones: TZQuery;
    Subscripciones: TDataSource;
    Button1: TButton;
    DBGridSubscripciones: TDBGrid;
    Button2: TButton;
    Button4: TButton;
    Buscar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button6: TButton;
    Titular: TEdit;
    RFC: TEdit;
    NoEmpleado: TEdit;
    Label4: TLabel;
    CheckTitular: TCheckBox;
    CheckRFC: TCheckBox;
    CheckNoEmpleado: TCheckBox;
    actualizar: TButton;
    Button5: TButton;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    ModifSub: TButton;
    Label5: TLabel;
    totals1: TLabel;
    ZQtmp: TZQuery;
    Label6: TLabel;
    totals2: TLabel;
    ZQalta: TZQuery;
    Button7: TButton;
    nosubscriptorb: TEdit;
    Button8: TButton;
    ZQb: TZQuery;
    bsubscripcion: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Button9: TButton;
    Excel: TExcelApplication;
    Button10: TButton;
    ZQreactivar: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure DBGridSubscriptorCellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure actualizarClick(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
    procedure CheckTitularClick(Sender: TObject);
    procedure CheckRFCClick(Sender: TObject);
    procedure CheckNoEmpleadoClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure ModifSubClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure nosubscriptorbKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button8Click(Sender: TObject);
    procedure ZQSubscriptoresAfterScroll(DataSet: TDataSet);
    procedure TitularKeyPress(Sender: TObject; var Key: Char);
    procedure RFCKeyPress(Sender: TObject; var Key: Char);
    procedure NoEmpleadoKeyPress(Sender: TObject; var Key: Char);
    procedure subscriptoresDataChange(Sender: TObject; Field: TField);
    procedure bsubscripcionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    no_de_subscriptor_public:string;
    no_de_subscripcion_public:string;
    {Public declarations}
  end;

var
  FSubscripciones: TFSubscripciones;

implementation

uses FNuevaSubscripcion, FAlta_de_subscriptor, F_Modificar_Subscripcion,
  FCancelar_subscripcion, FModificar_subscriptor,fprincipal,FR_Notificacion_alta,
  FCambio_Subscriptor, FR_Alta_Subscripcion,FReactivar_suscripcion;

{$R *.dfm}

procedure TFSubscripciones.actualizarClick(Sender: TObject);
var
valor:String;
begin
   valor:=DBGridSubscriptor.Fields[0].AsString;
   no_de_subscriptor_public:=DBGridSubscriptor.Fields[0].AsString;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select * from t_subscripcion where NoSubscriptor ='+valor);
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Active := TRUE;
   DBgridSubscriptor.Refresh;
   ZQSubscriptores.Close;
   ZQSubscriptores.SQL.Clear;
   ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor');
   ZQSubscriptores.ExecSQL;
   ZQSubscriptores.Open;
   ZQSubscriptores.Refresh;


end;

procedure TFSubscripciones.Button10Click(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin

 i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[1,1].ColumnWidth := 2;

 Hoja.Cells.Item[2,3]:='Listado de subscriptores';
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='NoSubscriptor';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Titular';
 Hoja.Cells.Item[4,3].ColumnWidth := 40;
 Hoja.Cells.Item[4,4]:='Fecha Alta';
 Hoja.Cells.Item[4,4].ColumnWidth := 16;
 Hoja.Cells.Item[4,5]:='RFC';
 Hoja.Cells.Item[4,5].ColumnWidth := 20;
 Hoja.Cells.Item[4,6]:='EMAIL';
 Hoja.Cells.Item[4,6].ColumnWidth := 40;
 Hoja.Cells.Item[4,7]:='Calle';
 Hoja.Cells.Item[4,7].ColumnWidth := 40;
 Hoja.Cells.Item[4,8]:='Colonia';
 Hoja.Cells.Item[4,8].ColumnWidth := 30;
 Hoja.Cells.Item[4,8]:='Ciudad';
 Hoja.Cells.Item[4,8].ColumnWidth := 25;
 Hoja.Cells.Item[4,8]:='CP';
 Hoja.Cells.Item[4,8].ColumnWidth := 25;


with ZQSubscriptores do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=DBGridSubscriptor.Fields[0].AsString;
       Hoja.Cells.Item[i,3]:=DBGridSubscriptor.Fields[1].AsString;
       Hoja.Cells.Item[i,4]:=DBGridSubscriptor.Fields[2].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=DBGridSubscriptor.Fields[3].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=' '+DBGridSubscriptor.Fields[4].AsString;
       Hoja.Cells.Item[i,7]:=DBGridSubscriptor.Fields[6].AsString;
       Hoja.Cells.Item[i,7].WrapText:=TRUE;
       Hoja.Cells.Item[i,8]:=DBGridSubscriptor.Fields[7].AsString;
       Hoja.Cells.Item[i,8].WrapText:=TRUE;
       Hoja.Cells.Item[i,9]:=DBGridSubscriptor.Fields[8].AsString;
       Hoja.Cells.Item[i,9].WrapText:=TRUE;
       Hoja.Cells.Item[i,10]:=DBGridSubscriptor.Fields[9].AsString;
       Hoja.Cells.Item[i,11]:=DBGridSubscriptor.Fields[10].AsString;
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
         Hoja.Range['i'+IntToStr(b),'i'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['j'+IntToStr(b),'j'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['k'+IntToStr(b),'k'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      i:=i+3;
      Hoja.Cells.Item[i,2]:='Total  '+IntToStr(ZQSubscriptores.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
end;

procedure TFSubscripciones.Button1Click(Sender: TObject);
begin
if FprincipalCirculacion.permiso('301') then
    begin
  FprincipalCirculacion.quienllamanueva:=1;
  no_de_subscripcion_public := DBGridSubscripciones.Fields[0].AsString;
  FNueva_Subscripcion.Enabled := FALSE;
  FNueva_Subscripcion := TFNueva_Subscripcion.Create(self);
  FNueva_Subscripcion.ShowModal;
    end
    else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;

end;

procedure TFSubscripciones.Button2Click(Sender: TObject);
begin
  if FPrincipalCirculacion.permiso('301') then
     begin
   FAlta_subscriptor.Enabled :=FALSE;
   FAlta_subscriptor :=TFAlta_subscriptor.Create(self);
   FAlta_Subscriptor.ShowModal;
     end
    else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFSubscripciones.Button3Click(Sender: TObject);
begin
   FCambioSubscriptor.Enabled:=FALSE;
   FCambioSubscriptor := TFCambioSubscriptor.Create(self);
   FCambioSubscriptor.Showmodal;
end;

procedure TFSubscripciones.Button4Click(Sender: TObject);
begin
 if FprincipalCirculacion.permiso('304') then
     begin
   FCancelaciones.Enabled:=FALSE;
   FCancelaciones := TFCancelaciones.Create(self);
   FCancelaciones.ShowModal;
     end
     else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFSubscripciones.Button5Click(Sender: TObject);
begin
  if Fprincipalcirculacion.permiso('303') then
    begin
   no_de_subscripcion_public := DBGridSubscripciones.Fields[0].AsString;
   FPrincipalCirculacion.numerodesubscripcion:=no_de_subscripcion_public;
   FModificar_Subscripcion.Enabled := FALSE;
   FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
   FModificar_Subscripcion.ShowModal;
    end
    else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;

end;

procedure TFSubscripciones.Button6Click(Sender: TObject);
begin

  no_de_subscripcion_public := DBGridSubscripciones.Fields[0].AsString;

  if DBGridSubscripciones.Fields[3].AsInteger=0 then
    begin
   ZQalta.Close;
   ZQalta.SQL.Clear;
   ZQAlta.SQL.Add('Select nosubscripcion,Nosubscriptor,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
   ZQAlta.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
   ZQAlta.ExecSQL;
   ZQAlta.Open;

  FRAltaSubscripcion.fechainicio.Caption:=ZQAlta.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscripcion.Caption:=ZQAlta.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQAlta.FieldByName('nosubscriptor').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQAlta.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQAlta.FieldByName('telefono').AsString;
  FRAltaSubscripcion.calle.Caption:=ZQAlta.FieldByName('calle').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQAlta.FieldByName('ruta').AsString;
  FRAltaSubscripcion.colonia.Caption:=ZQAlta.FieldByName('colonia').AsString;
  FRAltaSubscripcion.cp.Caption:=ZQAlta.FieldByName('cp').AsString;
  FRAltaSubscripcion.ciudad.Caption:=ZQAlta.FieldByName('ciudad').AsString;
  FRAltaSubscripcion.observaciones.Caption:=ZQAlta.FieldByName('observaciones').AsString;
  FRAltaSubscripcion.descripcion.Caption:=ZQAlta.FieldByName('descripcion_domicilio').AsString;
  FRAltaSubscripcion.user.Caption:='Jefe de circulacion';
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;
    end;
 if DBGridSubscripciones.Fields[3].AsInteger>0 then
    begin
   ZQalta.Close;
   ZQalta.SQL.Clear;
   ZQAlta.SQL.Add('Select descripcion from c_edificios where id_edificio='+DBGridSubscripciones.Fields[3].AsString);
   ZQAlta.ExecSQL;
   ZQAlta.Open;
   FRAltaSubscripcion.calle.Caption:=ZQAlta.FieldByName('descripcion').AsString;

   ZQalta.Close;
   ZQalta.SQL.Clear;
   ZQAlta.SQL.Add('Select t_subscripcion.nosubscripcion,nosubscriptor,Atenciona,Ruta,Fecha_inicio,Telefono,observaciones,area from t_subscripcion JOIN t_descripcion_ruta_edificio ON ');
   ZQAlta.SQL.Add('(t_subscripcion.nosubscripcion = t_descripcion_ruta_edificio.nosubscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public );
   ZQAlta.ExecSQL;
   ZQAlta.Open;

  FRAltaSubscripcion.colonia.Caption:=ZQAlta.FieldByName('area').AsString;
  FRAltaSubscripcion.fechainicio.Caption:=ZQAlta.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscripcion.Caption:=ZQAlta.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQAlta.FieldByName('nosubscriptor').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQAlta.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQAlta.FieldByName('telefono').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQAlta.FieldByName('ruta').AsString;
  FRAltaSubscripcion.user.Caption:='Jefe de circulacion';
  FRAltaSubscripcion.observaciones.Caption:='';
  FRAltaSubscripcion.descripcion.Caption:='';
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;

    end;


  //ShowMessage('Se incrementa el numero del folio');

end;

procedure TFSubscripciones.Button7Click(Sender: TObject);
var
folio:String;
edif:Integer;
begin
  ZQAlta.Close;
  ZQalta.SQL.Clear;
  ZQAlta.SQL.Add('Select Max(Folio)AS folio from t_cambio_domicilio where NoSubscripcion='+DBGridSubscripciones.Fields[0].ASString);
  ZQAlta.ExecSQL;
  ZQAlta.Open;
  if ZQalta.FieldByName('folio').IsNull=FALSE then
     begin
   folio:=ZQAlta.FieldByName('folio').AsString;
   FRNotificacionalta.Enabled:=FALSE;
   FRNotificacionalta := TFRNotificacionalta.Create(self);

    ///// Determinamos si el cambio de domicilio deberia ser en un edificio por medio del grid, si se cambia en orden de la
    ///  presentacion de los datos en el grid se debera cambiar tambien esta condicion o la obtencion del parametro.
    ///
   edif:= DBGridSubscripciones.Fields[3].AsInteger;
     if edif=0 then
       begin
  no_de_subscripcion_public := DBGridSubscripciones.Fields[0].AsString;
  ZQalta.Close;
  ZQalta.SQL.Clear;
  ZQAlta.SQL.Add('Select nosubscripcion,nosubscriptor,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
  ZQAlta.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQAlta.ExecSQL;
  ZQAlta.Open;

  FRNotificacionalta.fechainicio.Caption:=ZQAlta.FieldByName('fecha_inicio').AsString;
  FRNotificacionalta.nosubscripcion.Caption:=ZQAlta.FieldByName('nosubscripcion').AsString;
  FRNotificacionalta.nosubscriptor.Caption:=ZQAlta.FieldByName('nosubscriptor').AsString;
  FRNotificacionalta.nombre.Caption:=ZQAlta.FieldByName('atenciona').AsString;
  FRNotificacionalta.telefono.Caption:=ZQAlta.FieldByName('telefono').AsString;
  FRNotificacionalta.calle.Caption:=ZQAlta.FieldByName('calle').AsString;
  FRNotificacionalta.ruta.Caption:=ZQAlta.FieldByName('ruta').AsString;
  FRNotificacionalta.colonia.Caption:=ZQAlta.FieldByName('colonia').AsString;
  FRNotificacionalta.cp.Caption:=ZQAlta.FieldByName('cp').AsString;
  FRNotificacionalta.ciudad.Caption:=ZQAlta.FieldByName('ciudad').AsString;
  FRNotificacionalta.observaciones.Caption:=ZQAlta.FieldByName('observaciones').AsString;
  FRNotificacionalta.descripcion.Caption:=ZQAlta.FieldByName('descripcion_domicilio').AsString;
  FRNotificacionalta.folio.caption:=folio;
  FRNotificacionalta.user.Caption:='Jefe de circulacion';
  FRNotificacionalta.Notificacion.Prepare;
  FRNotificacionalta.Notificacion.Preview;
       end
   else begin
   // ShowMessage('Se cambio el domicilio a un edificio');
    no_de_subscripcion_public := DBGridSubscripciones.Fields[0].AsString;
  ZQalta.Close;
  ZQalta.SQL.Clear;
  ZQAlta.SQL.Add('Select t_subscripcion.nosubscripcion,nosubscriptor,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,area,(Select descripcion from c_edificios where c_edificios.id_edificio=');
  ZQAlta.SQL.Add('t_subscripcion.edificio)AS Edificio from t_subscripcion JOIN t_descripcion_ruta_edificio ON (t_subscripcion.nosubscripcion = t_descripcion_ruta_edificio.nosubscripcion)');
  ZQalta.SQL.Add('where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQAlta.ExecSQL;
  ZQAlta.Open;

  FRNotificacionalta.fechainicio.Caption:=ZQAlta.FieldByName('fecha_inicio').AsString;
  FRNotificacionalta.nosubscripcion.Caption:=ZQAlta.FieldByName('nosubscripcion').AsString;
  FRNotificacionalta.nosubscriptor.Caption:=ZQAlta.FieldByName('nosubscriptor').AsString;
  FRNotificacionalta.nombre.Caption:=ZQAlta.FieldByName('atenciona').AsString;
  FRNotificacionalta.telefono.Caption:=ZQAlta.FieldByName('telefono').AsString;
  FRNotificacionalta.calle.Caption:=ZQAlta.FieldByName('Edificio').AsString;
  FRNotificacionalta.ruta.Caption:=ZQAlta.FieldByName('ruta').AsString;
  FRNotificacionalta.colonia.Caption:=ZQAlta.FieldByName('Area').AsString;
 // FRNotificacionalta.cp.Caption:=ZQAlta.FieldByName('cp').AsString;
 // FRNotificacionalta.ciudad.Caption:=ZQAlta.FieldByName('ciudad').AsString;
  FRNotificacionalta.observaciones.Caption:=ZQAlta.FieldByName('observaciones').AsString;
 // FRNotificacionalta.descripcion.Caption:=ZQAlta.FieldByName('descripcion_domicilio').AsString;
  FRNotificacionalta.folio.caption:=folio;
  FRNotificacionalta.user.Caption:='Jefe de circulacion';
  FRNotificacionalta.Notificacion.Prepare;
  FRNotificacionalta.Notificacion.Preview;
   end;
      end
    else begin
      ShowMessage('No se han encontrado cambios de domicilio para esta dirección');
    end;
end;

procedure TFSubscripciones.Button8Click(Sender: TObject);
begin
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Insert into t_codigos_imprimir (codigo) VALUES ('+DBGridSubscripciones.Fields[17].AsString+')');
  ZQtmp.ExecSQL;
  ShowMessage('Se agrego a la lista para imprimir el codigo de la subscripción');
end;

procedure TFSubscripciones.Button9Click(Sender: TObject);
begin

    FReactivar.Enabled:=FALSE;
    FReactivar := TFReactivar.Create(self);
    FReactivar.ShowModal;

end;

procedure TFSubscripciones.BuscarClick(Sender: TObject);
begin
  {Buscamos los clientes subscriptores en base al criterio de busqueda}
  if CheckRFC.Checked = TRUE then
      begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where RFC LIKE "%'+RFC.Text+'%"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
      end;
  if CheckTitular.Checked = TRUE then
      begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where Titular LIKE "%'+Titular.Text+'%"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
      end;
  if CheckNoEmpleado.Checked = TRUE then
      begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where NoEmpleadoUAEH LIKE "%'+Noempleado.Text+'%"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
      end;


  {Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor}

end;

procedure TFSubscripciones.CheckNoEmpleadoClick(Sender: TObject);
begin
    if CheckNoEmpleado.Checked = TRUE then
      begin
      NoEmpleado.Enabled :=TRUE;
      RFC.Enabled := FALSE;
      Titular.Enabled:=FALSE;
      CheckRFC.Checked := FALSE;
      CheckTitular.Checked:=FALSE;
      Noempleado.SetFocus;
      end;
    if CheckNoEmpleado.Checked = FALSE then
      begin
      NoEmpleado.Enabled :=FALSE;
      end;
end;

procedure TFSubscripciones.CheckRFCClick(Sender: TObject);
begin
    if CheckRFC.Checked = TRUE then
      begin
      RFC.Enabled := TRUE;
      NoEmpleado.Enabled :=FALSE;
      Titular.Enabled:=FALSE;
      CheckTitular.Checked:=FALSE;
      CheckNoEmpleado.Checked:=FALSE;
      RFC.SetFocus;
      end;
    if CheckRFC.Checked = FALSE then
      begin
      RFC.Enabled := FALSE;
      end;
end;

procedure TFSubscripciones.CheckTitularClick(Sender: TObject);
begin
  if CheckTitular.Checked = TRUE then
      begin
      Titular.Enabled:=TRUE;
      RFC.Enabled := FALSE;
      NoEmpleado.Enabled :=FALSE;
      CheckRFC.Checked := FALSE;
      CheckNoEmpleado.Checked:=FALSE;
      Titular.SetFocus;
      end;
 if CheckTitular.Checked = FALSE then
      begin
      Titular.Enabled:=FALSE;
      end;


end;

procedure TFSubscripciones.DBGridSubscriptorCellClick(Column: TColumn);
var
   valor :string;
begin
    {tomamos el valor seleccionado en el primer grid  para mostrar los datos de las subscripciones en el segundo}

    valor:=DBGridSubscriptor.Fields[0].AsString;
    no_de_subscriptor_public:=DBGridSubscriptor.Fields[0].AsString;
    ZQSubscripciones.SQL.Clear;
    ZQSubscripciones.SQL.Add('Select * from t_subscripcion where NoSubscriptor ='+valor);
    ZQSubscripciones.ExecSQL;
    ZQSubscripciones.Active := TRUE;
    DBgridSubscriptor.Refresh;

    {showMessage('El valor es: '+valor);}
end;


procedure TFSubscripciones.bsubscripcionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
filtro:String;
begin
 if bsubscripcion.Text<>'' then
  begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select Nosubscriptor from t_subscripcion where nosubscripcion='+bsubscripcion.Text);
    ZQtmp.ExecSQL;
    Zqtmp.Open;

    if ZQtmp.FieldByName('Nosubscriptor').IsNull=FALSE then
      begin
    nosubscriptorb.Text:=Zqtmp.FieldByName('Nosubscriptor').AsString;
    filtro:='"No Subscriptor" = '+Zqtmp.FieldByName('Nosubscriptor').AsString;
    ZQSubscriptores.Filter:=filtro;
    ZQSubscriptores.Filtered:=TRUE;
      end
     else begin
    ZQSubscriptores.Filter:=filtro;
    ZQSubscriptores.Filtered:=TRUE;
     end;


  end
  else begin
    ZQSubscriptores.Filtered:=FALSE;
  end;

end;

procedure TFSubscripciones.nosubscriptorbKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
filtro:String;
begin
if nosubscriptorb.Text<>'' then
  begin
    filtro:='"No Subscriptor" = '+nosubscriptorb.Text;
    ZQSubscriptores.Filter:=filtro;
    ZQSubscriptores.Filtered:=TRUE;
  end
  else begin
    ZQSubscriptores.Filtered:=FALSE;
  end;


end;

procedure TFSubscripciones.RFCKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where RFC LIKE "%'+RFC.Text+'%"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
  end;
end;

procedure TFSubscripciones.FormShow(Sender: TObject);
begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select count(*) as total from t_subscripcion');
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    totals1.caption:= Zqtmp.FieldByName('total').AsString;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select count(*) as total from t_cliente_subscriptor where estatus = "Activo"');
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    totals2.Caption:=ZQtmp.FieldByName('total').AsString;

end;

procedure TFSubscripciones.ModifSubClick(Sender: TObject);
begin
 if FPrincipalCirculacion.permiso('301') then
    begin
  FModif_subscriptor.Enabled:=FALSE;
  FModif_subscriptor := TFModif_subscriptor.Create(self);
  FModif_subscriptor.Showmodal;
    end
  else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFSubscripciones.NoEmpleadoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where NoEmpleadoUAEH = "'+Noempleado.Text+'"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
    end;
end;

procedure TFSubscripciones.Salir1Click(Sender: TObject);
begin
   FSubscripciones.Close;
end;

procedure TFSubscripciones.subscriptoresDataChange(Sender: TObject;
  Field: TField);
var
   valor :string;
begin
    {tomamos el valor seleccionado en el primer grid  para mostrar los datos de las subscripciones en el segundo}

    valor:=DBGridSubscriptor.Fields[0].AsString;
    no_de_subscriptor_public:=DBGridSubscriptor.Fields[0].AsString;
    ZQSubscripciones.SQL.Clear;
    ZQSubscripciones.SQL.Add('Select * from t_subscripcion where NoSubscriptor ='+valor);
    ZQSubscripciones.ExecSQL;
    ZQSubscripciones.Active := TRUE;
    DBgridSubscriptor.Refresh;

    {showMessage('El valor es: '+valor);}
end;

procedure TFSubscripciones.TitularKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    begin
     ZQSubscriptores.Close;
     ZQSubscriptores.SQL.Clear;
     ZQSubscriptores.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where Titular LIKE "%'+Titular.Text+'%"');
     ZQSubscriptores.ExecSQL;
     ZQSubscriptores.Open;
    end;
end;

procedure TFSubscripciones.ZQSubscriptoresAfterScroll(DataSet: TDataSet);
var
   valor :string;
begin
   {tomamos el valor seleccionado en el primer grid  para mostrar los datos de las subscripciones en el segundo}

    valor:=DBGridSubscriptor.Fields[0].AsString;
    no_de_subscriptor_public:=DBGridSubscriptor.Fields[0].AsString;
    ZQSubscripciones.SQL.Clear;
    ZQSubscripciones.SQL.Add('Select * from t_subscripcion where NoSubscriptor ='+valor);
    ZQSubscripciones.ExecSQL;
    ZQSubscripciones.Active := TRUE;
    DBgridSubscriptor.Refresh;

    {showMessage('El valor es: '+valor);}
end;

end.
