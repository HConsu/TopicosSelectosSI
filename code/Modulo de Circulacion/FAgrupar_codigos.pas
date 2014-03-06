unit FAgrupar_codigos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFAgruparCodigos = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    gridsubscripciones: TDBGrid;
    nosubscripcionb: TEdit;
    atencionab: TEdit;
    Nosubscripcion: TLabel;
    atenciona: TLabel;
    ZQsubscripciones: TZQuery;
    Label3: TLabel;
    DSsubscripciones: TDataSource;
    ZQagrupar: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure nosubscripcionbKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure atencionabKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAgruparCodigos: TFAgruparCodigos;

implementation

{$R *.dfm}
USes
Fprincipal,FAdmon_codigos;

procedure TFAgruparCodigos.atencionabKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
valor,filtro:String;
begin
if atencionab.Text<>'' then
  begin
    filtro:='Atenciona LIKE '+quotedstr('*'+atencionab.Text+'*');
    ZQSubscripciones.Filter:=filtro;
    ZQSubscripciones.Filtered:=TRUE;
  end
  else begin
    ZQSubscripciones.Filtered:=FALSE;
  end;
end;

procedure TFAgruparCodigos.Button1Click(Sender: TObject);
begin
   if application.MessageBox (pchar('¿Esta seguro que desea agrupar estas subscripciones en un solo codigo?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
            ZQagrupar.Close;
            ZQagrupar.SQL.Clear;
            ZQAgrupar.SQL.Add('Update t_subscripcion SET codigo="'+gridsubscripciones.Fields[1].AsString+'" where nosubscripcion='+nosubscripcion.Caption);
            ZQAgrupar.ExecSQL;
            ShowMessage('Se agruparon las subscripciones');
            FAgruparCodigos.Close;
           end;
end;

procedure TFAgruparCodigos.FormShow(Sender: TObject);
begin
    Nosubscripcion.Caption:=FAdmoncodigos.gridsubscripciones.Fields[0].AsString;
    atenciona.Caption:=FAdmonCodigos.gridsubscripciones.Fields[2].AsString;

   ZQSubscripciones.Close;
   ZQSubscripciones.SQL.Clear;
   ZQSubscripciones.SQL.Add('Select NoSubscripcion,Codigo,AtencionA from t_subscripcion');
   ZQSubscripciones.ExecSQL;
   ZQSubscripciones.Open;
   gridsubscripciones.Refresh;

end;

procedure TFAgruparCodigos.nosubscripcionbKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
valor,filtro:String;
begin
if nosubscripcionb.Text<>'' then
  begin
    filtro:='"NoSubscripcion" = '+nosubscripcionb.Text;
    ZQSubscripciones.Filter:=filtro;
    ZQSubscripciones.Filtered:=TRUE;
  end
  else begin
    ZQSubscripciones.Filtered:=FALSE;
  end;
end;

end.
