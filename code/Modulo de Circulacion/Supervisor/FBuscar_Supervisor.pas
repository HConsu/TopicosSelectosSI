unit FBuscar_Supervisor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFBuscarSupervisor = class(TForm)
    gridsubscripciones: TDBGrid;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    nosubscripcion: TLabel;
    atenciona: TLabel;
    direccion: TLabel;
    Label11: TLabel;
    ruta: TLabel;
    ZQsubscripciones: TZQuery;
    DSsubscripciones: TDataSource;
    bnombre: TEdit;
    bdireccion: TEdit;
    Label2: TLabel;
    edificio: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure bnombreKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bdireccionKeyPress(Sender: TObject; var Key: Char);
    procedure bdireccionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridsubscripcionesCellClick(Column: TColumn);
    procedure Button1Click(Sender: TObject);
    procedure ZQsubscripcionesAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBuscarSupervisor: TFBuscarSupervisor;

implementation

{$R *.dfm}
Uses
FPrincipal;

procedure TFBuscarSupervisor.bdireccionKeyPress(Sender: TObject; var Key: Char);
begin
//  ZQSubscripciones.Close;
//  ZQSubscripciones.SQL.Clear;
//  ZQSubscripciones.SQL.Add();
end;

procedure TFBuscarSupervisor.bdireccionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
filtro:String;
begin
 if bdireccion.Text<>'' then
    begin
  filtro:='calle LIKE '+quotedstr('*'+bdireccion.Text+'*')+' OR colonia LIKE '+quotedstr('*'+bdireccion.Text+'*')+' OR descripcion like '+quotedstr('*'+bdireccion.Text+'*');
  ZQSubscripciones.Filter:=filtro;
  ZQSubscripciones.Filtered:=TRUE;
    end
  else begin
    ZQsubscripciones.Filtered:=FALSE;
  end;
end;

procedure TFBuscarSupervisor.bnombreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
filtro:String;
begin
 if bnombre.Text<>'' then
    begin
  filtro:='Atenciona LIKE '+quotedstr('*'+bnombre.Text+'*');
  ZQSubscripciones.Filter:=filtro;
  ZQSubscripciones.Filtered:=TRUE;
    end
  else begin
    ZQsubscripciones.Filtered:=FALSE;
  end;
end;

procedure TFBuscarSupervisor.Button1Click(Sender: TObject);
begin
    FBuscarSupervisor.Close;
end;

procedure TFBuscarSupervisor.FormShow(Sender: TObject);
begin
   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select Nosubscripcion,AtencionA,ruta,(Select descripcion from c_edificios where edificio=id_edificio)AS Edificio,Telefono,Observaciones,(Select calle from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)');
   ZQSubscripciones.SQL.Add('AS calle,(Select colonia from t_descripcion_rutas where no_de_subscripcion=nosubscripcion)AS Colonia, (Select descripcion_domicilio from t_descripcion_rutas');
   ZQSubscripciones.SQL.Add(' where no_de_subscripcion=nosubscripcion)AS Descripcion from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;
end;

procedure TFBuscarSupervisor.gridsubscripcionesCellClick(Column: TColumn);
begin
   nosubscripcion.Caption:=gridsubscripciones.Fields[0].AsString;
   atenciona.Caption:=gridsubscripciones.Fields[1].AsString;
   ruta.Caption:=gridsubscripciones.Fields[2].AsString;
   edificio.Caption:=gridsubscripciones.Fields[3].AsString;
   direccion.Caption:=gridsubscripciones.Fields[4].AsString+','+gridsubscripciones.Fields[5].AsString+','+gridsubscripciones.Fields[6].AsString;
end;

procedure TFBuscarSupervisor.ZQsubscripcionesAfterScroll(DataSet: TDataSet);
begin
   nosubscripcion.Caption:=gridsubscripciones.Fields[0].AsString;
   atenciona.Caption:=gridsubscripciones.Fields[1].AsString;
   ruta.Caption:=gridsubscripciones.Fields[2].AsString;
   edificio.Caption:=gridsubscripciones.Fields[3].AsString;
   direccion.Caption:=gridsubscripciones.Fields[4].AsString+','+gridsubscripciones.Fields[5].AsString+','+gridsubscripciones.Fields[6].AsString;
end;

end.