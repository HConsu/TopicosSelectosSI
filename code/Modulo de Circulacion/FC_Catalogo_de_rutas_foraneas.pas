unit FC_Catalogo_de_rutas_foraneas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, ExtCtrls, DBCtrls, StdCtrls, Mask, Grids, DBGrids, jpeg, Menus;

type
  TFC_Rutas_foraneas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DSRutaf: TDataSource;
    DBGrid1: TDBGrid;
    Noruta: TDBEdit;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    ZQchofer: TZQuery;
    ZTrutasf: TZTable;
    Label6: TLabel;
    DBGridChofer: TDBGrid;
    Asignar: TButton;
    DSchofer: TDataSource;
    ZQtmp: TZQuery;
    Image1: TImage;
    Button1: TButton;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    procedure AsignarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FC_Rutas_foraneas: TFC_Rutas_foraneas;

implementation

{$R *.dfm}

procedure TFC_Rutas_foraneas.AsignarClick(Sender: TObject);
var
nombreruta:String;
begin
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select Nombre_ruta from c_rutas_foraneas where nochofer ='+DbGridChofer.Fields[0].AsString);
  ZQtmp.ExecSQL;
  Zqtmp.Open;
// ShowMessage('No esta en otra ruta'+DbGridChofer.Fields[0].AsString);

 {----------------verificamos si el chofer ya esta asignado a otra ruta-------------------}
if (ZQtmp.FieldByName('Nombre_ruta').IsNull = TRUE) then
     begin
    //ShowMessage('Primer if');
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas_foraneas SET NoChofer ='+DbGridChofer.Fields[0].AsString+' Where no_ruta='+Dbgrid1.Fields[0].AsString);
    ZQtmp.ExecSQL;
    //ShowMessage('despues de insert ');
    ShowMessage('Se actualizo la ruta '+noruta.Text+' con el Chofer '+DbGridChofer.Fields[1].AsString);
    ZTrutasf.Close;
    ZTrutasf.Open;
    ZTrutasf.Active:=TRUE;
    DbGrid1.Refresh;
     end
 else begin
   nombreruta:=ZQtmp.FieldByName('Nombre_ruta').AsString;
  if application.MessageBox (pchar('El Chofer ya esta asigando a la ruta '+nombreruta+' desea modificar su asignacion a la ruta '+dbedit2.Text+'?'), pchar('Confirmar cambio de ruta'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas_foraneas SET NoChofer =0 Where Nochofer='+DbGridChofer.Fields[0].AsString);
    ZQtmp.ExecSQL;
   // ShowMessage('Primer update');
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas_foraneas SET NoChofer ='+DbGridChofer.Fields[0].AsString+' Where no_ruta='+Dbgrid1.Fields[0].AsString);
  //  ShowMessage('Segundo Update');
    ZQtmp.ExecSQL;
    ShowMessage('Se actualizo la ruta '+noruta.Text+' con el Chofer '+DbGridChofer.Fields[1].AsString);
    ZTrutasf.Close;
    ZTrutasf.Open;
    ZTrutasf.Active:=TRUE;
    DbGrid1.Refresh;
      end;
    end;

end;


procedure TFC_Rutas_foraneas.Button1Click(Sender: TObject);
begin
   FC_Rutas_foraneas.Close;
end;

procedure TFC_Rutas_foraneas.Salir1Click(Sender: TObject);
begin
FC_Rutas_foraneas.Close;
end;

end.
