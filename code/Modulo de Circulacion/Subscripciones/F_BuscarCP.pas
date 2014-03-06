unit F_BuscarCP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, DBCtrls;

type
  TFbuscarCP = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    alta: TButton;
    GridCP: TDBGrid;
    cp: TEdit;
    colonia: TEdit;
    ZQbuscar: TZQuery;
    DSbuscar: TDataSource;
    ZQalta: TZQuery;
    Label3: TLabel;
    municipio: TDBLookupComboBox;
    ZQmunicipio: TZQuery;
    DSmunicipio: TDataSource;
    nuevo: TCheckBox;
    Button1: TButton;
    procedure cpKeyPress(Sender: TObject; var Key: Char);
    procedure cpKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure coloniaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure altaClick(Sender: TObject);
    procedure municipioClick(Sender: TObject);
    procedure municipioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nuevoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FbuscarCP: TFbuscarCP;

implementation

{$R *.dfm}
Uses
Fprincipal,FAlta_de_subscriptor,FNuevaSubscripcion,FModificar_Subscriptor,F_Modificar_subscripcion;

procedure TFbuscarCP.altaClick(Sender: TObject);
begin

 if ((cp.Text<>'')and (colonia.Text <>'') and (municipio.Text<>''))then
    begin
   ZQalta.Close;
   ZQalta.SQL.Clear;
   ZQalta.SQL.Add('Insert into c_cp (cp,descripcion,municipio) values ('+cp.Text+',"'+colonia.Text+'","'+municipio.Text+'")');
   ZQalta.ExecSQL;
   ShowMessage('Se dio de alta la colonia '+Colonia.Text+' con el CP '+cp.Text);
   ZQbuscar.Close;
   ZQbuscar.SQL.Clear;
   ZQbuscar.SQL.Add('Select CP,Descripcion,municipio,tipoColonia from c_cp where cp ='+cp.Text);
   ZQBuscar.ExecSQL;
   ZQBuscar.Open;
   GridCP.Refresh;
    end
  else begin
    ShowMessage('Debe indicar todos los datos para dar de alta');
  end;

end;


procedure TFbuscarCP.Button1Click(Sender: TObject);
begin
   if FPrincipalCirculacion.quienllamacp=1 then
      begin
        FAlta_subscriptor.cp.Text:=Gridcp.Fields[0].AsString;
        FAlta_subscriptor.colonia.Text:=Gridcp.Fields[1].AsString;
        FAlta_subscriptor.ciudad.Text:=Gridcp.Fields[2].AsString;
        FBuscarCP.Close;
      end;
   if FPrincipalCirculacion.quienllamacp=2 then
      begin
        FNueva_Subscripcion.cp.Text:=Gridcp.Fields[0].AsString;
        FNueva_Subscripcion.colonia.Text:=Gridcp.Fields[1].AsString;
        FNueva_Subscripcion.ciudad.Text:=Gridcp.Fields[2].AsString;
        FBuscarCP.Close;
      end;
    if FPrincipalCirculacion.quienllamacp=3 then
      begin
        FModif_subscriptor.cp.Text:=Gridcp.Fields[0].AsString;
        FModif_subscriptor.colonia.Text:=Gridcp.Fields[1].AsString;
        FModif_subscriptor.ciudad.Text:=Gridcp.Fields[2].AsString;
        FBuscarCP.Close;
      end;
    if FPrincipalCirculacion.quienllamacp=4 then
      begin
        FModificar_Subscripcion.cp.Text:=Gridcp.Fields[0].AsString;
        FModificar_Subscripcion.colonia.Text:=Gridcp.Fields[1].AsString;
        FModificar_Subscripcion.ciudad.Text:=Gridcp.Fields[2].AsString;
        FBuscarCP.Close;
      end;


end;

procedure TFbuscarCP.coloniaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if nuevo.Checked=FALSE then
   begin
 cp.Text:='';
 municipio.KeyValue:=0;
 ZQbuscar.Close;
 ZQbuscar.SQL.Clear;
 ZQbuscar.SQL.Add('Select CP,Descripcion,municipio,tipoColonia from c_cp where Descripcion like "%'+colonia.Text+'%"');
 ZQBuscar.ExecSQL;
 ZQBuscar.Open;
 GridCP.Refresh;
   end;
end;

procedure TFbuscarCP.cpKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;

end;

procedure TFbuscarCP.cpKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if nuevo.Checked=FALSE then
   begin
 if cp.Text <> '' then
    begin
 colonia.Text:='';
 municipio.KeyValue:=0;
 ZQbuscar.Close;
 ZQbuscar.SQL.Clear;
 ZQbuscar.SQL.Add('Select CP,Descripcion,municipio,tipoColonia from c_cp where cp ='+cp.Text);
 ZQBuscar.ExecSQL;
 ZQBuscar.Open;
 GridCP.Refresh;
    end;
  end;
end;

procedure TFbuscarCP.municipioClick(Sender: TObject);
begin
if nuevo.Checked=FALSE then
   begin
 colonia.Text:='';
 ZQbuscar.Close;
 ZQbuscar.SQL.Clear;
 ZQbuscar.SQL.Add('Select CP,Descripcion,municipio,tipoColonia from c_cp where municipio ="'+municipio.Text+'"');
 ZQBuscar.ExecSQL;
 ZQBuscar.Open;
 GridCP.Refresh;
   end;
end;

procedure TFbuscarCP.municipioKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if nuevo.Checked=FALSE then
   begin
 colonia.Text:='';
 ZQbuscar.Close;
 ZQbuscar.SQL.Clear;
 ZQbuscar.SQL.Add('Select CP,Descripcion,municipio,tipoColonia from c_cp where municipio ="'+municipio.Text+'"');
 ZQBuscar.ExecSQL;
 ZQBuscar.Open;
 GridCP.Refresh;
   end;
end;

procedure TFbuscarCP.nuevoClick(Sender: TObject);
begin
    if nuevo.Checked=TRUE then
      begin
      alta.Enabled:=TRUE;
      end;
    if nuevo.Checked=FALSE then
      begin
        alta.Enabled:=FALSE;
      end;
end;

end.