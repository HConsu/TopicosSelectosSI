unit FRemision_ruta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Menus, jpeg, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, ComCtrls;

type
  TFRemision = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Imprimir1: TMenuItem;
    DBGridRemision: TDBGrid;
    ZQRemision: TZQuery;
    DSRemision: TDataSource;
    Button1: TButton;
    Label1: TLabel;
    MFecha: TLabel;
    Label2: TLabel;
    verotrafecha: TButton;
    seleccionarfecha: TDateTimePicker;
    LEdificio: TLabel;
    ZQtmp: TZQuery;
    procedure Salir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure verotrafechaClick(Sender: TObject);
    procedure DBGridRemisionKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRemision: TFRemision;

implementation

{$R *.dfm}
Uses
FAdministracion_rutas,FPrincipal,FCaptura_Pagos_x_distribuidor;

procedure TFRemision.DBGridRemisionKeyPress(Sender: TObject; var Key: Char);
var
dotacion,tarifa,codigo:String;
observaciones:String;
ruta:double;
tiporuta:string;
begin
   if (Key=#13) then
     begin
       codigo:=DBGridRemision.Fields[3].AsString;
       ruta:=FAdministracion_rutas.FAdmon_rutas.Ruta.KeyValue;
       tiporuta:=FAdministracion_rutas.FAdmon_rutas.tiporuta.Text;
       dotacion:=DBGridRemision.Fields[4].AsString;
       tarifa:=DBGridRemision.Fields[5].AsString;
       Observaciones:=DBGridRemision.Fields[7].AsString;
      if  tiporuta = 'Ruta foranea' then
       begin
       //ShowMessage('Valor:'+DBGridRemision.Fields[4].AsString);
      ZQtmp.Close;
      ZQtmp.SQL.Clear;
      ZQtmp.SQL.Add('Update t_remision_rutas SET dotacion='+dotacion+',tarifa='+tarifa+',observaciones="'+observaciones+'" where ruta ='+FloatToStr(ruta)+' AND Fecha="'+DateToStr(seleccionarfecha.Date)+'" AND Codigo_proveedor='+codigo);
      ZQtmp.ExecSQL;
      ZQRemision.close;
      ZQRemision.SQL.Clear;
      ZQRemision.SQL.Add('Select Fecha,Edicion as "Edición",Plaza,Codigo_proveedor AS "Cod Prov.",Dotacion,tarifa,Empaque,Observaciones FROM t_remision_rutas where ruta ='+FloatToStr(ruta)+' AND fecha="'+DateToStr(seleccionarfecha.Date)+'"');
      ZQRemision.ExecSQL;
      ZQRemision.Open;
      ZQRemision.Active:=TRUE;
      DBGridRemision.Refresh;
      MFecha.Caption:=DateToStr(seleccionarfecha.Date);
       end;
     end;
end;

procedure TFRemision.FormShow(Sender: TObject);
var
ruta:double;
fecha,tiporuta:string;

begin
   {jalamos los datos del formulario anterior administracion de rutas para llenar el grid de remision}
    ruta:=FAdministracion_rutas.FAdmon_rutas.Ruta.KeyValue;
    tiporuta:=FAdministracion_rutas.FAdmon_rutas.tiporuta.Text;
    seleccionarfecha.Date:=now();

    {dependiendo de si es ruta foranea o de edificio ejecutamos la consulta para llenar el grid}
    if  tiporuta = 'Ruta foranea' then
     begin
      LEdificio.Visible:=FALSE;
      LEdificio.Caption:='';
      ZQRemision.close;
      ZQRemision.SQL.Clear;
      ZQRemision.SQL.Add('Select Fecha,Edicion as "Edición",Plaza,Codigo_proveedor AS "Cod Prov.",Dotacion,tarifa,Empaque,Observaciones FROM t_remision_rutas where ruta ='+FloatToStr(ruta)+' AND Fecha="'+DateToStr(seleccionarfecha.Date)+'" Order by codigo_proveedor');
      ZQRemision.ExecSQL;
      ZQRemision.Open;
      ZQRemision.Active:=TRUE;
      DBGridRemision.Refresh;
      MFecha.Caption:=DateToStr(now);
     end;
    if  tiporuta = 'Ruta Edificio' then
     begin
      ZQRemision.close;
      ZQRemision.SQL.Clear;
      ZQRemision.SQL.Add('Select Nosubscripcion as "No Subscriptor",Titular,Area,edificio from t_remision_edificios where edificio ='+FloatToStr(ruta)+' AND Fecha="'+DateToStr(seleccionarfecha.Date)+'" Order by Orden_en_reparto');
      ZQRemision.ExecSQL;
      ZQRemision.Open;
      LEdificio.Visible:=TRUE;
      LEdificio.Caption:='Mostrando '+FAdministracion_rutas.FAdmon_rutas.Ruta.Text;
      ZQRemision.Active:=TRUE;
      DBGridRemision.Refresh;
      MFecha.Caption:=DateToStr(now);
     end;

end;

procedure TFRemision.Salir1Click(Sender: TObject);
begin
   FRemision.Close;
end;

procedure TFRemision.verotrafechaClick(Sender: TObject);
var
ruta:double;
tiporuta:string;
fechaselec:String;
begin
{jalamos los datos del formulario anterior administracion de rutas para llenar el grid de remision}
    ruta:=FAdministracion_rutas.FAdmon_rutas.Ruta.KeyValue;
    tiporuta:=FAdministracion_rutas.FAdmon_rutas.tiporuta.Text;
    {dependiendo de si es ruta foranea o de edificio ejecutamos la consulta para llenar el grid}
    fechaselec:= DateToStr(Seleccionarfecha.Date);
    if  tiporuta = 'Ruta foranea' then
     begin
      ZQRemision.close;
      ZQRemision.SQL.Clear;
      ZQRemision.SQL.Add('Select Fecha,Edicion as "Edición",Plaza,Codigo_proveedor AS "Cod Prov.",Dotacion,tarifa,Empaque,Observaciones FROM t_remision_rutas where ruta ='+FloatToStr(ruta)+' AND fecha="'+fechaselec+'"');
      ZQRemision.ExecSQL;
      ZQRemision.Open;
      ZQRemision.Active:=TRUE;
      DBGridRemision.Refresh;
      MFecha.Caption:=fechaselec;
     end;
    if  tiporuta = 'Ruta Edificio' then
     begin
      ZQRemision.close;
      ZQRemision.SQL.Clear;
      ZQRemision.SQL.Add('Select t_subscripcion.nosubscripcion as "No Subscripcion",AtencionA AS "Titular",area AS "Área" from t_subscripcion join t_remision_edificios ON t_subscripcion.nosubscripcion = t_remision_edificios.nosubscripcion where t_remision_edificios.edificio ='+FloatToStr(ruta)+' AND fecha="'+fechaselec+'" Order by Orden_en_reparto');

      ZQRemision.ExecSQL;
      ZQRemision.Open;
      ZQRemision.Active:=TRUE;
      DBGridRemision.Refresh;
      MFecha.Caption:=fechaselec;
     end;
end;

end.
