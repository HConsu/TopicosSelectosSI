unit FC_Dotacion_total;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractTable, ZDataset;

type
  TFCTotal_dotacion = class(TForm)
    Label1: TLabel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    ZTable1: TZTable;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCTotal_dotacion: TFCTotal_dotacion;

implementation

{$R *.dfm}

procedure TFCTotal_dotacion.Button1Click(Sender: TObject);
begin
  FCTotal_dotacion.Close;
end;

end.
