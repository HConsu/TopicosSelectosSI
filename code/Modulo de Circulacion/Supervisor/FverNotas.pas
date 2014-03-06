unit FverNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids;

type
  TFver = class(TForm)
    Label1: TLabel;
    nosubscripcion: TLabel;
    DSver: TDataSource;
    gridnotas: TDBGrid;
    Button1: TButton;
    ZQver: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fver: TFver;


implementation

{$R *.dfm}
Uses
FSeguimientoAltas,FPrincipal;

procedure TFver.Button1Click(Sender: TObject);
begin
  FVer.Close;
end;

procedure TFver.FormShow(Sender: TObject);
begin
  nosubscripcion.Caption:=FSeguimientoA.gridsubs.Fields[0].AsString;
  ZQver.Close;
  ZQver.SQL.Clear;
  ZQver.SQL.Add('Select Fecha,Nota from t_notas_subscripciones where nosubscripcion='+nosubscripcion.Caption+' Order by id_nota');
  ZQver.ExecSQL;
  ZQver.Open;
  gridnotas.Refresh;
end;

end.