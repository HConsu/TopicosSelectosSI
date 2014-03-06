unit FCorte_circulacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  StdCtrls, jpeg, ExtCtrls, ComCtrls;

type
  TFcorte = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    ZQcorte: TZQuery;
    DScorte: TDataSource;
    Label2: TLabel;
    totalcorte: TLabel;
    Label4: TLabel;
    ZQtotales: TZQuery;
    Label3: TLabel;
    labelresumen: TLabel;
    ZQtmp1: TZQuery;
    corte: TButton;
    Button2: TButton;
    ZQtmp2: TZQuery;
    Imprimirhoja: TButton;
    ZQimprime: TZQuery;
    DSImprime: TDataSource;
    Label5: TLabel;
    imppoliza: TButton;
    nopoliza: TEdit;
    Label6: TLabel;
    Image1: TImage;
    Label7: TLabel;
    checkefectivo: TCheckBox;
    Checkdeposito: TCheckBox;
    ZQpoliza: TZQuery;
    ZQtmp3: TZQuery;
    Progress: TProgressBar;
    Label8: TLabel;
    gastos: TEdit;
    aceptargastos: TButton;
    ZQtmp: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure corteClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImprimirhojaClick(Sender: TObject);
    procedure imppolizaClick(Sender: TObject);
    procedure nopolizaChange(Sender: TObject);
    procedure checkefectivoClick(Sender: TObject);
    procedure CheckdepositoClick(Sender: TObject);
    procedure aceptargastosClick(Sender: TObject);
  private
   corteactual:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fcorte: TFcorte;

implementation

{$R *.dfm}

Uses
FR_Hoja_Corte,FRImprime_poliza,FAutorizacion,Fprincipal;

procedure TFcorte.CheckdepositoClick(Sender: TObject);
begin
if checkdeposito.Checked=TRUE then
     begin
       checkefectivo.Checked:=FALSE;
       corte.Enabled:=TRUE;
     end;
   if checkdeposito.Checked=FALSE then
      begin
        corte.Enabled:=FALSE;
      end;
end;

procedure TFcorte.checkefectivoClick(Sender: TObject);
begin
   if checkefectivo.Checked=TRUE then
     begin
       checkdeposito.Checked:=FALSE;
       corte.Enabled:=TRUE;
     end;
   if checkefectivo.Checked=FALSE then
      begin
        corte.Enabled:=FALSE;
      end;
end;

procedure TFcorte.corteClick(Sender: TObject);
begin
if application.MessageBox (pchar('¿Esta seguro que desea realizar este corte por el monto indicado?'), pchar('Confirmar corte'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin
        {-------Rutina para insertar datos del corte y cambiar estatus de los pagos del corte-------}
        ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Insert into t_corte_cobranza (nombre,codigo,fechas_que_paga,total,fecha_corte,nocorte,tarifa,totalventa) (Select nombre,codigo,fechas_que_paga,total,fechacorte,nocorte,tarifa,totalventa from t_temporal_corte)');
        ZQtmp2.ExecSQL;
        if checkefectivo.Checked=TRUE then
            begin
            ZQtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Update t_corte_cobranza SET formapago="Efectivo",genero="Circulacion" where nocorte='+IntToStr(corteactual));
            ZQtmp2.ExecSQL;
            end;
        if checkdeposito.Checked=TRUE then
            begin
            ZQtmp2.Close;
            ZQtmp2.SQL.Clear;
            ZQtmp2.SQL.Add('Update t_corte_cobranza SET formapago="Deposito",genero="Circulacion" where nocorte='+IntToStr(corteactual));
            ZQtmp2.ExecSQL;
            end;

        ShowMessage('Se realizo el corte correctamente por la cantidad de $'+totalcorte.Caption+' ,Recuerde imprimir la hoja de corte');
        ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Update t_devoluciones SET scorte = "PA" Where scorte = "PC"');
        ZQtmp2.ExecSQL;
        ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Delete from t_temporal_corte');
        ZQtmp2.ExecSQL;
        corte.Enabled:=FALSE;
        {-------------Inicia rutina para generar hoja de corte------------------------------------}
        ZQImprime.Close;
        ZQImprime.SQL.Clear;
        //ShowMessage('Corte Actual:'+IntToStr(corteactual));
        ZQImprime.SQL.Add('Select * from t_corte_cobranza where nocorte='+IntToStr(corteactual));
        ZQImprime.ExecSQL;
        ZQImprime.Open;
        ZQImprime.Active;
        FR_HojaCorte.formato.Caption:=ZQImprime.FieldByName('formapago').AsString;
        FR_HojaCorte.nocorte.Caption:=ZQimprime.FieldByName('nocorte').AsString;
        FR_HojaCorte.QRHojaCorte.DataSet:=ZQImprime;
        FR_HojaCorte.Nombre.DataSet:=ZQImprime;
        FR_HojaCorte.Nombre.DataField:='Nombre';
        FR_HojaCorte.codigo.DataSet:=ZQimprime;
        FR_HojaCorte.codigo.DataField:='Codigo';
        FR_HojaCorte.Fechasquepaga.DataSet:=ZQImprime;
        FR_HojaCorte.Fechasquepaga.DataField:='fechas_que_paga';
        FR_HojaCorte.pago.DataSet:=ZQImprime;
        FR_HojaCorte.pago.DataField:='total';
        FR_HojaCorte.sumTotal.Expression:='SUM(total)';
        FR_HojaCorte.fechacorte.Caption:=ZQImprime.FieldByName('fecha_corte').AsString;
        FR_HojaCorte.QRHojaCorte.Prepare;
        FR_HojaCorte.QRHojaCorte.Preview;
        Nopoliza.Enabled:=TRUE;
        {-------------Fin de rutina para generar hoja de corte------------------------------------}
      end;
end;

procedure TFcorte.imppolizaClick(Sender: TObject);
var
concepto,ingreso,saldo:String;
begin
   FPrincipalCirculacion.autorizacionquerida:=2;
   FPassword.Enabled:=FALSE;
   FPassword := TFPassword.Create(Self);
   Fpassword.ShowModal;

if FPassword.autorizado=1 then
   begin
if application.MessageBox (pchar('¿Esta seguro que quiere generar la poliza usando el numero '+nopoliza.Text+'?'), pchar('Confirmar generar poliza'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin

      ZQtmp3.Close;
      ZQtmp3.SQL.Clear;
      ZQtmp3.SQL.Add('Select no_poliza from t_poliza_ingreso where no_poliza='+nopoliza.Text);
      ZQtmp3.ExecSQL;
      ZQtmp3.Open;
        if ZQtmp3.FieldByName('no_poliza').IsNull=TRUE then
            Begin
         //ShowMessage('Se genero la poliza');
         ZQPoliza.Close;
         ZQPoliza.SQL.Clear;
         ZQPoliza.SQL.Add('Select * from v_imprime_poliza where nocorte='+IntToStr(corteactual));
         ZQPoliza.ExecSQL;
         ZQPoliza.Open;
         FRImprimePoliza.QRpoliza.DataSet:=ZQPoliza;
         FRImprimePoliza.codigo.DataSet:=ZQPoliza;
         FRImprimePoliza.codigo.DataField:='Codigo';
         FRImprimePoliza.nombre.DataSet:=ZQPoliza;
         FRImprimePoliza.nombre.DataField:='nombre';
         FRImprimePoliza.ejemplares.DataSet:=ZQPoliza;
         FRImprimePoliza.ejemplares.DataField:='ejemplares';
         FRImprimePoliza.fechas.DataSet:=ZQPoliza;
         FRImprimePoliza.fechas.DataField:='fechas_que_paga';
         FRImprimePoliza.tarifa.DataSet:=ZQPoliza;
         FRImprimePoliza.tarifa.DataField:='tarifa';
         FRImprimePoliza.Pago.DataSet:=ZQPoliza;
         FRImprimePoliza.Pago.DataField:='total';
         FRImprimePoliza.nopoliza.Caption:=nopoliza.Text;
         FRImprimePoliza.SumEjemplares.Expression:='SUM(ejemplares)';
         FRImprimePoliza.sumtotal.Expression:='SUM(total)';
         FRImprimePoliza.concepto.Caption:='Venta del diario El independiente de Hidalgo al publico en general, detallado en corte de circulación No '+ZQPoliza.FieldByName('nocorte').AsString+' recibido en '+ZQpoliza.FieldByName('formapago').AsString;
         concepto:='Venta del diario El independiente de Hidalgo al publico en general, detallado en corte de circulación No '+ZQPoliza.FieldByName('nocorte').AsString+' recibido en '+ZQpoliza.FieldByName('formapago').AsString;
         ZQtmp3.Close;
         ZQtmp3.SQL.Clear;
         ZQtmp3.SQL.Add('Select SUM(total) As total from v_imprime_poliza where nocorte='+IntToStr(corteactual));
         ZQtmp3.ExecSQL;
         ZQtmp3.Open;
         ingreso:=ZQtmp3.FieldByName('total').AsString;
         saldo:=ingreso;
         ZQtmp3.Close;
         ZQtmp3.SQL.Clear;
         ZQtmp3.SQL.Add('Insert into t_poliza_ingreso (no_poliza,fecha_registro_poliza,nofactura,area_genera_poliza,concepto,ingreso,saldo) VALUES ');
         ZQtmp3.SQL.Add('('+nopoliza.Text+',"'+DateToStr(now())+'","sn","Circulacion","'+concepto+'",'+ingreso+','+saldo+')');
         ZQtmp3.ExecSQL;
         ZQtmp3.Close;
         ZQtmp3.SQL.Clear;
         ZQtmp3.SQL.Add('Update t_corte_cobranza SET nopoliza='+nopoliza.text+' Where nocorte='+IntToStr(corteactual));
         ZQtmp3.ExecSQL;
         FRImprimePoliza.QRpoliza.Prepare;
         FRImprimePoliza.QRpoliza.Preview;
         imppoliza.Enabled:=FALSE;


            End
        else begin
           ShowMessage('Ese numero de poliza ya se ha ocupado, verifique por favor el numero de poliza');
        end;
      end;
   end;
end;

procedure TFcorte.aceptargastosClick(Sender: TObject);
begin
   if application.MessageBox (pchar('¿Esta seguro que desea aplicar este gasto a el corte actual?'), pchar('Confirmar gasto'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     ZQtmp.SQL.Add('Insert into  t_temporal_corte (Nombre,codigo,total,fechacorte,nocorte) VALUES ("Gastos de operacion",0,-'+gastos.text+',"'+DateToStr(now())+'",'+IntToStr(corteactual)+')');
     ZQtmp.ExecSQL;
     totalcorte.Caption:=FloatToStr(StrToFloat(totalcorte.Caption)-StrToFloat(gastos.Text));
     aceptargastos.Enabled:=False;
      end;
end;

procedure TFcorte.Button2Click(Sender: TObject);
begin
   FCorte.Close;
end;

procedure TFcorte.FormShow(Sender: TObject);
var
numeropagos,nodist,codigodist,nocorte:integer;
nombredist,tarifa:String;
fechasquepaga:String;
resumen:String;
totaldist,i,x:double;
totalventa:String;
begin
  {----------------Limpiamos la tabla temporal y las variables que se usaran-------------------------}
    ZQtmp2.Close;
   ZQtmp2.SQL.Clear;
   ZQtmp2.SQL.Add('Delete from t_temporal_corte');
   ZQtmp2.ExecSQL;
   resumen:='';
   corteactual:=0;
  {---------------Fin de limpieza de tabla y variables-----------------------------------------------}

  {------------------------------Obtenemos el no de corte que se efectuara-------------------------}
     ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Select MAX(nocorte) AS nocorte from t_corte_cobranza');
        ZQtmp2.ExecSQL;
        ZQtmp2.open;
         if ZQtmp2.FieldByName('nocorte').IsNull = FALSE then
            begin
              nocorte:=ZQtmp2.FieldByName('nocorte').AsInteger+1;
            end
          else begin
              nocorte:=1;
          end;
     corteactual:=nocorte;
    {------------------------------Total de lo que se incluira en el corte----------------------}
    ZQtotales.Close;
    ZQtotales.SQL.Clear;
    ZQTotales.SQL.Add('select SUM(`t_devoluciones`.`pago`) AS `Total` from (`t_remision_rutas` join `t_devoluciones` on(((`t_remision_rutas`.`codigo_proveedor` = `t_devoluciones`.`codigo`) and (`t_remision_rutas`.`edicion` = `t_devoluciones`.`edicion`)))) Where scorte="PC"');
    ZQTotales.ExecSQL;
    ZQTotales.Open;
    totalcorte.Caption:=ZQTotales.FieldByName('Total').AsString;

    {------------------------Total del ejemplares vendidos--------------------------------------}
    ZQtotales.Close;
    ZQtotales.SQL.Clear;
    ZQtotales.SQL.Add('select SUM(`t_devoluciones`.`vendidos`) AS `Total` from (`t_remision_rutas` join `t_devoluciones` on(((`t_remision_rutas`.`codigo_proveedor` = `t_devoluciones`.`codigo`) and (`t_remision_rutas`.`edicion` = `t_devoluciones`.`edicion`)))) Where scorte="PC"');
    ZQtotales.ExecSQL;
    ZQtotales.Open;
    totalventa:=ZQtotales.FieldByName('Total').AsString;

    {-------------------------------Fin del calculo de total del corte-----------------------}
    {----------Inicia el preceso de insercion en tabla temporal preparacion para la poliza--------}
    ZQTotales.Close;
    ZQTotales.SQL.Clear;
    ZQTotales.SQL.Add('select DISTINCT `t_remision_rutas`.`plaza`,codigo from (`t_remision_rutas` join `t_devoluciones` on(((`t_remision_rutas`.`codigo_proveedor` = `t_devoluciones`.`codigo`) and');
    ZQTotales.SQL.Add('(`t_remision_rutas`.`edicion` = `t_devoluciones`.`edicion`)))) Where scorte="PC" order by `t_remision_rutas`.`edicion`');
    ZQTotales.ExecSQL;
    ZQtotales.Open;
    {asignamos a la variable el primer codigo del proveedor}
    nodist:=ZQTotales.RecordCount;
    i:=1;

    while i<= nodist do
       begin
    x:=1;
    codigodist:=ZQTotales.FieldByName('codigo').AsInteger;
    fechasquepaga:='';
    totaldist:=0;
    ZQtmp1.Close;
    ZQtmp1.SQL.Clear;
       {Consulta para contar el numero de fechas que se agregaran}
    ZQtmp1.SQL.Add('select count(`t_remision_rutas`.`fecha`) AS nopagos from (`t_remision_rutas` join `t_devoluciones` on(((`t_remision_rutas`.`codigo_proveedor` = `t_devoluciones`.`codigo`) ');
    ZQtmp1.SQL.Add('and (`t_remision_rutas`.`edicion` = `t_devoluciones`.`edicion`)))) Where scorte="PC" AND codigo='+IntToStr(codigodist)+' order by `t_remision_rutas`.`edicion`');
    ZQtmp1.ExecSQL;
    ZQtmp1.Open;
    numeropagos:=ZQtmp1.FieldByName('nopagos').AsInteger;
       {Consulta para obtener las fechas que se usaran para la concatenacion}
    ZQtmp1.Close;
    ZQtmp1.SQL.Clear;
    ZQtmp1.SQL.Add('select plaza,`t_remision_rutas`.`fecha` AS Fecha,`t_devoluciones`.`pago` AS `pago`,tarifa from (`t_remision_rutas` join `t_devoluciones` on(((`t_remision_rutas`.`codigo_proveedor` = `t_devoluciones`.`codigo`) ');
    ZQtmp1.SQL.Add('and (`t_remision_rutas`.`edicion` = `t_devoluciones`.`edicion`)))) Where scorte="PC"AND codigo='+IntToStr(codigodist)+' order by `t_remision_rutas`.`edicion`');
    ZQtmp1.ExecSQL;
    ZQtmp1.Open;

    {--------------------------------------}
    tarifa:=ZQtmp1.FieldByName('tarifa').AsString;
    {--------------------------------------}

   {Bucle que pega las fechas}
         while x<=numeropagos  do
            begin
               totaldist:=totaldist+ZQtmp1.FieldByName('pago').AsFloat;
               if x=1 then
                    begin
                    fechasquepaga:='De ';
                    fechasquepaga:=Fechasquepaga+ZQtmp1.FieldByName('fecha').AsString;
                    fechasquepaga:=Fechasquepaga+' al ';
                    end;
                if x=numeropagos then
                   begin
                    fechasquepaga:=Fechasquepaga+ZQtmp1.FieldByName('fecha').AsString;
                   end;
               x:=x+1;
               ZQtmp1.Next;

            end;
        i:=i+1;
        nombredist:=ZQtmp1.FieldByName('plaza').AsString;
        ZQTotales.Next;
        ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Insert into t_temporal_corte (nombre,codigo,fechas_que_paga,total,fechacorte,nocorte,tarifa,totalventa) VALUES("'+nombredist+'",'+IntToStr(codigodist)+',"'+fechasquepaga+'",'+FloatToStr(totaldist)+',"'+DateToStr(now)+'",'+IntToStr(nocorte)+','+tarifa+','+totalventa+')');
        ZQtmp2.ExecSQL;
        resumen:=resumen+'El distribuidor:'+nombredist+' Paga las fechas: '+fechasquepaga+' Por un total de $'+FloatToStr(totaldist)+#10;

     end;
   Progress.Visible:=FALSE;
   labelresumen.Caption:=resumen;
     if resumen='' then
         begin
           ShowMessage('No hay datos para realizar el corte');
           nopoliza.Enabled:=FALSE;
           checkefectivo.Enabled:=FALSE;
           checkdeposito.Enabled:=FALSE;
         end;

   //ShowMessage(resumen);

    {-----------Termina el proceso de insercion en tabla temporal preparacion para la poliza------}

end;

procedure TFcorte.ImprimirhojaClick(Sender: TObject);
var
nocorte:integer;
begin
        ZQtmp2.Close;
        ZQtmp2.SQL.Clear;
        ZQtmp2.SQL.Add('Select MAX(nocorte) AS nocorte from t_corte_cobranza where genero="Circulacion"');
        ZQtmp2.ExecSQL;
        ZQtmp2.open;
        nocorte:=ZQtmp2.FieldByName('nocorte').AsInteger;
        ZQImprime.Close;
        ZQImprime.SQL.Clear;
        ZQImprime.SQL.Add('Select * from t_corte_cobranza where nocorte='+IntToStr(nocorte));
        ZQImprime.ExecSQL;
        ZQImprime.Open;
        ZQImprime.Active;
        FR_HojaCorte.formato.Caption:=ZQImprime.FieldByName('formapago').AsString;
        FR_HojaCorte.nocorte.Caption:=ZQimprime.FieldByName('nocorte').AsString;
        FR_HojaCorte.QRHojaCorte.DataSet:=ZQImprime;
        FR_HojaCorte.Nombre.DataSet:=ZQImprime;
        FR_HojaCorte.Nombre.DataField:='Nombre';
        FR_HojaCorte.codigo.DataSet:=ZQimprime;
        FR_HojaCorte.codigo.DataField:='Codigo';
        FR_HojaCorte.Fechasquepaga.DataSet:=ZQImprime;
        FR_HojaCorte.Fechasquepaga.DataField:='fechas_que_paga';
        FR_HojaCorte.pago.DataSet:=ZQImprime;
        FR_HojaCorte.pago.DataField:='total';
        FR_HojaCorte.sumTotal.Expression:='SUM(total)';
        FR_HojaCorte.fechacorte.Caption:=ZQImprime.FieldByName('fecha_corte').AsString;
        FR_HojaCorte.QRHojaCorte.Prepare;
        FR_HojaCorte.QRHojaCorte.Preview;
end;

procedure TFcorte.nopolizaChange(Sender: TObject);
begin
  imppoliza.Enabled:=TRUE;
end;

end.
