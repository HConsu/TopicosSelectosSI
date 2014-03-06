unit FCaptura_pagos_x_distribuidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  DBCtrls, StdCtrls, Menus, jpeg, ExtCtrls, ZAbstractTable, ComCtrls, OleServer,
  Excel2000;

type
  TFCapturaXdistribuidor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Codigo: TEdit;
    ComboDis: TDBLookupComboBox;
    GridDis: TDBGrid;
    ZQDistribuidor: TZQuery;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    DSdistribuidor: TDataSource;
    ZQGridD: TZQuery;
    DSGridDis: TDataSource;
    ZQtmp: TZQuery;
    Label3: TLabel;
    verpagos: TButton;
    Marcarp: TButton;
    ImprimirE: TButton;
    corte: TButton;
    Capturdepagos1: TMenuItem;
    Menejodedotaciones1: TMenuItem;
    Remisiones1: TMenuItem;
    Label4: TLabel;
    fechaedicion: TDateTimePicker;
    Label5: TLabel;
    noedicion: TEdit;
    Label7: TLabel;
    totaldotacion: TLabel;
    totaldevolucion: TLabel;
    totalvendido: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    impremision: TButton;
    exel: TButton;
    Excel: TExcelApplication;
    ZQtdot: TZQuery;
    Administracionderutas1: TMenuItem;
    PopupMenu1: TPopupMenu;
    AgregarIncidente1: TMenuItem;
    Agregarincidenteglobal1: TMenuItem;
    nota: TLabel;
    procedure Salir1Click(Sender: TObject);
    procedure CodigoKeyPress(Sender: TObject; var Key: Char);
    procedure ComboDisClick(Sender: TObject);
    procedure CodigoChange(Sender: TObject);
    procedure GridDisKeyPress(Sender: TObject; var Key: Char);
    procedure GridDisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure verpagosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MarcarpClick(Sender: TObject);
    procedure ImprimirEClick(Sender: TObject);
    procedure corteClick(Sender: TObject);
    procedure Capturdepagos1Click(Sender: TObject);
    procedure Menejodedotaciones1Click(Sender: TObject);
    procedure fechaedicionCloseUp(Sender: TObject);
    procedure noedicionKeyPress(Sender: TObject; var Key: Char);
    procedure GridDisTitleClick(Column: TColumn);
    procedure exelClick(Sender: TObject);
    procedure Administracionderutas1Click(Sender: TObject);
    procedure Remisiones1Click(Sender: TObject);
    procedure AgregarIncidente1Click(Sender: TObject);
    procedure GridDisCellClick(Column: TColumn);
    procedure Agregarincidenteglobal1Click(Sender: TObject);
    procedure GridDisDblClick(Sender: TObject);
    type THackDBGrid = class(TDBGrid);
  private
    { Private declarations }
    vertodos:integer;
    marcar:integer;
    edicionactual:integer;
    controlgrid:integer;
    {controlgrid :1 Captura de pagos
    controlgrid :2 Manejo de dotaciones
    controlgrid :3 Remisiones}
    ordenconsulta:String;
  public
    { Public declarations }
  end;

var
  FCapturaXdistribuidor: TFCapturaXdistribuidor;

implementation

uses FREstado_de_Cuenta, FCorte_circulacion,FAutorizacion,FPrincipal,ComObj,
  FAdministracion_rutas,FRemision_ruta,F_Incidencias_Descripcion,
  FIncidencia_global_circulacion,Finfo_proveedor;

{$R *.dfm}

procedure TFCapturaXdistribuidor.Administracionderutas1Click(Sender: TObject);
begin
   FAdmon_rutas.Enabled:=FALSE;
   FAdmon_rutas := TFAdmon_rutas.Create(self);
   FAdmon_rutas.ShowModal;
end;

procedure TFCapturaXdistribuidor.AgregarIncidente1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

{-----------------------------------------}
   ds := THackDBGrid(Griddis).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(Griddis).Row;
   row := ds.RecNo;
{-------------------------------------------}


   FIncidenciasDescripcion.Enabled:=FALSE;
   FIncidenciasdescripcion := TFIncidenciasdescripcion.Create(self);
   FIncidenciasdescripcion.ShowModal;

   ZQgridD.Refresh;
{--------- Actualizamos la posicion en el grid----}
    with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
   end;
{-------Fin actualizar posiscion en grid--------}

end;

procedure TFCapturaXdistribuidor.Agregarincidenteglobal1Click(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

{-----------------------------------------}
   ds := THackDBGrid(Griddis).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(Griddis).Row;
   row := ds.RecNo;
{-------------------------------------------}

/// nueva ventana de incidencia goblal
 FIncidenciaGlobal.Enabled:=FALSE;
 FIncidenciaGlobal := TFIncidenciaGlobal.Create(self);
 FIncidenciaGlobal.ShowModal;

 ZQgridD.Refresh;
{--------- Actualizamos la posicion en el grid----}
    with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
   end;
{-------Fin actualizar posiscion en grid--------}
end;

procedure TFCapturaXdistribuidor.Capturdepagos1Click(Sender: TObject);
begin
   ZQGridD.Close;
   GridDis.Refresh;
   controlgrid:=1;
   Label3.Caption:='Solo se mostraran las fechas y ediciones que están pendientes de pago, para ver  todo el listado de pagos haga clic en “Ver todos los pagos” y seleccione el proveedor';
   Label3.Visible:=TRUE;
   Label1.Visible:=TRUE;
   Label2.Visible:=TRUE;
   Codigo.Visible:=TRUE;
   ComboDis.Visible:=TRUE;
   verpagos.Visible:=TRUE;
   Marcarp.Visible:=TRUE;
   ImprimirE.Visible:=FALSE;
   corte.Visible:=TRUE;
   GridDis.Visible:=TRUE;
   Label4.Visible:=FALSE;
   Label5.Visible:=FALSE;
   fechaedicion.Visible:=FALSE;
   noedicion.Visible:=FALSE;
   Label7.Visible:=FALSE;
   totaldotacion.Visible:=FALSE;
   totaldevolucion.Visible:=FALSE;
   totalvendido.Visible:=FALSE;
   Label6.Visible:=FALSE;
   Label8.Visible:=FALSE;
   impremision.Visible:=FALSE;
   exel.Visible:=FALSE;
end;

procedure TFCapturaXdistribuidor.CodigoChange(Sender: TObject);
begin
if codigo.Text<>'' then
         begin
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select nombre,id_proveedor from c_proveedores where id_proveedor='+codigo.Text);
   ZQtmp.ExecSQL;
   ZQtmp.Open;
   if ZQtmp.FieldByName('id_proveedor').IsNull = FALSE then
           begin
   Combodis.KeyValue:=ZQtmp.FieldByName('id_proveedor').AsFloat;
   codigo.Text:=FloatToStr(combodis.KeyValue);
           end;
   if (vertodos=1) then
      begin
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
    end;
end;

procedure TFCapturaXdistribuidor.CodigoKeyPress(Sender: TObject; var Key: Char);
begin
     {Revisamos que en el campo no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;

end;

procedure TFCapturaXdistribuidor.ComboDisClick(Sender: TObject);
begin
  //ShowMessage(IntToStr(edicionactual)+' '+codigo.Text);
    codigo.Text:=FloatToStr(combodis.KeyValue);
      if (vertodos=1) then
      begin
    //  ShowMessage(IntToStr(edicionactual)+' '+codigo.Text);

     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select Codigo,Nombre,Fecha,Edicion,tarifa,Dotacion,Devolucion,Pago,Adeudo from v_pagos where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select Codigo,Nombre,Fecha,Edicion,tarifa,Dotacion,Devolucion,Pago,Adeudo from v_pagos where codigo='+codigo.Text+' AND Scorte <> "PA"  AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;

end;

procedure TFCapturaXdistribuidor.corteClick(Sender: TObject);
begin
   FPrincipalCirculacion.autorizacionquerida:=3;
    FPassword.Enabled:=FALSE;
    FPassword := TFpassword.Create(Self);
    FPassword.ShowModal;
    if FPassword.autorizado=1 then
       begin
     Fcorte.Enabled:=FALSE;
     Fcorte := TFcorte.Create(self);
     Fcorte.ShowModal;
       end;
end;

procedure TFCapturaXdistribuidor.exelClick(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
begin
 i:=2;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
 Hoja.Cells.Item[2,1]:='Nombre';
 Hoja.Cells.Item[2,2]:='Fecha';
 Hoja.Cells.Item[2,3]:='Edicion';
 Hoja.Cells.Item[2,4]:='Codigo_Proveedor';
 Hoja.Cells.Item[2,5]:='Tarifa';
 Hoja.Cells.Item[2,6]:='Dotacion';
 Hoja.Cells.Item[2,7]:='Devolucion';
 Hoja.Cells.Item[2,8]:='Vendidos';

 with ZQGridD do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,1]:=GridDis.Fields[0].AsString;
       Hoja.Cells.Item[i,2]:=GridDis.Fields[1].AsString;
       Hoja.Cells.Item[i,3]:=GridDis.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=GridDis.Fields[3].AsString;
       Hoja.Cells.Item[i,5]:=GridDis.Fields[4].AsString;
       Hoja.Cells.Item[i,6]:=GridDis.Fields[5].AsString;
       Hoja.Cells.Item[i,7]:=GridDis.Fields[6].AsString;
       Hoja.Cells.Item[i,8]:=GridDis.Fields[7].AsString;
       Next;
       end;//while
    end;//with
    For b:=2 to i do
        begin
         Hoja.Range['a'+IntToStr(b),'a'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['b'+IntToStr(b),'b'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['f'+IntToStr(b),'f'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['g'+IntToStr(b),'g'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['h'+IntToStr(b),'h'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      Excel.Visible[1]:=true;
end;

procedure TFCapturaXdistribuidor.fechaedicionCloseUp(Sender: TObject);
var
edicion:integer;
begin
   controlgrid:=2;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(fechaedicion.Date)+'" limit 1');
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   edicion:=ZQGridD.FieldByName('edicion').AsInteger;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select SUM(dotacion) AS Dotacion,SUM(devolucion) AS Devolucion, SUM(vendidos) AS Venta from v_dotaciones_circulacion Where edicion ='+IntToStr(edicion));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   totaldotacion.Caption:=ZQGridD.FieldByName('Dotacion').AsString;
   totaldevolucion.Caption:=ZQGridD.FieldByName('devolucion').AsString;
   totalvendido.Caption:=ZQGridD.FieldByName('venta').AsString;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_dotaciones_circulacion where edicion='+IntToStr(edicion));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGridD.Active:=TRUE;
   GridDis.Refresh;
   {----------------------------fin de llenado del grid--------------------------------------}

end;

procedure TFCapturaXdistribuidor.FormShow(Sender: TObject);
var fechaactual:String;
begin
{Primero obtenemos el numero de edicion correspondiente al dia de hoy}
   fechaactual:=DateToStr(now()-1);
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select max(edicion) AS Edicion from t_remision_rutas');
   ZQtmp.Open;
   edicionactual:=ZQtmp.FieldByName('edicion').AsInteger;
{------ fin de determinacion de edicion actual-----------------------}
   vertodos:=0;
   marcar:=0;
   verpagos.Caption:='Ver todos los pagos';
   Marcarp.Enabled:=FALSE;

end;

procedure TFCapturaXdistribuidor.GridDisCellClick(Column: TColumn);
begin
 if GridDis.Fields[9].AsInteger=1 then
    begin
   nota.Caption:='Existe una incidencia registrada en esta fecha para el  proveedor seleccionado';
    end;
  if GridDis.Fields[9].AsInteger=0 then
   begin
   nota.Caption:='';
  end;

end;

procedure TFCapturaXdistribuidor.GridDisDblClick(Sender: TObject);
begin
    FInfoProveedor.Close;
    FInfoProveedor.Enabled;
    FinfoProveedor := TFInfoProveedor.Create(self);
    FInfoProveedor.Show;
end;

procedure TFCapturaXdistribuidor.GridDisDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if controlgrid=1 then
        begin    {inicio control grid = 1}
     if marcar=1 then
         begin
         if (GridDis.Fields[8].AsFloat) = 0 then
           begin
          GridDis.Canvas.Brush.Color := clGreen;
          // Manda pintar la celda
          GridDis.DefaultDrawColumnCell(rect,DataCol,Column,State);
           end;
        end;
     if marcar=0 then
         begin
         if (GridDis.Fields[8].AsFloat) = 0 then
           begin
          GridDis.Canvas.Brush.Color := clWindow;
          // Manda pintar la celda
          GridDis.DefaultDrawColumnCell(rect,DataCol,Column,State);
           end;
        end;
     end;  {fin del controlgrid = 1}


 if controlgrid=2 then
        begin    {inicio control grid = 2}

     if (GridDis.Fields[9].ASInteger) = 1 then
           begin
          GridDis.Canvas.Brush.Color := clGreen;
          //GridDis.Font.Color:=clWhite;
          // Manda pintar la celda
          GridDis.DefaultDrawColumnCell(rect,DataCol,Column,State);
           end;


   {   if (GridDis.Fields[9].AsInteger) = 0 then
           begin
          GridDis.Canvas.Brush.Color := clWindow;
          //GridDis.Font.Color:=clBlack;
          // Manda pintar la celda
          GridDis.DefaultDrawColumnCell(rect,DataCol,Column,State);
           end;      }
     end;  {fin del controlgrid = 2}


end;

procedure TFCapturaXdistribuidor.GridDisKeyPress(Sender: TObject; var Key: Char);
var
devolucion,Pago,adeudo,vendidos,dotacion,empaque:String;
edicion,estatuscorte:String;
codigoprov:String;
{variables para control del corte}
devc,dotc,pagc,adeuc,tarifac:double;
fila,columna:integer;
edicions:Integer;
dotdevtarif:double;  // variable para resolver problema en la evaluacion del corte
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
//  x:=GRidDis.SelectedIndex;
//  y:=ZQgridD.RecNo;
   if key=#40 then
      begin
        ShowMessage('Cambio');
      end;

  if (Key=#13) then
     begin
      if controlgrid=1 then
          begin
     columna:=GridDis.SelectedIndex;
     fila:=ZQGridD.RecNo;
       if (GridDis.Fields[8].AsFloat) >= 0 then
           begin
      {------------Verificamos que el pago no sobrepase el adeudo -----------------------}
  {  if ((GridDis.Fields[4].Asfloat*((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat))) - GridDis.Fields[7].AsFloat) < 0  then
          begin
            ShowMessage('No puede asignar un saldo a favor del proveedor');
          end
      else begin}
       dotacion:=GridDis.Fields[5].AsString;
       pago:=GridDis.Fields[7].AsString;
       adeudo:=FloatToStr(GridDis.Fields[4].Asfloat*((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat)));
       edicion:=GridDis.Fields[3].AsString;
       codigoprov:=GridDis.Fields[0].AsString;
       devolucion:=GridDis.Fields[6].AsString;
       vendidos:=FloatToStr((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat));

       if (StrToInt(dotacion)<StrToint(devolucion)) OR (StrToFloat(pago)>StrToFloat(adeudo)) then
          begin
            ShowMessage('La devolución no puede ser mayor que la dotación y el pago no puede ser mayor que el adeudo');
          end
       else begin

       //ShowMessage('Pago: '+pago+',Adeudo: '+adeudo+',Nuevo Adeudo :'+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago)));

       {-------------------Determinar si este pago ya se capturo en un corte-----------------------------}
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Select Scorte from t_devoluciones where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       estatuscorte:=ZQtmp.FieldByName('Scorte').AsString;

       {-------------------------------------------------------------------------------------------------}
     if estatuscorte='PA' then
            begin
              ShowMessage('El pago de esta edición ya se agrego en un corte');
            end
     else begin
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_devoluciones SET pago='+pago+',devolucion='+devolucion+',vendidos='+vendidos+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_rutas SET tarifa='+GridDis.Fields[4].AsString+' where edicion='+edicion+' AND codigo_proveedor='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_rutas SET adeudo=((dotacion-'+devolucion+')*tarifa) where edicion='+edicion+' AND codigo_proveedor='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_rutas SET adeudo='+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago))+',dotacion='+dotacion+' Where codigo_proveedor='+codigoprov+' AND edicion='+edicion);
       ZQtmp.ExecSQL;
       GridDis.Refresh;
       {-------------------------------inicia Actualizacion del estatus para corte---------------------------}
       Zqtmp.close;
       ZQtmp.SQl.Clear;
       ZQtmp.SQL.Add('Select dotacion,devolucion,tarifa,pago from v_pagos where codigo='+codigo.Text+' AND edicion ='+edicion );
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       dotc:=ZQtmp.FieldByName('dotacion').AsFloat;
       devc:=ZQtmp.FieldByName('devolucion').AsFloat;
       pagc:=ZQtmp.FieldByName('pago').AsFloat;
       tarifac:=ZQtmp.FieldByName('tarifa').AsFloat;
       dotdevtarif:=(dotc-devc)*tarifac;

      if dotc > 0 then
             begin
         if ((dotc-devc)=0) OR (dotdevtarif <= pagc) then
            begin
              if tarifac = 0 then
               begin
              if application.MessageBox (pchar('¿Confirma que desea usar una tarifa de $0 pesos para este vendedor?'), pchar('Confirmar tarifa'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
                begin
                ZQtmp.Close;
                ZQtmp.SQL.Clear;
                ZQtmp.SQL.Add('Update t_devoluciones SET scorte="PC" where codigo='+codigo.Text+' AND edicion='+edicion);
                ZQtmp.ExecSQL;
               // ShowMessage('Esta pagado totalmente y se actualiza el estatus a PC');
                end;
               end
               else begin
             ZQtmp.Close;
             ZQtmp.SQL.Clear;
             ZQtmp.SQL.Add('Update t_devoluciones SET scorte="PC" where codigo='+codigo.Text+' AND edicion='+edicion);
             ZQtmp.ExecSQL;
                end;
          end;
       end;
     end;
       {------------------------------Fin Actualizacion del estatus para corte---------------------------}
       codigo.Text:=FloatToStr(combodis.KeyValue);
    if (vertodos=1) then
      begin
   {-----------------------------------------}
   ds := THackDBGrid(GridDis).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(GridDis).Row;
   row := ds.RecNo;
   ds.Refresh;
   {-------------------------------------------}
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select Codigo,Nombre,Fecha,Edicion,tarifa,Dotacion,Devolucion,Pago,Adeudo from v_pagos where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
    {--------- Actualizamos la posicion en el grid----}
    with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     GridDis.SelectedIndex:=columna+1;
     EnableControls;
   end;
   {-------Fin actualizar posiscion en grid--------}

       END;
   if (vertodos=0) then
     begin
   {-----------------------------------------}
   ds := THackDBGrid(GridDis).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(GridDis).Row;
   row := ds.RecNo;
   ds.Refresh;
   {-------------------------------------------}
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select Codigo,Nombre,Fecha,Edicion,tarifa,Dotacion,Devolucion,Pago,Adeudo from v_pagos where codigo='+codigo.Text+' AND Scorte <> "PA"  AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
    {--------- Actualizamos la posicion en el grid----}
    with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     GridDis.SelectedIndex:=columna+1;
     EnableControls;

   end;
   {-------Fin actualizar posiscion en grid--------}
      end;
       end; {fin del else devolucion es mayor que dotacion}
       end   {---End del if adeudo > 0 ----------}

       else begin
          ShowMessage('El pago de este proveedor ya esta cubierto para esta edicion');
        end;

     end; {fin del control del grid = 1}
  if controlgrid=2 then
       begin
       columna:=GridDis.SelectedIndex;
       fila:=ZQGridD.RecNo;
       dotacion:=GridDis.Fields[5].AsString;
       edicion:=GridDis.Fields[2].AsString;
       codigoprov:=GridDis.Fields[3].AsString;
       devolucion:=GridDis.Fields[6].AsString;
       vendidos:=FloatToStr((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat));
       adeudo:=FloatToStr(GridDis.Fields[4].Asfloat*((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat)));
       empaque:=GridDis.Fields[8].AsString;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_rutas SET dotacion='+dotacion+',adeudo='+adeudo+',empaque="'+empaque+'" Where codigo_proveedor='+codigoprov+' AND edicion='+edicion);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_devoluciones SET vendidos='+vendidos+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;

      {-----------------------------------------}
       ds := THackDBGrid(GridDis).DataSource.DataSet;
       rowDelta := -1 + THackDBGrid(GridDis).Row;
       row := ds.RecNo;
       ds.Refresh;
   {-------------------------------------------}
   {----------------------Regrescamos el grid con los datos indicados----------------------------}
       ZQGridD.Close;
       ZQGridD.SQL.Clear;
       ZQGridD.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(fechaedicion.Date)+'" limit 1');
       ZQGridD.ExecSQL;
       ZQGridD.Open;
       edicions:=ZQGridD.FieldByName('edicion').AsInteger;
       ZQGridD.Close;
       ZQGridD.SQL.Clear;
       ZQGridD.SQL.Add('Select SUM(dotacion) AS Dotacion,SUM(devolucion) AS Devolucion, SUM(vendidos) AS Venta from v_dotaciones_circulacion Where edicion ='+IntToStr(edicions));
       ZQGridD.ExecSQL;
       ZQGridD.Open;
       totaldotacion.Caption:=ZQGridD.FieldByName('Dotacion').AsString;
       ZQtdot.Close;
       ZQtdot.SQL.Clear;
       ZQtdot.SQL.Add('Select dotaciontotal from c_totales_dotacion limit 1');
       ZQtdot.ExecSQL;
       ZQtdot.Open;
       if StrToInt(totaldotacion.Caption)>ZQtdot.FieldByName('dotaciontotal').AsInteger then
          begin
            totaldotacion.Font.Color:=clRed;
          end;
       if StrToInt(totaldotacion.Caption)<=ZQtdot.FieldByName('dotaciontotal').AsInteger then
          begin
            totaldotacion.Font.Color:=clGreen;
          end;
       totaldevolucion.Caption:=ZQGridD.FieldByName('devolucion').AsString;
       totalvendido.Caption:=ZQGridD.FieldByName('venta').AsString;
       ZQGridD.Close;
       ZQGridD.SQL.Clear;
       ZQGridD.SQL.Add('Select * from v_dotaciones_circulacion where edicion='+IntToStr(edicions)+' order by '+ordenconsulta);
       ZQGridD.ExecSQL;
       ZQGridD.Open;
       ZQGridD.Active:=TRUE;
       GridDis.Refresh;
       GridDis.SelectedIndex:=columna;
       ZQGridD.RecNo:=fila;
          {--------- Actualizamos la posicion en el grid----}
    with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta);
     MoveBy(rowDelta);
     GridDis.SelectedIndex:=columna+1;
     EnableControls;
   end;
   {-------Fin actualizar posiscion en grid--------}
    {--------------------Fin de refresh del grid--------------------------------------------------}

       //ShowMessage('Control de grid = 2');
       end;  {fin de control de grid = 2}

     end;

end;

procedure TFCapturaXdistribuidor.GridDisTitleClick(Column: TColumn);
 var
   edicions:integer;
begin
  if  controlgrid=2 then
      begin

   if Column.Title.Caption = 'Nombre' then
       ordenconsulta:='Nombre';
   if Column.Title.Caption = 'Fecha' then
       ordenconsulta:='edicion';
   if Column.Title.Caption = 'codigo_proveedor' then
       ordenconsulta:='codigo_proveedor';
   if Column.Title.Caption = 'tarifa' then
       ordenconsulta:='tarifa';
   if Column.Title.Caption = 'dotacion' then
       ordenconsulta:='dotacion';
   if Column.Title.Caption = 'vendidos' then
       ordenconsulta:='vendidos';
   if Column.Title.Caption = 'devolucion' then
       ordenconsulta:='devolucion';

   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(fechaedicion.Date)+'" limit 1');
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   edicions:=ZQGridD.FieldByName('edicion').AsInteger;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select SUM(dotacion) AS Dotacion,SUM(devolucion) AS Devolucion, SUM(vendidos) AS Venta from v_dotaciones_circulacion Where edicion ='+IntToStr(edicions));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   totaldotacion.Caption:=ZQGridD.FieldByName('Dotacion').AsString;
   totaldevolucion.Caption:=ZQGridD.FieldByName('devolucion').AsString;
   totalvendido.Caption:=ZQGridD.FieldByName('venta').AsString;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_dotaciones_circulacion where edicion='+IntToStr(edicions)+' order by '+ordenconsulta );
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGridD.Active:=TRUE;
   GridDis.Refresh;
      end;


end;

procedure TFCapturaXdistribuidor.ImprimirEClick(Sender: TObject);
begin
   FREstadoCuenta.Enabled:=FALSE;
   FREstadoCuenta := TFREstadoCuenta.Create(self);
   FREstadoCuenta.ShowModal;
end;

procedure TFCapturaXdistribuidor.MarcarpClick(Sender: TObject);
begin
    if(marcar = 0) then
     begin
     marcar:=1;
     marcarp.Caption:='No Marcar pagados';

     end
  else
      begin
      marcar:=0;
      marcarp.Caption:='Marcar pagados';
     end;
   if (vertodos=1) then
      begin
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;

end;

procedure TFCapturaXdistribuidor.Menejodedotaciones1Click(Sender: TObject);
var
edicion:integer;

begin
   controlgrid:=2;
   ordenconsulta:='codigo_proveedor';
   fechaedicion.Date:=now();
   {-------------------------------}
   Label3.Caption:='En esta pantalla puede administrar, modificar las dotaciones y devoluciones de la remisión de la fecha indicada, si desea realizar la captura de pagos, seleccione en el menú superior “Captura de pagos”';
   Label3.Visible:=TRUE;
   Label1.Visible:=FALSE;
   Label2.Visible:=FALSE;
   Codigo.Visible:=FALSE;
   ComboDis.Visible:=FALSE;
   verpagos.Visible:=FALSE;
   Marcarp.Visible:=FALSE;
   ImprimirE.Visible:=FALSE;
   corte.Visible:=FALSE;
   {-------------------------------}
   GridDis.Visible:=TRUE;
   Label4.Visible:=TRUE;
   Label5.Visible:=TRUE;
   fechaedicion.Visible:=TRUE;
   noedicion.Visible:=TRUE;
   Label7.Visible:=TRUE;
   totaldotacion.Visible:=TRUE;
   totaldevolucion.Visible:=TRUE;
   totalvendido.Visible:=TRUE;
   Label6.Visible:=TRUE;
   Label8.Visible:=TRUE;
   impremision.Visible:=FALSE;
   exel.Visible:=TRUE;
   {-------------------------------}
   {-----------------Llenamos el grid con los datos del dia de hoy---------------------------}
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(now())+'" limit 1');
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   edicion:=ZQGridD.FieldByName('edicion').AsInteger;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select SUM(dotacion) AS Dotacion,SUM(devolucion) AS Devolucion, SUM(vendidos) AS Venta from v_dotaciones_circulacion Where edicion ='+IntToStr(edicion));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   totaldotacion.Caption:=ZQGridD.FieldByName('Dotacion').AsString;
   totaldevolucion.Caption:=ZQGridD.FieldByName('devolucion').AsString;
   totalvendido.Caption:=ZQGridD.FieldByName('venta').AsString;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_dotaciones_circulacion where edicion='+IntToStr(edicion)+' order by '+ordenconsulta);
   ZQGridD.ExecSQL;

   ZQGridD.Open;

   ZQGridD.Active:=TRUE;
   GridDis.Refresh;
   {----------------------------fin de llenado del grid--------------------------------------}
end;

procedure TFCapturaXdistribuidor.noedicionKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key=#13) then
     begin
   controlgrid:=2;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select fecha  from t_remision_rutas where edicion='+noedicion.Text+' limit 1');
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   if ZQGridD.FieldByName('fecha').IsNull = FALSE then
     begin
   fechaedicion.Date:=ZQGridD.FieldByName('fecha').AsDateTime;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select SUM(dotacion) AS Dotacion,SUM(devolucion) AS Devolucion, SUM(vendidos) AS Venta from v_dotaciones_circulacion Where edicion ='+noedicion.Text);
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   totaldotacion.Caption:=ZQGridD.FieldByName('Dotacion').AsString;
   totaldevolucion.Caption:=ZQGridD.FieldByName('devolucion').AsString;
   totalvendido.Caption:=ZQGridD.FieldByName('venta').AsString;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_dotaciones_circulacion where edicion='+noedicion.Text+' order by '+ordenconsulta);
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGridD.Active:=TRUE;
   GridDis.Refresh;
     end;
   if ZQGridD.FieldByName('fecha').IsNull = TRUE then
       begin
         ShowMessage('El numero de edicion indicado no tiene hoja de remisión, actualice las remisiones si es necesario');
       end;
   {----------------------------fin de llenado del grid--------------------------------------}
     end;
end;

procedure TFCapturaXdistribuidor.Remisiones1Click(Sender: TObject);
begin
  FPrincipalCirculacion.quienllamaremision:=2;
  FRemision.Enabled:=FALSE;
  FRemision := TFRemision.Create(Self);
  FRemision.Show;
end;

procedure TFCapturaXdistribuidor.Salir1Click(Sender: TObject);
begin
   FCapturaXDistribuidor.Close;
end;

procedure TFCapturaXdistribuidor.verpagosClick(Sender: TObject);
begin
  if(vertodos = 0) then
     begin
    vertodos:=1;
    verpagos.Caption:='Ocultar los pagados';
    marcarp.Enabled:=TRUE;

     end
  else
      begin
        vertodos:=0;
        verpagos.Caption:='Ver todos los pagos';
        Marcarp.Enabled:=FALSE;
      end;

     if (vertodos=1) then
      begin
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
end;

end.
