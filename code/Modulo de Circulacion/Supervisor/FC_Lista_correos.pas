unit FC_Lista_correos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TFListaCorreos = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ZTable1: TZTable;
    DataSource1: TDataSource;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FListaCorreos: TFListaCorreos;

implementation

{$R *.dfm}

Uses
Fprincipal;

procedure TFListaCorreos.Button1Click(Sender: TObject);
begin
   FlistaCorreos.Close;
end;

end.
