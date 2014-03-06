unit FAsignar_C_Edificio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFAsignarCEdificio = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    gridedificios: TDBGrid;
    gridsubscripciones: TDBGrid;
    Asignar: TButton;
    Label3: TLabel;
    Label4: TLabel;
    nosubscripcion: TLabel;
    atenciona: TLabel;
    ZQedificios: TZQuery;
    ZQSubscriptores: TZQuery;
    DSEdificios: TDataSource;
    DSSubscriptores: TDataSource;
    ZQasignar: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure gridedificiosCellClick(Column: TColumn);
    procedure ZQedificiosAfterScroll(DataSet: TDataSet);
    procedure AsignarClick(Sender: TObject);
    type THackDBGrid = class(TDBGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAsignarCEdificio: TFAsignarCEdificio;

implementation

{$R *.dfm}
Uses
FAdmon_codigos,Fprincipal;

procedure TFAsignarCEdificio.gridedificiosCellClick(Column: TColumn);
begin
    ZQSubscriptores.Close;
    ZQSubscriptores.SQL.Clear;
    ZQSubscriptores.SQL.Add('Select NoSubscripcion,AtencionA AS Atencion from t_subscripcion where codigo="'+gridedificios.Fields[1].AsString+'"');
    ZQsubscriptores.ExecSQL;
    ZQSubscriptores.Open;
    GridSubscripciones.Refresh;

end;

procedure TFAsignarCEdificio.ZQedificiosAfterScroll(DataSet: TDataSet);
begin
    ZQSubscriptores.Close;
    ZQSubscriptores.SQL.Clear;
    ZQSubscriptores.SQL.Add('Select NoSubscripcion,Atenciona AS Atencion from t_subscripcion where codigo="'+gridedificios.Fields[1].AsString+'"');
    ZQsubscriptores.ExecSQL;
    ZQSubscriptores.Open;
    GridSubscripciones.Refresh;
end;

procedure TFAsignarCEdificio.AsignarClick(Sender: TObject);
var
{---------------------}
rowDelta: Integer;
row: integer;
recNo: integer;
ds : TDataSet;
{---------------------}
begin
if application.MessageBox (pchar('¿Esta seguro de querer asignar al subscriptor '+atenciona.Caption+' al edificio '+gridedificios.Fields[0].AsString+'?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin

 {----Para mantener el focus del grid------------------------------}
   ds := THackDBGrid(gridedificios).DataSource.DataSet;
   rowDelta := -1 + THackDBGrid(gridedificios).Row;
   row := ds.RecNo;
   ds.Refresh;
 {-------------fin mantener el foco--------------------------------}

             //Se debe guaradar en una tabla el codigo que tenia asignado anteriormente aparte de la bitacora
             ZQAsignar.Close;
             ZQasignar.SQL.Clear;
             ZQASignar.SQL.Add('Insert into t_control_codigos (Nosubscripcion,codigoa,codigon) VALUES ('+nosubscripcion.Caption+',"'+FadmonCodigos.gridsubscripciones.Fields[1].AsString+'","'+GridEdificios.Fields[1].AsString+'")');
             ZQasignar.ExecSQL;

             //Actualizamos la subscripcion con el codigo del edificio
             ZQasignar.Close;
             ZQAsignar.SQL.Clear;
             ZQasignar.SQL.Add('Update t_subscripcion SET codigo="'+GridEdificios.Fields[1].AsString+'" Where nosubscripcion='+nosubscripcion.Caption);
             ZQasignar.ExecSQL;
             // actualizamos el grid de subscripciones
            ZQSubscriptores.Close;
            ZQSubscriptores.SQL.Clear;
            ZQSubscriptores.SQL.Add('Select NoSubscripcion,AtencionA AS Atencion from t_subscripcion where codigo="'+gridedificios.Fields[1].AsString+'"');
            ZQsubscriptores.ExecSQL;
            ZQSubscriptores.Open;
            GridSubscripciones.Refresh;
   with ds do
   begin
     DisableControls;
     RecNo := row;
     MoveBy(-rowDelta) ;
     MoveBy(rowDelta) ;
     EnableControls;
     //ShowMessage(IntToStr(-rowdelta)+','+IntToStr(rowdelta));
   end;
  ShowMessage('Hecho!');
  FAsignarCEdificio.Close;

           end;
end;

procedure TFAsignarCEdificio.FormShow(Sender: TObject);
begin
   //Leemos los datos del formularios que llamo para mostrarlos
   nosubscripcion.caption:=FadmonCodigos.gridsubscripciones.Fields[0].AsString;
   atenciona.Caption:=Fadmoncodigos.gridsubscripciones.Fields[2].AsString;

   //cargamos el catalogo de edificios y sus codigos asignados
   ZQedificios.Close;
   ZQEdificios.SQL.Clear;
   ZQedificios.SQL.Add('Select Descripcion,codigo from c_edificios');
   ZQedificios.ExecSQL;
   ZQEdificios.Open;



end;

end.
