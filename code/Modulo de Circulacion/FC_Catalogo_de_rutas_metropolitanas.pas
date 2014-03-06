unit FC_Catalogo_de_rutas_metropolitanas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Mask, Menus, jpeg;

type
  TFC_rutas_metropolitanas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DSrutasmetro: TDataSource;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    ZQtmp: TZQuery;
    ZTrutasmetro: TZTable;
    ZQmoto: TZQuery;
    DSmoto: TDataSource;
    DBGrid2: TDBGrid;
    Image1: TImage;
    Label3: TLabel;
    Asignar: TButton;
    Salir: TButton;
    procedure Salir1Click(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure AsignarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FC_rutas_metropolitanas: TFC_rutas_metropolitanas;

implementation

{$R *.dfm}

procedure TFC_rutas_metropolitanas.AsignarClick(Sender: TObject);
var
nombreruta:String;
begin
  ZQtmp.Close;
  ZQtmp.SQL.Clear;
  ZQtmp.SQL.Add('Select Nombre_ruta from c_rutas where id_responsable_ruta ='+DbGrid2.Fields[0].AsString);
  ZQtmp.ExecSQL;
  Zqtmp.Open;
if (ZQtmp.FieldByName('Nombre_ruta').IsNull = TRUE) then
     begin
    //ShowMessage('Primer if');
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas SET id_responsable_ruta ='+DbGrid2.Fields[0].AsString+' Where no_ruta='+Dbgrid1.Fields[0].AsString);
    ZQtmp.ExecSQL;
   //ShowMessage('despues de insert ');
    ShowMessage('Se actualizo la ruta '+DBEdit2.Text+' con el Motociclista '+DbGrid2.Fields[1].AsString);
    ZTrutasmetro.Close;
    ZTrutasmetro.Open;
    ZTrutasmetro.Active:=TRUE;
    DbGrid1.Refresh;
     end
else begin
   nombreruta:=ZQtmp.FieldByName('Nombre_ruta').AsString;
  if application.MessageBox (pchar('El Motociclista ya esta asigando a la ruta '+nombreruta+' desea modificar su asignacion a la ruta '+dbedit2.Text+'?'), pchar('Confirmar cambio de ruta'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
      begin
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas SET id_responsable_ruta =0 Where id_responsable_ruta='+DbGrid2.Fields[0].AsString);
    ZQtmp.ExecSQL;
   // ShowMessage('Primer update');
    ZQtmp.Close;
    ZQtmp.SQL.Clear;
    ZQtmp.SQL.Add('Update c_rutas SET id_responsable_ruta ='+DbGrid2.Fields[0].AsString+' Where no_ruta='+Dbgrid1.Fields[0].AsString);
  //  ShowMessage('Segundo Update');
    ZQtmp.ExecSQL;
    ShowMessage('Se actualizo la ruta '+DBEdit2.Text+' Con el motociclista '+DbGrid2.Fields[1].AsString);
    ZTrutasmetro.Close;
    ZTrutasmetro.Open;
    ZTrutasmetro.Active:=TRUE;
    DbGrid1.Refresh;
      end;
    end;

end;

procedure TFC_rutas_metropolitanas.Salir1Click(Sender: TObject);
begin
  FC_rutas_metropolitanas.Close;
end;

procedure TFC_rutas_metropolitanas.SalirClick(Sender: TObject);
begin
FC_rutas_metropolitanas.Close;
end;

end.
