unit FAutorizacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFPassword = class(TForm)
    Label1: TLabel;
    codigo: TEdit;
    Button1: TButton;
    Button2: TButton;
    ZQautorizacion: TZQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    autorizado:Integer;
    { Public declarations }
  end;

var
  FPassword: TFPassword;

implementation

{$R *.dfm}
Uses
FPrincipal,FCorte_circulacion;


procedure TFPassword.Button1Click(Sender: TObject);
var
temp:string;
begin
   ZQAutorizacion.Close;
   ZQAutorizacion.SQL.Clear;
   ZQAutorizacion.SQL.Add('Select nivel,usuario from t_usuarios where codigo="'+codigo.Text+'"');
   ZQAutorizacion.ExecSQL;
   ZQAutorizacion.Open;
     if ZQAutorizacion.FieldByName('nivel').IsNull = FALSE then
        begin
         // temp:=ZQAutorizacion.FieldByName('nivel').AsString;
         // ShowMessage('Nivel :'+temp);
         //  FPrincipalCirculacion.nivelapp:=ZQAutorizacion.FieldByName('nivel').AsInteger;
         //  FPrincipalCirculacion.usuarioapp:=ZQAutorizacion.FieldByName('usuario').AsString;
           if ZQAutorizacion.FieldByName('nivel').AsInteger = FPrincipalCirculacion.autorizacionquerida then
                 begin
                  autorizado:=1;
                  FPassword.Close;
                 end
           else begin
              ShowMessage('No Esta autorizado para acceder a este modulo');
              autorizado:=0;
           end;

        end
     else begin
        ShowMessage('El codigo de autorizacion no existe');
     end;

end;

procedure TFPassword.Button2Click(Sender: TObject);
begin
  FPassword.Close;
end;

procedure TFPassword.codigoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
     begin
  ZQAutorizacion.Close;
   ZQAutorizacion.SQL.Clear;
   ZQAutorizacion.SQL.Add('Select nivel,usuario from t_usuarios where codigo="'+codigo.Text+'"');
   ZQAutorizacion.ExecSQL;
   ZQAutorizacion.Open;
     if ZQAutorizacion.FieldByName('nivel').IsNull = FALSE then
        begin
         // temp:=ZQAutorizacion.FieldByName('nivel').AsString;
         // ShowMessage('Nivel :'+temp);
         //  FPrincipalCirculacion.nivelapp:=ZQAutorizacion.FieldByName('nivel').AsInteger;
         //  FPrincipalCirculacion.usuarioapp:=ZQAutorizacion.FieldByName('usuario').AsString;
           if ZQAutorizacion.FieldByName('nivel').AsInteger = FPrincipalCirculacion.autorizacionquerida then
                 begin
                  autorizado:=1;
                  FPassword.Close;
                 end
           else begin
              ShowMessage('No Esta autorizado para acceder a este modulo');
              autorizado:=0;
           end;

        end
     else begin
        ShowMessage('El codigo de autorizacion no existe');
     end;
     end;
end;

end.

