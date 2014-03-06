unit Flogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection;

type
  TFPassword = class(TForm)
    Label1: TLabel;
    nombre: TEdit;
    Label2: TLabel;
    password: TEdit;
    Button1: TButton;
    ZConnection1: TZConnection;
    ZQpassword: TZQuery;
    ZQbitacora: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure passwordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    usuario:integer;
    administrador:integer;
  end;

var
  FPassword: TFPassword;

implementation

{$R *.dfm}
Uses
Fprincipal_publicidad;

procedure TFPassword.Button1Click(Sender: TObject);
begin
   ZQpassword.Close;
   ZQpassword.SQL.Clear;
   ZQpassword.SQL.Add('Select id_usuario,Administrador from t_usuario_ventas where nombre="'+nombre.Text+'" AND password="'+password.Text+'"');
   ZQpassword.ExecSQL;
   ZQpassword.Open;
   if ZQpassword.FieldByName('id_usuario').IsNull=TRUE then
         begin
           ShowMessage('Datos incorrectos, verifique por favor.');
               ZQbitacora.Close;
               ZQbitacora.SQL.Clear;
               ZQBitacora.SQL.Add('Insert into b_movimientos_publicidad (movimiento,usuario) VALUES("Fallo el inicio de sesion","'+nombre.Text+'")');
               ZQBitacora.ExecSQL;
               ZQBitacora.Close;
         end
    else begin
       usuario:=ZQpassword.FieldByName('id_usuario').AsInteger;
       administrador:=ZQPassword.FieldByName('Administrador').AsInteger;
        ZQbitacora.SQL.Clear;
        ZQBitacora.SQL.Add('Insert into b_movimientos_publicidad (movimiento,usuario) VALUES("Inicio de sesion","'+nombre.Text+'")');
        ZQBitacora.ExecSQL;
        ZQBitacora.Close;

       FPassword.Visible:=FALSE;
       FPrincipalPublicidad.Enabled:=FALSE;
       FPrincipalPublicidad := TFPrincipalPublicidad.Create(self);
       FPrincipalPublicidad.ShowModal;

    end;

end;

procedure TFPassword.passwordKeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then
       begin
          ZQpassword.Close;
   ZQpassword.SQL.Clear;
   ZQpassword.SQL.Add('Select id_usuario,Administrador from t_usuario_ventas where nombre="'+nombre.Text+'" AND password="'+password.Text+'"');
   ZQpassword.ExecSQL;
   ZQpassword.Open;
     if ZQpassword.FieldByName('id_usuario').IsNull=TRUE then
         begin
           ShowMessage('Datos incorrectos, verifique por favor.');
            ZQbitacora.Close;
            ZQbitacora.SQL.Clear;
            ZQBitacora.SQL.Add('Insert into b_movimientos_publicidad (movimiento,usuario) VALUES("Fallo el inicio de sesion","'+nombre.Text+'")');
            ZQBitacora.ExecSQL;
            ZQBitacora.Close;
         end
    else begin
       usuario:=ZQpassword.FieldByName('id_usuario').AsInteger;
       administrador:=ZQPassword.FieldByName('Administrador').AsInteger;
       ZQbitacora.SQL.Clear;
       ZQBitacora.SQL.Add('Insert into b_movimientos_publicidad (movimiento,usuario) VALUES("Inicio de sesion","'+nombre.Text+'")');
       ZQBitacora.ExecSQL;
       ZQBitacora.Close;
       FPassword.Visible:=FALSE;
       FPrincipalPublicidad.Enabled:=FALSE;
       FPrincipalPublicidad := TFPrincipalPublicidad.Create(self);
       FPrincipalPublicidad.ShowModal;
    end;
       end;
end;

end.
