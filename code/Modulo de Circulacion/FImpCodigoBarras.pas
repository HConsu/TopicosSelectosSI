unit FImpCodigoBarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids, ExtCtrls, pBarcode, pCode128, pEAN128, pUPC, pEAN13, Mask, DBCtrls;

type
  TFImpCodigo = class(TForm)
    Button1: TButton;
    ZQgenerar: TZQuery;
    GridCodigos: TDBGrid;
    DSGenerar: TDataSource;
    Barcode: TBarcode_EAN128;
    codigojpg: TImage;
    ZQinserta: TZQuery;
    Button2: TButton;
    Label1: TLabel;
    ZQedificios: TZQuery;
    DSedificios: TDataSource;
    cruta: TDBLookupComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure crutaCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImpCodigo: TFImpCodigo;

implementation

{$R *.dfm}
uses
Fprincipal;

procedure TFImpCodigo.Button1Click(Sender: TObject);
var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin

if application.MessageBox (pchar('Esta generara codigos para las suscripciones en el edificio seleccionado, solo debera hacer esto si esta seguro de lo que esta haciendo'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin

  i:=1;
  ZQgenerar.Close;
  ZQGenerar.SQL.Clear;
  ZQGenerar.SQL.Add('Select Nosubscripcion,Nosubscriptor,Atenciona,Edificio,ruta,fecha_inicio,Fecha_fin from t_subscripcion where edificio='+IntToStr(cruta.KeyValue));
  ZQGenerar.ExecSQL;
  ZQGenerar.Open;
  GridCodigos.Refresh;
  while i<= ZQGenerar.RecordCount  do
    begin
  {---------------------------------------------------------------------------}
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





    Codigo:=nosubscripcion+nosubscriptor+consec;
    //ShowMessage(Codigo);
      barcode.Barcode:=codigo;
      codigo:=barcode.FullEncoded;
  //  codigojpg.Picture.SaveToFile('C:\Documents and Settings\EdgarCT\Mis documentos\RAD Studio\Projects\Circulacion\Codigosdebarras\128-'+codigo+'.jpg');
    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Update t_subscripcion SET codigo="'+Codigo+'" where nosubscripcion ='+nosubscripcion);
    ZQInserta.ExecSQL;

    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Insert into t_identificador_codigo (id) VALUES('+IntToStr(consecutivo)+')');
    ZQInserta.ExecSQL;

    ZQGenerar.Next;
    i:=i+1;
    end;

   end;

end;

procedure TFImpCodigo.Button2Click(Sender: TObject);
var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin
  i:=1;
  ZQgenerar.Close;
  ZQGenerar.SQL.Clear;
  ZQGenerar.SQL.Add('Select codigo from t_subscripcion where ruta=6');
  ZQGenerar.ExecSQL;
  ZQGenerar.Open;
  GridCodigos.Refresh;
  while i<= ZQGenerar.RecordCount  do
    begin
      Codigo:=ZQgenerar.FieldByName('codigo').AsString;
      //ShowMessage(Codigo);
      barcode.Barcode:=codigo;
      codigojpg.Picture.SaveToFile('C:\Users\Desarrollo\Documents\RAD Studio\Projects\Circulacion\Codigosdebarras\128-'+codigo+'.jpg');
      ZQGenerar.Next;
      i:=i+1;
    end;
end;

procedure TFImpCodigo.crutaCloseUp(Sender: TObject);
begin
     if cruta.Text<>'' then
       begin
  ZQgenerar.Close;
  ZQGenerar.SQL.Clear;
  ZQGenerar.SQL.Add('Select Nosubscripcion,Nosubscriptor,Atenciona,Edificio,ruta,fecha_inicio,Fecha_fin from t_subscripcion where edificio='+IntToStr(cruta.KeyValue));
  ZQGenerar.ExecSQL;
  ZQGenerar.Open;
  GridCodigos.Refresh;
       end;

end;

end.
