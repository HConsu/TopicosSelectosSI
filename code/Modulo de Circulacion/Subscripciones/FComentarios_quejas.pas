unit FComentarios_quejas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFcomentariosQuejas = class(TForm)
    Label1: TLabel;
    comentarios: TMemo;
    Aceptar: TButton;
    ZQcomentarios: TZQuery;
    procedure AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FcomentariosQuejas: TFcomentariosQuejas;

implementation

{$R *.dfm}
Uses
Fprincipal,FSeguimiento_Quejas;

procedure TFcomentariosQuejas.AceptarClick(Sender: TObject);
begin
   ZQcomentarios.Close;
   ZQcomentarios.SQL.Clear;
   ZQcomentarios.SQL.Add('insert into t_comentario_cliente_queja(id_queja,comentario) VALUES('+FseguimientoQ.GridQuejas.Fields[0].AsString+',"'+comentarios.Text+'")');
   ZQcomentarios.ExecSQL;
   Fcomentariosquejas.Close;
end;

end.
