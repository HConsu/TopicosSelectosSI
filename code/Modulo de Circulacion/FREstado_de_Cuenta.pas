unit FREstado_de_Cuenta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DBCtrls, ComCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TFREstadoCuenta = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    adeudos: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    fechai: TDateTimePicker;
    fechaf: TDateTimePicker;
    edicioninicial: TEdit;
    edicionfinal: TEdit;
    codigo: TEdit;
    combodist: TDBLookupComboBox;
    cfecha: TCheckBox;
    cedicion: TCheckBox;
    reporte: TButton;
    ZQdist: TZQuery;
    DSdist: TDataSource;
    ZQMesactual: TZQuery;
    DSMesActual: TDataSource;
    procedure cfechaClick(Sender: TObject);
    procedure cedicionClick(Sender: TObject);
    procedure edicioninicialKeyPress(Sender: TObject; var Key: Char);
    procedure edicionfinalKeyPress(Sender: TObject; var Key: Char);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure combodistClick(Sender: TObject);
    procedure codigoChange(Sender: TObject);
    procedure adeudosClick(Sender: TObject);
    procedure reporteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FREstadoCuenta: TFREstadoCuenta;

implementation

{$R *.dfm}
Uses
FCaptura_pagos_x_distribuidor,FR_reporte_edo_cuenta_imp;


procedure TFREstadoCuenta.Button1Click(Sender: TObject);
var
fechaactual:String;
maxed,mined:integer;
totaldot,totaldev:Double;
begin
  fechaactual:=FormatDateTime('mm/yyyy',now());
  //ShowMessage('El mes actual es:'+fechaactual);
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select min(edicion) as Min from t_devoluciones where fechae like "%'+fechaactual+'"');
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  mined:=ZQMesActual.FieldByName('Min').AsInteger;
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select Max(edicion) as Max from t_devoluciones where fechae like "%'+fechaactual+'"');
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  maxed:=ZQMesActual.FieldByName('Max').AsInteger;
  ShowMessage('De '+IntToStr(mined)+' A '+IntToStr(Maxed));
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select SUM(totaldot) AS Totaldot,SUM(totaldev) AS Totaldev from v_pagos_report where edicion between '+IntToStr(mined)+' AND '+IntToStr(maxed)+' AND codigo='+codigo.Text);
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  totaldot:=ZQMesActual.FieldByName('totaldot').AsFloat;
  totaldev:=ZQMesActual.FieldByName('totaldev').AsFloat;
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select * from v_pagos_report where edicion between '+IntToStr(mined)+' AND '+IntToStr(maxed)+' AND codigo='+codigo.Text);
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  ZQMesActual.Active;
  {pasamos los datos para generar el reporte del mes actual}
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.codigo.Caption:=ZQMesActual.FieldByName('codigo').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Nombre.Caption:=ZQMesActual.FieldByName('Nombre').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.tarifa.Caption:=ZQMesActual.FieldByName('tarifa').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechai.Caption:=fechaactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechaf.Caption:=fechaactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataField:='Fecha Edicion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataField:='edicion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataField:='dotacion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataField:='devolucion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataField:='pago';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataField:='vendidos';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataField:='adeudo';
    FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ventas.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ventas.DataField:='ventas';
 // FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.Caption:=IntToStr((StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Dotacion.Caption)-StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.Caption)));
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Prepare;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldev.Caption:=FloatToStr(totaldev);
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldot.Caption:=FloatToStr(totaldot);
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaD.Expression:='SUM(dotacion)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaDev.Expression:='SUM(devolucion)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Sumav.Expression:='SUM(vendidos)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaVentas.Expression:='SUM(ventas)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Preview;


end;

procedure TFREstadoCuenta.adeudosClick(Sender: TObject);
var
totaldev,totaldot:double;
begin
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select SUM(totaldot) AS Totaldot,SUM(totaldev) AS Totaldev from v_pagos_report where adeudo>0 AND codigo='+codigo.Text);
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  totaldot:=ZQMesActual.FieldByName('totaldot').AsFloat;
  totaldev:=ZQMesActual.FieldByName('totaldev').AsFloat;
  ZQMesActual.Close;
  ZQMesActual.SQL.Clear;
  ZQMesActual.SQL.Add('Select * from v_pagos_report where adeudo > 0 AND codigo='+codigo.Text);
  ZQMesActual.ExecSQL;
  ZQMesActual.Open;
  ZQMesActual.Active;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.codigo.Caption:=ZQMesActual.FieldByName('codigo').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Nombre.Caption:=ZQMesActual.FieldByName('Nombre').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.tarifa.Caption:=ZQMesActual.FieldByName('tarifa').AsString;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechai.Caption:='Adeudos';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechaf.Caption:='Adeudos';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataField:='Fecha Edicion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataField:='edicion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataField:='dotacion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataField:='devolucion';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataField:='pago';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataField:='vendidos';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataSet:=FREstadoCuenta.ZQMesactual;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataField:='adeudo';
 // FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.Caption:=IntToStr((StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Dotacion.Caption)-StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.Caption)));
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Prepare;
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldev.Caption:=FloatToStr(totaldev);
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldot.Caption:=FloatToStr(totaldot);
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaD.Expression:='SUM(dotacion)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaDev.Expression:='SUM(devolucion)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Sumav.Expression:='SUM(vendidos)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaVentas.Expression:='SUM(ventas)';
  FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Preview;
end;

procedure TFREstadoCuenta.cedicionClick(Sender: TObject);
begin
    if cedicion.Checked=TRUE then
      begin
        cfecha.Checked:=FALSE;
        reporte.Enabled:=TRUE;
        edicioninicial.Enabled:=TRUE;
        edicionfinal.Enabled:=TRUE;
        fechai.Enabled:=FALSE;
        fechaf.Enabled:=FALSE;
      end;
    if cedicion.Checked=FALSE then
       begin
         reporte.Enabled:=FALSE;
         edicioninicial.Enabled:=FALSE;
         edicionfinal.Enabled:=FALSE;
        end;
end;

procedure TFREstadoCuenta.cfechaClick(Sender: TObject);
begin
   if cfecha.Checked=TRUE then
     begin
       cedicion.Checked:=FALSE;
       reporte.Enabled:=TRUE;
       Fechai.Enabled:=TRUE;
       Fechaf.Enabled:=TRUE;
       edicioninicial.Enabled:=FALSE;
       edicionfinal.Enabled:=FALSE;
     end;
  if cfecha.Checked=FALSE then
     begin
       reporte.Enabled:=FALSE;
       fechai.Enabled:=TRUE;
       fechaf.Enabled:=TRUE;
     end;
end;

procedure TFREstadoCuenta.codigoChange(Sender: TObject);
begin
if codigo.Text <>'' then
    begin
    combodist.KeyValue:=StrToFloat(codigo.Text);
    end;
end;

procedure TFREstadoCuenta.codigoKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFREstadoCuenta.combodistClick(Sender: TObject);
begin
   codigo.Text:=FloatToStr(combodist.KeyValue);
end;

procedure TFREstadoCuenta.edicionfinalKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFREstadoCuenta.edicioninicialKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFREstadoCuenta.FormShow(Sender: TObject);
begin
  Codigo.Text:=FCapturaXdistribuidor.Codigo.Text;
  combodist.KeyValue:=StrToInt(codigo.Text);
end;

procedure TFREstadoCuenta.reporteClick(Sender: TObject);
var
edicioni,edicionf:Integer;
totaldev,totaldot:double;
begin
   if cfecha.Checked=TRUE then
      begin
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(fechai.Date)+'" limit 1');
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        edicioni:=ZQMesActual.FieldByName('edicion').AsInteger;
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select edicion from t_remision_rutas where fecha="'+DateToStr(fechaf.Date)+'" limit 1');
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        edicionf:=ZQMesActual.FieldByName('edicion').AsInteger;
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select SUM(totaldot) AS Totaldot,SUM(totaldev) AS Totaldev from v_pagos_report where edicion between '+IntToStr(edicioni)+' AND '+IntToStr(edicionf)+' AND codigo='+codigo.Text);
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        totaldot:=ZQMesActual.FieldByName('totaldot').AsFloat;
        totaldev:=ZQMesActual.FieldByName('totaldev').AsFloat;
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select * from v_pagos_report where edicion between '+IntToStr(edicioni)+' AND '+IntToStr(edicionf)+' AND codigo='+codigo.Text);
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        ZQMesActual.Active;
        {pasamos los datos para generar el reporte del mes actual}
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.codigo.Caption:=ZQMesActual.FieldByName('codigo').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Nombre.Caption:=ZQMesActual.FieldByName('Nombre').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.tarifa.Caption:=ZQMesActual.FieldByName('tarifa').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechai.Caption:=DateToStr(fechai.Date);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechaf.Caption:=DateToStr(fechaf.Date);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataField:='Fecha Edicion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataField:='edicion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataField:='dotacion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataField:='devolucion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataField:='pago';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataField:='vendidos';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataField:='adeudo';
       // FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.Caption:=IntToStr((StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Dotacion.Caption)-StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.Caption)));
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Prepare;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldev.Caption:=FloatToStr(totaldev);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldot.Caption:=FloatToStr(totaldot);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaD.Expression:='SUM(dotacion)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaDev.Expression:='SUM(devolucion)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Sumav.Expression:='SUM(vendidos)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaVentas.Expression:='SUM(ventas)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Preview;


      end;
   if cedicion.Checked=TRUE then
        begin
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select SUM(totaldot) AS Totaldot,SUM(totaldev) AS Totaldev from v_pagos_report where edicion between '+edicioninicial.Text+' AND '+edicionfinal.Text+' AND codigo='+codigo.Text);
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        totaldot:=ZQMesActual.FieldByName('totaldot').AsFloat;
        totaldev:=ZQMesActual.FieldByName('totaldev').AsFloat;
        ZQMesActual.Close;
        ZQMesActual.SQL.Clear;
        ZQMesActual.SQL.Add('Select * from v_pagos_report where edicion between '+edicioninicial.Text+' AND '+edicionfinal.Text+' AND codigo='+codigo.Text);
        ZQMesActual.ExecSQL;
        ZQMesActual.Open;
        ZQMesActual.Active;
        {pasamos los datos para generar el reporte del mes actual}
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.codigo.Caption:=ZQMesActual.FieldByName('codigo').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Nombre.Caption:=ZQMesActual.FieldByName('Nombre').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.tarifa.Caption:=ZQMesActual.FieldByName('tarifa').AsString;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechai.Caption:='Edicion:'+edicioninicial.Text;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.fechaf.Caption:='Edicion:'+edicionfinal.Text;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Fecha.DataField:='Fecha Edicion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.edicion.DataField:='edicion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.dotacion.DataField:='dotacion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.DataField:='devolucion';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.pago.DataField:='pago';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.DataField:='vendidos';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataSet:=FREstadoCuenta.ZQMesactual;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.adeudo.DataField:='adeudo';
       // FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.vendidos.Caption:=IntToStr((StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Dotacion.Caption)-StrToInt(FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.devolucion.Caption)));
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Prepare;
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldev.Caption:=FloatToStr(totaldev);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.totaldot.Caption:=FloatToStr(totaldot);
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaD.Expression:='SUM(dotacion)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaDev.Expression:='SUM(devolucion)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.Sumav.Expression:='SUM(vendidos)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.SumaVentas.Expression:='SUM(ventas)';
        FR_reporte_edo_cuenta_imp.FR_Edo_cuenta.ReporteEdoCuenta.Preview;
        end;
end;

end.
