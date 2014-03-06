unit FCaptura_pagos_zocalo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFCapturaZocalo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    codigo: TEdit;
    Combodis: TDBLookupComboBox;
    GridDis: TDBGrid;
    Checkvendedor: TCheckBox;
    Checkedicion: TCheckBox;
    Label3: TLabel;
    noedicion: TEdit;
    ZQtmp: TZQuery;
    ZQGridD: TZQuery;
    DSGridDis: TDataSource;
    ZQvoceador: TZQuery;
    DSvoceador: TDataSource;
    vertodo: TButton;
    bmarcar: TButton;
    Label4: TLabel;
    totalzocalo: TLabel;
    veredicion: TButton;
    Label6: TLabel;
    totalcirculacion: TLabel;
    ZQtotales: TZQuery;
    Button1: TButton;
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure codigoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vertodoClick(Sender: TObject);
    procedure CombodisClick(Sender: TObject);
    procedure bmarcarClick(Sender: TObject);
    procedure GridDisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridDisKeyPress(Sender: TObject; var Key: Char);
    procedure CheckvendedorClick(Sender: TObject);
    procedure CheckedicionClick(Sender: TObject);
    procedure veredicionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vertodos:integer;
    marcar:integer;
    edicionactual:integer;
    controldegrid:integer;
  public
    { Public declarations }
  end;

var
  FCapturaZocalo: TFCapturaZocalo;

implementation

{$R *.dfm}
Uses
FPrincipal,FAutorizacion,FCorte_Zocalo;

procedure TFCapturaZocalo.bmarcarClick(Sender: TObject);
begin
    if(marcar = 0) then
     begin
     marcar:=1;
     bmarcar.Caption:='No Marcar pagados';

     end
  else
      begin
      marcar:=0;
      bmarcar.Caption:='Marcar pagados';
     end;
   if (vertodos=1) then
      begin
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
end;

procedure TFCapturaZocalo.Button1Click(Sender: TObject);
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

procedure TFCapturaZocalo.CheckedicionClick(Sender: TObject);
begin
   if checkedicion.Checked=TRUE then
      begin
        noedicion.Enabled:=TRUE;
        veredicion.Enabled:=TRUE;
        checkvendedor.Checked:=FALSE;
        controldegrid:=1;
      end
   else begin
        checkvendedor.Checked:=TRUE;
   end;
end;

procedure TFCapturaZocalo.CheckvendedorClick(Sender: TObject);
begin
   if checkvendedor.Checked=TRUE then
      begin
        checkedicion.Checked:=FALSE;
        veredicion.Enabled:=FALSE;
        noedicion.Enabled:=FALSE;
        controldegrid:=0;
        Label6.Visible:=FALSE;
        Label4.Visible:=FALSE;
        totalzocalo.Visible:=FALSE;
        totalcirculacion.Visible:=FALSE;
      end
   else  begin
      checkedicion.Checked:=TRUE;
   end;

end;

procedure TFCapturaZocalo.codigoChange(Sender: TObject);
begin
if codigo.Text<>'' then
         begin
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select nombre,id_proveedor from c_proveedores_zocalo where id_proveedor='+codigo.Text);
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
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
    end;
end;

procedure TFCapturaZocalo.codigoKeyPress(Sender: TObject; var Key: Char);
begin
     {Revisamos que en el campo no se introduscan letras}
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCapturaZocalo.CombodisClick(Sender: TObject);
begin
 codigo.Text:=FloatToStr(combodis.KeyValue);
  if (vertodos=1) then
      begin
     ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND adeudo > 0  AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
end;

procedure TFCapturaZocalo.FormShow(Sender: TObject);
var fechaactual:String;
begin
{Primero obtenemos el numero de edicion correspondiente al dia de hoy}
   fechaactual:=DateToStr(now());
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select edicion from t_remision_zocalo where fecha="'+fechaactual+'"');
   ZQtmp.Open;
   edicionactual:=ZQtmp.FieldByName('edicion').AsInteger;
{------ fin de determinacion de edicion actual-----------------------}
   vertodos:=1;
   marcar:=0;
   controldegrid:=0;

end;

procedure TFCapturaZocalo.GridDisDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

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

end;

procedure TFCapturaZocalo.GridDisKeyPress(Sender: TObject; var Key: Char);
var
devolucion,Pago,adeudo,vendidos,dotacion:String;
edicion:String;
codigoprov:String;
fila,columna:Integer;
{variables para control del corte}
devc,dotc,pagc,adeuc,tarifac:double;
//x,y:integer;
begin
//  x:=GRidDis.SelectedIndex;
//  y:=ZQgridD.RecNo;
  if (Key=#13) then
     begin
    if controldegrid=0 then
          begin
      columna:=GridDis.SelectedIndex;
      fila:=ZQGridD.RecNo;
       if (GridDis.Fields[8].AsFloat) >= 0 then
           begin
       dotacion:= GridDis.Fields[5].AsString;
       pago:=GridDis.Fields[7].AsString;
       adeudo:=FloatToStr(GridDis.Fields[4].Asfloat*((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat)));
       edicion:=GridDis.Fields[3].AsString;
       codigoprov:=GridDis.Fields[0].AsString;
       devolucion:=GridDis.Fields[6].AsString;
       vendidos:=FloatToStr((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat));
       //ShowMessage('Pago: '+pago+',Adeudo: '+adeudo+',Nuevo Adeudo :'+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago)));

       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET pago='+pago+',devolucion='+devolucion+',vendidos='+vendidos+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET tarifa='+GridDis.Fields[4].AsString+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET adeudo=((dotacion-'+devolucion+')*tarifa) where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET adeudo='+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago))+',dotacion='+dotacion+' Where codigo='+codigoprov+' AND edicion='+edicion);
       ZQtmp.ExecSQL;
       GridDis.Refresh;
       {-------------------------------inicia Actualizacion del estatus para corte---------------------------}
       Zqtmp.close;
       ZQtmp.SQl.Clear;
       ZQtmp.SQL.Add('Select dotacion,devolucion,tarifa,pago from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion ='+edicion );
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       dotc:=ZQtmp.FieldByName('dotacion').AsFloat;
       devc:=ZQtmp.FieldByName('devolucion').AsFloat;
       pagc:=ZQtmp.FieldByName('pago').AsFloat;
       tarifac:=ZQtmp.FieldByName('tarifa').AsFloat;
        if dotc > 0 then
             begin
         if ((dotc-devc)=0) OR (((dotc-devc)*tarifac) <= pagc) then
              begin
           if tarifac = 0 then
               begin
            if application.MessageBox (pchar('¿Confirma que desea usar una tarifa de $0 pesos para este vendedor?'), pchar('Confirmar tarifa'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
                begin
                ZQtmp.Close;
                ZQtmp.SQL.Clear;
                ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET scorte="PC" where codigo='+codigo.Text+' AND edicion='+edicion);
                ZQtmp.ExecSQL;
               // ShowMessage('Esta pagado totalmente y se actualiza el estatus a PC');
                end;
              end
           else begin
             ZQtmp.Close;
             ZQtmp.SQL.Clear;
             ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET scorte="PC" where codigo='+codigo.Text+' AND edicion='+edicion);
             ZQtmp.ExecSQL;
           end;
         end;
      end;

       {------------------------------Fin Actualizacion del estatus para corte---------------------------}
    codigo.Text:=FloatToStr(combodis.KeyValue);


    if (vertodos=1) then
      begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
      end;
                end
       else begin
          ShowMessage('El pago de este proveedor ya esta cubierto para esta edicion');
        end;
     end;  {fin del if del control del grid}

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
   if controldegrid=1 then
       begin
       // ShowMessage('Se usa grid por edicion');
      columna:=GridDis.SelectedIndex;
      fila:=ZQGridD.RecNo;
       if (GridDis.Fields[8].AsFloat) >= 0 then
           begin
       dotacion:= GridDis.Fields[5].AsString;
       pago:=GridDis.Fields[7].AsString;
       adeudo:=FloatToStr(GridDis.Fields[4].Asfloat*((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat)));
       edicion:=GridDis.Fields[3].AsString;
       codigoprov:=GridDis.Fields[0].AsString;
       devolucion:=GridDis.Fields[6].AsString;
       vendidos:=FloatToStr((GridDis.Fields[5].AsFloat)-(GridDis.Fields[6].AsFloat));
       //ShowMessage('Pago: '+pago+',Adeudo: '+adeudo+',Nuevo Adeudo :'+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago)));
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET pago='+pago+',devolucion='+devolucion+',vendidos='+vendidos+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET tarifa='+GridDis.Fields[4].AsString+' where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET adeudo=((dotacion-'+devolucion+')*tarifa) where edicion='+edicion+' AND codigo='+codigoprov);
       ZQtmp.ExecSQL;
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Update t_remision_zocalo SET adeudo='+FloatToStr(StrToFloat(adeudo)-StrToFloat(pago))+',dotacion='+dotacion+' Where codigo='+codigoprov+' AND edicion='+edicion);
       ZQtmp.ExecSQL;
       GridDis.Refresh;
       {-------------------------------inicia Actualizacion del estatus para corte---------------------------}
       Zqtmp.close;
       ZQtmp.SQl.Clear;
       ZQtmp.SQL.Add('Select dotacion,devolucion,tarifa,pago from v_pagos_zocalo where codigo='+codigoprov+' AND edicion ='+edicion );
       ZQtmp.ExecSQL;
       ZQtmp.Open;
       dotc:=ZQtmp.FieldByName('dotacion').AsFloat;
       devc:=ZQtmp.FieldByName('devolucion').AsFloat;
       pagc:=ZQtmp.FieldByName('pago').AsFloat;
       tarifac:=ZQtmp.FieldByName('tarifa').AsFloat;
        if dotc > 0 then
             begin
         if ((dotc-devc)=0) OR (((dotc-devc)*tarifac) <= pagc) then
            begin
          if tarifac = 0 then
              begin
            if application.MessageBox (pchar('¿Confirma que desea usar una tarifa de $0 pesos para este vendedor?'), pchar('Confirmar tarifa'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
                begin
                ZQtmp.Close;
                ZQtmp.SQL.Clear;
                ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET scorte="PC" where codigo='+codigoprov+' AND edicion='+edicion);
                ZQtmp.ExecSQL;
              //  ShowMessage('Esta pagado totalmente y se actualiza el estatus a PC');
                end;
              end
            else begin
             ZQtmp.Close;
             ZQtmp.SQL.Clear;
             ZQtmp.SQL.Add('Update t_devoluciones_zocalo SET scorte="PC" where codigo='+codigoprov+' AND edicion='+edicion);
             ZQtmp.ExecSQL;
               end;
            end;
         end;

       {------------------------------Fin Actualizacion del estatus para corte---------------------------}

    if (vertodos=1) then
      begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where edicion ='+noedicion.Text);
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
   {-----------------------------------}
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select SUM(dotacion) AS Dotacion from t_remision_zocalo where edicion ='+noedicion.Text);
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   totalzocalo.Caption:=ZQTotales.FieldByName('Dotacion').AsString;
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select dotacion from t_remision_rutas where edicion ='+noedicion.Text+' AND codigo_proveedor = 61');
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   totalcirculacion.Caption:=ZQtotales.FieldByName('dotacion').AsString;
   if StrToFloat(totalzocalo.Caption) > StrToFloat(totalcirculacion.Caption) then
      begin
      totalzocalo.Font.Color:=ClRed;
      end
   else  begin
       totalzocalo.Font.Color:=ClGreen;
   end;
       END;


   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   GridDis.SelectedIndex:=columna;
   ZQGridD.RecNo:=fila;
   {-----------------------------}
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select SUM(dotacion) AS Dotacion from t_remision_zocalo where edicion ='+noedicion.Text);
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   totalzocalo.Caption:=ZQTotales.FieldByName('Dotacion').AsString;
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select dotacion from t_remision_rutas where edicion ='+noedicion.Text+' AND codigo_proveedor = 61');
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   totalcirculacion.Caption:=ZQtotales.FieldByName('dotacion').AsString;
   if StrToFloat(totalzocalo.Caption) > StrToFloat(totalcirculacion.Caption) then
      begin
      totalzocalo.Font.Color:=ClRed;
      end
   else  begin
       totalzocalo.Font.Color:=ClGreen;
   end;
      end;
                end
       else begin
          ShowMessage('El pago de este proveedor ya esta cubierto para esta edicion');
        end;

       end;
     end;
end;


procedure TFCapturaZocalo.veredicionClick(Sender: TObject);
begin
   if noedicion.Text<>'0' then
      begin
   Label6.Visible:=TRUE;
   Label4.Visible:=TRUE;
   totalzocalo.Visible:=TRUE;
   totalcirculacion.Visible:=TRUE;
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where edicion ='+noedicion.Text);
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select SUM(dotacion) AS Dotacion from t_remision_zocalo where edicion ='+noedicion.Text);
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   if ZQtotales.FieldByName('Dotacion').IsNull=FALSE then
      begin
      totalzocalo.Caption:=ZQTotales.FieldByName('Dotacion').AsString;
      end
   else begin
      totalzocalo.Caption:='0';
   end;
   ZQtotales.Close;
   ZQtotales.SQL.Clear;
   ZQtotales.SQL.Add('Select dotacion from t_remision_rutas where edicion ='+noedicion.Text+' AND codigo_proveedor = 61');
   ZQtotales.ExecSQL;
   ZQtotales.Open;
   if ZQtotales.FieldByName('dotacion').IsNull=FALSE then
      begin
      totalcirculacion.Caption:=ZQtotales.FieldByName('dotacion').AsString;
      end
   else begin
     totalcirculacion.Caption:='0';
   end;
   if StrToFloat(totalzocalo.Caption) > StrToFloat(totalcirculacion.Caption) then
      begin
      totalzocalo.Font.Color:=ClRed;
      end
   else  begin
       totalzocalo.Font.Color:=ClGreen;
   end;



    end;
end;

procedure TFCapturaZocalo.vertodoClick(Sender: TObject);
begin
 if(vertodos = 0) then
     begin
    vertodos:=1;
    vertodo.Caption:='Ocultar los pagados';
    bmarcar.Enabled:=TRUE;

     end
  else
      begin
        vertodos:=0;
        vertodo.Caption:='Ver todos los pagos';
        bmarcar.Enabled:=FALSE;
      end;

     if (vertodos=1) then
      begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
       END;
   if (vertodos=0) then
     begin
   ZQGridD.Close;
   ZQGridD.SQL.Clear;
   ZQGridD.SQL.Add('Select * from v_pagos_zocalo where codigo='+codigo.Text+' AND adeudo > 0 AND edicion <='+IntToStr(edicionactual));
   ZQGridD.ExecSQL;
   ZQGridD.Open;
   ZQGRidD.Active:=TRUE;
   GridDis.Refresh;
      end;
end;

end.
