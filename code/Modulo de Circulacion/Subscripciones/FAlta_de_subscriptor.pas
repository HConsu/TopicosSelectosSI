unit FAlta_de_subscriptor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ZAbstractTable, ZDataset, DB,
  ZAbstractRODataset, ZAbstractDataset, ZConnection, ComCtrls, StdCtrls,
  DBCtrls, ZAbstractConnection, Menus, jpeg, ExtCtrls;

type
  TFAlta_subscriptor = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NoSubscriptor: TEdit;
    Titular: TEdit;
    Fecha_Alta: TDateTimePicker;
    RFC: TEdit;
    email: TEdit;
    checkempleado: TCheckBox;
    calle: TEdit;
    ciudad: TEdit;
    cp: TEdit;
    Label12: TLabel;
    NoEmpleadotext: TEdit;
    ZQ_Subscriptores: TZQuery;
    Agente_de_ventas: TDBLookupComboBox;
    ZTable1: TZTable;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Label13: TLabel;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Label14: TLabel;
    Button4: TButton;
    colonia: TEdit;
    ZQb: TZQuery;
    procedure checkempleadoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cpKeyPress(Sender: TObject; var Key: Char);
    procedure Salir1Click(Sender: TObject);
    procedure TitularKeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlta_subscriptor: TFAlta_subscriptor;

implementation

uses FAlta_Subscripciones, F_BuscarCP,FPrincipal;

{$R *.dfm}



procedure TFAlta_subscriptor.checkempleadoClick(Sender: TObject);
begin
 if checkempleado.Checked = TRUE then
    NoEmpleadotext.Enabled := TRUE;
 if checkempleado.Checked = FALSE then
    NoEmpleadotext.Enabled := FALSE;
    NoEmpleadotext.Text := '';
end;

procedure TFAlta_subscriptor.cpKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFAlta_subscriptor.Button1Click(Sender: TObject);
var
fechaalta : String;
begin
   if titular.Text = '' then
      begin
      ShowMessage('No puede estar vacio el campo Titular verifique para continuar');
      end;
   if calle.Text = '' then
      begin
      ShowMessage('No puede estar vacio el campo calle verifique para continuar');
      end;
   if colonia.Text = '' then
      begin
      ShowMessage('No puede estar vacio el campo colonia verifique para continuar');
      end;
   if ciudad.Text = '' then
      begin
      ShowMessage('No puede estar vacio el campo ciudad verifique para continuar');
      end;
   if cp.Text = '' then
      begin
      ShowMessage('No puede estar vacio el campo CP verifique para continuar');
      end;
   if (titular.Text <> '')AND(calle.text <> '')AND(colonia.Text <> '')AND(ciudad.text <> '')AND(cp.text <>'') then
       begin
       fechaalta := FormatDateTime('yyyy-mm-dd',Fecha_alta.Date);
       ZQ_Subscriptores.Close;
       ZQ_Subscriptores.SQL.Clear;
       ZQ_Subscriptores.SQL.Add('Insert into t_cliente_subscriptor (Titular,Fecha_alta,RFC,email,Calle,Colonia,Ciudad,Agente_de_ventas,Empleado_UAEH,CP,NoEmpleadoUAEH)Values ("'+Titular.text+'","'+fechaalta+'","'+RFC.Text+'","'+email.Text+'","'+Calle.Text+'","'+Colonia.Text+'","'+Ciudad.Text+'",'+IntToStr(Agente_de_ventas.KeyValue)+',"'+BoolToStr(checkempleado.Checked)+'",'+CP.Text+',"'+NoEmpleadotext.Text+'")');
       ZQ_Subscriptores.ExecSQL;
       ZQ_Subscriptores.Close;
         {------------Bitacora-----------------------------------------}
        ZQb.Close;
        ZQb.SQL.Clear;
        ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se dio de alta el subscriptor '+titular.Text+' con no:'+nosubscriptor.Text+'","Jefe de circulacion")');
        ZQb.ExecSQL;
        ZQb.Close;
       {------------Bitacora-----------------------------------------}

       ShowMessage('El Subscriptor fue dado de alta correctamente');

       if application.MessageBox (pchar('�Desea dar de alta otro subscriptor?'), pchar('Nuevo subscriptor'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
             titular.Text:='';
             rfc.Text:='';
             email.Text:='';
             calle.Text:='';
             //colonia.Text:='';
             Ciudad.Text:='';
             CP.Text:='';
             checkempleado.Checked := FALSE;
           end
            else
              FAlta_Subscriptor.Close;
           end;


end;

procedure TFAlta_subscriptor.Button2Click(Sender: TObject);
begin
    FAlta_subscriptor.Close;
end;

procedure TFAlta_subscriptor.Button3Click(Sender: TObject);
begin
  FSubscripciones.Enabled := FALSE;
  FSubscripciones := TFSubscripciones.Create(self);
  FSubscripciones.ShowModal;
end;

procedure TFAlta_subscriptor.Button4Click(Sender: TObject);
begin
 FPrincipalCirculacion.quienllamacp:=1;
 FbuscarCP.Enabled:=FALSE;
 FbuscarCP := TFbuscarCP.Create(self);
 FbuscarCP.ShowModal;
end;

procedure TFAlta_subscriptor.FormShow(Sender: TObject);
begin
    Fecha_alta.Date := NOW;
    ZQ_Subscriptores.Close;
    ZQ_Subscriptores.SQL.Clear;
    ZQ_Subscriptores.SQL.Add('Select MAX(id_subscriptor+1)AS no from t_cliente_subscriptor');
    ZQ_Subscriptores.ExecSQL;
    ZQ_Subscriptores.Open;
    NoSubscriptor.Text:=(ZQ_Subscriptores.FieldByName('no').AsString);
    ZQ_subscriptores.Close;
end;

procedure TFAlta_subscriptor.Salir1Click(Sender: TObject);
begin
   FAlta_Subscriptor.Close;
end;

procedure TFAlta_subscriptor.TitularKeyPress(Sender: TObject; var Key: Char);
begin
{Revisamos que en el campo atencion no se introduscan numeros}
  if not (key in [' ','a'..'z','�','�','A'..'Z', #7, #8, #13]) then
   begin
     Key := #0;
     Beep;
   end;
end;

end.