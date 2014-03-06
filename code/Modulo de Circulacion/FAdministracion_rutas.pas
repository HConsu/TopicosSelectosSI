unit FAdministracion_rutas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Grids, DBGrids, ComCtrls, CheckLst, OleCtrls, SHDocVw, OleServer, Excel2000,
  QuickRpt;

type
  TFAdmon_rutas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Ruta: TDBLookupComboBox;
    tiporuta: TComboBox;
    ZQRutas: TZQuery;
    DSrutas: TDataSource;
    DBGridSubs: TDBGrid;
    ZQSubsruta: TZQuery;
    DSSubsruta: TDataSource;
    ver: TButton;
    Subir: TButton;
    Bajar: TButton;
    BRemision: TButton;
    actualizar: TButton;
    ZQActualiza: TZQuery;
    ZQcuentarutas: TZQuery;
    ZQcuentaregistros: TZQuery;
    ZQtmp: TZQuery;
    Progreso: TProgressBar;
    Progresototal: TProgressBar;
    Exportexel: TButton;
    Excel: TExcelApplication;
    asignarrutas: TButton;
    DBGridRuta: TDBGrid;
    agregar: TButton;
    quitar: TButton;
    Seleccionarruta: TDBLookupComboBox;
    ZQrutadestino: TZQuery;
    DSrutadestino: TDataSource;
    rutaprincipal: TComboBox;
    verruta: TButton;
    ZQgridseleccionruta: TZQuery;
    DSgridseleccionruta: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dir: TLabel;
    tit: TLabel;
    dird: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    tot: TLabel;
    totd: TLabel;
    Button1: TButton;
    titd: TLabel;
    ZQtmp2: TZQuery;
    Button2: TButton;
    DSedificio: TDataSource;
    ZQedificio: TZQuery;
    edificios: TDBLookupComboBox;
    Label9: TLabel;
    ZQtotal: TZQuery;
    DSrutae: TDataSource;
    Label10: TLabel;
    totalruta: TLabel;
    ZQnuevos: TZQuery;
    Button3: TButton;
    Button4: TButton;
    cancelados: TLabel;
    altas: TLabel;
    Button5: TButton;
    ZQreporte: TZQuery;
    Compuesto: TQRCompositeReport;
    procedure tiporutaChange(Sender: TObject);
    procedure verClick(Sender: TObject);
  //  procedure BRemisionClick(Sender: TObject);
    procedure actualizarClick(Sender: TObject);
    procedure SubirClick(Sender: TObject);
    procedure DBGridSubsKeyPress(Sender: TObject; var Key: Char);
    procedure generarClick(Sender: TObject);
    procedure ExportexelClick(Sender: TObject);
    procedure asignarrutasClick(Sender: TObject);
    procedure rutaprincipalChange(Sender: TObject);
    procedure verrutaClick(Sender: TObject);
    procedure agregarClick(Sender: TObject);
    procedure DBGridSubsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridSubsCellClick(Column: TColumn);
    procedure Button1Click(Sender: TObject);
    procedure DBGridRutaCellClick(Column: TColumn);
    procedure quitarClick(Sender: TObject);
    procedure BajarClick(Sender: TObject);
    procedure RutaCloseUp(Sender: TObject);
    procedure edificiosCloseUp(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SetGridColumnWidths(Grid: Tdbgrid);
    procedure Button5Click(Sender: TObject);
    procedure ZQSubsrutaAfterScroll(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    type THackDBGrid = class(TDBGrid);


  private
    { Private declarations }
    fechahoy:String;
    totalporruta:integer;
  public
    { Public declarations }
    rutap,edificiop:Integer;
  end;

var
  FAdmon_rutas: TFAdmon_rutas;

implementation

uses FRemision_ruta,ComObj,FRHojadeModifiacionRuta,FAlta_subscripciones,
  F_Modificar_Subscripcion,Fprincipal,FCanceladas_en_ruta,FNuevas_enruta,
  FBuscar_supervisor,FR_lista_ruta,FR_lista_Edificio,FR_lista_rutac;

{$R *.dfm}

procedure TFAdmon_rutas.verClick(Sender: TObject);
begin
  DBGridSubs.Options:=[dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
  edificios.KeyValue:=0;
 if ((ruta.KeyValue <> NULL) OR (tiporuta.Text='Sin ruta')) then
     begin
  //showmessage('El no de ruta es:'+FloatToStr(ruta.KeyValue));
  if  (tiporuta.Text = 'Ruta Metropolitana') then
     begin
    BRemision.Enabled:=FALSE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
  if  tiporuta.Text = 'Ruta foranea' then
     begin
    BRemision.Enabled:=TRUE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_enel_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
  if  tiporuta.Text = 'Ruta Edificio' then
     begin
    BRemision.Enabled:=TRUE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto' );
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
 if tiporuta.Text = 'Sin ruta' then
      begin
      Ruta.Enabled:=FALSE;
      ZQSubsruta.Close;
      zQSubsruta.SQL.Clear;
      ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
      ZQSubsruta.ExecSQL;
      ZQSubsruta.Open;
      ZQSubsruta.Active:=TRUE;
      DBGridSubs.Refresh;
      tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
      end;
    end
 else begin
    ShowMessage('Seleccione una ruta');
 end;


end;

procedure TFAdmon_rutas.verrutaClick(Sender: TObject);
begin
 if ((Seleccionarruta.KeyValue <> NULL) OR (rutaprincipal.Text='Sin ruta')) then
     begin
  //showmessage('El no de ruta es:'+FloatToStr(ruta.KeyValue));
  if  rutaprincipal.Text = 'Ruta Metropolitana' then
     begin
    //ShowMessage('Ruta Metropolitana 2');
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;
  if  rutaprincipal.Text = 'Ruta foranea' then
     begin

    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_enel_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;
  if  rutaprincipal.Text = 'Ruta Edificio' then
     begin

    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(Seleccionarruta.KeyValue)+' order by orden_en_reparto' );
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;
 if rutaprincipal.Text = 'Sin ruta' then
      begin
      Seleccionarruta.Enabled:=FALSE;
      ZQgridseleccionruta.Close;
      ZQgridseleccionruta.SQL.Clear;
      ZQgridseleccionruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
      ZQgridseleccionruta.ExecSQL;
      ZQgridseleccionruta.Open;
      ZQgridseleccionruta.Active:=TRUE;
      DBGridRuta.Refresh;
      totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
      end;
    end
 else begin
    ShowMessage('Seleccione una ruta');
 end;

end;

procedure TFAdmon_rutas.ZQSubsrutaAfterScroll(DataSet: TDataSet);
begin
//  DBGridSubs.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
if edificios.Text='' then
   begin
if  tiporuta.Text = 'Ruta Metropolitana' then
     begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridSubs.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     tit.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dir.Caption:=DBGridSubs.Fields[3].AsString+', '+DBGridSubs.Fields[4].AsString+', CP:'+DBGridSubs.Fields[5].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[6].AsString;
     end;
if tiporuta.Text = 'Ruta foranea' then
      begin
       tit.Caption:=DBGridSubs.Fields[2].AsString;
       dir.Caption:=DBGridSubs.Fields[5].AsString+','+DBGridSubs.Fields[6].AsString+', Observaciones:'+DBGridSubs.Fields[7].AsString;
      end;
if tiporuta.Text='Sin ruta' then
   begin
     tit.Caption:=DbGridSubs.Fields[1].AsString;
     dir.Caption:=DBGridSubs.Fields[5].AsString+', '+DBGridSubs.Fields[6].AsString+', '+DBGridSubs.Fields[7].AsString+', CP:'+DBGridSubs.Fields[8].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[10].AsString;
   end;
if tiporuta.Text='Ruta Edificio' then
   begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridSubs.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     tit.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dir.Caption:=DBGridSubs.Fields[4].AsString;
   end;
 end;
end;

procedure TFAdmon_rutas.agregarClick(Sender: TObject);
var
nosubscripcion,norutaant,norutanueva,ordennuevo,codigo:string;
fila,columna,filad,columnad:integer;
titular,direccion:String;
begin
  fechahoy:=dateToStr(now);
  columna:=DBGridSubs.SelectedIndex;
  fila:=ZQSubsruta.RecNo;
  columnad:=DBGridSubs.SelectedIndex;
  filad:=ZQSubsruta.RecNo;
  if  ((tiporuta.Text = 'Ruta Metropolitana') and (rutaprincipal.Text='Ruta Metropolitana')) then
     begin
    //ShowMessage('Ruta Metropolitana 2');
    nosubscripcion:=DBGridSubs.Fields[2].AsString;
    norutaant:=FloatToStr(ruta.KeyValue);
    norutanueva:=FloatToStr(Seleccionarruta.KeyValue);
    Direccion:=DBGridSubs.Fields[3].AsString+',colonia '+DBGridSubs.Fields[4].AsString+',C.P. '+DBGridSubs.Fields[5].AsString+', Descripcion domicilio'+DBGridSubs.Fields[6].AsString;
    Zqtmp.Close;
    Zqtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update t_subscripcion set ruta='+norutanueva+',fechamodif="'+DateToStr(now())+'" where nosubscripcion='+nosubscripcion);
    ZQtmp.ExecSQL;
    Zqtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update t_descripcion_rutas set no_ruta='+norutanueva+' where no_de_subscripcion='+nosubscripcion);
    ZQtmp.ExecSQL;
    Zqtmp.Close;
       {inicia procedimiento para tabla de notifiacion}
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+nosubscripcion);
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       titular:=ZQtmp.FieldByName('atenciona').AsString;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosubscripcion+',"'+titular+'","'+fechahoy+'","'+direccion+'",'+norutaant+','+norutanueva+')');
       ZQtmp.ExecSQL;
       ZQtmp.Close;

    {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;

    {---------------------Fin de pasar a lado derecho metropolitano--------------------}
    {----------------------Inicio pasar a lado derecho ruta foranea--------------------}
if  ((tiporuta.Text = 'Ruta foranea') and (rutaprincipal.Text = 'Ruta foranea')) then
     begin
     codigo:=DBGridSubs.Fields[0].AsString;
     norutaant:=ruta.KeyField;
     norutanueva:=FloatToStr(Seleccionarruta.KeyValue);
     Zqtmp.Close;
     Zqtmp.SQL.Clear;
     ZQtmp.SQL.Add('Update c_proveedores set ruta='+norutanueva+' where id_proveedor='+codigo);
     ZQtmp.ExecSQL;
     Zqtmp.Close;
     {-------------------------Actualizamos grid izquierdo------------------------------}
     ZQSubsruta.Close;
     ZQSubsruta.SQL.Clear;
     ZQSubsruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_enel_reparto');
     ZQSubsruta.ExecSQL;
     ZQSubsruta.Open;
     ZQSubsruta.Active:=TRUE;
     DBGridSubs.Refresh;
     DBGridSubs.SelectedIndex:=columna;
     ZQSubsruta.RecNo:=fila;
     tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     {-------------------------Actualizamos grid derecho--------------------------------}
     ZQgridseleccionruta.Close;
     ZQgridseleccionruta.SQL.Clear;
     ZQgridseleccionruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_enel_reparto');
     ZQgridseleccionruta.ExecSQL;
     ZQgridseleccionruta.Open;
     ZQgridseleccionruta.Active:=TRUE;
     DBGridRuta.Refresh;
     DBGridRuta.SelectedIndex:=columnad;
     ZQgridseleccionruta.RecNo:=filad;
     totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;
     {-------------------------Fin de pasar del lado derecho ruta foranea---------------}
     {---------------------Inicio pasar del lado derecho sin ruta-o asignar ruta--------}
  if ((tiporuta.Text = 'Sin ruta')and (rutaprincipal.Text='Ruta Metropolitana')) then
      begin
    nosubscripcion:=DBGridSubs.Fields[0].AsString;
    norutaant:='0';
    norutanueva:=FloatToStr(Seleccionarruta.KeyValue);
    if DBGridSubs.Fields[6].AsString ='' then
      begin
       ShowMessage('Hacen falta datos para poder asignar a una ruta metropolitana, modifique la subscripcion para actualizar los datos faltantes');
      end
    else begin
     Direccion:=DBGridSubs.Fields[6].AsString+',colonia '+DBGridSubs.Fields[7].AsString+',C.P. '+DBGridSubs.Fields[8].AsString+','+DBGridSubs.Fields[9].AsString+', Descripcion domicilio'+DBGridSubs.Fields[10].AsString;
     Zqtmp2.Close;
     Zqtmp2.SQL.Clear;
     ZQtmp2.SQL.Add('Update t_subscripcion set ruta='+norutanueva+',fechamodif="'+DateToStr(now())+'" where nosubscripcion='+nosubscripcion);
     ZQtmp2.ExecSQL;
     Zqtmp2.Close;
     ZQtmp2.SQL.Clear;
     ZQtmp2.SQL.Add('insert into t_descripcion_rutas (no_ruta,No_de_subscripcion,calle,colonia,cp,ciudad,Descripcion_domicilio) Values('+norutanueva+','+nosubscripcion+',"'+DBGridSubs.Fields[6].AsString+'","'+DBGridSubs.Fields[7].AsString+'",'+DBGridSubs.Fields[8].AsString+',"'+DBGridSubs.Fields[9].AsString+'","'+DBGridSubs.Fields[10].AsString+'")');
     ZQtmp2.ExecSQL;
     Zqtmp2.Close;
        {inicia procedimiento para tabla de notifiacion}
       ZQtmp2.SQL.Clear;
       ZQtmp2.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+nosubscripcion);
       ZQtmp2.ExecSQL;
       ZQtmp2.Open;
       titular:=ZQtmp2.FieldByName('atenciona').AsString;
       ZQtmp2.SQL.Clear;
       ZQtmp2.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosubscripcion+',"'+titular+'","'+fechahoy+'","'+direccion+'",'+norutaant+','+norutanueva+')');
       ZQtmp2.ExecSQL;
       ZQtmp2.Close;

    {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    zQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);

      end; {Fin del if de datos completos}
    end;      {fin del if de rutas}
  if ((tiporuta.Text = 'Sin ruta')and (rutaprincipal.Text='Ruta Edificio')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[0].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    zQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(Seleccionarruta.KeyValue)+' order by orden_en_reparto' );
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);

      end;
   if ((tiporuta.Text = 'Ruta Edificio')and (rutaprincipal.Text='Ruta Metropolitana')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[2].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}

    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto' );
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
      end;

  if ((tiporuta.Text = 'Ruta Edificio')and (rutaprincipal.Text='Ruta Edificio')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[2].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}

    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto' );
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(Seleccionarruta.KeyValue)+' order by orden_en_reparto' );
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
      end;



end;

procedure TFAdmon_rutas.asignarrutasClick(Sender: TObject);
begin
   DBGridSubs.Width:=521;
   DBGridSubs.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
   agregar.Visible:=TRUE;
   //quitar.Visible:=TRue;
   DBGridRuta.Visible:=TRUE;
   rutaprincipal.Visible:=TRUE;
   Seleccionarruta.Visible:=TRUE;
   verruta.Visible:=TRUE;
   label5.Visible:=TRUE;
   label6.Visible:=TRUE;
   titd.Visible:=TRUE;
   dird.Visible:=TRUE;
   Subir.Visible:=FALSE;
   Bajar.Visible:=FALSE;
end;

procedure TFAdmon_rutas.BajarClick(Sender: TObject);
var
actual,nueva,anterior,ultimo:integer;
nosubactual,nosubanterior:integer;
posicionactual,posicionnueva:integer;
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
   ds := THackDBGrid(DBGridSubs).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(DBGridSubs).Row;
   row := ds.RecNo;
//   ds.Refresh;

 DBGridSubs.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
  if ((tiporuta.Text = 'Ruta Metropolitana') AND (edificios.Text='')) then
      begin
      {obtenemos el orden actual}
      actual:=DBGridSubs.Fields[1].AsInteger;
      nosubactual:=DBGridSubs.Fields[2].AsInteger;
      posicionactual:=ZQSubsruta.RecNo;
      Zqtmp2.Close;
      ZQtmp2.SQL.Clear;
      ZQtmp2.SQL.Add('Select MAX(Orden_en_el_reparto) as ultimo from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
      ZQtmp2.ExecSQL;
      ZQtmp2.Open;
      {obtenemos el ultimo valor en el orden}
      ultimo:=ZQtmp2.FieldByName('ultimo').AsInteger;
      if (actual = 0) then
         begin
            Zqtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Select MAX(Orden_en_el_reparto) as ultimo from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
            ZQtmp2.ExecSQL;
            ZQtmp2.Open;
              if ZQtmp2.FieldByName('ultimo').AsInteger = 0 then  {determinamos si el maximo orden de entrega es 0}
                begin
                   nueva:=1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(nueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
                end  {fin del if de ultimo es igual a 0}
              else begin
                   nueva:=ZQtmp2.FieldByName('ultimo').AsInteger+1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(nueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
              end;   {fin de determinacion de orden cuando es 0}

         end  {fin de si el orden es 0}
         {----------------------------------------------------------------}
      else begin  {else del if el orden que tiene no es 0 se debe asignar el valor anterior}
        if actual<ultimo then   {determinamos si es el primer registro para no asignar el orden en 0}
           begin
             ZQSubsruta.RecNo:=Posicionactual+1;
             nosubanterior:= DBGridSubs.Fields[2].AsInteger;
             posicionnueva:=DBGridSubs.Fields[1].AsInteger;
            //ShowMessage('Orden actual ='+IntToStr(actual)+' Nuevo orden ='+IntToStr(posicionnueva));
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(posicionnueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
             ZQtmp2.ExecSQL;
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(actual)+' Where no_de_subscripcion='+IntToStr(nosubanterior));
             ZQtmp2.ExecSQL;
           end;

      end;  {fin del else el orden que tiene no es 0}
      {-----------------------Actualizamos el grid----------------------------------}
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
     ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_rutas.no_de_subscripcion) AS Atenciona,calle');
    ZQSubsruta.SQL.Add(',colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
   // ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    ZQSubsruta.RecNo:= posicionnueva;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {------------------------ fin del refresh --------------------------------------}

    end;    {fin del if de ruta metropolitana}

   if ((tiporuta.Text = 'Ruta Metropolitana') AND (edificios.Text<>'')) then
      begin
      {obtenemos el orden actual}
      actual:=DBGridSubs.Fields[1].AsInteger;
      nosubactual:=DBGridSubs.Fields[2].AsInteger;
      posicionactual:=ZQSubsruta.RecNo;
      Zqtmp2.Close;
      ZQtmp2.SQL.Clear;
      ZQtmp2.SQL.Add('Select MAX(Orden_en_reparto) as ultimo from t_descripcion_ruta_edificio where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_reparto');
      ZQtmp2.ExecSQL;
      ZQtmp2.Open;
      {obtenemos el ultimo valor en el orden}
      ultimo:=ZQtmp2.FieldByName('ultimo').AsInteger;
      if (actual = 0) then
         begin
            Zqtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Select MAX(Orden_en_reparto) as ultimo from t_descripcion_ruta_edificio where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_reparto');
            ZQtmp2.ExecSQL;
            ZQtmp2.Open;
              if ZQtmp2.FieldByName('ultimo').AsInteger = 0 then  {determinamos si el maximo orden de entrega es 0}
                begin
                   nueva:=1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(nueva)+' Where nosubscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
                end  {fin del if de ultimo es igual a 0}
              else begin
                   nueva:=ZQtmp2.FieldByName('ultimo').AsInteger+1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(nueva)+' Where nosubscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
              end;   {fin de determinacion de orden cuando es 0}

         end  {fin de si el orden es 0}
         {----------------------------------------------------------------}
      else begin  {else del if el orden que tiene no es 0 se debe asignar el valor anterior}
        if actual<ultimo then   {determinamos si es el primer registro para no asignar el orden en 0}
           begin
             ZQSubsruta.RecNo:=Posicionactual+1;
             nosubanterior:= DBGridSubs.Fields[2].AsInteger;
             posicionnueva:=DBGridSubs.Fields[1].AsInteger;
            //ShowMessage('Orden actual ='+IntToStr(actual)+' Nuevo orden ='+IntToStr(posicionnueva));
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(posicionnueva)+' Where nosubscripcion='+IntToStr(nosubactual));
             ZQtmp2.ExecSQL;
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(actual)+' Where nosubscripcion='+IntToStr(nosubanterior));
             ZQtmp2.ExecSQL;
           end;

      end;  {fin del else el orden que tiene no es 0}
      {-----------------------Actualizamos el grid----------------------------------}
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
    ZQSubsruta.SQL.Add(',Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(edificios.KeyValue)+' order by orden_en_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    ZQSubsruta.RecNo:= posicionactual+1;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {------------------------ fin del refresh --------------------------------------}

    end;    {fin del if de ruta metropolitana}

  with ds do
   begin
     DisableControls;
     RecNo := row+1;
     MoveBy(-rowDelta-1) ;
     MoveBy(rowDelta+1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;

  SetGridColumnWidths(dbgridsubs);

end;

procedure TFAdmon_rutas.Button1Click(Sender: TObject);
begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Select * from t_notificacion_rutas where impreso=0');
    ZQtmp.ExecSQL;
    ZQtmp.Open;
    Fhoja_modif_ruta.Notificaciones.DataSet:=Zqtmp;
    Fhoja_modif_ruta.foliob.Caption:= ZQtmp.FieldByName('id_notificacion').AsString;
    Fhoja_modif_ruta.folioa.Caption:= ZQtmp.FieldByName('id_notificacion').AsString;
    Fhoja_modif_ruta.fechaimpb.Caption:=DateToStr(now());
    Fhoja_modif_ruta.fechaimpa.Caption:=DateToStr(now());
    Fhoja_modif_ruta.Nosubscripcionb.DataSet:=ZQtmp;
    Fhoja_modif_ruta.Nosubscripcionb.DataField:='NoSubscripcion';
    Fhoja_modif_ruta.titularb.DataSet:=ZQtmp;
    Fhoja_modif_ruta.titularb.DataField:='Titular';
    Fhoja_modif_ruta.Nosubscripciona.DataSet:=ZQtmp;
    Fhoja_modif_ruta.Nosubscripciona.DataField:='NoSubscripcion';
    Fhoja_modif_ruta.titulara.DataSet:=ZQtmp;
    Fhoja_modif_ruta.titulara.DataField:='Titular';
    Fhoja_modif_ruta.Direccionb.Caption:=ZQtmp.FieldByName('Direccion').AsString;
    Fhoja_modif_ruta.Direcciona.Caption:=ZQtmp.FieldByName('Direccion').AsString;
    Fhoja_modif_ruta.rutaanterior.Caption:=ZQtmp.FieldByName('Rutaanterior').AsString;
    Fhoja_modif_ruta.rutanueva.Caption:=ZQtmp.FieldByName('Nuevaruta').AsString;
    Fhoja_modif_ruta.Notificaciones.Prepare;
    Fhoja_modif_ruta.Notificaciones.Preview;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update t_notificacion_rutas SET impreso=1');
    ZQtmp.ExecSQL;
    ZQtmp.Open;

end;

procedure TFAdmon_rutas.Button2Click(Sender: TObject);
begin
   if ((tiporuta.Text = 'Ruta Metropolitana') AND (edificios.Text='')) then
      begin
    ZQreporte.Close;
    ZQreporte.SQL.Clear;
    ZQreporte.SQL.Add('Select No_ruta,Orden_en_el_reparto,No_de_Subscripcion ,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_rutas.no_de_subscripcion)As AtencionA,calle,colonia,cp');
    ZQreporte.SQL.Add(',Descripcion_domicilio from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQreporte.ExecSQL;
    ZQreporte.Open;



    //ShowMessage(ZQreporte.FieldByName('No_de_subscripcion').AsString);
    FRHojadeRuta.QListado.DataSet:=ZQreporte;
    FRHojaderuta.noruta.Caption:=FloatToStr(ruta.KeyValue);
    FRHojadeRuta.Nosubscripcion.DataSet:=ZQreporte;
    FRHojaderuta.Nosubscripcion.DataField:='No_de_subscripcion';
    FRHojadeRuta.atenciona.DataSet:=ZQreporte;
    FRHojadeRuta.atenciona.DataField:='AtencionA';
    FRHojadeRuta.calle.DataSet:=ZQreporte;
    FRHojadeRuta.calle.datafield:='calle';
    FRHojadeRuta.colonia.DataSet:=ZQreporte;
    FRHojadeRuta.colonia.DataField:='colonia';
    FRHojadeRuta.descripcion.DataSet:=ZQreporte;
    FRHojadeRuta.descripcion.DataField:='Descripcion_domicilio';
    FRHojadeRuta.total.Caption:=IntToStr(ZQReporte.RecordCount);
    FRHojadeRuta.Qlistado.Prepare;
    FRHojadeRuta.Qlistado.Preview;

      {-----------Consulta para indentificar las subscripciones Canceladas-----------------------------------}
      ZQNuevos.Close;
      ZQNuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir from t_cancelacion where ruta='+FloatToStr(ruta.KeyValue)+' and fecha_ultimo_ejemplar between "'+Formatdatetime('yyyy-mm-dd',now()-60)+' 00:00:00" AND "'+Formatdatetime('yyyy-mm-dd',now())+' 23:59:59"');
      ZQNuevos.ExecSQL;
      ZQNuevos.Open;
      {--------------------------------------------------------------------------------------------------------}

  if ZQnuevos.RecordCount>0 then
     begin
    FRListaCancelados.Qcancelados.DataSet:=ZQNuevos;
    FRListaCancelados.Nosubc.DataSet:=ZQNuevos;
    FRListaCancelados.Nosubc.DataField:='NoSubscripcion';
    FRListaCancelados.atencionac.DataSet:=ZQNuevos;
    FRListaCancelados.atencionac.DataField:='Atenciona';
    FRListaCancelados.callec.DataSet:=ZQNuevos;
    FRListaCancelados.callec.DataField:='Calle';
    FRListaCancelados.coloniac.DataSet:=ZQNuevos;
    FRListaCancelados.coloniac.DataField:='Colonia';
    FRListaCancelados.descripcionc.DataSet:=ZQNuevos;
    FRListaCancelados.descripcionc.DataField:='Descripcion_dir';
    FRListaCancelados.Qcancelados.Prepare;

    FRListaCancelados.Qcancelados.Preview;
     end;

    {-----------Consulta para indentificar las subscripciones que cambiaron de domicilio o ruta-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambio_domicilio.nosubscripcion)AS Atenciona,rutao,rutan,direccion from t_cambio_domicilio where rutao='+FloatToStr(ruta.KeyValue)+' AND fecha between CURDATE()-7 AND CURDATE()+1');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
    {-----------------------------------------------------------------------------------}

    { Compuesto.reports.add(FRHojaderuta.Qlistado);
     Compuesto.reports.add(FRListaCancelados.Qcancelados);
     Compuesto.Prepare;
     Compuesto.Preview;    }

     end;
if ((tiporuta.Text = 'Ruta Edificio') OR (edificios.Text<>'')) then
      begin

      if tiporuta.Text='Ruta Edificio' then
         begin
         ZQreporte.Close;
         ZQreporte.SQL.Clear;
         ZQreporte.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion,(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
         ZQreporte.SQL.Add(',Area from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto');
         ZQreporte.ExecSQL;
         ZQreporte.Open;
         FRlistaedificio.edificio.Caption:=ruta.Text;
         end

   else  begin
         ZQreporte.Close;
         ZQreporte.SQL.Clear;
         ZQreporte.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion,(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
         ZQreporte.SQL.Add(',Area from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(edificios.KeyValue)+' order by orden_en_reparto');
         ZQreporte.ExecSQL;
         ZQreporte.Open;
         FRlistaedificio.edificio.Caption:=edificios.Text;
         end;



   FRlistaedificio.QRlista.DataSet:=ZQreporte;
   FRlistaedificio.Nosubscripcion.DataSet:=ZQReporte;
   FRlistaedificio.Nosubscripcion.DataField:='Nosubscripcion';
   FRlistaedificio.atenciona.DataSet:=ZQReporte;
   FRlistaedificio.atenciona.DataField:='Atenciona';
   FRlistaedificio.area.DataSet:=ZQreporte;
   FRlistaedificio.area.DataField:='area';
   FRlistaedificio.total.caption:=IntToStr(ZQreporte.RecordCount);
   FRlistaedificio.QRlista.Prepare;
   FRlistaedificio.QRlista.Preview;

      end;



end;    // fin del evento del boton imprimir hoja de ruta

procedure TFAdmon_rutas.Button3Click(Sender: TObject);
begin
 if ((tiporuta.Text<>'') AND (ruta.Text<>'')) then
    begin
   if edificios.Text='' then
      begin
        rutap:=ruta.KeyValue;
        edificiop:=0;
      end;
   if edificios.Text<>'' then
      begin
        rutap:=ruta.KeyValue;
        edificiop:=edificios.KeyValue;
      end;

   FCanceladasR.Enabled:=FALSE;
   FCanceladasR := TFCanceladasR.Create(self);
   FCanceladasR.Show;
    end;
end;

procedure TFAdmon_rutas.Button4Click(Sender: TObject);
begin
if ((tiporuta.Text<>'') AND (ruta.Text<>'')) then
    begin

      if edificios.Text='' then
      begin
        rutap:=ruta.KeyValue;
        edificiop:=0;
      end;
   if edificios.Text<>'' then
      begin
        rutap:=ruta.KeyValue;
        edificiop:=edificios.KeyValue;
      end;
    FNuevosR.Enabled:=FALSE;
    FNuevosR := TFNuevosR.Create(self);
    FNuevosR.Show;
  end;

end;

procedure TFAdmon_rutas.Button5Click(Sender: TObject);
begin
   FBuscarSupervisor.Enabled:=FALSE;
   FBuscarSupervisor := TFBuscarSupervisor.Create(self);
   FBuscarSupervisor.ShowModal;
end;

procedure TFAdmon_rutas.rutaprincipalChange(Sender: TObject);
begin
  {Seleccionamos los datos de la tabla segun corresponda para llenar el segundo combobox}
   if rutaprincipal.Text = 'Ruta Metropolitana' then
      begin
      Seleccionarruta.Enabled:=TRUE;
      Seleccionarruta.ListField:='';
      Seleccionarruta.KeyField:='';
      ZQrutadestino.Close;
      ZQrutadestino.SQL.Clear;
      ZQrutadestino.SQL.Add('Select Nombre_ruta,no_ruta from c_rutas');
      ZQrutadestino.ExecSQL;
      ZQrutadestino.Open;
      Seleccionarruta.ListField:='Nombre_ruta';
      Seleccionarruta.KeyField:='no_ruta';
      //ShowMessage('ruta metropolitana');
      end;
   if rutaprincipal.Text = 'Ruta foranea' then
      begin
      Seleccionarruta.Enabled:=TRUE;
      Seleccionarruta.ListField:='';
      Seleccionarruta.KeyField:='';
      ZQrutadestino.Close;
      ZQrutadestino.SQL.Clear;
      ZQrutadestino.SQL.Add('Select no_ruta,nombre_ruta from c_rutas_foraneas');
      ZQrutadestino.ExecSQL;
      ZQrutadestino.Open;
      Seleccionarruta.ListField:='Nombre_ruta';
      Seleccionarruta.KeyField:='no_ruta';
     //ShowMessage('ruta foranea');
      end;
   if rutaprincipal.Text = 'Ruta Edificio' then
      begin
      Seleccionarruta.Enabled:=TRUE;
      Seleccionarruta.ListField:='';
      Seleccionarruta.KeyField:='';
      ZQrutadestino.Close;
      ZQrutadestino.SQL.Clear;
      ZQrutadestino.SQL.Add('Select id_edificio,descripcion from c_edificios');
      ZQrutadestino.ExecSQL;
      ZQrutadestino.Open;
      Seleccionarruta.ListField:='descripcion';
      Seleccionarruta.KeyField:='id_edificio';
      //ShowMessage('ruta foranea');
      end;
   if rutaprincipal.Text = 'Sin Ruta' then
      begin
      Seleccionarruta.Enabled:=FALSE;
      ZQrutadestino.Close;
      ZQrutadestino.SQL.Clear;
      ZQrutadestino.SQL.Add('Select * from  v_subscriptores_sin_ruta');
      ZQrutadestino.ExecSQL;
      ZQrutadestino.Open;
      end;

end;

procedure TFAdmon_rutas.ExportexelClick(Sender: TObject);
var
Libro : _WORKBOOK;
Hoja : _WORKSHEET;
i,b:Integer;
tall:Integer;
edificio:String;
begin
if ((tiporuta.Text = 'Ruta Metropolitana') AND (edificios.Text='')) then
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
      tall:=round(ZQSubsruta.RecordCount/27);
        if tall<=1 then
           begin
          Hoja.PageSetup.FitToPagesTall:=1
           end
        else begin
          Hoja.PageSetup.FitToPagesTall:=tall;
        end;

 Hoja.Cells.Item[1,1].ColumnWidth := 2;
 Hoja.Cells.Item[2,3]:='Hoja de descripcion ruta '+ruta.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,2]:='No Subscripcion';
 Hoja.Cells.Item[4,2].ColumnWidth := 8;
 Hoja.Cells.Item[4,3]:='Atencion A';
 Hoja.Cells.Item[4,3].ColumnWidth := 50;
 Hoja.Cells.Item[4,4]:='Calle';
 Hoja.Cells.Item[4,4].ColumnWidth := 60;
 Hoja.Cells.Item[4,5]:='Colonia';
 Hoja.Cells.Item[4,5].ColumnWidth := 50;
 Hoja.Cells.Item[4,6]:='descripcion';
 Hoja.Cells.Item[4,6].ColumnWidth := 50;


 with ZQsubsRuta do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=DBGridSubs.Fields[2].AsString;
       Hoja.Cells.Item[i,3].WrapText:=TRUE;
       Hoja.Cells.Item[i,3].font.size:=16;
       Hoja.Cells.Item[i,3]:=DBGridSubs.Fields[3].AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,4].font.size:=16;
       Hoja.Cells.Item[i,4]:=DBGridSubs.Fields[4].AsString;
       Hoja.Cells.Item[i,5].font.size:=16;
       Hoja.Cells.Item[i,5]:=DBGridSubs.Fields[5].AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=DBGridSubs.Fields[7].AsString;
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
      Hoja.Cells.Item[i,2]:='Total en la ruta '+IntToStr(ZQSubsruta.RecordCount);
      Hoja.Cells.Item[i,2].font.size:=16;
      Excel.Visible[1]:=true;
      {-----------Consulta para indentificar las subscripciones nuevas de la ruta-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select No_de_subscripcion AS Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_rutas.no_de_subscripcion)As AtencionA,Calle,Colonia,Descripcion_Domicilio as Descripcion from t_descripcion_rutas');
      ZQnuevos.SQL.Add(' where no_de_subscripcion IN (Select nosubscripcion from t_subscripcion where (fecha_alta between CURDATE()-7 AND CURDATE())  AND ruta='+FloatToStr(ruta.KeyValue)+')');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;

 if ZQnuevos.FieldByName('NoSubscripcion').IsNull=FALSE then
     begin
     i:=i+2;
     Hoja.Cells.Item[i,2]:='Subscripciones NUEVAS en la ruta '+ruta.Text;
     Hoja.Cells.Item[i,2].font.size:=16;

  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2].font.size:=11;
       Hoja.Cells.Item[i,2]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('atenciona').AsString;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('Calle').AsString;
       Hoja.Cells.Item[i,5]:=ZQnuevos.FieldByName('Colonia').AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=ZQnuevos.FieldByName('Descripcion').AsString;
       ZQnuevos.Next;
       end;//while
    end;//with
  end;
      {----------------------fin de consulta para identificar los nuevos de la ruta---------------------------------}

         {-----------Consulta para indentificar las subscripciones Canceladas-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir from t_cancelacion where ruta='+FloatToStr(ruta.KeyValue)+' and fecha_ultimo_ejemplar between "'+Formatdatetime('yyyy-mm-dd',now()-8)+' 00:00:00" AND "'+Formatdatetime('yyyy-mm-dd',now())+' 23:59:59"');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
if ZQNuevos.FieldByName('Nosubscripcion').IsNull=FALSE then
   begin
 i:=i+2;
 Hoja.Cells.Item[i,2]:='Subscripciones canceladas que ya NO se deberan entregar en la ruta '+ruta.Text;
 Hoja.Cells.Item[i,2].font.size:=16;

  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('AtencionA').AsString;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('Calle').AsString;
       Hoja.Cells.Item[i,5]:=ZQnuevos.FieldByName('Colonia').AsString;
       Hoja.Cells.Item[i,6].WrapText:=TRUE;
       Hoja.Cells.Item[i,6]:=ZQnuevos.FieldByName('Descripcion_dir').AsString;
       ZQnuevos.Next;
       end;//while
     end;//with
    end;
      {----------------------fin de consulta para identificar los cancelados de la ruta---------------------------------}

     {-----------Consulta para indentificar las subscripciones que cambiaron de domicilio o ruta-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambio_domicilio.nosubscripcion)AS Atenciona,rutao,rutan,direccion from t_cambio_domicilio where rutao='+FloatToStr(ruta.KeyValue)+' AND rutao<>rutan AND fecha between CURDATE()-7 AND CURDATE()+1');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
if ZQNuevos.FieldByName('Nosubscripcion').IsNull=FALSE then
   begin
 i:=i+2;
 Hoja.Cells.Item[i,2]:='Subscripciones ya NO se deberan entregar en la ruta '+ruta.Text+' ya que cambiaron de domicilio';
 Hoja.Cells.Item[i,2].font.size:=16;

  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,2]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,3].WrapText:=TRUE;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('Atenciona').AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('Direccion').AsString;


       ZQnuevos.Next;
       end;//while
     end;//with
    end;
      {----------------------fin de consulta para identificar los que cambiaron de domicilio o ruta---------------------------------}


  end;


if ((tiporuta.Text = 'Ruta foranea') AND (edificios.Text=''))then
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
      tall:=round(ZQSubsruta.RecordCount/30);
        if tall<=1 then
           begin
          Hoja.PageSetup.FitToPagesTall:=1
           end
        else begin
          Hoja.PageSetup.FitToPagesTall:=tall;
        end;

 Hoja.Cells.Item[2,3]:='Hoja de descripcion ruta '+ruta.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,1]:='Cod. Prov.';
 Hoja.Cells.Item[4,2]:='Orden';
 Hoja.Cells.Item[4,3]:='Proveedor';
 Hoja.Cells.Item[4,4]:='Dotacion';
 Hoja.Cells.Item[4,5]:='Tarifa';
 Hoja.Cells.Item[4,6]:='Calle';
 Hoja.Cells.Item[4,6].ColumnWidth := 40;
 Hoja.Cells.Item[4,7]:='Colonia';
 Hoja.Cells.Item[4,7].ColumnWidth := 30;
 Hoja.Cells.Item[4,8]:='Observaciones';
 Hoja.Cells.Item[4,4].ColumnWidth := 30;

 with ZQsubsRuta do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,1]:=DBGridSubs.Fields[0].AsString;
       Hoja.Cells.Item[i,2]:=DBGridSubs.Fields[1].AsString;
       Hoja.Cells.Item[i,3]:=DBGridSubs.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=DBGridSubs.Fields[3].AsString;
       Hoja.Cells.Item[i,5]:=DBGridSubs.Fields[4].AsString;
       Hoja.Cells.Item[i,6]:=DBGridSubs.Fields[5].AsString;
       Hoja.Cells.Item[i,7]:=DBGridSubs.Fields[6].AsString;
       Hoja.Cells.Item[i,8]:=DBGridSubs.Fields[7].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
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
      Hoja.Cells.Item[i+3,3]:='Total en la ruta '+IntToStr(ZQSubsruta.RecordCount);
      Hoja.Cells.Item[i+3,3].font.size:=16;
      Excel.Visible[1]:=true;
  end;  {fin del if de ruta foranea}

if ((tiporuta.Text = 'Ruta Edificio') OR ((tiporuta.Text = 'Ruta Metropolitana') AND (edificios.Text<>''))) then
      begin
i:=4;
 Libro := Excel.Workbooks.Add(NULL, 0);
 Hoja := Libro.Sheets[1] as _WORKSHEET;
  Hoja.PageSetup.Orientation:=1;
  // Ajustar margenes
 Hoja.PageSetup.LeftMargin  := 15;
 Hoja.PageSetup.RightMargin := -5;
 Hoja.PageSetup.TopMargin:=  Excel.InchesToPoints(0.2);
 Hoja.PageSetup.HeaderMargin:= Excel.InchesToPoints(0.2);
 Hoja.PageSetup.BottomMargin:=Excel.InchesToPoints(0.3);
 Hoja.PageSetup.FooterMargin:=Excel.InchesToPoints(0.3);
  Hoja.PageSetup.Zoom:=FALSE;
      Hoja.PageSetup.FitToPagesWide:=1;
      tall:=round(ZQSubsruta.RecordCount/35);
        if tall<=1 then
           begin
          Hoja.PageSetup.FitToPagesTall:=1
           end
        else begin
          Hoja.PageSetup.FitToPagesTall:=tall;
        end;

    if tiporuta.Text='Ruta Edificio' then
      begin
        edificio:=FloatToStr(ruta.KeyValue);
      end;
    if tiporuta.Text='Ruta Metropolitana' then
       begin
         edificio:=FloatToStr(edificios.KeyValue);
       end;





 Hoja.Cells.Item[2,3]:='Hoja de descripcion ruta '+ruta.Text+' '+edificios.Text;
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,3]:='No Subscripcion';
 Hoja.Cells.Item[4,3].ColumnWidth := 5;
 Hoja.Cells.Item[4,4]:='Atencion A';
 Hoja.Cells.Item[4,4].ColumnWidth := 40;
 Hoja.Cells.Item[4,5]:='Área';
 Hoja.Cells.Item[4,5].ColumnWidth := 30;


 with ZQsubsRuta do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=DBGridSubs.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=DBGridSubs.Fields[3].AsString;
       Hoja.Cells.Item[i,5].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=DBGridSubs.Fields[4].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['c'+IntToStr(b),'c'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['d'+IntToStr(b),'d'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
         Hoja.Range['e'+IntToStr(b),'e'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
       end;
      Hoja.Cells.Item[i+3,3]:='Total en la ruta '+IntToStr(ZQSubsruta.RecordCount);
      Hoja.Cells.Item[i+3,3].font.size:=16;
      Excel.Visible[1]:=true;

 {-----------Consulta para indentificar las subscripciones nuevas de la ruta-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion AS Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion)As AtencionA,area from t_descripcion_ruta_edificio');
      ZQnuevos.SQL.Add(' where nosubscripcion IN (Select nosubscripcion from t_subscripcion where (fecha_alta between CURDATE()-7 AND CURDATE()+1) AND (t_subscripcion.edificio>0) AND (ruta='+FloatToStr(ruta.KeyValue)+') AND (id_edificio='+edificio+'))');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;

 if ZQnuevos.FieldByName('NoSubscripcion').IsNull=FALSE then
     begin
     i:=i+2;
     Hoja.Cells.Item[i,3]:='Subscripciones NUEVAS en la ruta '+ruta.Text;
     Hoja.Cells.Item[i,3].font.size:=16;


  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3].font.size:=11;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('atenciona').AsString;
       Hoja.Cells.Item[i,5].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=ZQnuevos.FieldByName('Area').AsString;
       ZQnuevos.Next;
       end;//while
    end;//with
  end;
      {----------------------fin de consulta para identificar los nuevos de la ruta---------------------------------}

         {-----------Consulta para indentificar las subscripciones Canceladas-----------------------------------}
  if tiporuta.Text='Ruta Edificio' then
        begin
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,AtencionA,area from t_cancelacion where edificio='+FloatToStr(ruta.KeyValue)+' and fecha_ultimo_ejemplar between "'+Formatdatetime('yyyy-mm-dd',now()-8)+' 00:00:00" AND "'+Formatdatetime('yyyy-mm-dd',now())+' 23:59:59"');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
        end;
 if tiporuta.Text='Ruta Metropolitana' then
       begin
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,AtencionA,area from t_cancelacion where edificio='+FloatToStr(edificios.KeyValue)+' and fecha_ultimo_ejemplar between "'+Formatdatetime('yyyy-mm-dd',now()-8)+' 00:00:00" AND "'+Formatdatetime('yyyy-mm-dd',now())+' 23:59:59"');
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
      end;
if ZQNuevos.FieldByName('Nosubscripcion').IsNull=FALSE then
   begin
 i:=i+2;
 Hoja.Cells.Item[i,3]:='Subscripciones canceladas que ya NO se deberan entregar en el edificio '+edificios.Text;
 Hoja.Cells.Item[i,3].font.size:=16;

  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3].font.size:=11;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('AtencionA').AsString;
       Hoja.Cells.Item[i,5]:=ZQnuevos.FieldByName('Area').AsString;
       ZQnuevos.Next;
       end;//while
     end;//with
    end;

 {-----------Consulta para indentificar las subscripciones que cambiaron de domicilio o ruta-----------------------------------}
      ZQnuevos.Close;
      ZQnuevos.SQL.Clear;
      ZQNuevos.SQL.Add('Select Nosubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambio_domicilio.nosubscripcion)AS Atenciona,Edificio,rutao,rutan,direccion from t_cambio_domicilio where rutao='+FloatToStr(ruta.KeyValue)+' AND rutao <> rutan AND fecha between CURDATE()-7 AND CURDATE()+1 AND edificio='+edificio);
      ZQnuevos.ExecSQL;
      ZQnuevos.Open;
if ZQNuevos.FieldByName('Nosubscripcion').IsNull=FALSE then
   begin
 i:=i+2;
 Hoja.Cells.Item[i,2]:='Subscripciones ya NO se deberan entregar en la ruta '+ruta.Text+' ya que cambiaron de domicilio';
 Hoja.Cells.Item[i,2].font.size:=16;

  with ZQnuevos do
    begin    first;
     while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,3]:=ZQnuevos.FieldByName('Nosubscripcion').AsString;
       Hoja.Cells.Item[i,4].WrapText:=TRUE;
       Hoja.Cells.Item[i,4]:=ZQnuevos.FieldByName('Atenciona').AsString;
       Hoja.Cells.Item[i,5].WrapText:=TRUE;
       Hoja.Cells.Item[i,5]:=ZQnuevos.FieldByName('Direccion').AsString;


       ZQnuevos.Next;
       end;//while
     end;//with
    end;
{----------------------fin de consulta para identificar los que cambiaron de domicilio o ruta---------------------------------}



   end;         {Fin de if de ruta de edificio}

 if tiporuta.Text = 'Sin ruta' then
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
      tall:=round(ZQSubsruta.RecordCount/32);
        if tall<=1 then
           begin
          Hoja.PageSetup.FitToPagesTall:=1
           end
        else begin
          Hoja.PageSetup.FitToPagesTall:=tall;
        end;
 Hoja.Cells.Item[2,3]:='Subscripciones que no tienene una ruta asignada';
 Hoja.Cells.Item[2,3].font.size:=16;
 Hoja.Cells.Item[4,1]:='No subscripcion';
 Hoja.Cells.Item[4,2]:='titular';
 Hoja.Cells.Item[4,3]:='Ruta';
 Hoja.Cells.Item[4,4]:='Fecha alta';
 Hoja.Cells.Item[4,5]:='Fecha inicio';
 Hoja.Cells.Item[4,6]:='Edificio';
 Hoja.Cells.Item[4,7]:='Calle';
 Hoja.Cells.Item[4,7].ColumnWidth := 40;
 Hoja.Cells.Item[4,8]:='Colonia';
 Hoja.Cells.Item[4,8].ColumnWidth := 40;
 Hoja.Cells.Item[4,9]:='CP';
 Hoja.Cells.Item[4,10]:='Ciudad';
 Hoja.Cells.Item[4,11]:='Descripcion';
 Hoja.Cells.Item[4,11].ColumnWidth := 40;



 with ZQsubsRuta do
    begin    first;
  while not EOF Do
       begin
       i:=i+1;
       Hoja.Cells.Item[i,1]:=DBGridSubs.Fields[0].AsString;
       Hoja.Cells.Item[i,2]:=DBGridSubs.Fields[1].AsString;
       Hoja.Cells.Item[i,3]:=DBGridSubs.Fields[2].AsString;
       Hoja.Cells.Item[i,4]:=DBGridSubs.Fields[3].AsString;
       Hoja.Cells.Item[i,5]:=DBGridSubs.Fields[4].AsString;
       Hoja.Cells.Item[i,6]:=DBGridSubs.Fields[5].AsString;
       Hoja.Cells.Item[i,7]:=DBGridSubs.Fields[6].AsString;
       Hoja.Cells.Item[i,8]:=DBGridSubs.Fields[7].AsString;
       Hoja.Cells.Item[i,9]:=DBGridSubs.Fields[8].AsString;
       Hoja.Cells.Item[i,10]:=DBGridSubs.Fields[9].AsString;
       Hoja.Cells.Item[i,11]:=DBGridSubs.Fields[10].AsString;
       Next;
       end;//while
    end;//with
    For b:=4 to i do
        begin
         Hoja.Range['a'+IntToStr(b),'a'+IntToStr(b)].BorderAround(xlContinuous,xlTransparent,xlAutomatic,EmptyParam);
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
      Hoja.Cells.Item[i+3,3]:='Total en la ruta '+IntToStr(ZQSubsruta.RecordCount);
      Hoja.Cells.Item[i+3,3].font.size:=16;
      Excel.Visible[1]:=true;
      end;


end;




procedure TFAdmon_rutas.FormShow(Sender: TObject);
begin
  altas.Caption:=FPrincipalCirculacion.label6.Caption+' '+FPrincipalCirculacion.altas.Caption;
  cancelados.Caption:=FPrincipalCirculacion.label5.Caption+' '+FPrincipalCirculacion.cambios.Caption;
end;

procedure TFAdmon_rutas.actualizarClick(Sender: TObject);
var
Norutas,i,ruta,a,statusbar:integer;
NoRegistros,edicion,orden:integer;
fecha,fechaedicion:String;
actualiza:Bool;
{variables para la insercion de rutas foraneas}
id_proveedor,nombre,dotacion,devolucion,empaque,observaciones,tarifa:String;
adeudo,pagado:double;
{variables para la insercion de rutas edificios}
nosubscripcion,titular,area:String;
{variables para la insercion de rutas metropolitanas}
 calle,colonia,cp,ciudad,descripcion:String;
yearremision,incremento:integer;
{variables para la insercion en zocalo}
noproveedores:integer;
codigo,voceador:String;
begin
fecha:=DateToStr(now); {Leemos la fecha actual para usarla en todo el evento}
yearremision:=10;
incremento:=1;
progresototal.Position:=0;
progresototal.Max:=yearremision;
progresototal.Visible:=TRUE;
 if application.MessageBox (pchar('¿Esta seguro que desea actualizar las tablas de remisiones? Esto tomara unos minutos y borrara los pagos capturados el dia de hoy'), pchar('Confirmar actualizacion'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin



{-------------------------------------------------------------------------------------}


     {Inicia el proceso de actualizacion de remision en rutas foraneas}
{----------------------------RUTAS FORANEAS-----------------------------------------------------}
{Determinamos edicion que corresponde de acuerdo a la fecha actual}
ZQCuentarutas.Close;
ZQCuentarutas.SQL.Clear;
ZQCuentarutas.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(now())+'" limit 1');
ZQCuentarutas.ExecSQL;
ZQCuentarutas.Open;
  if ZQCuentarutas.FieldByName('Edicion').IsNull = TRUE then
      begin
        edicion:=835;
       // showMessage(IntToStr(edicion));
      end;
  if ZQCuentarutas.FieldByName('Edicion').IsNull = FALSE then
   begin
    // showMessage(IntToStr(edicion));
    edicion:=ZQCuentarutas.FieldByName('Edicion').AsInteger;
    actualiza:=FALSE;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_remision_rutas where edicion >='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_remision_edificios where edicion>='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_remision_metropolitana where edicion>='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_remision_zocalo where edicion>='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_devoluciones where edicion>='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Delete from t_devoluciones_zocalo where edicion>='+IntToStr(edicion));
        ZQtmp.ExecSQL;
        ZQtmp.Close;


   end;
ZQCuentarutas.Close;
//ZQcuentarutas.SQL.Clear;
//ZQCuentarutas.SQL.Add('Select fecha from t_remision_rutas where edicion='+IntToStr(edicion));
//ZQCuentarutas.ExecSQL;
//ZQCuentarutas.Open;
//fechaedicion:=ZQCuentarutas.FieldByName('fecha').AsString;
//showmessage('La fecha es:'+fecha+'la fecha del query es: '+ZQCuentarutas.FieldByName('fecha').AsString);
  //if  fechaedicion = fecha then
    // begin
     


     //end
   //else begin
   //     Edicion:=Edicion+1;
   //     actualiza:=FALSE;
   //end;
 while incremento <= yearremision do
   begin

      Progreso.Visible:=TRUE;
       i:=1;
       ZQcuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Contamos el numero de rutas que existe en rutas foraneas}
       ZQCuentarutas.SQL.Add('Select count(DISTINCT(ruta)) AS NoRutas from c_proveedores;');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       {guardamos el numero de rutas foraneas}
       Norutas:=ZQCuentarutas.FieldByName('Norutas').AsInteger;
       ZQCuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Seleccionamos los numeros de rutas foraneas en ZQCuentarutas para iterar dependiendo del numero de rutas}
       ZQCuentarutas.SQL.Add('Select DISTINCT(ruta)AS rutas from c_proveedores');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       while i<=Norutas do
         begin
              {Seleccionamos la primera ruta del query}
             ruta:=ZQCuentarutas.FieldByName('rutas').AsInteger;
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {contamos el numero de registros que se van a insertar en la tabla de remision}
             ZQCuentaregistros.SQL.Add('Select Count(*) AS NoRegistros FROM c_proveedores where ruta='+IntToStr(ruta));
             ZQCuentaregistros.Open;
             Noregistros:=ZQCuentaregistros.FieldByName('Noregistros').AsInteger;
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {Pasamos al query los registros que se van a actualizar para irnos moviendo entre ellos}
             ZQCuentaregistros.SQL.Add('Select id_proveedor,Nombre,dotacion,empaque,observaciones,tarifa FROM c_proveedores where ruta ='+IntToStr(ruta));
             ZQCuentaregistros.ExecSQL;
             ZQCuentaregistros.Open;
             a:=1;
             if i=1 then
                begin
                  Progreso.Position:=1;
                  Progreso.Max:=Norutas*Noregistros;
                end;
              while a<= Noregistros do
                   begin
                        Progreso.Position:=Progreso.Position+1;
                       {Pasamos los datos que se van a insertar en la tabla de remision}
                       id_proveedor:=ZQCuentaregistros.FieldByName('id_proveedor').AsString;
                       nombre:=ZQCuentaregistros.FieldByName('Nombre').AsString;
                       dotacion:=ZQCuentaregistros.FieldByName('dotacion').AsString;
                       empaque:=ZQCuentaregistros.FieldByName('empaque').AsString;
                       observaciones:=ZQCuentaregistros.FieldByName('Observaciones').AsString;
                       tarifa:=ZQCuentaregistros.FieldByName('tarifa').AsString;
                       ZQtmp.Close;
                       ZQtmp.SQL.Clear;
                       adeudo:=(StrToFloat(dotacion)*StrToFloat(tarifa));
                       {Determinamos si es una actualización de la edicion o si es una nueva edicion}
                       if (actualiza = TRUE) then
                               begin
                               {Actualizamos los datos de la fecha y edicion actual}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Update t_remision_rutas SET plaza="'+nombre+'",dotacion='+dotacion+',empaque="'+empaque+'",observaciones="'+observaciones+'",fecha="'+fecha+'",tarifa='+tarifa+',adeudo='+FloatToStr(adeudo)+' Where (ruta ='+IntToStr(ruta)+' AND edicion='+IntToStr(edicion)+' AND codigo_proveedor='+id_proveedor+')');
                       ZQActualiza.ExecSQL;
                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                               end;
                       if (Actualiza = FALSE) then
                               begin
                               {Insertamos los nuevos datos de la edicion este caso no deberia pasar a menos que ocurra un error cuando se ejecute el trigger que llena la tabla de remison}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Insert into t_remision_rutas (codigo_proveedor,plaza,dotacion,empaque,observaciones,fecha,ruta,tarifa,edicion,adeudo) VALUES ('+id_proveedor+',"'+nombre+'",'+dotacion+',"'+empaque+'","'+observaciones+'","'+fecha+'",'+IntToStr(ruta)+','+tarifa+','+IntToStr(edicion)+','+FloatToStr(adeudo)+')');
                       ZQActualiza.ExecSQL;
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Update t_devoluciones SET vendidos=('+dotacion+'-devolucion) Where edicion='+IntToStr(edicion)+' and codigo='+id_proveedor);
                       ZQActualiza.ExecSQL;
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Select SUM(pago) AS Pagado from t_devoluciones Where edicion='+IntToStr(edicion)+' and codigo='+id_proveedor);
                       ZQActualiza.ExecSQL;
                       ZQActualiza.Open;
                       pagado:=ZQActualiza.FieldByName('pagado').AsFloat;
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Update t_remision_rutas Set Adeudo=('+FloatToStr(adeudo-pagado)+') where edicion='+IntToStr(edicion)+' AND codigo_proveedor='+id_proveedor);
                       //ShowMessage('Adeudo: '+FloatToStr(adeudo-pagado));
                       ZQActualiza.ExecSQL;

                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                          end;

                   end;  {fin de segundo while}
             i:=i+1;
             ZQCuentarutas.Next;


         end;  {fin del primer while}
{---------------------------FIN DE ACTUALIZACION EN RUTAS FORANEAS---------------------------------}
{---------------------------INICIA ACTUALIZACION DE REMISION EN EDIFICIOS--------------------------}
      i:=1;
       ZQcuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Contamos el numero de rutas que existe en rutas foraneas}
       ZQCuentarutas.SQL.Add('Select count(DISTINCT(id_edificio)) AS NoRutas from t_descripcion_ruta_edificio');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       {guardamos el numero de rutas foraneas}
       Norutas:=ZQCuentarutas.FieldByName('Norutas').AsInteger;
       ZQCuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Seleccionamos los numeros de rutas foraneas en ZQCuentarutas para iterar dependiendo del numero de rutas}
       ZQCuentarutas.SQL.Add('Select DISTINCT(id_edificio)AS rutas from t_descripcion_ruta_edificio');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       while i<=Norutas do
         begin
              {Seleccionamos la primera ruta del query}
             ruta:=ZQCuentarutas.FieldByName('rutas').AsInteger;
             //ShowMessage(IntTOStr(ruta));
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {contamos el numero de registros que se van a insertar en la tabla de remision}
             ZQCuentaregistros.SQL.Add('Select Count(*) AS NoRegistros FROM t_descripcion_ruta_edificio where id_edificio='+IntToStr(ruta));
             ZQCuentaregistros.Open;
             Noregistros:=ZQCuentaregistros.FieldByName('Noregistros').AsInteger;
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {Pasamos al query los registros que se van a actualizar para irnos moviendo entre ellos}
             ZQCuentaregistros.SQL.Add('Select nosubscripcion as "NoSubscripcion",area  from t_descripcion_ruta_edificio where id_edificio ='+IntToStr(ruta)+' Order by Orden_en_reparto');
             ZQCuentaregistros.ExecSQL;
             ZQCuentaregistros.Open;
             a:=1;
              if i=1 then
                begin
                  Progreso.Position:=1;
                  Progreso.Max:=Norutas*Noregistros;
                end;
              while a<= Noregistros do
                   begin
                       Progreso.Position:=Progreso.Position+1;
                       {Pasamos los datos que se van a insertar en la tabla de remision}
                       Nosubscripcion:=ZQCuentaregistros.FieldByName('Nosubscripcion').AsString;
                       ZQTmp.Close;
                       ZQtmp.SQL.Clear;
                       ZQtmp.SQL.Add('Select atenciona as titular from t_subscripcion where nosubscripcion='+Nosubscripcion);
                       ZQtmp.ExecSQL;
                       ZQtmp.Open;
                       //ShowMessage('Nosubs '+Nosubscripcion+',Contador '+IntToStr(a));
                       titular:=ZQtmp.FieldByName('titular').AsString;
                       area:=ZQCuentaregistros.FieldByName('area').AsString;

                       {Determinamos si es una actualización de la edicion o si es una nueva edicion}
                       if (actualiza = TRUE) then
                               begin
                               {Actualizamos los datos de la fecha y edicion actual}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Update t_remision_edificios SET titular="'+titular+'",area="'+area+'",edicion='+IntToStr(edicion)+',fecha="'+fecha+'" Where (edificio ='+IntToStr(ruta)+' AND edicion='+IntToStr(edicion)+' AND Nosubscripcion='+nosubscripcion+')');
                       ZQActualiza.ExecSQL;
                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                               end;
                       if (Actualiza = FALSE) then
                               begin
                       {Insertamos los nuevos datos de la edicion este caso no deberia pasar a menos que ocurra un error cuando se ejecute el trigger que llena la tabla de remison}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Insert into t_remision_edificios (Nosubscripcion,titular,area,edicion,fecha,edificio) VALUES ('+Nosubscripcion+',"'+titular+'","'+area+'",'+IntToStr(edicion)+',"'+fecha+'",'+IntToStr(ruta)+')');
                       ZQActualiza.ExecSQL;
                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                         end;

                   end;  {fin de segundo while}
             i:=i+1;
             ZQCuentarutas.Next;


         end;  {fin del primer while}
{-----------------------------FIN DE ACTUALIZACION EN EDIFICIOS-------------------------------------}
{-----------------------------Inicia Actualizacion de remision subscriptores------------------------}
       i:=1;
       ZQcuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Contamos el numero de rutas que existe en rutas metropolitanas}
       ZQCuentarutas.SQL.Add('select count(DISTINCT(no_ruta)) AS norutas from t_descripcion_rutas');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       {guardamos el numero de rutas metropolitanas}
       Norutas:=ZQCuentarutas.FieldByName('Norutas').AsInteger;
       ZQCuentarutas.Close;
       ZQCuentarutas.SQL.Clear;
       {Seleccionamos los numeros de rutas metropolitanas en ZQCuentarutas para iterar dependiendo del numero de rutas}
       ZQCuentarutas.SQL.Add('Select DISTINCT(no_ruta) as rutas from t_descripcion_rutas');
       ZQCuentarutas.ExecSQL;
       ZQCuentarutas.Open;
       while i<=Norutas do
         begin
              {Seleccionamos la primera ruta del query}
             ruta:=ZQCuentarutas.FieldByName('rutas').AsInteger;
             //ShowMessage(IntTOStr(ruta));
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {contamos el numero de registros que se van a insertar en la tabla de remision}
             ZQCuentaregistros.SQL.Add('Select count(*) as NoRegistros from t_descripcion_rutas where no_ruta = '+IntToStr(ruta));
             ZQCuentaregistros.Open;
             Noregistros:=ZQCuentaregistros.FieldByName('Noregistros').AsInteger;
             ZQCuentaregistros.Close;
             ZQCuentaregistros.SQL.Clear;
             {Pasamos al query los registros que se van a actualizar para irnos moviendo entre ellos}
             ZQCuentaregistros.SQL.Add('Select no_de_subscripcion as "NoSubscripcion",calle,colonia,cp,ciudad,descripcion_domicilio AS Descripcion,orden_en_el_reparto AS Orden from t_descripcion_rutas where no_ruta ='+IntToStr(ruta)+' Order by Orden_en_el_reparto');
             ZQCuentaregistros.ExecSQL;
             ZQCuentaregistros.Open;
             a:=1;
              if i=1 then
                begin
                  Progreso.Position:=1;
                  Progreso.Max:=Norutas*Noregistros;
                end;
              while a<= Noregistros do
                   begin
                       Progreso.Position:=Progreso.Position+1;
                       {Pasamos los datos que se van a insertar en la tabla de remision}
                       Nosubscripcion:=ZQCuentaregistros.FieldByName('Nosubscripcion').AsString;

                       ZQTmp.Close;
                       ZQtmp.SQL.Clear;
                       ZQtmp.SQL.Add('Select atenciona as titular from t_subscripcion where nosubscripcion='+Nosubscripcion);
                       ZQtmp.ExecSQL;
                       ZQtmp.Open;
                       //ShowMessage('Nosubs '+Nosubscripcion+',Contador '+IntToStr(a));
                       titular:=ZQtmp.FieldByName('titular').AsString;
                       calle:=ZQCuentaregistros.FieldByName('calle').AsString;
                       colonia:=ZQCuentaregistros.FieldByName('colonia').AsString;
                       cp:=ZQCuentaregistros.FieldByName('cp').AsString;
                       ciudad:=ZQCuentaregistros.FieldByName('ciudad').AsString;
                       descripcion:=ZQCuentaregistros.FieldByName('Descripcion').AsString;
                       Orden:=ZQCuentaregistros.FieldByName('Orden').AsInteger;


                       {Determinamos si es una actualización de la edicion o si es una nueva edicion}
                       if (actualiza = TRUE) then
                               begin
                               {Actualizamos los datos de la fecha y edicion actual}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Update t_remision_metropolitana SET titular="'+titular+'",calle="'+calle+'",colonia="'+colonia+'",cp='+cp+',ciudad="'+ciudad+'",descripcion="'+descripcion+'",orden_en_reparto='+IntToStr(orden)+',fecha="'+fecha+'" Where (ruta ='+IntToStr(ruta)+' AND edicion='+IntToStr(edicion)+' AND Nosubscripcion='+nosubscripcion+')');
                       ZQActualiza.ExecSQL;
                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                               end;
                       if (Actualiza = FALSE) then
                               begin
                        {Insertamos los nuevos datos de la edicion este caso no deberia pasar a menos que ocurra un error cuando se ejecute el trigger que llena la tabla de remison}
                       ZQActualiza.Close;
                       ZQActualiza.SQL.Clear;
                       ZQActualiza.SQL.Add('Insert into t_remision_metropolitana (Nosubscripcion,titular,calle,colonia,cp,ciudad,descripcion,orden_en_reparto,fecha,ruta,edicion) VALUES ('+Nosubscripcion+',"'+titular+'","'+calle+'","'+colonia+'",'+cp+',"'+ciudad+'","'+descripcion+'",'+IntToStr(orden)+',"'+fecha+'",'+IntToStr(ruta)+','+IntToStr(edicion)+')');
                       ZQActualiza.ExecSQL;
                       {incrementamos el contador y nos movemos un registro adelante}
                       a:=a+1;
                       ZQCuentaregistros.Next;
                         end;

                   end;  {fin de segundo while}
             i:=i+1;
             ZQCuentarutas.Next;


         end;  {fin del primer while}


{------------------------------FIN DE ACTUALIZACION DE SUBSCRIPTORES--------------------------------}
{------------------------inicia actualizacion de remisones para zocalo------------------------------}
  ZQcuentaregistros.close;
  ZQcuentaregistros.SQL.Clear;
  ZQcuentaregistros.SQL.Add('Select count(*) as totalp from c_proveedores_zocalo');
  ZQcuentaregistros.ExecSQL;
  ZQcuentaregistros.Open;
  noproveedores:=ZQcuentaregistros.FieldByName('totalp').AsInteger;
  ZQcuentaregistros.Close;
  ZQcuentaregistros.SQL.Clear;
  ZQcuentaregistros.SQL.Add('Select * from c_proveedores_zocalo where estatus=1');
  ZQcuentaregistros.ExecSQL;
  ZQcuentaregistros.Open;

  while i<= noproveedores do
      begin {inicio primer while}
         codigo:=ZQcuentaregistros.FieldByName('id_proveedor').AsString;
         voceador:=ZQcuentaregistros.FieldByName('nombre').AsString;
         dotacion:=ZQcuentaregistros.FieldByName('dotacion').AsString;
         tarifa:=ZQcuentaregistros.FieldByName('tarifa').AsString;
         ZQtmp.Close;
         ZQtmp.SQl.Clear;
         ZQtmp.SQL.Add('Insert into t_remision_zocalo (edicion,codigo,voceador,dotacion,tarifa,adeudo,fecha) VALUES ('+IntTOStr(edicion)+','+codigo+',"'+voceador+'",'+dotacion+','+tarifa+','+FloatToStr(StrToFloat(dotacion)*StrToFloat(tarifa))+',"'+fecha+'")');
         ZQtmp.ExecSQL;
         i:=i+1;
         ZQCuentaregistros.Next;
      end; {Fin del primer while}


{----------------------------- fin de actualizacion de remisiones para zocalo-----------------------}

    fecha:=DateToStr(now()+incremento);
    edicion:=edicion+1;
    incremento:=incremento+1;
    progresototal.Position:=progresototal.Position+1;
     end;
    ShowMessage('Se actualizaron las remisiones correctamente');
 end; {Fin del if de actualizacion de remision}
  progresototal.Visible:=FALSE;
  Progreso.Visible:=FALSE;

end;


procedure TFAdmon_rutas.DBGridRutaCellClick(Column: TColumn);
begin
if  rutaprincipal.Text = 'Ruta Metropolitana' then
     begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridRuta.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     titd.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dird.Caption:=DBGridRuta.Fields[3].AsString+', '+DBGridRuta.Fields[4].AsString+', CP:'+DBGridRuta.Fields[5].AsString+', Descripcion del domicilio:'+DBGridRuta.Fields[6].AsString;
     end;
if rutaprincipal.Text = 'Ruta foranea' then
      begin
       titd.Caption:=DBGridRuta.Fields[2].AsString;
       dird.Caption:=DBGridRuta.Fields[5].AsString+','+DBGridRuta.Fields[6].AsString+', Observaciones:'+DBGridRuta.Fields[7].AsString;
      end;
if rutaprincipal.Text='Sin ruta' then
   begin
     titd.Caption:=DBGridRuta.Fields[1].AsString;
     dird.Caption:=DBGridRuta.Fields[5].AsString+', '+DBGridSubs.Fields[6].AsString+', '+DBGridSubs.Fields[7].AsString+', CP:'+DBGridSubs.Fields[8].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[10].AsString;
   end;
if rutaprincipal.Text='Ruta Edificio' then
   begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridRuta.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     titd.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dird.Caption:=DBGridRuta.Fields[3].AsString;
   end;
end;

procedure TFAdmon_rutas.DBGridSubsCellClick(Column: TColumn);
begin
//  DBGridSubs.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
if edificios.Text='' then
   begin
if  tiporuta.Text = 'Ruta Metropolitana' then
     begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridSubs.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     tit.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dir.Caption:=DBGridSubs.Fields[3].AsString+', '+DBGridSubs.Fields[4].AsString+', CP:'+DBGridSubs.Fields[5].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[6].AsString;
     end;
if tiporuta.Text = 'Ruta foranea' then
      begin
       tit.Caption:=DBGridSubs.Fields[2].AsString;
       dir.Caption:=DBGridSubs.Fields[5].AsString+','+DBGridSubs.Fields[6].AsString+', Observaciones:'+DBGridSubs.Fields[7].AsString;
      end;
if tiporuta.Text='Sin ruta' then
   begin
     tit.Caption:=DbGridSubs.Fields[1].AsString;
     dir.Caption:=DBGridSubs.Fields[5].AsString+', '+DBGridSubs.Fields[6].AsString+', '+DBGridSubs.Fields[7].AsString+', CP:'+DBGridSubs.Fields[8].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[10].AsString;
   end;
if tiporuta.Text='Ruta Edificio' then
   begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridSubs.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     tit.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dir.Caption:=DBGridSubs.Fields[4].AsString;
   end;
 end;


end;

procedure TFAdmon_rutas.DBGridSubsKeyPress(Sender: TObject; var Key: Char);
var
nombre,dotacion,tarifa,calle,colonia,observaciones,codigo:String;
fila,columna:integer;
begin
  columna:=DBGridSubs.SelectedIndex;
  fila:=ZQSubsruta.RecNo;
 if (Key=#13) then
     begin
   if  tiporuta.Text = 'Ruta foranea' then
     begin
    nombre:=DBGridSubs.Fields[2].AsString;
    dotacion:=DBGridSubs.Fields[3].AsString;
    tarifa:=DBGridSubs.Fields[4].AsString;
    calle:=DBGridSubs.Fields[5].AsString;
    colonia:=DBGridSubs.Fields[6].AsString;
    Observaciones:=DBGridSubs.Fields[7].AsString;
    Codigo:=DBGridSubs.Fields[0].AsString;
    ZQSubsruta.Close;
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_proveedores Set nombre="'+nombre+'",dotacion='+dotacion+',Tarifa='+tarifa+',calle="'+calle+'",colonia="'+colonia+'",observaciones="'+observaciones+'" where id_proveedor='+codigo);
    ZQtmp.ExecSQL;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_enel_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
     end;
   end;

end;

procedure TFAdmon_rutas.DBGridSubsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if  tiporuta.Text = 'Ruta Metropolitana' then
     begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+DBGridSubs.Fields[2].AsString);
     ZQtmp.ExecSQL;
     ZQtmp.Open;
     tit.Caption:=ZQtmp.FieldByName('atenciona').AsString;
     Zqtmp.close;
     dir.Caption:=DBGridSubs.Fields[3].AsString+', '+DBGridSubs.Fields[4].AsString+', CP:'+DBGridSubs.Fields[5].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[6].AsString;
     end;
if  tiporuta.Text = 'Ruta foranea' then
      begin
       tit.Caption:=DBGridSubs.Fields[2].AsString;
       dir.Caption:=DBGridSubs.Fields[5].AsString+','+DBGridSubs.Fields[6].AsString+', Observaciones:'+DBGridSubs.Fields[7].AsString;
      end;
if tiporuta.Text='Sin ruta' then
   begin
     tit.Caption:=DbGridSubs.Fields[1].AsString;
     dir.Caption:=DBGridSubs.Fields[5].AsString+', '+DBGridSubs.Fields[6].AsString+', '+DBGridSubs.Fields[7].AsString+', CP:'+DBGridSubs.Fields[8].AsString+', Descripcion del domicilio:'+DBGridSubs.Fields[10].AsString;
   end;
end;

procedure TFAdmon_rutas.edificiosCloseUp(Sender: TObject);
begin
  if edificios.Text<>'' then
   begin
   ZQSubsruta.Close;
   ZQSubsruta.SQL.Clear;
   ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
   ZQSubsruta.SQL.Add(',Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(edificios.KeyValue)+' order by orden_en_reparto');
   ZQSubsruta.ExecSQL;
   ZQSubsruta.Open;
   ZQSubsruta.Active:=TRUE;
   DBGridSubs.Refresh;
   tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
   tit.Caption:='';
   dir.Caption:='';

   end;

end;

procedure TFAdmon_rutas.generarClick(Sender: TObject);
var
Norutas,i,ruta,a,statusbar:integer;
NoRegistros,edicion,orden:integer;
fecha,fechaedicion:String;
actualiza:Bool;
{variables para la insercion de rutas foraneas}
id_proveedor,nombre,dotacion,devolucion,empaque,observaciones,tarifa:String;
adeudo,pagado:double;
{variables para la insercion de rutas edificios}
nosubscripcion,titular,area:String;
{variables para la insercion de rutas metropolitanas}
 calle,colonia,cp,ciudad,descripcion:String;
{variables para el control del no de edicion}
fechahoy,fechaprogramada:String;
diferenciadias:integer;
begin
 {Leemos la fecha actual para usarla en todo el evento}

ShowMessage('Mañana:'+dateToStr((now()+1)));

end;

procedure TFAdmon_rutas.quitarClick(Sender: TObject);
var
nosubscripcion,norutaant,norutanueva,ordennuevo,codigo:string;
fila,columna,filad,columnad:integer;
titular,direccion:String;
begin
  fechahoy:=dateToStr(now);
  columna:=DBGridSubs.SelectedIndex;
  fila:=ZQSubsruta.RecNo;
  columnad:=DBGridSubs.SelectedIndex;
  filad:=ZQSubsruta.RecNo;
  if  ((tiporuta.Text = 'Ruta Metropolitana') and (rutaprincipal.Text='Ruta Metropolitana')) then
     begin
    //ShowMessage('Ruta Metropolitana 2');
    nosubscripcion:=DBGridSubs.Fields[2].AsString;
    norutanueva:=FloatToStr(ruta.KeyValue);
    norutaant:=FloatToStr(Seleccionarruta.KeyValue);
    Direccion:=DBGridRuta.Fields[3].AsString+',colonia '+DBGridRuta.Fields[4].AsString+',C.P. '+DBGridRuta.Fields[5].AsString+', Descripcion domicilio'+DBGridRuta.Fields[6].AsString;
    Zqtmp.Close;
    Zqtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update t_subscripcion set ruta='+norutanueva+',fechamodif="'+DateToStr(now())+'" where nosubscripcion='+nosubscripcion);
    ZQtmp.ExecSQL;
    Zqtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update t_descripcion_rutas set no_ruta='+norutanueva+' where no_de_subscripcion='+nosubscripcion);
    ZQtmp.ExecSQL;
    Zqtmp.Close;
       {inicia procedimiento para tabla de notifiacion}
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+nosubscripcion);
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       titular:=ZQtmp.FieldByName('atenciona').AsString;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosubscripcion+',"'+titular+'","'+fechahoy+'","'+direccion+'",'+norutaant+','+norutanueva+')');
       ZQtmp.ExecSQL;
       ZQtmp.Close;

    {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;

    {---------------------Fin de pasar a lado derecho metropolitano--------------------}
    {----------------------Inicio pasar a lado derecho ruta foranea--------------------}
if  ((tiporuta.Text = 'Ruta foranea') and (rutaprincipal.Text = 'Ruta foranea')) then
     begin
     codigo:=DBGridSubs.Fields[0].AsString;
     norutanueva:=ruta.KeyField;
     norutaant:=FloatToStr(Seleccionarruta.KeyValue);
     Zqtmp.Close;
     Zqtmp.SQL.Clear;
     ZQtmp.SQL.Add('Update c_proveedores set ruta='+norutanueva+' where id_proveedor='+codigo);
     ZQtmp.ExecSQL;
     Zqtmp.Close;
     {-------------------------Actualizamos grid izquierdo------------------------------}
     ZQSubsruta.Close;
     ZQSubsruta.SQL.Clear;
     ZQSubsruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_enel_reparto');
     ZQSubsruta.ExecSQL;
     ZQSubsruta.Open;
     ZQSubsruta.Active:=TRUE;
     DBGridSubs.Refresh;
     DBGridSubs.SelectedIndex:=columna;
     ZQSubsruta.RecNo:=fila;
     tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     {-------------------------Actualizamos grid derecho--------------------------------}
     ZQgridseleccionruta.Close;
     ZQgridseleccionruta.SQL.Clear;
     ZQgridseleccionruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_enel_reparto');
     ZQgridseleccionruta.ExecSQL;
     ZQgridseleccionruta.Open;
     ZQgridseleccionruta.Active:=TRUE;
     DBGridRuta.Refresh;
     DBGridRuta.SelectedIndex:=columnad;
     ZQgridseleccionruta.RecNo:=filad;
     totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
     end;
     {-------------------------Fin de pasar del lado derecho ruta foranea---------------}
     {---------------------Inicio pasar del lado derecho sin ruta-o asignar ruta--------}
  if ((tiporuta.Text = 'Sin ruta')and (rutaprincipal.Text='Ruta Metropolitana')) then
      begin
    nosubscripcion:=DBGridSubs.Fields[0].AsString;
    norutanueva:='0';
    norutaant:=FloatToStr(Seleccionarruta.KeyValue);
    if DBGridSubs.Fields[6].AsString ='' then
      begin
       ShowMessage('Hacen falta datos para poder asignar a una ruta metropolitana, modifique la subscripcion para actualizar los datos faltantes');
      end
    else begin
     Direccion:=DBGridSubs.Fields[6].AsString+',colonia '+DBGridSubs.Fields[7].AsString+',C.P. '+DBGridSubs.Fields[8].AsString+','+DBGridSubs.Fields[9].AsString+', Descripcion domicilio'+DBGridSubs.Fields[10].AsString;
     Zqtmp2.Close;
     Zqtmp2.SQL.Clear;
     ZQtmp2.SQL.Add('Update t_subscripcion set ruta='+norutanueva+',fechamodif="'+DateToStr(now())+'" where nosubscripcion='+nosubscripcion);
     ZQtmp2.ExecSQL;
     Zqtmp2.Close;
     ZQtmp2.SQL.Clear;
     ZQtmp2.SQL.Add('insert into t_descripcion_rutas (no_ruta,No_de_subscripcion,calle,colonia,cp,ciudad,Descripcion_domicilio) Values('+norutanueva+','+nosubscripcion+',"'+DBGridSubs.Fields[6].AsString+'","'+DBGridSubs.Fields[7].AsString+'",'+DBGridSubs.Fields[8].AsString+',"'+DBGridSubs.Fields[9].AsString+'","'+DBGridSubs.Fields[10].AsString+'")');
     ZQtmp2.ExecSQL;
     Zqtmp2.Close;
        {inicia procedimiento para tabla de notifiacion}
       ZQtmp2.SQL.Clear;
       ZQtmp2.SQL.Add('Select atenciona from t_subscripcion where nosubscripcion='+nosubscripcion);
       ZQtmp2.ExecSQL;
       ZQtmp2.Open;
       titular:=ZQtmp2.FieldByName('atenciona').AsString;
       ZQtmp2.SQL.Clear;
       ZQtmp2.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosubscripcion+',"'+titular+'","'+fechahoy+'","'+direccion+'",'+norutaant+','+norutanueva+')');
       ZQtmp2.ExecSQL;
       ZQtmp2.Close;

    {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    zQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);

      end; {Fin del if de datos completos}
    end;      {fin del if de rutas}
  if ((tiporuta.Text = 'Sin ruta')and (rutaprincipal.Text='Ruta Edificio')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[0].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}
    ZQSubsruta.Close;
    zQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(Seleccionarruta.KeyValue)+' order by orden_en_reparto' );
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);

      end;
   if ((tiporuta.Text = 'Ruta Edificio')and (rutaprincipal.Text='Ruta Metropolitana')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[2].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}

    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto' );
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",calle,colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(Seleccionarruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
      end;

  if ((tiporuta.Text = 'Ruta Edificio')and (rutaprincipal.Text='Ruta Edificio')) then
      begin
       nosubscripcion:=DBGridSubs.Fields[2].AsString;
        FPrincipalCirculacion.numerodesubscripcion:=nosubscripcion;
        FModificar_Subscripcion.Enabled:=FALSE;
        FModificar_Subscripcion := TFModificar_Subscripcion.Create(self);
        FModificar_Subscripcion.ShowModal;

        {---------------Actualizamos grid de origen-------------------------------}

    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto' );
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    DBGridSubs.SelectedIndex:=columna;
    ZQSubsruta.RecNo:=fila;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {----------------Actualizamos grid de destino-----------------------------}
    ZQgridseleccionruta.Close;
    ZQgridseleccionruta.SQL.Clear;
    ZQgridseleccionruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(Seleccionarruta.KeyValue)+' order by orden_en_reparto' );
    ZQgridseleccionruta.ExecSQL;
    ZQgridseleccionruta.Open;
    ZQgridseleccionruta.Active:=TRUE;
    DBGridRuta.Refresh;
    DBGridRuta.SelectedIndex:=columnad;
    ZQgridseleccionruta.RecNo:=filad;
    totd.Caption:=IntToStr(ZQgridseleccionruta.RecordCount);
      end;



end;

procedure TFAdmon_rutas.RutaCloseUp(Sender: TObject);
begin
  DBGridSubs.Options:=[dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
  //showmessage('El no de ruta es:'+FloatToStr(ruta.KeyValue));
 

if ruta.Text<>'' then
    begin

  if  tiporuta.Text = 'Ruta Metropolitana' then
     begin
    edificios.ListField:='';
    edificios.KeyValue:='';
    edificios.Visible:=TRUE;
    BRemision.Enabled:=FALSE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_rutas.no_de_subscripcion)As AtencionA,calle,colonia,cp');
    ZQSubsruta.SQL.Add(',Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    totalporruta:=Zqsubsruta.RecordCount;
    {--------Contamos el total por edificios y lo sumamos--------------}
    zqtotal.Close;
    Zqtotal.SQL.Clear;
    ZQtotal.SQL.Add('Select count(*) as edificios from t_descripcion_ruta_edificio where no_ruta='+FloatToStr(ruta.KeyValue));
    Zqtotal.ExecSQL;
    ZQtotal.Open;
    totalporruta:=totalporruta+Zqtotal.FieldByName('edificios').AsInteger;
    totalruta.Caption:=IntToStr(totalporruta);

    {------------------------------------------------------------------}
    {------llenamos el combo de edificios de la ruta-------------------}
    ZQEdificio.Close;
    ZQEdificio.SQL.Clear;
    ZQEdificio.SQL.Add('Select Descripcion,id_edificio from c_edificios where ruta='+FloatToStr(ruta.KeyValue));
    ZQedificio.ExecSQL;
    ZQEdificio.Open;
    ZQEdificio.Active:=TRUE;
    //ShowMessage(ZQEdificio.FieldByName('Descripcion').AsString);
    //edificios.ListSource:=DSedificio;
    edificios.ListField:='Descripcion';
    edificios.KeyField:='id_edificio';

    {-------------------------------------------------------------------}
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
  if  tiporuta.Text = 'Ruta foranea' then
     begin
    Edificios.Visible:=TRUE;
    BRemision.Enabled:=TRUE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_proveedor as "Cod. proveedor",Orden_enel_reparto AS "Orden entrega",nombre AS "Proveedor",dotacion,Tarifa,calle,colonia,observaciones from c_proveedores where ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_enel_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
  if  tiporuta.Text = 'Ruta Edificio' then
     begin
     Edificios.Visible:=FALSE;
    BRemision.Enabled:=TRUE;
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
    ZQSubsruta.SQL.Add(',Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(ruta.KeyValue)+' order by orden_en_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
     end;
 if tiporuta.Text = 'Sin ruta' then
      begin
      Edificios.Visible:=FALSE;
      Ruta.Enabled:=FALSE;
      ZQSubsruta.Close;
      zQSubsruta.SQL.Clear;
      ZQSubsruta.SQL.Add('Select * from  v_subscriptores_sin_ruta');
      ZQSubsruta.ExecSQL;
      ZQSubsruta.Open;
      ZQSubsruta.Active:=TRUE;
      DBGridSubs.Refresh;
      tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
      end;
 { if  tiporuta.Text <> 'Ruta Edificio' then
     begin


     end;   }
    end;
 SetGridColumnWidths(dbgridsubs);

end;

procedure TFAdmon_rutas.SubirClick(Sender: TObject);
var
actual,nueva,anterior:integer;
nosubactual,nosubanterior:integer;
posicionactual,posicionnueva:integer;
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin

   ds := THackDBGrid(DBGridSubs).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(DBGridSubs).Row;
   row := ds.RecNo;
  // ds.Refresh;


  DBGridSubs.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
  if ((tiporuta.Text = 'Ruta Metropolitana') AND  (edificios.Text='')) then
      begin
      {obtenemos el orden actual}
      actual:=DBGridSubs.Fields[1].AsInteger;
      nosubactual:=DBGridSubs.Fields[2].AsInteger;
      posicionactual:=ZQSubsruta.RecNo;
      if (actual = 0) then
         begin
            Zqtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Select MAX(Orden_en_el_reparto) as ultimo from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
            ZQtmp2.ExecSQL;
            ZQtmp2.Open;
              if ZQtmp2.FieldByName('ultimo').AsInteger = 0 then  {determinamos si el maximo orden de entrega es 0}
                begin
                   nueva:=1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(nueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
                end  {fin del if de ultimo es igual a 0}
              else begin
                   nueva:=ZQtmp2.FieldByName('ultimo').AsInteger+1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(nueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
              end;   {fin de determinacion de orden cuando es 0}

         end  {fin de si el orden es 0}
         {----------------------------------------------------------------}
      else begin  {else del if el orden que tiene no es 0 se debe asignar el valor anterior}
        if actual>1 then   {determinamos si es el primer registro para no asignar el orden en 0}
           begin
             ZQSubsruta.RecNo:=Posicionactual-1;
             nosubanterior:= DBGridSubs.Fields[2].AsInteger;
             posicionnueva:=DBGridSubs.Fields[1].AsInteger;
            //ShowMessage('Orden actual ='+IntToStr(actual)+' Nuevo orden ='+IntToStr(posicionnueva));
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(posicionnueva)+' Where no_de_subscripcion='+IntToStr(nosubactual));
             ZQtmp2.ExecSQL;
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto='+IntToStr(actual)+' Where no_de_subscripcion='+IntToStr(nosubanterior));
             ZQtmp2.ExecSQL;
           end;

      end;  {fin del else el orden que tiene no es 0}
      {-----------------------Actualizamos el grid----------------------------------}
    ZQSubsruta.Close;
    ZQSubsruta.SQL.Clear;
    ZQSubsruta.SQL.Add('Select No_ruta AS "No Ruta",Orden_en_el_reparto AS "Orden entrega",No_de_Subscripcion AS "No Subscripcion",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_rutas.no_de_subscripcion) AS Atenciona,calle');
    ZQSubsruta.SQL.Add(',colonia,cp,Descripcion_domicilio AS "Descripción" from t_descripcion_rutas where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_el_reparto');
   //ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
   // ZQSubsruta.SQL.Add(',Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(edificios.KeyValue)+' order by orden_en_reparto');
    ZQSubsruta.ExecSQL;
    ZQSubsruta.Open;
    ZQSubsruta.Active:=TRUE;
    DBGridSubs.Refresh;
    ZQSubsruta.RecNo:= posicionnueva;
    tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
    {------------------------ fin del refresh --------------------------------------}

    end;    {fin del if de ruta metropolitana}

 {----------------------------Comienza if para ruta edificio----------------------------}
   if ((tiporuta.Text = 'Ruta Metropolitana')  AND (edificios.Text<>'')) then
      begin
      {obtenemos el orden actual}
      actual:=DBGridSubs.Fields[1].AsInteger;
      nosubactual:=DBGridSubs.Fields[2].AsInteger;
      posicionactual:=ZQSubsruta.RecNo;
      if (actual = 0) then
         begin
            Zqtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Select MAX(Orden_en_reparto) as ultimo from t_descripcion_ruta_edificio where no_ruta ='+FloatToStr(ruta.KeyValue)+' order by Orden_en_reparto');
            ZQtmp2.ExecSQL;
            ZQtmp2.Open;
              if ZQtmp2.FieldByName('ultimo').AsInteger = 0 then  {determinamos si el maximo orden de entrega es 0}
                begin
                   nueva:=1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(nueva)+' Where nosubscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
                end  {fin del if de ultimo es igual a 0}
              else begin
                   nueva:=ZQtmp2.FieldByName('ultimo').AsInteger+1;
                   ZQtmp2.Close;
                   ZQtmp2.SQL.Clear;
                   ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(nueva)+' Where nosubscripcion='+IntToStr(nosubactual));
                   ZQtmp2.ExecSQL;
              end;   {fin de determinacion de orden cuando es 0}

         end  {fin de si el orden es 0}
         {----------------------------------------------------------------}
      else begin  {else del if el orden que tiene no es 0 se debe asignar el valor anterior}
        if actual>1 then   {determinamos si es el primer registro para no asignar el orden en 0}
           begin
             ZQSubsruta.RecNo:=Posicionactual-1;
             nosubanterior:= DBGridSubs.Fields[2].AsInteger;
             posicionnueva:=DBGridSubs.Fields[1].AsInteger;
            //ShowMessage('Orden actual ='+IntToStr(actual)+' Nuevo orden ='+IntToStr(posicionnueva));
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(posicionnueva)+' Where nosubscripcion='+IntToStr(nosubactual));
             ZQtmp2.ExecSQL;
             ZQtmp2.Close;
             ZQtmp2.SQL.Clear;
             ZQtmp2.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto='+IntToStr(actual)+' Where nosubscripcion='+IntToStr(nosubanterior));
             ZQtmp2.ExecSQL;
           end;

      end;  {fin del else el orden que tiene no es 0}
      {-----------------------Actualizamos el grid----------------------------------}
   ZQSubsruta.Close;
   ZQSubsruta.SQL.Clear;
   ZQSubsruta.SQL.Add('Select id_edificio as "Id Edificio",Orden_en_reparto AS "Orden de entrega",NoSubscripcion AS "No Subscripción",(Select atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_descripcion_ruta_edificio.nosubscripcion) AS Atenciona' );
   ZQSubsruta.SQL.Add(',Area AS "Área" from t_descripcion_ruta_edificio where id_edificio ='+FloatToStr(edificios.KeyValue)+' order by orden_en_reparto');
   ZQSubsruta.ExecSQL;
   ZQSubsruta.Open;
   ZQSubsruta.Active:=TRUE;
   DBGridSubs.Refresh;
   ZQSubsruta.RecNo:= posicionactual-1;
   tot.Caption:=IntToStr(ZQSubsruta.RecordCount);
   tit.Caption:='';
   dir.Caption:='';
    {------------------------ fin del refresh --------------------------------------}

    end;
    {----------------------------Fin de ruta edificio----------------------------------}

 with ds do
   begin
     DisableControls;
     RecNo := row-1;
     MoveBy(-rowDelta+1) ;
     MoveBy(rowDelta-1) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;

  SetGridColumnWidths(dbgridsubs);

end;

{fin del evento click actualizar remisión}

procedure TFAdmon_rutas.tiporutaChange(Sender: TObject);
begin
   {Seleccionamos los datos de la tabla segun corresponda para llenar el segundo combobox}
   if tiporuta.Text = 'Ruta Metropolitana' then
      begin
      Ruta.Enabled:=TRUE;
      Ruta.ListField:='';
      Ruta.KeyField:='';
      ZQRutas.Close;
      ZQRutas.SQL.Clear;
      ZQRutas.SQL.Add('Select Nombre_ruta,no_ruta from c_rutas');
      ZQRutas.ExecSQL;
      ZQRutas.Open;
      Ruta.ListField:='Nombre_ruta';
      Ruta.KeyField:='no_ruta';
      //ShowMessage('ruta metropolitana');
      end;
   if tiporuta.Text = 'Ruta foranea' then
      begin
      Ruta.Enabled:=TRUE;
      Ruta.ListField:='';
      Ruta.KeyField:='';
      ZQRutas.Close;
      ZQRutas.SQL.Clear;
      ZQRutas.SQL.Add('Select no_ruta,nombre_ruta from c_rutas_foraneas');
      ZQRutas.ExecSQL;
      ZQRutas.Open;
      Ruta.ListField:='Nombre_ruta';
      Ruta.KeyField:='no_ruta';
      //ShowMessage('ruta foranea');
      end;
   if tiporuta.Text = 'Ruta Edificio' then
      begin
      Ruta.Enabled:=TRUE;
      Ruta.ListField:='';
      Ruta.KeyField:='';
      ZQRutas.Close;
      ZQRutas.SQL.Clear;
      ZQRutas.SQL.Add('Select id_edificio,descripcion from c_edificios');
      ZQRutas.ExecSQL;
      ZQRutas.Open;
      Ruta.ListField:='descripcion';
      Ruta.KeyField:='id_edificio';
      //ShowMessage('ruta foranea');
      end;
   if tiporuta.Text = 'Sin Ruta' then
      begin
      Ruta.Enabled:=FALSE;
      ZQRutas.Close;
      ZQRutas.SQL.Clear;
      ZQRutas.SQL.Add('Select * from  v_subscriptores_sin_ruta');
      ZQRutas.ExecSQL;
      ZQRutas.Open;
      end;


end;


procedure TFAdmon_rutas.SetGridColumnWidths(Grid: Tdbgrid);
const
  DEFBORDER = 10;
var
  temp, n: Integer;
  lmax: array [0..30] of Integer;
begin
  with Grid do
  begin
    Canvas.Font := Font;
    if tiporuta.Text='Ruta Metropolitana'  then
       begin
    for n := 0 to Columns.Count - 1 do
      if ((n<=2) OR (n=6)) then
          begin
           Columns[n].Width := 50;
          end
      else  begin
         Columns[n].Width := 200;
      end;
    end;  //End del if ruta foranea

     if tiporuta.Text='Ruta foranea'  then
       begin
    for n := 0 to Columns.Count - 1 do
      if ((n<=1) OR (n=3) OR (n=4)) then
          begin
           Columns[n].Width := 50;
          end
      else  begin
         Columns[n].Width := 200;
      end;
    end;  //End del if ruta foranea

  end; { With }
end; {SetGridColumnWidths  }



end.
