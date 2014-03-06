unit FC_Tipo_de_circulacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Mask;

type
  TFCTipo_Circulacion = class(TForm)
    ID: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ZTable1: TZTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCTipo_Circulacion: TFCTipo_Circulacion;

implementation

{$R *.dfm}

end.
