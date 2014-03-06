unit FCCatalogo_de_edificios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, Grids, DBGrids, StdCtrls, Mask, Menus, pBarcode,
  pCode128, pEAN128;

type
  TFCEdificios = class(TForm)
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGridedificio: TDBGrid;
    ZTEdificio: TZTable;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGridmetro: TDBGrid;
    DSrutasmetro: TDataSource;
    ZTRutasmetro: TZTable;
    ZTrutasforaneas: TZTable;
    DSrutasforaneas: TDataSource;
    DBGridfor: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    asignarm: TButton;
    asignarf: TButton;
    Label5: TLabel;
    salir: TButton;
    ZQasignarm: TZQuery;
    ZQasignarf: TZQuery;
    DBText1: TDBText;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    fullcodigo: TDBText;
    Button1: TButton;
    Barcode: TBarcode_EAN128;
    ZQtmp: TZQuery;
    Button2: TButton;
    ZQprepara: TZQuery;
    Button3: TButton;
    procedure Salir1Click(Sender: TObject);
    procedure salirClick(Sender: TObject);
    procedure asignarmClick(Sender: TObject);
    procedure asignarfClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCEdificios: TFCEdificios;

implementation

{$R *.dfm}
Uses
FPrincipal;

procedure TFCEdificios.salirClick(Sender: TObject);
begin
     FCEdificios.Close;
end;

procedure TFCEdificios.asignarfClick(Sender: TObject);
var
nombreruta:String;
begin
 nombreruta:=DBGridfor.Fields[1].AsString;
  //ShowMessage(nombreruta);
    ZQAsignarf.Close;
    ZQAsignarf.SQl.Clear;
    ZQAsignarf.SQL.Add('Update c_edificios SET ruta="'+nombreruta+'" where id_edificio ='+DBGridEdificio.Fields[0].AsString);
    ZQAsignarf.ExecSQL;
    ZTEdificio.Refresh;
    DBGRidEdificio.Refresh;

end;

procedure TFCEdificios.asignarmClick(Sender: TObject);
var
nombreruta:String;
begin
  nombreruta:=DBGridmetro.Fields[1].AsString;
  //ShowMessage(nombreruta);

    ZQAsignarm.Close;
    ZQAsignarm.SQl.Clear;
    ZQAsignarm.SQL.Add('Update c_edificios SET ruta="'+DBGridmetro.Fields[0].AsString+'" where id_edificio ='+DBGridEdificio.Fields[0].AsString);
    ZQAsignarm.ExecSQL;
    ZTEdificio.Refresh;
    DBGRidEdificio.Refresh;


end;

procedure TFCEdificios.Button1Click(Sender: TObject);
var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin
  if Length(fullcodigo.Caption)<14 then
    begin

if Length(DBGridedificio.Fields[0].AsString)=3 then
      begin
        nosubscripcion:='0000000000'+DBGridedificio.Fields[0].AsString;
      end;
if Length(DBGridedificio.Fields[0].AsString)=2 then
      begin
        nosubscripcion:='00000000000'+DBGridedificio.Fields[0].AsString;
      end;
if Length(DBGridedificio.Fields[0].AsString)=1 then
      begin
        nosubscripcion:='000000000000'+DBGridedificio.Fields[0].AsString;
      end;

    {--------Concatenamos y agregamos el digito verificador---------}
    Codigo:=nosubscripcion;
    barcode.Barcode:=codigo;
    codigo:=barcode.FullEncoded;
    fullcodigo.Caption:=codigo;
    {------ Fin de generar codigo de barras---------------}


      ZQtmp.Close;
      ZQtmp.SQL.Clear;
      ZQtmp.SQL.Add('Update c_edificios SET codigo="'+fullcodigo.Caption+'" where id_edificio='+DBEdit1.Text);
      ZQtmp.ExecSQL;
      ZTEdificio.Refresh;
    end
  Else begin
    ShowMessage('Este codigo ya esta generado');
  end;

end;

procedure TFCEdificios.Button2Click(Sender: TObject);
var
i:Integer;
code:String;
begin
 code:=fullcodigo.Caption;

    {   verificamos que el codigo no este insertado ya }
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Select Codigo from t_codigos_imprimir where codigo="'+Code+'"');
       ZQPrepara.ExecSQL;
       ZQprepara.Open;

       if ZQPrepara.FieldByName('Codigo').IsNull=TRUE then
          begin
      { insertamos el codigo en la tabla para imprimir  }
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Insert into t_codigos_imprimir (Codigo) Values("'+Code+'")');
       ZQPrepara.ExecSQL;

          end;
end;

procedure TFCEdificios.Button3Click(Sender: TObject);
begin
if application.MessageBox (pchar('¿Esta seguro que desea limpiar la tabla de codigos para imprimir?'), pchar('Confirmar'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
       ZQPrepara.Close;
       ZQPrepara.SQL.Clear;
       ZQPrepara.SQL.Add('Delete from  t_codigos_imprimir');
       ZQPrepara.ExecSQL;
           end;
end;

procedure TFCEdificios.Salir1Click(Sender: TObject);
begin
   FCEdificios.Close;
end;

end.
