unit FImpHojasRuta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, DBCtrls, StdCtrls;

type
  TFimprimirrutas = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button4: TButton;
    Label8: TLabel;
    Button5: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DSMetro: TDataSource;
    DSEdificio: TDataSource;
    Label9: TLabel;
    Button6: TButton;
    DBLookupComboBox3: TDBLookupComboBox;
    DSforaneas: TDataSource;
    ZQmetro: TZQuery;
    ZQedificio: TZQuery;
    ZQforaneas: TZQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fimprimirrutas: TFimprimirrutas;

implementation

{$R *.dfm}
Uses
FPrincipal;

end.
