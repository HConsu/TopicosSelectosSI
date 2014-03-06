unit FCerra_ConActa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFCierreConActa = class(TForm)
    motivo: TMemo;
    Button1: TButton;
    Label1: TLabel;
    ZQcomentarios: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCierreConActa: TFCierreConActa;

implementation

{$R *.dfm}

Uses
Fprincipal, FSeguimiento_Quejas;

procedure TFCierreConActa.Button1Click(Sender: TObject);
begin
   ZQcomentarios.Close;
   ZQcomentarios.SQL.Clear;
   ZQcomentarios.SQL.Add('insert into t_motivo_cierre_acta(id_queja,comentario) VALUES('+FseguimientoQ.GridQuejas.Fields[0].AsString+',"'+motivo.Text+'")');
   ZQcomentarios.ExecSQL;
   FCierreConActa.Close;
end;

procedure TFCierreConActa.FormShow(Sender: TObject);
begin
  motivo.Text:='';
end;

end.
