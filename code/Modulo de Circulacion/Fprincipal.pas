unit Fprincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ZConnection, ZAbstractConnection, StdCtrls, jpeg, ExtCtrls,
  Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFPrincipalCirculacion = class(TForm)
    MainMenu1: TMainMenu;
    Rutas1: TMenuItem;
    Cobran1: TMenuItem;
    Catalogos1: TMenuItem;
    Acercade1: TMenuItem;
    Salir1: TMenuItem;
    Administracinderuta1: TMenuItem;
    Estadosdecuenta1: TMenuItem;
    Rutasmetropolitanas1: TMenuItem;
    Rutasforaneas1: TMenuItem;
    Repartidoresychoferes1: TMenuItem;
    Proveedoresyvendedores1: TMenuItem;
    Edificios1: TMenuItem;
    ZConexion: TZConnection;
    ipodecirculacin1: TMenuItem;
    ZQquejas: TZQuery;
    DSquejas: TDataSource;
    GridQuejas: TDBGrid;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Button2: TButton;
    Quejas1: TMenuItem;
    Municipiosconentrega1: TMenuItem;
    Altadequeja1: TMenuItem;
    Segumientodequejas1: TMenuItem;
    GridSubs: TDBGrid;
    Label3: TLabel;
    irarutas: TButton;
    ZQsubs: TZQuery;
    DSsubs: TDataSource;
    Capturapordistribuidor1: TMenuItem;
    Efectuarcorte1: TMenuItem;
    ZQusuario: TZQuery;
    Modificarruta1: TMenuItem;
    Zocalo1: TMenuItem;
    Vendedoresyvoceadores1: TMenuItem;
    Capturadepagos1: TMenuItem;
    Cortezocalo1: TMenuItem;
    Modificartotaldotacion1: TMenuItem;
    Subscripciones1: TMenuItem;
    ControlSubscripciones1: TMenuItem;
    Codigospostales1: TMenuItem;
    ZQimphoja: TZQuery;
    Codigos1: TMenuItem;
    Entregaderutas1: TMenuItem;
    Label4: TLabel;
    GridCancelados: TDBGrid;
    ZQcancelados: TZQuery;
    DScancelados: TDataSource;
    Reporte1: TMenuItem;
    Label5: TLabel;
    cambios: TLabel;
    Label6: TLabel;
    altas: TLabel;
    Asignarcodigosdebarras1: TMenuItem;
    Estadisticasderutas1: TMenuItem;
    Suspencindeentrega1: TMenuItem;
    ZQAlta: TZQuery;
    Buscar1: TMenuItem;
    BuscarSubscriptor1: TMenuItem;
    Codigosdebarras1: TMenuItem;
    gridaltas: TDBGrid;
    Label7: TLabel;
    ZQaltas: TZQuery;
    DSAltas: TDataSource;
    ZQaltar: TZQuery;
    Label8: TLabel;
    cancelados: TLabel;
    Vercodigosagrupados1: TMenuItem;
    Configurarcorreos1: TMenuItem;
    Administraciondedotacionporruta1: TMenuItem;
    Asignararutas1: TMenuItem;
    Verremisiones1: TMenuItem;
    Suscripciones1: TMenuItem;
    V1: TMenuItem;
    AdmonCodigos1: TMenuItem;
    Entregaderuta1: TMenuItem;
    Estadisticasdeentrega1: TMenuItem;
    ZQpermiso: TZQuery;
    procedure Acercade1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Edificios1Click(Sender: TObject);
    procedure Rutasmetropolitanas1Click(Sender: TObject);
    procedure Rutasforaneas1Click(Sender: TObject);
    procedure Repartidoresychoferes1Click(Sender: TObject);
    procedure Proveedoresyvendedores1Click(Sender: TObject);
    procedure ipodecirculacin1Click(Sender: TObject);
    procedure Administracinderuta1Click(Sender: TObject);
    procedure Municipiosconentrega1Click(Sender: TObject);
    procedure Altadequeja1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Segumientodequejas1Click(Sender: TObject);
    procedure iraquejaClick(Sender: TObject);
    procedure Capturadepagos1Click(Sender: TObject);
    procedure Capturadedevoluciones1Click(Sender: TObject);
    procedure Capturapordistribuidor1Click(Sender: TObject);
    procedure Efectuarcorte1Click(Sender: TObject);
    procedure Vendedoresyvoceadores1Click(Sender: TObject);
    procedure Modificartotaldotacion1Click(Sender: TObject);
    procedure irarutasClick(Sender: TObject);
    procedure ControlSubscripciones1Click(Sender: TObject);
    procedure Codigospostales1Click(Sender: TObject);
    procedure Codigos1Click(Sender: TObject);
    procedure Cortezocalo1Click(Sender: TObject);
    procedure Reportesderutas1Click(Sender: TObject);
    procedure Entregaderutas1Click(Sender: TObject);
    procedure GridCanceladosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Reporte1Click(Sender: TObject);
    procedure GridQuejasDblClick(Sender: TObject);
    procedure Asignarcodigosdebarras1Click(Sender: TObject);
    procedure Estadisticasderutas1Click(Sender: TObject);
    procedure Suspencindeentrega1Click(Sender: TObject);
    procedure GridCanceladosDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BuscarSubscriptor1Click(Sender: TObject);
    procedure gridaltasDblClick(Sender: TObject);
    procedure GridSubsDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Vercodigosagrupados1Click(Sender: TObject);
    procedure Configurarcorreos1Click(Sender: TObject);
    procedure Asignararutas1Click(Sender: TObject);
    procedure Verremisiones1Click(Sender: TObject);
    procedure AdmonCodigos1Click(Sender: TObject);
    procedure Entregaderuta1Click(Sender: TObject);
    procedure Estadisticasdeentrega1Click(Sender: TObject);
    procedure GridQuejasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridaltasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridSubsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
  autorizacionquerida,nivelapp:Integer;
  usuarioapp:String;
  numerodesubscripcion:String;
  quienllamacp:integer;
   {variable para saber que formulario llama la busqueda del CP 1:subscriptor,2:NuevaSubscripcion }
   {3: Modificar Subscriptor, 4: Modificar Subscripcion}
  {variable para saber que formulario llama al area 1: nueva subrscripcion 2: modificar}
   quienllamaareadeentrega:integer;
   {variable para controlar desde que formulario se abre el control de remision 1:Administracion de rutas 2: Cobranza}
   quienllamaremision:integer;
   quienllamaquejasS:Integer;
   quienllamanotas:integer;    { 1= Aaltas 2 = Cambios }
   quienllamanueva:integer;  { variable para controlar que formulario esta llamando a nueva suscripcion 1:Nueva suscripcion 2:Reactivacion}

   diasadverenciaaltas:integer;
   coloradvertenciaalta:Tcolor;

   diasincidenciaaltas:integer;
   colorincidenciaalta:Tcolor;

   diasadvertenciaqueja:integer;
   coloradvertenciaqueja:Tcolor;

   diasincidenciaqueja:integer;
   colorincidenciaqueja:Tcolor;

   diasadvertenciacambio:integer;
   coloradvertenciacambio:Tcolor;

   diasincidenciacambio:integer;
   colorincidenciacambio:Tcolor;

    { Public declarations }
    function permiso(id_opcion:string):boolean;
    { variables globales para el control de avisos }

  end;

var
  FPrincipalCirculacion: TFPrincipalCirculacion;

implementation

uses Acerca_de_Subs, FCCatalogo_de_edificios,
  FC_Catalogo_de_rutas_metropolitanas, FC_Catalogo_de_rutas_foraneas,
  FC_Catalogo_de_repartidores_y_choferes,
  FC_Catalogo_de_proveedores_vendedores, FC_Tipo_de_circulacion,
  FAdministracion_rutas, FC_Municipios_con_entrega, FAlta_de_queja,
  FSeguimiento_Quejas, FCaptura_Pagos, FCaptura_devoluciones,
  FCaptura_pagos_x_distribuidor, FCorte_circulacion,FAutorizacion,
  FC_Vendedores_zocalo, FCaptura_pagos_zocalo,FC_Dotacion_total,
  FAlta_Subscripciones, FC_Codigos_postales,FR_Notificacion_alta,
  FImpCodigoBarras,Fcorte_Zocalo,FImpHojasRuta,FEntregaRuta,FQuejasReporte,
  FAdmon_Codigos,FEstadisticas_rutas,FSuspender_Entrega,FSeguimientoAltas,
  FSeguimientoCancelados,FR_Alta_subscripcion,FBuscar_Supervisor,
  FSeguimiento_Cambios,Floginpass,FFCodigos_Agrupados,FC_Lista_correos,
  Fadmon_DotaRuta,FReporteRemisionesRutas,FAdmonCodigosVendedores,
  FEntregaRutaVenta,Festadisticas_rutas_ventas;

{$R *.dfm}

function TFPrincipalCirculacion.permiso(id_opcion:String):boolean;
var
permiso:integer;
      begin
      zqpermiso.Close;
      ZQpermiso.SQL.Clear;
      ZQpermiso.SQL.Add('Select permiso from t_permisos_aplicaciones where id_opcion='+id_opcion+' AND id_empleado='+IntToStr(Flogin.usuario));
      Zqpermiso.ExecSQL;
      ZQpermiso.Open;
      permiso:=ZQpermiso.FieldByName('permiso').AsInteger;
         if permiso=1 then
           begin
             Result:=TRUE;
           end
        else begin
            Result:=FALSE;
        end;

 end;

procedure TFPrincipalCirculacion.Acercade1Click(Sender: TObject);
begin
   FAcercade.Enabled := FALSE;
   FAcercade := TFAcercade.Create(self);
   FAcercade.ShowModal;
end;

procedure TFPrincipalCirculacion.Salir1Click(Sender: TObject);
begin
  FPrincipalCirculacion.Close;
end;

procedure TFPrincipalCirculacion.Segumientodequejas1Click(Sender: TObject);
begin
 if permiso('202') then
    begin
  FSeguimientoQ.Enabled:=FALSE;
  FSeguimientoQ := TFSeguimientoQ.Create(self);
  FSeguimientoQ.ShowModal;
    end
    else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFPrincipalCirculacion.Suspencindeentrega1Click(Sender: TObject);
begin
  FSuspenderEntrega.Enabled:=FALSE;
  FSuspenderEntrega := TFSuspenderEntrega.Create(self);
  FSuspenderEntrega.ShowModal;
end;

procedure TFPrincipalCirculacion.Vendedoresyvoceadores1Click(Sender: TObject);
begin
  FCVendedoresZocalo.Enabled:=FALSE;
  FCVendedoresZocalo := TFCVendedoresZocalo.Create(self);
  FCVendedoresZocalo.ShowModal;
end;

procedure TFPrincipalCirculacion.Vercodigosagrupados1Click(Sender: TObject);
begin
  FGrupos_codigos.Show;
end;

procedure TFPrincipalCirculacion.Verremisiones1Click(Sender: TObject);
begin
     FRemisionRutas.Enabled:=FALSE;
     FRemisionRutas := TFRemisionRutas.Create(self);
     FRemisionRutas.ShowModal;
end;

procedure TFPrincipalCirculacion.Administracinderuta1Click(Sender: TObject);
begin
  if permiso('619') then
    begin
  FAdmon_rutas.enabled:=FALSE;
  FAdmon_rutas := TFAdmon_rutas.Create(Self);
  FAdmon_rutas.ShowModal;
    end
  else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFPrincipalCirculacion.AdmonCodigos1Click(Sender: TObject);
begin
  FCod_vendedores.Enabled:=FALSE;
  FCod_vendedores := TFCod_vendedores.Create(self);
  FCod_vendedores.ShowModal;
end;

procedure TFPrincipalCirculacion.Altadequeja1Click(Sender: TObject);
begin
  if permiso('201') then
    begin
  FAltaQueja.Enabled:=FALSE;
  FAltaQueja:= TFAltaQueja.Create(self);
  FAltaQueja.ShowModal;
    end
   else begin
      ShowMessage('No esta autorizado para realizar esta accion');
    end;
end;

procedure TFPrincipalCirculacion.Asignararutas1Click(Sender: TObject);
begin
   FChoferDot.show;
end;

procedure TFPrincipalCirculacion.Asignarcodigosdebarras1Click(Sender: TObject);
begin
   FadmonCodigos.Enabled:=FALSE;
   FAdmonCodigos := TFAdmonCodigos.Create(self);
   FAdmonCodigos.ShowModal;
end;

procedure TFPrincipalCirculacion.iraquejaClick(Sender: TObject);
begin
  FSeguimientoQ.Enabled:=FALSE;
  FSeguimientoQ := TFSeguimientoQ.Create(self);
  FSeguimientoQ.ShowModal;
end;

procedure TFPrincipalCirculacion.irarutasClick(Sender: TObject);
begin
  FAdmon_rutas.Enabled:=FALSE;
  FAdmon_rutas := TFAdmon_rutas.Create(self);
  FAdmon_rutas.ShowModal;
end;


procedure TFPrincipalCirculacion.BuscarSubscriptor1Click(Sender: TObject);
begin
  FBuscarSupervisor.Enabled:=FALSE;
  FBuscarSupervisor := TFBuscarSupervisor.Create(self);
  FBuscarSupervisor.ShowModal;
  end;

procedure TFPrincipalCirculacion.Button1Click(Sender: TObject);
var
no_de_subscripcion_public:String;
begin

  no_de_subscripcion_public := Gridaltas.Fields[0].AsString;

  if Gridaltas.Fields[2].AsString='' then
    begin
   ZQaltar.Close;
   ZQaltar.SQL.Clear;
   ZQAltar.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
   ZQAltar.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
   ZQAltar.ExecSQL;
   ZQAltar.Open;

  FRAltaSubscripcion.fechainicio.Caption:=ZQAltar.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQAltar.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQAltar.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQAltar.FieldByName('telefono').AsString;
  FRAltaSubscripcion.calle.Caption:=ZQAltar.FieldByName('calle').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQAltar.FieldByName('ruta').AsString;
  FRAltaSubscripcion.colonia.Caption:=ZQAltar.FieldByName('colonia').AsString;
  FRAltaSubscripcion.cp.Caption:=ZQAltar.FieldByName('cp').AsString;
  FRAltaSubscripcion.ciudad.Caption:=ZQAltar.FieldByName('ciudad').AsString;
  FRAltaSubscripcion.observaciones.Caption:=ZQAltar.FieldByName('observaciones').AsString;
  FRAltaSubscripcion.descripcion.Caption:=ZQAltar.FieldByName('descripcion_domicilio').AsString;
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;
    end;
 if Gridaltas.Fields[2].AsString<>'' then
    begin
   FRAltaSubscripcion.calle.Caption:=Gridaltas.Fields[2].AsString;

   ZQaltar.Close;
   ZQaltar.SQL.Clear;
   ZQAltar.SQL.Add('Select t_subscripcion.nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,observaciones,area from t_subscripcion JOIN t_descripcion_ruta_edificio ON ');
   ZQAltar.SQL.Add('(t_subscripcion.nosubscripcion = t_descripcion_ruta_edificio.nosubscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public );
   ZQAltar.ExecSQL;
   ZQAltar.Open;

  FRAltaSubscripcion.colonia.Caption:=ZQAltar.FieldByName('area').AsString;
  FRAltaSubscripcion.fechainicio.Caption:=ZQAltar.FieldByName('fecha_inicio').AsString;
  FRAltaSubscripcion.nosubscriptor.Caption:=ZQAltar.FieldByName('nosubscripcion').AsString;
  FRAltaSubscripcion.nombre.Caption:=ZQAltar.FieldByName('atenciona').AsString;
  FRAltaSubscripcion.telefono.Caption:=ZQAltar.FieldByName('telefono').AsString;
  FRAltaSubscripcion.ruta.Caption:=ZQAltar.FieldByName('ruta').AsString;
  FRAltaSubscripcion.QuickRep1.Prepare;
  FRAltaSubscripcion.QuickRep1.Preview;

    end;

end;

procedure TFPrincipalCirculacion.Button2Click(Sender: TObject);
begin
     GridQuejas.Refresh;
     ZQQuejas.Refresh;
     GridSubs.Refresh;
     ZQSubs.Refresh;
     ZQAltas.Refresh;
     GridAltas.Refresh;
     GridCancelados.Refresh;
     ZQCancelados.Refresh;
end;

procedure TFPrincipalCirculacion.Button3Click(Sender: TObject);
var
folio,no_de_subscripcion_public:String;
begin
  ZQAltar.Close;
  ZQaltar.SQL.Clear;
  ZQAltar.SQL.Add('Select Max(Folio)AS folio from t_cambio_domicilio where NoSubscripcion='+GridSubs.Fields[0].ASString);
  ZQAltar.ExecSQL;
  ZQAltar.Open;
  if ZQaltar.FieldByName('folio').IsNull=FALSE then
     begin
   folio:=ZQAltar.FieldByName('folio').AsString;
   FRNotificacionalta.Enabled:=FALSE;
   FRNotificacionalta := TFRNotificacionalta.Create(self);


  no_de_subscripcion_public := GridSubs.Fields[0].AsString;
  ZQaltar.Close;
  ZQaltar.SQL.Clear;
  ZQAltar.SQL.Add('Select nosubscripcion,Atenciona,Ruta,Fecha_inicio,Telefono,Observaciones,calle,colonia,cp,ciudad,descripcion_domicilio');
  ZQAltar.SQL.Add(' from t_subscripcion JOIN t_descripcion_rutas ON (t_subscripcion.nosubscripcion = t_descripcion_rutas.no_de_subscripcion) where t_subscripcion.nosubscripcion ='+no_de_subscripcion_public);
  ZQAltar.ExecSQL;
  ZQAltar.Open;

  FRNotificacionalta.fechainicio.Caption:=ZQAltar.FieldByName('fecha_inicio').AsString;
  FRNotificacionalta.nosubscriptor.Caption:=ZQAltar.FieldByName('nosubscripcion').AsString;
  FRNotificacionalta.nombre.Caption:=ZQAltar.FieldByName('atenciona').AsString;
  FRNotificacionalta.telefono.Caption:=ZQAltar.FieldByName('telefono').AsString;
  FRNotificacionalta.calle.Caption:=ZQAltar.FieldByName('calle').AsString;
  FRNotificacionalta.ruta.Caption:=ZQAltar.FieldByName('ruta').AsString;
  FRNotificacionalta.colonia.Caption:=ZQAltar.FieldByName('colonia').AsString;
  FRNotificacionalta.cp.Caption:=ZQAltar.FieldByName('cp').AsString;
  FRNotificacionalta.ciudad.Caption:=ZQAltar.FieldByName('ciudad').AsString;
  FRNotificacionalta.observaciones.Caption:=ZQAltar.FieldByName('observaciones').AsString;
  FRNotificacionalta.descripcion.Caption:=ZQAltar.FieldByName('descripcion_domicilio').AsString;
  FRNotificacionalta.folio.caption:=folio;
  FRNotificacionalta.Notificacion.Prepare;
  FRNotificacionalta.Notificacion.Preview;
      end
    else begin
      ShowMessage('No se han encontrado cambios de domicilio para esta dirección');
    end;
end;

procedure TFPrincipalCirculacion.Capturadedevoluciones1Click(Sender: TObject);
begin
  Fdevoluciones.Enabled:=False;
  Fdevoluciones := TFdevoluciones.Create(self);
  Fdevoluciones.ShowModal;
end;

procedure TFPrincipalCirculacion.Capturadepagos1Click(Sender: TObject);
begin
  FCapturaZocalo.Enabled:=FALSE;
  FCapturaZocalo := TFCapturaZocalo.Create(self);
  FCapturaZocalo.ShowModal;
end;

procedure TFPrincipalCirculacion.Capturapordistribuidor1Click(Sender: TObject);
begin
    FCapturaXdistribuidor.enabled:=FALSE;
    FCapturaXdistribuidor := TFCapturaXdistribuidor.Create(self);
    FCapturaXdistribuidor.ShowModal;
end;

procedure TFPrincipalCirculacion.Codigos1Click(Sender: TObject);
begin
 FImpCodigo.Enabled:=FALSE;
 FimpCodigo := TFImpCodigo.Create(Self);
 FImpCodigo.ShowModal;
end;

procedure TFPrincipalCirculacion.Codigospostales1Click(Sender: TObject);
begin
   FC_CP.Enabled:=FALSE;
   FC_CP := TFC_CP.Create(self);
   FC_CP.ShowModal;
end;

procedure TFPrincipalCirculacion.Configurarcorreos1Click(Sender: TObject);
begin
    FListaCorreos.Enabled:=FALSE;
    FListaCorreos := TFListaCorreos.Create(self);
    FListaCorreos.ShowModal;
end;

procedure TFPrincipalCirculacion.ControlSubscripciones1Click(Sender: TObject);
begin
  FSubscripciones.Enabled;
  FSubscripciones := TFSubscripciones.Create(self);
  FSubscripciones.ShowModal;
end;

procedure TFPrincipalCirculacion.Cortezocalo1Click(Sender: TObject);
begin
   FPrincipalCirculacion.autorizacionquerida:=6;
    FPassword.Enabled:=FALSE;
    FPassword := TFpassword.Create(Self);
    FPassword.ShowModal;
    if FPassword.autorizado=1 then
       begin
     Fcortezocalo.Enabled:=FALSE;
     Fcortezocalo := TFcortezocalo.Create(self);
     Fcortezocalo.ShowModal;
       end;
end;

procedure TFPrincipalCirculacion.Edificios1Click(Sender: TObject);
begin
   FCEdificios.Enabled := FALSE;
   FCEdificios := TFCEdificios.Create(self);
   FCEdificios.ShowModal;
end;

procedure TFPrincipalCirculacion.Efectuarcorte1Click(Sender: TObject);
begin
    autorizacionquerida:=3;
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

procedure TFPrincipalCirculacion.Entregaderuta1Click(Sender: TObject);
begin
//  ShowMessage('Este modulo aun no se encuentra disponible');
   FEntregaRutaVentas.Enabled:=FALSE;
   FEntregaRutaVentas := TFEntregaRutaVentas.Create(self);
   FEntregaRutaVentas.ShowModal;
end;

procedure TFPrincipalCirculacion.Entregaderutas1Click(Sender: TObject);
begin
   Fentregaderuta.Enabled:=FALSE;
   FEntregaderuta := TFEntregaderuta.Create(Self);
   FEntregaderuta.ShowModal;
end;

procedure TFPrincipalCirculacion.Estadisticasdeentrega1Click(Sender: TObject);
begin
  FestadisticasVEntas.Enabled:=FALSE;
  FestadisticasVEntas := TFestadisticasVEntas.Create(self);
  FestadisticasVEntas.ShowModal;
end;

procedure TFPrincipalCirculacion.Estadisticasderutas1Click(Sender: TObject);
begin
   FestadisticasRutas.Enabled:=FALSE;
   FEstadisticasRutas := TFEstadisticasRutas.Create(Self);
   FEstadisticasRutas.ShowModal;
end;

procedure TFPrincipalCirculacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Flogin.close;
end;

procedure TFPrincipalCirculacion.FormShow(Sender: TObject);
var
fechahoy,fechasiete:String;
i,dias:Integer;
Col:Tcolor;
opcion:String;
begin

  Zqpermiso.Close;
  Zqpermiso.SQL.Clear;
  ZQpermiso.SQL.Add('Select * from t_dias_advertencia_suscripciones where tipo="j"');
  ZQpermiso.ExecSQL;
  ZQpermiso.Open;

 while ZQpermiso.Eof=FALSE do
   begin
     opcion:=ZQpermiso.FieldByName('opcion').AsString;
     Col:=StringToColor(ZQpermiso.FieldByName('color').AsString);
     dias:=ZQpermiso.FieldByName('dias').AsInteger;
      if opcion='Adaj' then
        begin
         diasadverenciaaltas:=dias;
         coloradvertenciaalta:=col;
        end;
      if opcion='Adij' then
        begin
         diasincidenciaaltas:=dias;
         colorincidenciaalta:=col;
        end;
      if opcion='Cdaj' then
        begin
       diasadvertenciacambio:=dias;
       coloradvertenciacambio:=col;
        end;
      if opcion='Cdij' then
        begin
       diasincidenciacambio:=dias;
       colorincidenciacambio:=col;
        end;
      if opcion='Qdaj' then
        begin
       diasadvertenciaqueja:=dias;
       coloradvertenciaqueja:=Col;
        end;
      if opcion='Qdij' then
        begin
       diasincidenciaqueja:=dias;
       colorincidenciaqueja:=col;
        end;
      ZQpermiso.Next;

   end;



  ZQquejas.Close;
  ZQquejas.SQL.Clear;
  ZQquejas.SQL.Add('Select id_Queja as Folio,NoSubscripcion as "No subscripcion",fecha_queja AS "Fecha captura",Descripcion as "Descripción",Status AS Estatus from t_quejas where (status >= 1 AND Status <= 2)');
  ZQquejas.ExecSQL;
  ZQquejas.Open;
  GridQuejas.Refresh;

  i:=1;
  fechahoy:= (FormatDateTime('yyyy-mm-dd',Now()));
  fechasiete:=(FormatDateTime('yyyy-mm-dd',Now()-59));
  //ShowMessage(fechasiete+' a '+fechahoy);
  {---------------Rutas con altas----------------------}
  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Distinct (Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion) AS  Ruta from t_altas where atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  while ZQsubs.Eof=FALSE do
     begin
       altas.Caption:=altas.Caption+ZQSubs.FieldByName('Ruta').AsString;
       altas.Caption:=altas.Caption+',';
       ZQSubs.Next;
     end;
  {------------------ALTAS----------------------------------}

  {---------------Rutas con cambios----------------------}
  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select Distinct (Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS  Ruta from t_cambios_domicilio where atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  while ZQsubs.Eof=FALSE do
     begin
       cambios.Caption:=cambios.Caption+ZQSubs.FieldByName('Ruta').AsString;
       cambios.Caption:=cambios.Caption+',';
       ZQSubs.Next;
     end;
  {------------------ALTAS----------------------------------}


  ZQAltas.Close;
  ZQAltas.SQL.Clear;
  ZQAltas.SQL.Add('Select t_altas.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion)AS Atenciona');
  ZQAltas.SQL.Add(',Direccion,(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_altas.nosubscripcion) AS  Ruta,fecha_alta AS Fecha_Alta from t_altas where atendido="N"');
  ZQAltas.ExecSQL;
  ZQAltas.Open;
  ZQAltas.Active:=TRUE;
  Gridaltas.Refresh;
  {----------CAMBIOS DE DOMICILIO--------------------------------}
  ZQSubs.Close;
  ZQSubs.SQL.Clear;
  ZQSubs.SQL.Add('Select t_cambios_domicilio.nosubscripcion AS NoSubscripcion,(Select Atenciona from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion)AS Atenciona,Direccion,');
  ZQsubs.SQL.Add('(Select ruta from t_subscripcion where t_subscripcion.nosubscripcion=t_cambios_domicilio.nosubscripcion) AS  Ruta,fecha_cambio AS Fecha_Cambio from t_cambios_domicilio where atendido="N"');
  ZQSubs.ExecSQL;
  ZQSubs.Open;
  ZQSubs.Active:=TRUE;
  GridSubs.Refresh;
  {----------Rutas con cancelados--------------------------------}

  ZQCancelados.Close;
  ZQCancelados.SQL.Clear;
  ZQCancelados.SQL.Add('Select Distinct(Ruta) from t_cancelacion where fecha_ultimo_ejemplar between "'+FormatDateTime('yyyy-mm-dd',now()-8)+'" AND "'+FormatDateTime('yyyy-mm-dd',now())+' 23:59:59" AND atendido=0');
  ZQCancelados.ExecSQL;
  ZQCancelados.Open;
  while ZQCancelados.Eof=FALSE do
     begin
    cancelados.Caption:=cancelados.Caption+ZQCancelados.FieldByName('Ruta').AsString;
    cancelados.Caption:=cancelados.Caption+',';
    ZQCancelados.Next;
     end;
  {--------------------------------------------------------------}

  ZQCancelados.Close;
  ZQCancelados.SQL.Clear;
  ZQCancelados.SQL.Add('Select Nosubscripcion,AtencionA,Calle,Colonia,Descripcion_dir AS Descripcion,Ruta,Fecha_sol_cancelacion,Fecha_ultimo_ejemplar from t_cancelacion where fecha_ultimo_ejemplar between "'+FormatDateTime('yyyy-mm-dd',now()-8)+'" AND "'+FormatDateTime('yyyy-mm-dd',now())+' 23:59:59" AND atendido=0');
  ZQCancelados.ExecSQL;
  ZQCancelados.Open;
  GridCancelados.Refresh;

end;

procedure TFPrincipalCirculacion.gridaltasDblClick(Sender: TObject);
begin
   quienllamanotas:=1;
   FSeguimientoA.Enabled:=FALSE;
   FSeguimientoA := TFSeguimientoA.Create(self);
   FSeguimientoA.ShowModal;
end;

procedure TFPrincipalCirculacion.gridaltasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if (((Gridaltas.Fields[4].AsDateTime)<=now()-diasadverenciaaltas) )then
        begin
          Gridaltas.Canvas.Brush.Color := coloradvertenciaalta;
          Gridaltas.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((Gridaltas.Fields[4].AsDateTime)<=now()-diasadverenciaaltas) )then
    begin
      Gridaltas.Canvas.Brush.Color := colorincidenciaalta;
      Gridaltas.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end;
end;

procedure TFPrincipalCirculacion.GridCanceladosDblClick(Sender: TObject);
begin
    FCancelados.Enabled:=FALSE;
    FCancelados := TFCancelados.Create(self);
    FCancelados.ShowModal;
end;

procedure TFPrincipalCirculacion.GridCanceladosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
      if GridCancelados.Fields[0].AsInteger>0 then
        begin
          GridCancelados.Canvas.Brush.Color := clRed;
          GridCancelados.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;
end;

procedure TFPrincipalCirculacion.GridQuejasDblClick(Sender: TObject);
begin
  FSeguimientoQ.Enabled:=FALSE;
  FSeguimientoQ := TFSeguimientoQ.Create(self);
  FSeguimientoQ.ShowModal;
end;

procedure TFPrincipalCirculacion.GridQuejasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if (((GridQuejas.Fields[2].AsDateTime)<=now()-diasadvertenciaqueja) )then
        begin
          GridQuejas.Canvas.Brush.Color := coloradvertenciaqueja;
          GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((GridQuejas.Fields[2].AsDateTime)<=now()-diasincidenciaqueja) )then
    begin
      GridQuejas.Canvas.Brush.Color := colorincidenciaqueja;
      GridQuejas.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end;

end;

procedure TFPrincipalCirculacion.GridSubsDblClick(Sender: TObject);
begin
  quienllamanotas:=2;
  FSeguimientoCambios.Enabled:=FALSE;
  FSeguimientoCambios := TFSeguimientoCambios.Create(self);
  FSeguimientoCambios.ShowModal;
end;

procedure TFPrincipalCirculacion.GridSubsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if (((GridSubs.Fields[4].AsDateTime)<=now()-diasadvertenciacambio) )then
        begin
          GridSubs.Canvas.Brush.Color := coloradvertenciaalta;
          GridSubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
        end;

     if (((GridSubs.Fields[4].AsDateTime)<=now()-diasincidenciacambio) )then
    begin
      GridSubs.Canvas.Brush.Color := colorincidenciaalta;
      GridSubs.DefaultDrawColumnCell(rect,DataCol,Column,State);
    end;
end;

procedure TFPrincipalCirculacion.Rutasmetropolitanas1Click(
  Sender: TObject);
begin
  FC_rutas_metropolitanas.Enabled := FALSE;
  FC_rutas_metropolitanas := TFC_rutas_metropolitanas.Create(self);
  FC_rutas_metropolitanas.ShowModal;
end;

procedure TFPrincipalCirculacion.Rutasforaneas1Click(Sender: TObject);
begin
  FC_Rutas_foraneas.Enabled := FALSE;
  FC_Rutas_foraneas := TFC_Rutas_foraneas.Create(self);
  FC_Rutas_foraneas.Showmodal;
end;

procedure TFPrincipalCirculacion.Repartidoresychoferes1Click(
  Sender: TObject);
begin
  FC_Catalogo_repartidores_choferes.Enabled := FALSE;
  FC_Catalogo_repartidores_choferes := TFC_Catalogo_repartidores_choferes.Create(self);
  FC_Catalogo_repartidores_choferes.Showmodal;
end;

procedure TFPrincipalCirculacion.Reporte1Click(Sender: TObject);
begin
  FQuejasR.Enabled:=FALSE;
  FQuejasR := TFQuejasR.Create(self);
  FQuejasR.ShowModal;
end;

procedure TFPrincipalCirculacion.Reportesderutas1Click(Sender: TObject);
begin
 Fimprimirrutas.Enabled:=FALSE;
 Fimprimirrutas := TFimprimirrutas.Create(self);
 Fimprimirrutas.ShowModal;
 end;

procedure TFPrincipalCirculacion.Proveedoresyvendedores1Click(
  Sender: TObject);
begin
  FC_Catalogo_proveedores_y_vendedores.Enabled := FALSE;
  FC_Catalogo_proveedores_y_vendedores := TFC_Catalogo_proveedores_y_vendedores.Create(self);
  FC_Catalogo_proveedores_y_vendedores.ShowModal;
end;

procedure TFPrincipalCirculacion.ipodecirculacin1Click(Sender: TObject);
begin
  FCTipo_Circulacion.Enabled :=False;
  FCTipo_Circulacion := TFCTipo_Circulacion.Create(self);
  FCTipo_Circulacion.ShowModal;
end;

procedure TFPrincipalCirculacion.Modificartotaldotacion1Click(Sender: TObject);
begin
   autorizacionquerida:=3;
   FPassword.Enabled:=FALSE;
   FPassword := TFpassword.Create(Self);
   FPassword.ShowModal;
    if FPassword.autorizado=1 then
       begin
       FCTotal_dotacion.Enabled:=FALSE;
       FCTotal_dotacion := TFCTotal_dotacion.Create(self);
       FCTotal_dotacion.ShowModal;
       end;
end;

procedure TFPrincipalCirculacion.Municipiosconentrega1Click(Sender: TObject);
begin
  FCMunicipiosconentrega.Enabled:=FALSE;
  FCMunicipiosconentrega := TFCMunicipiosconentrega.Create(self);
  FCMunicipiosconentrega.ShowModal;
end;

end.
