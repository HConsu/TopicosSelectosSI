
unit FAreas_de_entrega_en_edificio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ExtCtrls, Menus, jpeg;

type
  TFAreas_entrega_edificio = class(TForm)
    DBGridArea: TDBGrid;
    Label1: TLabel;
    Subir: TButton;
    Bajar: TButton;
    Label2: TLabel;
    Label3: TLabel;
    NSubscripcion: TEdit;
    combo_lista_area: TDBLookupComboBox;
    agregararea: TButton;
    ZQEdificio: TZQuery;
    DSEdificio: TDataSource;
    DSArea: TDataSource;
    ZQAreaGrid: TZQuery;
    Edificio: TEdit;
    ZQArea: TZQuery;
    DSAreaGrid: TDataSource;
    Agregar: TButton;
    Actualizar: TButton;
    ZQtmp: TZQuery;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Salir: TButton;
    procedure agregarareaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActualizarClick(Sender: TObject);
    procedure SubirClick(Sender: TObject);
    procedure BajarClick(Sender: TObject);
    procedure AgregarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure SalirClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAreas_entrega_edificio: TFAreas_entrega_edificio;

implementation

uses FNueva_Area_Edificio,FNuevaSubscripcion,FPrincipal,
      F_Modificar_subscripcion;


{$R *.dfm}

procedure TFAreas_entrega_edificio.ActualizarClick(Sender: TObject);
begin
   ZQAreaGrid.Refresh;
   DBGridArea.Refresh;
end;

procedure TFAreas_entrega_edificio.agregarareaClick(Sender: TObject);
begin
   FNueva_area_de_edifcio.Enabled := FALSE;
   FNueva_area_de_edifcio := TFNueva_area_de_edifcio.Create(self);
   FNueva_area_de_edifcio.ShowModal;
   agregar.Enabled:=FALSE;
   agregararea.Enabled:=FALSE;
end;

procedure TFAreas_entrega_edificio.AgregarClick(Sender: TObject);
var
orden:String;
nosubscripcion,noruta:string;
idedificio:string;
fechamodificacion:String;
direccion:String;
begin
  if combo_lista_area.Text <> '' then
    begin
   fechamodificacion:=DateToStr(now());

   if FprincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
   nosubscripcion := (FNuevaSubscripcion.FNueva_Subscripcion.numerodesubscripcion);
   idedificio := (FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio);
      end;
   if FprincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
   nosubscripcion := (FModificar_Subscripcion.nosusbcripcion.Text);
   idedificio := FloatToStr(FModificar_Subscripcion.combo_edificio.KeyValue);
      end;

    //ShowMessage(idedificio);
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select max(orden_en_reparto+1)AS Orden from t_descripcion_ruta_edificio where id_edificio='+idedificio);
   ZQtmp.ExecSQL;
   ZQtmp.Open;
   orden := ZQtmp.FieldByName('Orden').AsString;
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Select id_edificio,ruta AS Noruta  from c_edificios where id_edificio='+idedificio);
   ZQtmp.ExecSQL;
   ZQtmp.Open;
   noruta := ZQtmp.FieldByName('Noruta').AsString;
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   {buscamos si la subscripcion esta dada de alta en otra ruta y lo eliminamos}
   ZQtmp.SQL.Add('Delete from t_descripcion_ruta_edificio where nosubscripcion ='+nosubscripcion);
   ZQtmp.ExecSQL;
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Delete from t_descripcion_rutas where no_de_subscripcion ='+nosubscripcion);
   ZQtmp.ExecSQL;
   {insertamos la subscripcion en la nueva ruta}
   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Insert into t_descripcion_ruta_edificio (nosubscripcion,area,Orden_en_reparto,id_edificio) VALUES('+nosubscripcion+',"'+combo_lista_area.Text+'",'+orden+','+idedificio+')');
   ZQtmp.ExecSQL;


     if FPrincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
      {--- Agregamos la subscripcion a la tabla de altas para seguimiento en circulacion------}
        direccion:=edificio.Text+','+combo_lista_area.Text;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Insert into t_altas (nosubscripcion,direccion,fecha_alta) VALUES ('+NSubscripcion.Text+',"'+direccion+'",NOW())');
        ZQtmp.ExecSQL;
      {---------------------------------------------------------------------------------------}
      end;
   if FPrincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
     {----------------------Eliminamos los cambios de domicilio de menos de 7 dias-----------}
       ZQtmp.Close;
       ZQtmp.SQL.Clear;
       ZQtmp.SQL.Add('Delete from t_cambios_domicilio where nosubscripcion='+NSubscripcion.Text+' AND fecha_cambio between CURDATE()-7 AND CURDATE()+1;');
       ZQtmp.ExecSQL;
         {-------------------------Eliminar cambios de domicilio de menos de 7 dias--------------}

   {--- Agregamos la subscripcion a la tabla de cambios para seguimiento en circulacion------}
        direccion:=edificio.Text+','+combo_lista_area.Text;
        ZQtmp.Close;
        ZQtmp.SQL.Clear;
        ZQtmp.SQL.Add('Insert into t_cambios_domicilio (nosubscripcion,direccion,fecha_cambio) VALUES ('+NSubscripcion.Text+',"'+direccion+'",NOW())');
        ZQtmp.ExecSQL;
  {---------------------------------------------------------------------------------------}
      end;



  { ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Update t_subscripcion SET fechamodif="'+fechamodificacion+'",ruta='+noruta+' where nosubscripcion='+nosubscripcion);
   ZQtmp.ExecSQL;}
   ShowMessage('El subscriptor fue dado de dalta en el �rea indicada, verifique el orden de reparto');
   agregar.Enabled := FALSE;
   agregararea.Enabled:=FALSE;
   ZQAreaGrid.Refresh;
   DBGridArea.Refresh;
   FNueva_Subscripcion.close;
    end
   else begin
     ShowMessage('Seleccione el area');
   end;



end;

procedure TFAreas_entrega_edificio.BajarClick(Sender: TObject);
var
id_anterior:integer;
id_actual:integer;
actual:integer;
actuals:string;
nuevo:integer;
nuevos:string;
intercambio:integer;
begin
  actual := DBGridArea.Fields[0].AsInteger;
  nuevo := actual+1;
  nuevos:=IntToStr(nuevo);
  actuals := IntToStr(actual);
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_orden from t_descripcion_ruta_edificio where Orden_en_reparto = '+ IntToStr(actual+1) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_anterior := ZQtmp.FieldByName('id_orden').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_orden from t_descripcion_ruta_edificio where Orden_en_reparto = '+ IntToStr(actual) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_actual := ZQtmp.FieldByName('id_orden').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto ='+IntToStr(nuevo)+' where id_orden = '+IntToStr(id_actual));
  ZQtmp.ExecSQL;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto ='+IntToStr(actual)+' where id_orden = '+IntToStr(id_anterior));
  ZQtmp.ExecSQL;
  ZQAreaGrid.Refresh;
  DBGridArea.Refresh;

end;

procedure TFAreas_entrega_edificio.Salir1Click(Sender: TObject);
begin
   FAreas_entrega_edificio.Close;
end;

procedure TFAreas_entrega_edificio.SalirClick(Sender: TObject);
begin
    FAreas_entrega_edificio.Close;
end;

procedure TFAreas_entrega_edificio.SubirClick(Sender: TObject);
var
id_anterior:integer;
id_actual:integer;
actual:integer;
actuals:string;
nuevo:integer;
nuevos:string;
intercambio:integer;
begin
  actual := DBGridArea.Fields[0].AsInteger;
  nuevo := actual-1;
  nuevos:=IntToStr(nuevo);
  actuals := IntToStr(actual);
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_orden from t_descripcion_ruta_edificio where Orden_en_reparto = '+ IntToStr(actual-1) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_anterior := ZQtmp.FieldByName('id_orden').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_orden from t_descripcion_ruta_edificio where Orden_en_reparto = '+ IntToStr(actual) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_actual := ZQtmp.FieldByName('id_orden').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto ='+IntToStr(nuevo)+' where id_orden = '+IntToStr(id_actual));
  ZQtmp.ExecSQL;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_ruta_edificio SET Orden_en_reparto ='+IntToStr(actual)+' where id_orden = '+IntToStr(id_anterior));
  ZQtmp.ExecSQL;
  ZQAreaGrid.Refresh;
  DBGridArea.Refresh;


end;

procedure TFAreas_entrega_edificio.FormShow(Sender: TObject);
var
numero_de_edificio:String;
begin
  if FPrincipalCirculacion.quienllamaareadeentrega = 1 then
      begin
    numero_de_edificio := (FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio);
    ZQEdificio.Close;
    ZQEdificio.SQL.Clear;
    ZQEdificio.SQL.Add('Select * from c_edificios where id_edificio = '+numero_de_edificio);
    ZQEdificio.ExecSQL;
    ZQEdificio.Open;
    Edificio.Text := ZQEdificio.FieldByName('descripcion').AsString;
    NSubscripcion.Text := (FNuevaSubscripcion.FNueva_Subscripcion.numerodesubscripcion);
    ZQAreaGrid.Close;
    ZQAreaGrid.SQL.Clear;
    ZQAreaGrid.SQL.Add('Select Orden_en_reparto AS "Orden de entrega",NoSubscripcion,Area as "�rea",no_ruta AS "Ruta"  from t_descripcion_ruta_edificio where id_edificio='+numero_de_edificio+' order by  Orden_en_reparto');
    ZQAreaGrid.ExecSQL;
    ZQAreaGrid.Open;
    ZQArea.Close;
    ZQArea.SQL.Clear;
    ZQArea.SQL.Add('Select DISTINCT area,id_edificio from t_descripcion_ruta_edificio where id_edificio='+FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio+' GROUP BY area');
    ZQArea.ExecSQL;
    ZQArea.Open;
    ZQAreaGrid.Active:=TRUE;
    DBGridArea.Refresh;
      end;
  if FPrincipalCirculacion.quienllamaareadeentrega = 2 then
      begin
    numero_de_edificio := FloatToStr(F_Modificar_subscripcion.FModificar_Subscripcion.combo_edificio.KeyValue);

    ZQEdificio.Close;
    ZQEdificio.SQL.Clear;
    ZQEdificio.SQL.Add('Select * from c_edificios where id_edificio = '+numero_de_edificio);
    ZQEdificio.ExecSQL;
    ZQEdificio.Open;
    Edificio.Text := ZQEdificio.FieldByName('descripcion').AsString;
    NSubscripcion.Text := (F_Modificar_subscripcion.FModificar_Subscripcion.nosusbcripcion.Text);
    ZQAreaGrid.Close;
    ZQAreaGrid.SQL.Clear;
    ZQAreaGrid.SQL.Add('Select Orden_en_reparto AS "Orden de entrega",NoSubscripcion,Area as "�rea",no_ruta AS "Ruta"  from t_descripcion_ruta_edificio where id_edificio='+numero_de_edificio+' order by  Orden_en_reparto');
    ZQAreaGrid.ExecSQL;
    ZQAreaGrid.Open;
    ZQArea.Close;
    ZQArea.SQL.Clear;
    ZQArea.SQL.Add('Select DISTINCT area,id_edificio from t_descripcion_ruta_edificio where id_edificio='+numero_de_edificio+' GROUP BY area');
    ZQArea.ExecSQL;
    ZQArea.Open;
    ZQAreaGrid.Active:=TRUE;
    DBGridArea.Refresh;
      end;

end;

end.