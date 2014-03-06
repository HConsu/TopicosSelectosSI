unit FNueva_Area_Edificio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, jpeg,
  ExtCtrls;

type
  TFNueva_area_de_edifcio = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    ZQEdificio: TZQuery;
    ZQNuevaArea: TZQuery;
    Button2: TButton;
    edificio: TEdit;
    area: TEdit;
    Label3: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNueva_area_de_edifcio: TFNueva_area_de_edifcio;

implementation

Uses FNuevaSubscripcion,Fprincipal,F_Modificar_Subscripcion;

{$R *.dfm}

procedure TFNueva_area_de_edifcio.Button1Click(Sender: TObject);
var
orden:String;
nosubscripcion:string;
idedificio:string;
fechamodificacion:String;
direccion:String;
begin
   fechamodificacion:=DateToStr(now());
   if FPrincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
    idedificio := (FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio);
    nosubscripcion := (FNuevaSubscripcion.FNueva_Subscripcion.numerodesubscripcion);
      end;
  if FPrincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
    idedificio := FloatToStr(F_Modificar_subscripcion.FModificar_Subscripcion.combo_edificio.KeyValue);
    nosubscripcion := (F_Modificar_subscripcion.FModificar_Subscripcion.nosusbcripcion.Text);
      end;


   ZQEdificio.Close;
   ZQEdificio.SQL.Clear;
   ZQEdificio.SQL.Add('Select max(orden_en_reparto+1)AS Orden from t_descripcion_ruta_edificio where id_edificio='+idedificio);
   ZQEdificio.ExecSQL;
   ZQEdificio.Open;
   orden := ZQEdificio.FieldByName('Orden').AsString;
   if orden='' then
      begin
        orden:='1';
      end;
   ZQEdificio.Close;
   ZQEdificio.SQL.Clear;
   {buscamos si la subscripcion esta dada de alta en otra ruta y lo eliminamos}
   ZQEdificio.SQL.Add('Delete from t_descripcion_ruta_edificio where nosubscripcion ='+nosubscripcion);
   ZQEdificio.ExecSQL;
   ZQEdificio.Close;
   ZQEdificio.SQL.Clear;
   ZQEdificio.SQL.Add('Delete from t_descripcion_rutas where no_de_subscripcion ='+nosubscripcion);
   ZQEdificio.ExecSQL;
   {insertamos la subscripcion en la nueva ruta}
   ZQNuevaArea.Close;
   ZQNuevaArea.SQL.Clear;
   ZQNuevaArea.SQL.Add('Insert into t_descripcion_ruta_edificio (nosubscripcion,area,Orden_en_reparto,id_edificio) VALUES('+nosubscripcion+',"'+area.Text+'",'+orden+','+idedificio+')');
   ZQNuevaArea.ExecSQL;
   ZQNuevaArea.Close;
   ZQNuevaArea.SQL.Clear;
   ZQNuevaArea.SQL.Add('Update t_subscripcion SET fechamodif="'+fechamodificacion+'" where nosubscripcion='+nosubscripcion);
   ZQNuevaArea.ExecSQL;


    if FPrincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
   {--- Agregamos la subscripcion a la tabla de altas para seguimiento en circulacion------}
        direccion:=edificio.Text+','+area.Text;
        ZQNuevaArea.Close;
        ZQNuevaArea.SQL.Clear;
        ZQNuevaArea.SQL.Add('Insert into t_altas (nosubscripcion,direccion,fecha_alta) VALUES ('+nosubscripcion+',"'+direccion+'",NOW())');
        ZQNuevaArea.ExecSQL;
   {---------------------------------------------------------------------------------------}
      end;
  if FPrincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
     {----------------------Eliminamos los cambios de domicilio de menos de 7 dias-----------}
         ZQNuevaArea.Close;
         ZQNuevaArea.SQL.Clear;
         ZQNuevaArea.SQL.Add('Delete from t_cambios_domicilio where nosubscripcion='+nosubscripcion+' AND fecha_cambio between CURDATE()-7 AND CURDATE()+1;');
         ZQNuevaArea.ExecSQL;
    {-------------------------Eliminar cambios de domicilio de menos de 7 dias--------------}

    {--- Agregamos la subscripcion a la tabla de cambios para seguimiento en circulacion------}
        direccion:=edificio.Text+','+area.Text;
        ZQNuevaArea.Close;
        ZQNuevaArea.SQL.Clear;
        ZQNuevaArea.SQL.Add('Insert into t_cambios_domicilio (nosubscripcion,direccion,fecha_cambio) VALUES ('+nosubscripcion+',"'+direccion+'",NOW())');
        ZQNuevaArea.ExecSQL;
    {---------------------------------------------------------------------------------------}
      end;


   ShowMessage('El subscriptor fue dado de dalta en la nueva �rea, verifique el orden de reparto');
   FNueva_area_de_edifcio.Close;
   FNueva_Subscripcion.Close;

end;

procedure TFNueva_area_de_edifcio.Button2Click(Sender: TObject);
begin
  FNueva_area_de_edifcio.Close;
end;

procedure TFNueva_area_de_edifcio.FormShow(Sender: TObject);
var
numero_de_edificio:String;
begin
  if FPrincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
    numero_de_edificio := (FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio);
      end;
  if FPrincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
    numero_de_edificio := FloatToStr(F_Modificar_subscripcion.FModificar_Subscripcion.combo_edificio.KeyValue);
      end;

    ZQEdificio.Close;
    ZQEdificio.SQL.Clear;
    ZQEdificio.SQL.Add('Select * from c_edificios where id_edificio = '+numero_de_edificio);
    ZQEdificio.ExecSQL;
    ZQEdificio.Open;
    Edificio.Text := ZQEdificio.FieldByName('descripcion').AsString;
    ZQEdificio.Close;

end;

end.
