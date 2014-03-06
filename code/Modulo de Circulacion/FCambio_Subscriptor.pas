unit FCambio_Subscriptor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  StdCtrls, jpeg, ExtCtrls;

type
  TFCambioSubscriptor = class(TForm)
    GridSubs: TDBGrid;
    ZQsubscriptor: TZQuery;
    DSSubscriptor: TDataSource;
    Label1: TLabel;
    atenciona: TEdit;
    nosubscripcion: TEdit;
    buscar: TEdit;
    Button1: TButton;
    Button2: TButton;
    basignar: TButton;
    Button4: TButton;
    ZQasignar: TZQuery;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure basignarClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCambioSubscriptor: TFCambioSubscriptor;

implementation

{$R *.dfm}
Uses FAlta_Subscripciones;

procedure TFCambioSubscriptor.Button1Click(Sender: TObject);
begin
 if buscar.Text<>'' then
    begin
  ZQSubscriptor.Close;
  ZQSubscriptor.SQL.Clear;
  ZQSubscriptor.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor where titular like "%'+buscar.Text+'%"');
  ZQsubscriptor.ExecSQL;
  ZQSubscriptor.Open;
  GridSubs.Refresh;
    end;
end;

procedure TFCambioSubscriptor.Button2Click(Sender: TObject);
begin
   ZQSubscriptor.Close;
  ZQSubscriptor.SQL.Clear;
  ZQSubscriptor.SQL.Add('Select id_subscriptor AS "No Subscriptor", Titular,Fecha_alta,RFC,email,Agente_de_ventas as "Agente de ventas",Calle,Colonia,Ciudad,CP,NoEmpleadoUAEH from t_cliente_subscriptor');
  ZQsubscriptor.ExecSQL;
  ZQSubscriptor.Open;
  GridSubs.Refresh;
end;

procedure TFCambioSubscriptor.Button4Click(Sender: TObject);
begin
   FCambioSubscriptor.Close;
end;

procedure TFCambioSubscriptor.FormShow(Sender: TObject);
begin
   nosubscripcion.Text:=FSubscripciones.DBGridSubscripciones.Fields[0].AsString;
   atenciona.Text:=FSubscripciones.DBGridSubscripciones.Fields[2].AsString;
end;

procedure TFCambioSubscriptor.basignarClick(Sender: TObject);
begin
if application.MessageBox (pchar('¿Esta seguro de asignar la subscripción '+Nosubscripcion.Text+' al subscriptor '+GridSubs.Fields[0].AsString+'?'), pchar('Confirmar alta de queja'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
  ZQasignar.Close;
  ZQasignar.SQL.Clear;
  ZQasignar.SQL.Add('Update t_subscripcion SET nosubscriptor='+GridSubs.Fields[0].AsString+' Where nosubscripcion ='+nosubscripcion.Text);
  ZQasignar.ExecSQL;
  basignar.Enabled:=FALSE;
           end;
end;

end.
