unit FC_Codigos_postales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Grids,
  DBGrids, DBCtrls;

type
  TFC_CP = class(TForm)
    ZQcp: TZQuery;
    DScp: TDataSource;
    GridCP: TDBGrid;
    Label1: TLabel;
    buscar: TEdit;
    municipios: TDBLookupComboBox;
    DSmunicipios: TDataSource;
    ZQmunicipios: TZQuery;
    Label2: TLabel;
    descripcion: TEdit;
    Button2: TButton;
    ZQup: TZQuery;
    procedure FormShow(Sender: TObject);
    procedure municipiosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure buscarKeyPress(Sender: TObject; var Key: Char);
    procedure municipiosClick(Sender: TObject);
    procedure descripcionKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure GridCPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FC_CP: TFC_CP;

implementation

{$R *.dfm}

procedure TFC_CP.municipiosClick(Sender: TObject);
begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp where municipio="'+municipios.Text+'"');
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;
end;

procedure TFC_CP.municipiosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp where municipio="'+municipios.Text+'"');
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;
end;

procedure TFC_CP.buscarKeyPress(Sender: TObject; var Key: Char);
begin
{Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789,-'+chr(7)+chr(8)+chr(13), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
if (key = #13) then
   begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp where CP='+buscar.Text);
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;
   end;
end;

procedure TFC_CP.Button2Click(Sender: TObject);
begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp where Descripcion like "%'+descripcion.Text+'%"');
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;
end;

procedure TFC_CP.descripcionKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
   begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp where Descripcion like "%'+descripcion.Text+'%"');
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;
   end;
end;

procedure TFC_CP.FormShow(Sender: TObject);
begin
  ZQcp.Close;
  ZQcp.SQL.Clear;
  ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp');
  ZQcp.ExecSQL;
  ZQcp.Open;
  GridCP.Refresh;

end;

procedure TFC_CP.GridCPKeyPress(Sender: TObject; var Key: Char);
var
fila,columna:integer;
begin
   if (key = #13) then
   begin
     columna:=GridCP.SelectedIndex;
     fila:=ZQcp.RecNo;
     ZQup.Close;
     ZQup.SQL.Clear;
     Zqup.SQL.Add('Update c_cp Set ruta='+GridCP.Fields[1].AsString+',descripcion="'+GridCP.Fields[2].AsString+'",tipocolonia="'+GridCP.Fields[3].AsString+'",municipio="'+GridCP.Fields[4].AsString+'" where id_descripcion='+GridCP.Fields[5].AsString);
     Zqup.ExecSQL;
     ZQup.Close;
     ZQcp.Close;
     ZQcp.SQL.Clear;
     ZQcp.SQL.Add('Select CP,ruta,Descripcion,TipoColonia,Municipio,id_descripcion from c_cp');
     ZQcp.ExecSQL;
     ZQcp.Open;
     GridCP.Refresh;
     GridCP.SelectedIndex:=columna;
     ZQcp.RecNo:=fila;
   end;
end;

end.
