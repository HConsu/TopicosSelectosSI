unit FModificar_subscriptor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, jpeg, ExtCtrls, ComCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, DBCtrls;

type
  TFModif_subscriptor = class(TForm)
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Aceptar: TButton;
    Button2: TButton;
    nosubscriptor: TEdit;
    titular: TEdit;
    rfc: TEdit;
    email: TEdit;
    calle: TEdit;
    ciudad: TEdit;
    cp: TEdit;
    agenteventas: TEdit;
    noempleado: TEdit;
    checkempleado: TCheckBox;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Salir1: TMenuItem;
    Label13: TLabel;
    ZQmodificar: TZQuery;
    fechaalta: TEdit;
    colonia: TEdit;
    Button1: TButton;
    ZQb: TZQuery;
    procedure Button2Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure cpKeyPress(Sender: TObject; var Key: Char);
    procedure titularKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FModif_subscriptor: TFModif_subscriptor;

implementation

{$R *.dfm}
uses
fAlta_subscripciones,Fprincipal,F_buscarCP;

procedure TFModif_subscriptor.AceptarClick(Sender: TObject);
begin
   ZQModificar.Close;
   ZQModificar.SQL.Clear;
   ZQModificar.SQL.Add('update t_cliente_subscriptor set titular="'+titular.Text+'",rfc="'+rfc.Text+'",email="'+email.Text+'",calle="'+calle.text+'",colonia="'+colonia.text+'",cp='+cp.Text+',ciudad="'+ciudad.Text+'",noempleadouaeh="'+noempleado.Text+'"  Where id_subscriptor='+nosubscriptor.Text);
   ZQModificar.ExecSQL;
  {------------Bitacora-----------------------------------------}
        ZQb.Close;
        ZQb.SQL.Clear;
        ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se modifico el subscriptor '+titular.Text+' no:'+nosubscriptor.Text+',calle:'+calle.Text+',colonia:'+colonia.Text+'","Jefe de circulacion")');
        ZQb.ExecSQL;
        ZQb.Close;
   {------------Bitacora-----------------------------------------}
   ShowMessage('Se actualizaron los datos del subscriptor');
   FModif_Subscriptor.Close;

end;

procedure TFModif_subscriptor.Button1Click(Sender: TObject);
begin
  FPrincipalCirculacion.quienllamacp:=3;
  FBuscarCP.Enabled:=FALSE;
  FBuscarCP := TFBuscarCP.Create(Self);
  FbuscarCP.ShowModal;
end;

procedure TFModif_subscriptor.Button2Click(Sender: TObject);
begin
   FModif_subscriptor.Close;
end;

procedure TFModif_subscriptor.cpKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFModif_subscriptor.FormShow(Sender: TObject);
var
agentedeventas:integer;
esempleado:string;
subscriptor:String;
begin
    subscriptor:= FAlta_subscripciones.FSubscripciones.DBGridSubscriptor.Fields[0].AsString;
    ZQmodificar.Close;
    ZQmodificar.SQL.Clear;
    ZQmodificar.SQL.Add('Select * from t_cliente_subscriptor where id_subscriptor='+subscriptor );
    ZQmodificar.ExecSQL;
    ZQModificar.Open;
    nosubscriptor.Text:=ZQmodificar.FieldByName('id_subscriptor').AsString;
    titular.Text:= ZQmodificar.FieldByName('titular').AsString;
    fechaalta.Text:=ZQmodificar.FieldByName('fecha_alta').AsString;
    rfc.Text:=ZQmodificar.FieldByName('rfc').AsString;
    email.Text:=ZQmodificar.FieldByName('email').AsString;
    calle.Text:=ZQmodificar.FieldByName('calle').AsString;
    colonia.text:=ZQModificar.FieldByName('colonia').AsString;
    cp.Text:=ZQModificar.FieldByName('cp').AsString;
    ciudad.Text:=ZQmodificar.FieldByName('ciudad').AsString;
    agentedeventas:=ZQModificar.FieldByName('agente_de_ventas').AsInteger;
    noempleado.Text:=ZQModificar.FieldByName('noempleadouaeh').AsString;
    esempleado:=ZQModificar.FieldByName('empleado_uaeh').AsString;
    ZQmodificar.Close;
    ZQmodificar.SQL.Clear;
    ZQmodificar.SQL.Add('Select nombre from c_agente_ventas where id_agente='+IntToStr(agentedeventas));
    ZQmodificar.ExecSQL;
    ZQmodificar.Open;
    agenteventas.Text:=ZQmodificar.FieldByName('nombre').AsString;
      if esempleado='-1' then
          begin
        checkempleado.Checked:=TRUE;
          end;
      if esempleado='0' then
         begin
        checkempleado.Checked:=FALSE;
         end;


end;

procedure TFModif_subscriptor.Salir1Click(Sender: TObject);
begin
   FModif_subscriptor.Close;
end;

procedure TFModif_subscriptor.titularKeyPress(Sender: TObject; var Key: Char);
begin
{Revisamos que en el campo atencion no se introduscan numeros}
  if not (key in [' ','a'..'z','�','�','A'..'Z', #7, #8, #13]) then
   begin
     Key := #0;
     Beep;
   end;
end;

end.