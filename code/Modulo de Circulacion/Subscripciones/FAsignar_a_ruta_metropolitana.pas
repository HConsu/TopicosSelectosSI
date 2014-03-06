unit FAsignar_a_ruta_metropolitana;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids, DBCtrls, Mask, ZStoredProcedure;

type
  TFAsignarARutaMetro = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    NoSubscripcion: TEdit;
    DBGridRutas: TDBGrid;
    Asignar: TButton;
    Subir: TButton;
    Bajar: TButton;
    LCalle: TLabel;
    LColonia: TLabel;
    Calle: TEdit;
    Colonia: TEdit;
    Ldescripcion: TLabel;
    Descripcion: TEdit;
    ZQrutas: TZQuery;
    DSRutas: TDataSource;
    numeroruta: TDBEdit;
    ZQGridRuta: TZQuery;
    DSGridRuta: TDataSource;
    ZQAgregar: TZQuery;
    actualizar: TButton;
    aceptar: TButton;
    ZSordena: TZStoredProc;
    ZQtmp: TZQuery;
    Label4: TLabel;
    Label5: TLabel;
    CP: TEdit;
    Municipio: TEdit;
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AsignarClick(Sender: TObject);
    procedure actualizarClick(Sender: TObject);
    procedure aceptarClick(Sender: TObject);
    procedure SubirClick(Sender: TObject);
    procedure BajarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAsignarARutaMetro: TFAsignarARutaMetro;

implementation

{$R *.dfm}

Uses FNuevaSubscripcion,F_Modificar_Subscripcion;

procedure TFAsignarARutaMetro.aceptarClick(Sender: TObject);
begin
   FAsignarARutaMetro.Close;
   FNueva_Subscripcion.Close;
   FModificar_Subscripcion.Close;
end;

procedure TFAsignarARutaMetro.actualizarClick(Sender: TObject);
begin
  ZQGridRuta.Active :=FALSE;
  ZQGridRuta.Active :=TRUE;
  ZQGridRuta.Refresh;
  DBGridRutas.Refresh;

end;

procedure TFAsignarARutaMetro.AsignarClick(Sender: TObject);
var
Ordenenreparto:String;
codigopostal:String;
ciudad:String;
descripcion:String;
fechamodificacion:String;
begin
  fechamodificacion:=DateToStr(now());
  codigopostal:=FModificar_Subscripcion.cp.text;
  ciudad:=FModificar_Subscripcion.ciudad.text;
  descripcion:=FModificar_Subscripcion.descripcion.Text;
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('Select MAX(Orden_en_el_reparto+1) AS Orden from t_descripcion_rutas where no_ruta='+numeroruta.Text);
  ZQAgregar.ExecSQL;
  ZQAgregar.Open;
  Ordenenreparto:= ZQAgregar.FieldByName('Orden').AsString;
  if OrdenEnreparto = '' then
      begin
       Ordenenreparto := '1';
      end;
  {buscamos si la subscripcion esta dada de alta en otra ruta y lo eliminamos}
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('Delete from t_descripcion_ruta_edificio where nosubscripcion ='+nosubscripcion.text);
  ZQAgregar.ExecSQL;
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('Delete from t_descripcion_rutas where no_de_subscripcion ='+nosubscripcion.Text);
  ZQAgregar.ExecSQL;
  {llamamos el procedimiento almacenado de ordenamiento despues de eliminar un registro}
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('CALL Orden_de_reparto('+nosubscripcion.Text+')');
  ZQAgregar.ExecSQL;
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('CALL Orden_reparto_metro('+nosubscripcion.Text+')');
  ZQAgregar.ExecSQL;

  {Insertamos la subscripcion en la ruta indicada}
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('Insert into t_descripcion_rutas (no_ruta,Orden_en_el_reparto,no_de_subscripcion,calle,colonia,cp,ciudad,descripcion_domicilio) Values');
  ZQAgregar.SQL.Add('('+numeroruta.Text+','+ordenenreparto+','+nosubscripcion.Text+',"'+calle.Text+'","'+colonia.Text+'",'+codigopostal+',"'+ciudad+'","'+descripcion+'")');
  ZQAgregar.ExecSQL;
  ZQAgregar.Close;
  ZQAgregar.SQL.Clear;
  ZQAgregar.SQL.Add('Update t_subscripcion SET fechamodif="'+fechamodificacion+'" where nosubscripcion='+nosubscripcion.Text);
  ZQAgregar.ExecSQL;
  ShowMessage('La subscripción fue dada de alta correctamente, verifique el orden de entrega');
  asignar.Enabled:=FALSE;
  ZQGridRuta.Active :=FALSE;
  ZQGridRuta.Active :=TRUE;
  ZQGridRuta.Refresh;
  DBGridRutas.Refresh;
end;

procedure TFAsignarARutaMetro.BajarClick(Sender: TObject);
var
id_anterior:integer;
id_actual:integer;
actual:integer;
actuals:string;
nuevo:integer;
nuevos:string;
intercambio:integer;
begin
  actual := DBGridRutas.Fields[0].AsInteger;
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
  ZQGridRuta.Refresh;
  DBGridRutas.Refresh;

end;

procedure TFAsignarARutaMetro.DBLookupComboBox1Click(Sender: TObject);
begin
   ZQGridRuta.Active:=FALSE;
   ZQGridRuta.Close;
   ZQGridRuta.SQL.Clear;
   ZQGridRuta.SQL.Add('Select Orden_en_el_reparto AS "Orden en entrega",No_de_subscripcion AS "No Subscripcion",Calle,Colonia,Descripcion_domicilio AS "Descripción"');
   ZQGridRuta.SQL.Add(',CP,Ciudad from c_rutas inner join t_descripcion_rutas ON c_rutas.no_ruta = t_descripcion_rutas.no_ruta  Where t_descripcion_rutas.No_ruta ='+numeroruta.Text+' Order by Orden_en_el_reparto');
   ZQGridRuta.ExecSQL;
   ZQGridRuta.Active:=TRUE;
   DBGridRutas.Refresh;

end;

procedure TFAsignarARutaMetro.FormShow(Sender: TObject);
begin
     calle.Text:= FModificar_Subscripcion.calle.Text;
     colonia.Text := FModificar_Subscripcion.colonia.Text;
     descripcion.Text := FModificar_Subscripcion.descripcion.Text;
     NoSubscripcion.Text := FModificar_Subscripcion.nosusbcripcion.Text;
     cp.Text:=FModificar_Subscripcion.cp.Text;
     municipio.Text:=FModificar_Subscripcion.ciudad.Text;
     if Nosubscripcion.Text ='nosusbcripcion' then
         begin
         NoSubscripcion.Text := FNuevaSubscripcion.FNueva_Subscripcion.NoSubscripcion.Text;
         end;



end;

procedure TFAsignarARutaMetro.SubirClick(Sender: TObject);
var
id_anterior:integer;
id_actual:integer;
actual:integer;
actuals:string;
nuevo:integer;
nuevos:string;
intercambio:integer;
begin
  actual := DBGridRutas.Fields[0].AsInteger;
  nuevo := actual-1;
  nuevos:=IntToStr(nuevo);
  actuals := IntToStr(actual);
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_ruta from t_descripcion_rutas where Orden_en_el_reparto = '+ IntToStr(actual-1) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_anterior := ZQtmp.FieldByName('id_ruta').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select id_ruta from t_descripcion_rutas where Orden_en_el_reparto = '+ IntToStr(actual) );
  ZQtmp.ExecSQL;
  ZQtmp.Open;
  id_actual := ZQtmp.FieldByName('id_ruta').AsInteger;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto ='+IntToStr(nuevo)+' where id_ruta = '+IntToStr(id_actual));
  ZQtmp.ExecSQL;
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Update t_descripcion_rutas SET Orden_en_el_reparto ='+IntToStr(actual)+' where id_ruta = '+IntToStr(id_anterior));
  ZQtmp.ExecSQL;
  ZQGridRuta.Refresh;
  DBGridRutas.Refresh;


end;

end.
