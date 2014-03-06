unit FNuevo_codigo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  pBarcode, pCode128, pEAN128;

type
  TFNuevoCodigo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    nosubscripcionl: TLabel;
    atencional: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cactual: TLabel;
    cnuevo: TLabel;
    generarb: TButton;
    ZQgenerar: TZQuery;
    ZQinserta: TZQuery;
    Barcode: TBarcode_EAN128;
    Aceptar: TButton;
    procedure FormShow(Sender: TObject);
    procedure generarbClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNuevoCodigo: TFNuevoCodigo;

implementation

{$R *.dfm}

Uses
FAdmon_codigos,Fprincipal;

procedure TFNuevoCodigo.generarbClick(Sender: TObject);
var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin
   if application.MessageBox (pchar('Esta accion creara un nuevo codigo para este subscriptor, el codigo anterior ya no sera valido, ¿desea continuar?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin

   {----Inicia el proceso para generar el codigo----------------}
  ZQgenerar.Close;
  ZQGenerar.SQL.Clear;
  ZQGenerar.SQL.Add('Select Nosubscripcion,Nosubscriptor,Atenciona,Edificio,ruta,fecha_inicio,Fecha_fin from t_subscripcion where nosubscripcion='+nosubscripcionl.Caption);
  ZQGenerar.ExecSQL;
  ZQGenerar.Open;

  {------------------------------------------------------------------}
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=4 then
      begin
        nosubscripcion:=ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=3 then
      begin
        nosubscripcion:='0'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=2 then
      begin
        nosubscripcion:='00'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=1 then
      begin
        nosubscripcion:='000'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;


  {---------------------------------------------------------------------------}
     if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=4 then
      begin
        nosubscriptor:=ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=3 then
      begin
        nosubscriptor:='0'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=2 then
      begin
        nosubscriptor:='00'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=1 then
      begin
        nosubscriptor:='000'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;

   {---------------------------------------------------------------------------}
    ZQInserta.Close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Select max(id) AS Id from t_identificador_codigo');
    ZQInserta.ExecSQL;
    ZQInserta.Open;
      if ZQinserta.FieldByName('Id').IsNull=TRUE then
         begin
            consecutivo:=1;
         end
      else begin
        Consecutivo:=ZQinserta.FieldByName('Id').AsInteger+1;
      end;
    consec:=IntToStr(Consecutivo);
   // showMessage(consec);
   // ShowMessage(IntToStr(Consecutivo));
   if Length(Consec)=4 then
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

    {--------Concatenamos y agregamos el digito verificador---------}
    Codigo:=nosubscripcion+nosubscriptor+consec;
    barcode.Barcode:=codigo;
    codigo:=barcode.FullEncoded;
    cnuevo.Caption:=codigo;
    {------ Fin de generar codigo de barras---------------}

    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Update t_subscripcion SET codigo="'+Codigo+'" where nosubscripcion ='+nosubscripcion);
    ZQInserta.ExecSQL;

      //Se debe guaradar en una tabla el codigo que tenia asignado anteriormente aparte de la bitacora
     ZQInserta.Close;
     ZQInserta.SQL.Clear;
     ZQInserta.SQL.Add('Insert into t_control_codigos (Nosubscripcion,codigoa,codigon) VALUES ('+nosubscripcionl.Caption+',"'+cactual.Caption+'","'+cnuevo.Caption+'")');
     ZQInserta.ExecSQL;

    {---   guardamos el consecutivo del codigo--------------}
    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Insert into t_identificador_codigo (id) VALUES('+IntToStr(consecutivo)+')');
    ZQInserta.ExecSQL;
    ZQGenerar.Next;
    {---- insertamos en tabla para impresion ---------------}
    ZQinserta.Close;
    ZQinserta.SQL.Clear;
    ZQinserta.SQL.Add('Insert into t_codigos_imprimir (Codigo) Values("'+cnuevo.Caption+'")');
    ZQinserta.ExecSQL;

    generarb.Enabled:=FALSE;
    Aceptar.Visible:=TRUE;
   end;
end;

procedure TFNuevoCodigo.AceptarClick(Sender: TObject);
begin
      FnuevoCodigo.Close;
end;

procedure TFNuevoCodigo.FormShow(Sender: TObject);
var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin
    nosubscripcionl.Caption:=FAdmonCodigos.gridsubscripciones.Fields[0].AsString;
    atencional.Caption:=FadmonCodigos.gridsubscripciones.Fields[2].AsString;
    cactual.Caption:=FAdmonCodigos.gridsubscripciones.Fields[1].AsString;



end;

end.
