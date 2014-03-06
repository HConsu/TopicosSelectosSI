unit FC_Vendedores_zocalo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, Grids, DBGrids, DBCtrls;

type
  TFCVendedoresZocalo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    estatus: TComboBox;
    Label9: TLabel;
    Button1: TButton;
    Gridvendedores: TDBGrid;
    Button3: TButton;
    ZTditZocalo: TZTable;
    DSDitZocalo: TDataSource;
    Image1: TImage;
    observaciones: TMemo;
    codigo: TEdit;
    nombre: TEdit;
    dotacion: TEdit;
    tarifa: TEdit;
    telefono: TEdit;
    ZQtipocirculacion: TZQuery;
    DStipo: TDataSource;
    buscar: TEdit;
    Label10: TLabel;
    Button5: TButton;
    aceptarnuevo: TButton;
    ZQnuevo: TZQuery;
    Label4: TLabel;
    ubicacion: TEdit;
    Button2: TButton;
    Modificar: TButton;
    procedure buscarKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridvendedoresCellClick(Column: TColumn);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure aceptarnuevoClick(Sender: TObject);
    procedure tarifaKeyPress(Sender: TObject; var Key: Char);
    procedure actualizargrid();
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GridvendedoresDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ModificarClick(Sender: TObject);
    procedure GridvendedoresKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridvendedoresMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCVendedoresZocalo: TFCVendedoresZocalo;

implementation

{$R *.dfm}

Uses
Fprincipal;

procedure TFCVendedoresZocalo.aceptarnuevoClick(Sender: TObject);
var
est:string;
begin
 if nombre.Text<>'' then
    begin
  if estatus.Text='Activo' then
      begin
        est:='1';
      end;
  if estatus.Text='Inactivo' then
     begin
       est:='0';
     end;

if application.MessageBox (pchar('¿Esta seguro que desea dar de alta este vendedor?'), pchar('Nuevo vendedor'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
        ZQnuevo.Close;
        ZQnuevo.SQL.Clear;
        ZQnuevo.SQL.Add('Insert into c_proveedores_zocalo (id_proveedor,nombre,ubicacion,dotacion,tarifa,telefono,observaciones,estatus) VALUES('+codigo.text+',"'+nombre.text+'","'+ubicacion.text+'",'+dotacion.text+','+tarifa.text+',"'+telefono.text+'","'+observaciones.text+'",'+est+')');
        ZQnuevo.ExecSQL;
        actualizargrid();
        aceptarnuevo.Enabled:=FALSE;
        ShowMessage('Se agrego el nuevo vendedor');
           end;
    end
    else begin
      ShowMessage('Hacen falta datos, Verifique por favor');
    end;
end;

procedure TFCVendedoresZocalo.buscarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 filtro:String;
begin
  filtro:='nombre LIKE '+quotedstr('*'+buscar.Text+'*');
  ZTditZocalo.Filter:=filtro;
  ZTditZocalo.Filtered:=TRUE;
end;

procedure TFCVendedoresZocalo.Button1Click(Sender: TObject);
begin
   codigo.Text:='';
   nombre.Text:='';
   dotacion.Text:='0';
   tarifa.Text:='0';
   telefono.Text:='0';
   observaciones.Text:='';
   ubicacion.Text:='';
   estatus.Text:='Activo';

   ZQnuevo.Close;
   ZQnuevo.SQL.Clear;
   ZQNuevo.SQL.Add('Select Max(id_proveedor)as ID from c_proveedores_zocalo');
   ZQNuevo.ExecSQL;
   ZQnuevo.Open;
   codigo.Text:=IntToStr(ZQnuevo.FieldByName('ID').AsInteger+1);
   aceptarnuevo.Enabled:=TRUE;


end;

procedure TFCVendedoresZocalo.Button2Click(Sender: TObject);
begin
if application.MessageBox (pchar('¿ESTA SEGURO QUE DESEA ELIMINAR ESTE VENDEDOR?, SE RECOMIENDA NO ELIMINAR, EN SU LUGAR MÁRQUELO COMO "INACTIVO"'), pchar('Eliminar vendedor'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
             ZQnuevo.Close;
             ZQnuevo.SQL.Clear;
             ZQnuevo.SQL.Add('Delete from c_proveedores_zocalo where id_proveedor='+GridVendedores.Fields[0].AsString);
             ZQNuevo.ExecSQL;
             actualizargrid();
             ShowMessage('Se elimino el vendedor');
           end;
end;

procedure TFCVendedoresZocalo.Button3Click(Sender: TObject);
begin
   codigo.Text:='';
   nombre.Text:='';
   dotacion.Text:='0';
   tarifa.Text:='0';
   telefono.Text:='0';
   observaciones.Text:='';
   ubicacion.Text:='';
   estatus.Text:='Activo';
   Aceptarnuevo.Enabled:=FALSE;
end;

procedure TFCVendedoresZocalo.Button5Click(Sender: TObject);
begin
  ZTditZocalo.Filtered:=FALSE;
  GridVendedores.Refresh;
end;

procedure TFCVendedoresZocalo.GridvendedoresCellClick(Column: TColumn);
begin
    codigo.Text:=GridVendedores.Fields[0].AsString;
    nombre.Text:=GridVendedores.Fields[1].AsString;
    dotacion.Text:=GridVendedores.Fields[3].AsString;
    tarifa.Text:=GridVendedores.Fields[4].AsString;

    if GridVendedores.Fields[7].AsInteger=1 then
       begin
         estatus.Text:='Activo';
       end;
    if GridVendedores.Fields[7].AsInteger=0 then
       begin
         estatus.Text:='Inactivo';
       end;
   telefono.Text:=GridVendedores.Fields[5].AsString;
   observaciones.Text:=GridVendedores.Fields[6].AsString;
   ubicacion.Text:=GridVendedores.Fields[2].AsString;


end;

procedure TFCVendedoresZocalo.GridvendedoresDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (Gridvendedores.Fields[7].AsFloat) = 0 then
           begin
          Gridvendedores.Canvas.Brush.Color := clRed;
          // Manda pintar la celda
          Gridvendedores.DefaultDrawColumnCell(rect,DataCol,Column,State);
           end;
end;

procedure TFCVendedoresZocalo.GridvendedoresKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   codigo.Text:=GridVendedores.Fields[0].AsString;
    nombre.Text:=GridVendedores.Fields[1].AsString;
    dotacion.Text:=GridVendedores.Fields[3].AsString;
    tarifa.Text:=GridVendedores.Fields[4].AsString;

    if GridVendedores.Fields[7].AsInteger=1 then
       begin
         estatus.Text:='Activo';
       end;
    if GridVendedores.Fields[7].AsInteger=0 then
       begin
         estatus.Text:='Inactivo';
       end;
   telefono.Text:=GridVendedores.Fields[5].AsString;
   observaciones.Text:=GridVendedores.Fields[6].AsString;
   ubicacion.Text:=GridVendedores.Fields[2].AsString;
end;

procedure TFCVendedoresZocalo.GridvendedoresMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
   codigo.Text:=GridVendedores.Fields[0].AsString;
    nombre.Text:=GridVendedores.Fields[1].AsString;
    dotacion.Text:=GridVendedores.Fields[3].AsString;
    tarifa.Text:=GridVendedores.Fields[4].AsString;

    if GridVendedores.Fields[7].AsInteger=1 then
       begin
         estatus.Text:='Activo';
       end;
    if GridVendedores.Fields[7].AsInteger=0 then
       begin
         estatus.Text:='Inactivo';
       end;
   telefono.Text:=GridVendedores.Fields[5].AsString;
   observaciones.Text:=GridVendedores.Fields[6].AsString;
   ubicacion.Text:=GridVendedores.Fields[2].AsString;
end;

procedure TFCVendedoresZocalo.ModificarClick(Sender: TObject);
var
est:string;
begin
 if nombre.Text<>'' then
    begin
  if estatus.Text='Activo' then
      begin
        est:='1';
      end;
  if estatus.Text='Inactivo' then
     begin
       est:='0';
     end;

if application.MessageBox (pchar('¿ESTA SEGURO QUE DESEA APLICAR LOS CAMBIOS?'), pchar('MODIFICAR VENDEDOR'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
        ZQnuevo.Close;
        ZQnuevo.SQL.Clear;
        ZQnuevo.SQL.Add('Update c_proveedores_zocalo SET nombre="'+nombre.text+'",ubicacion="'+ubicacion.text+'",dotacion='+dotacion.text+',tarifa='+tarifa.text+',telefono="'+telefono.text+'",observaciones="'+observaciones.text+'",estatus='+est+' where id_proveedor='+codigo.text+')');
        ZQnuevo.ExecSQL;
        actualizargrid();
        aceptarnuevo.Enabled:=FALSE;
        ShowMessage('Se modificaron los datos del vendedor');
           end;
    end;
end;

procedure TFCVendedoresZocalo.tarifaKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789.'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFCVendedoresZocalo.actualizargrid();
  begin
  ZTditZocalo.Refresh;
  GridVendedores.Refresh;
  end;

end.
