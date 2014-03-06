unit FLoginpass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection;

type
  TFlogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    nombre: TEdit;
    password: TEdit;
    Button1: TButton;
    ZConnection1: TZConnection;
    ZQpassword: TZQuery;
    ZQbitacora: TZQuery;
    procedure passwordKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    usuario:integer;
    administrador:integer;
  end;

var
  Flogin: TFlogin;

implementation

{$R *.dfm}
Uses
Fprincipal;

procedure TFlogin.Button1Click(Sender: TObject);
begin
  ZQpassword.Close;
   ZQpassword.SQL.Clear;
   ZQpassword.SQL.Add('Select id_usuario,Administrador,circulacion from t_usuario_ventas where nombre="'+nombre.Text+'" AND password="'+password.Text+'"');
   ZQpassword.ExecSQL;
   ZQpassword.Open;
   if ZQpassword.FieldByName('id_usuario').IsNull=TRUE then
         begin
           ShowMessage('Datos incorrectos, verifique por favor.');
               ZQbitacora.Close;
               ZQbitacora.SQL.Clear;
               ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Fallo el inicio de sesion","'+nombre.Text+'")');
               ZQBitacora.ExecSQL;
               ZQBitacora.Close;


         end
    else if ZQpassword.FieldByName('circulacion').AsInteger=1  then
     begin
       usuario:=ZQpassword.FieldByName('id_usuario').AsInteger;
       administrador:=ZQPassword.FieldByName('Administrador').AsInteger;
        ZQbitacora.SQL.Clear;
        ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Inicio de sesion","'+nombre.Text+'")');
        ZQBitacora.ExecSQL;
        ZQBitacora.Close;
       FLogin.Visible:=FALSE;
       //FPrincipalCirculacion.Enabled:=FALSE;
       //FPrincipalCirculacion := FPrincipalCirculacion.Create(self);
       FPrincipalCirculacion.ShowModal;
       end
     else begin
       ShowMessage('No tiene permiso para usar esta aplicación');
     end;
end;

procedure TFlogin.passwordKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
       begin
         ZQpassword.Close;
   ZQpassword.SQL.Clear;
   ZQpassword.SQL.Add('Select id_usuario,Administrador,circulacion from t_usuario_ventas where nombre="'+nombre.Text+'" AND password="'+password.Text+'"');
   ZQpassword.ExecSQL;
   ZQpassword.Open;
   if ZQpassword.FieldByName('id_usuario').IsNull=TRUE then
         begin
           ShowMessage('Datos incorrectos, verifique por favor.');
               ZQbitacora.Close;
               ZQbitacora.SQL.Clear;
               ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Fallo el inicio de sesion","'+nombre.Text+'")');
               ZQBitacora.ExecSQL;
               ZQBitacora.Close;
         end
    else if ZQpassword.FieldByName('circulacion').AsInteger=1  then
     begin
       usuario:=ZQpassword.FieldByName('id_usuario').AsInteger;
       administrador:=ZQPassword.FieldByName('Administrador').AsInteger;
        ZQbitacora.SQL.Clear;
        ZQBitacora.SQL.Add('Insert into b_movimientos_circulacion (movimiento,usuario) VALUES("Inicio de sesion","'+nombre.Text+'")');
        ZQBitacora.ExecSQL;
        ZQBitacora.Close;

       FLogin.Visible:=FALSE;
     //  FPrincipalCirculacion.Enabled:=FALSE;
     //  FPrincipalCirculacion := FPrincipalCirculacion.Create(self);
       FPrincipalCirculacion.ShowModal;
       end
     else begin
       ShowMessage('No tiene permiso para usar esta aplicación');
     end;
end;
end;

end.
