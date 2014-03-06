unit FOrden_Entrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TFOrdenEntrega = class(TForm)
    gridentregas: TDBGrid;
    Label1: TLabel;
    Fecha: TLabel;
    ZQsubscripciones: TZQuery;
    ZQdireccion: TZQuery;
    ZQinsertar: TZQuery;
    Label2: TLabel;
    tiempo: TLabel;
    ZQentregas: TZQuery;
    DSentregas: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOrdenEntrega: TFOrdenEntrega;

implementation

{$R *.dfm}

Uses
Festadisticas_rutas,Fprincipal;

procedure TFOrdenEntrega.FormShow(Sender: TObject);
var
ruta,nosubscripcion,direccion:string;
i:integer;
hora,atenciona:String;
begin
     ZQsubscripciones.Close;
     ZQsubscripciones.SQL.Clear;
     ZQsubscripciones.SQL.Add('Delete from t_tiempos_ruta');
     ZQsubscripciones.ExecSQL;

     fecha.Caption:=FormatDateTime('yyyy-mm-dd',(FEstadisticasRutas.gridestadisticas.Fields[1].AsDateTime));
     ruta:=FestadisticasRutas.gridestadisticas.Fields[2].AsString;
     LongTimeFormat:='hh:mm:ss';
     tiempo.Caption:=FestadisticasRutas.gridestadisticas.Fields[8].AsString;

     ZQsubscripciones.Close;
     ZQsubscripciones.SQL.Clear;
     ZQSubscripciones.SQL.Add('Select nosubscripcion,Hora,edificio,atenciona from t_datos_scaner_final inner join t_subscripcion on t_datos_scaner_final.codigo=t_subscripcion.codigo Where t_datos_scaner_final.ruta='+ruta+' AND fecha="'+fecha.Caption+'" group by t_datos_scaner_final.codigo order by id_scan desc');
     ZQsubscripciones.ExecSQL;
     ZQsubscripciones.Open;
        i:=1;
        while i<=ZQsubscripciones.RecordCount do
           begin
             if ZQsubscripciones.FieldByName('edificio').AsInteger=0 then
                begin
                      hora:=ZQsubscripciones.FieldByName('hora').AsString;
                      atenciona:=ZQsubscripciones.FieldByName('atenciona').AsString;
                      nosubscripcion:=ZQsubscripciones.FieldByName('nosubscripcion').AsString;
                      ZQdireccion.Close;
                      ZQdireccion.SQL.Clear;
                      ZQdireccion.SQL.Add('Select Calle,Colonia,Ciudad,Descripcion_domicilio from t_descripcion_rutas where no_de_subscripcion='+nosubscripcion);
                      ZQdireccion.ExecSQL;
                      ZQdireccion.Open;
                      direccion:=ZQdireccion.FieldByName('Calle').AsString+','+ZQdireccion.FieldByName('Colonia').AsString+','+ZQdireccion.FieldByName('Ciudad').AsString+','+ZQdireccion.FieldByName('descripcion_domicilio').AsString;

                      ZQinsertar.Close;
                      ZQinsertar.SQL.Clear;
                      ZQinsertar.SQL.Add('Insert into t_tiempos_ruta (Atenciona,direccion,Hora) VALUES("'+atenciona+'","'+direccion+'","'+hora+'")');
                      ZQinsertar.ExecSQL;


                end;         // fin del if, se entrega en domicilio
              if ZQsubscripciones.FieldByName('edificio').AsInteger>0 then
                begin
                      hora:=ZQsubscripciones.FieldByName('hora').AsString;
                      atenciona:=ZQsubscripciones.FieldByName('atenciona').AsString;
                      nosubscripcion:=ZQsubscripciones.FieldByName('nosubscripcion').AsString;
                      ZQdireccion.Close;
                      ZQdireccion.SQL.Clear;
                      ZQdireccion.SQL.Add('Select (Select descripcion from c_edificios where c_edificios.id_edificio=t_descripcion_ruta_edificio.id_edificio)AS edificio,Area from t_descripcion_ruta_edificio where nosubscripcion='+nosubscripcion);
                      ZQdireccion.ExecSQL;
                      ZQdireccion.Open;
                      direccion:=ZQdireccion.FieldByName('Edificio').AsString+','+ZQdireccion.FieldByName('area').AsString;

                      ZQinsertar.Close;
                      ZQinsertar.SQL.Clear;
                      ZQinsertar.SQL.Add('Insert into t_tiempos_ruta (Atenciona,direccion,Hora) VALUES("'+atenciona+'","'+direccion+'","'+hora+'")');
                      ZQinsertar.ExecSQL;


                end;              //fin del if se entrega en edificio
           ZQsubscripciones.Next;
          i:=i+1;
           end;              // fin del while itera en el numero de subscripciones

      /// cargamos los datos en el grid para mostrar el orden en el que se entregaron.

    Zqentregas.close;
    ZQentregas.SQL.Clear;
    ZQEntregas.SQL.Add('Select Atenciona,Direccion,Hora from t_tiempos_ruta');
    ZQentregas.ExecSQL;
    ZQentregas.Open;
    GridEntregas.Refresh;



end;

end.
