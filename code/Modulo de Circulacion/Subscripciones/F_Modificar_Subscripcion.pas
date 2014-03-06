unit F_Modificar_Subscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZDataset, DB, ZAbstractRODataset, ZAbstractDataset, StdCtrls,
  ComCtrls, DBCtrls, jpeg, ExtCtrls, pBarcode, pCode128, pEAN128;

type
  TFModificar_Subscripcion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    LabelCosto: TLabel;
    combo_tiposub: TDBLookupComboBox;
    combo_edificio: TDBLookupComboBox;
    fecha_inicio: TDateTimePicker;
    fecha_fin: TDateTimePicker;
    EnEdificio: TCheckBox;
    areas: TButton;
    ZQTipo_subscripcion: TZQuery;
    ZQEdificio: TZQuery;
    DSTipoSubscripcion: TDataSource;
    DSEdificio: TDataSource;
    ZQRCosto: TZReadOnlyQuery;
    ZQNoSub: TZQuery;
    Lobservaciones: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Aceptar: TButton;
    Cancelar: TButton;
    ZQRuta: TZQuery;
    DSRuta: TDataSource;
    ZQAlta_subscripcion: TZQuery;
    fecha_alta: TEdit;
    nosubscriptor: TEdit;
    nosusbcripcion: TEdit;
    telefono: TEdit;
    costo: TEdit;
    atenciona: TEdit;
    calle: TEdit;
    cp: TEdit;
    ciudad: TEdit;
    descripcion: TEdit;
    observaciones: TEdit;
    usar: TButton;
    Image1: TImage;
    DScolonia: TDataSource;
    ZQcolonia: TZQuery;
    Label5: TLabel;
    email: TEdit;
    colonia: TEdit;
    Button1: TButton;
    ruta: TDBLookupComboBox;
    Label10: TLabel;
    formapago: TComboBox;
    ZQgenerar: TZQuery;
    ZQb: TZQuery;
    ZQinserta: TZQuery;
    Barcode: TBarcode_EAN128;
    ZQtmp: TZQuery;
    listafechas: TListBox;
    Label13: TLabel;
    entrega: TComboBox;
    cambiod: TCheckBox;
    procedure combo_tiposubClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure EnEdificioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure areasClick(Sender: TObject);
    procedure atencionaKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_inicioChange(Sender: TObject);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure AceptarClick(Sender: TObject);
    procedure cpKeyPress(Sender: TObject; var Key: Char);
    procedure usarClick(Sender: TObject);
    procedure cpExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure combo_edificioCloseUp(Sender: TObject);
    function asignarcodigo:boolean;

  private
    { Private declarations }
    rutaactual:integer;
    callecontrol:String;     {----Variable para saber si se cambio el domicilio----}
    diroriginal:String;      {---Variable para el control de cambio de direccion, direccion original---}
    edificioorg:integer;     {---Variable para el control de cambio de edificio y cambio de domicilio----}
    numerodesubscripcion:string;
  public
  duracionsubs:integer;
    { Public declarations }
  end;

var
  FModificar_Subscripcion: TFModificar_Subscripcion;

implementation

{$R *.dfm}

Uses FAlta_Subscripciones, FAreas_de_entrega_en_edificio,FNuevaSubscripcion,
  FAsignar_a_ruta_metropolitana,FPrincipal,F_BuscarCP;

procedure TFModificar_Subscripcion.AceptarClick(Sender: TObject);
var
dir:String;
codigo:String;
fechaactual,fechafin:TDateTime;
i:integer;
finicio,ffin,fecha:String;
punto:tpoint;
const
  DiasSemana: array[1..7] of String = ('Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' );
const
  Mes: array[1..12] of String = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
begin
   if application.MessageBox(pchar ('�Esta seguro que quiere actualizar los datos de la subscripcion?'), pchar('Confirmar actualizaci�n'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
            begin
   {----------Limpiamos las fechas de no entrega para la suscripcion------}
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     Zqtmp.SQL.Add('Delete from t_fechas_no_entrega_subscripcion where nosubscripcion='+nosusbcripcion.Text);
     ZQtmp.ExecSQL;

   {-----------------Para calcular las fechas en las que no se entregara el periodico----}
     fechaactual:=now();
     fechafin:=now()+830;

   if entrega.Text='DE LUNES A VIERNES' then
      begin
     while fechaactual<=fechafin do
       begin
                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Sabado' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;

                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Domingo' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;

        fechaactual:=fechaactual+1;
       end; //fin del while fecha actual<fechafin

      end;

   if entrega.Text='DE LUNES SABADO' then
      begin
     while fechaactual<=fechafin do
       begin

                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Domingo' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;

        fechaactual:=fechaactual+1;
       end; //fin del while fecha actual<fechafin
       end;


   i:=0;
   punto.X:=1;
   punto.Y:=1;
   listafechas.ItemAtPos(punto,True);  //nos colocamos al inicio de la lista

      i:=0;
  while i<=(listafechas.Count-1) do
     begin
   fecha:=listafechas.Items.Strings[i];

   {--- determinamos la fecha de inicio y la fecha de fin --------}
    if i=0 then
       begin
       finicio:=listafechas.Items.Strings[i];
       end;
    if i=(listafechas.Count-1) then
       begin
       ffin:=listafechas.Items.Strings[i];
      end;
  {--------------------------------------------------------------}

   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Insert into t_fechas_no_entrega_subscripcion (nosubscripcion,fecha) VALUES ('+NoSusbcripcion.Text+',"'+fecha+'")');
   ZQtmp.ExecSQL;

   if (punto.X <= listafechas.Count) then
       begin
       punto.X:=punto.x+1;
       end;
      i:=i+1;
     end;  // fin del while numero de fechas
    listafechas.Items.Clear;


   {-------------------------------------------------------------------------------------}


       ZQAlta_subscripcion.Close;
       ZQAlta_subscripcion.SQL.Clear;
       ZQAlta_subscripcion.SQL.Add('Update t_subscripcion Set AtencionA="'+atenciona.Text+'",tipo_subscripcion='+FloatToStr(combo_tiposub.KeyValue)+',telefono="'+telefono.Text+'",fecha_inicio="'+DateToStr(fecha_inicio.Date)+'",fecha_fin="'+DateToStr(fecha_fin.Date)+'",Observaciones="'+Observaciones.Text+'",costo='+costo.Text+',edificio=0');
       ZQAlta_subscripcion.SQL.Add(',ruta='+FloatToStr(ruta.KeyValue)+',formadepago="'+formapago.Text+'",email="'+email.Text+'" where nosubscripcion='+nosusbcripcion.text);
       ZQAlta_Subscripcion.ExecSQL;
       {--------------Borramos los datos de las rutas-----------}

       {---- insertamos un if para controlar si se registra como cambio de domicilio o solo es una actualizacion a los datos del suscriptor -------}

              //hacemos el cambio de domiclio
                    ZQAlta_Subscripcion.Close;
       ZQAlta_Subscripcion.SQL.Clear;
       ZQAlta_Subscripcion.SQL.Add('Delete from  t_descripcion_rutas  where No_de_subscripcion='+nosusbcripcion.Text);
       ZQAlta_Subscripcion.ExecSQL;
       ZQAlta_Subscripcion.Close;
       ZQAlta_Subscripcion.Close;
       ZQAlta_Subscripcion.SQL.Clear;
       ZQAlta_Subscripcion.SQL.Add('Delete from  t_descripcion_ruta_edificio  where Nosubscripcion='+nosusbcripcion.Text);
       ZQAlta_Subscripcion.ExecSQL;
       ZQAlta_Subscripcion.Close;
       {------------------------------------------------------}
       ZQAlta_Subscripcion.SQL.Clear;
       ZQAlta_Subscripcion.SQL.Add('Insert into t_descripcion_rutas  (no_de_subscripcion,calle,colonia,cp,ciudad,descripcion_domicilio,no_ruta) VALUES('+nosusbcripcion.text+',"'+calle.Text+'","'+colonia.Text+'",'+cp.Text+',"'+ciudad.Text+'","'+descripcion.Text+'",'+FloatToStr(ruta.KeyValue)+')');
       ZQAlta_Subscripcion.ExecSQL;
       ZQAlta_Subscripcion.Close;
       ZQAlta_Subscripcion.SQL.Clear;
       ZQAlta_Subscripcion.SQL.Add('Update t_saldos  SET adeudo='+costo.Text+',resta=adeudo-pagado where Nosubscripcion='+nosusbcripcion.Text);
       ZQAlta_Subscripcion.ExecSQL;

       {-----------Verificamos si se cambio la direccion de entrega----------------------------}
      if cambiod.Checked=TRUE then
          begin


         dir:=calle.Text+','+colonia.Text+','+cp.Text+','+descripcion.Text;
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosusbcripcion.text+',"'+atenciona.Text+'","'+DateToStr(now())+'","'+dir+'",'+IntToStr(rutaactual)+','+FloatToStr(ruta.KeyValue)+')');
         ZQAlta_Subscripcion.ExecSQL;
         {----------------------Eliminamos los cambios de domicilio de menos de 7 dias-----------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Delete from t_cambios_domicilio where nosubscripcion='+nosusbcripcion.text+' AND fecha_cambio between CURDATE()-7 AND CURDATE()+1;');
         ZQAlta_Subscripcion.ExecSQL;
         {-------------------------Eliminar cambios de domicilio de menos de 7 dias--------------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_cambio_domicilio (nosubscripcion,rutao,rutan,direccion,edificio) VALUES ('+nosusbcripcion.text+','+IntToStr(rutaactual)+','+FloatToStr(ruta.KeyValue)+',"'+diroriginal+'",'+FloatToStr(combo_edificio.KeyValue)+')');
         ZQAlta_Subscripcion.ExecSQL;

         {-------------------------Se inserta el cambio de domicilio para el seguimiento en Circulacion --------------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_cambios_domicilio (nosubscripcion,direccion,fecha_cambio) VALUES ('+nosusbcripcion.text+',"'+dir+'",NOW())');
         ZQAlta_Subscripcion.ExecSQL;

         {---------- se insertan los datos del codigo para recoleccion------------------}
         // Se cambio de edificio a domicilio o de domicilio a domicilio
         if ((combo_edificio.Text='') OR (calle.Text<>callecontrol)) then
            begin

         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Select codigo from t_subscripcion where nosubscripcion='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;
         ZQALta_subscripcion.Open;
         codigo:=ZQAlta_subscripcion.FieldByName('Codigo').AsString;
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_codigos_retirar (codigo,ruta,direccion)VALUES("'+codigo+'",'+IntToStr(rutaactual)+',"'+diroriginal+'")');
         ZQAlta_Subscripcion.ExecSQL;
         asignarcodigo();
         
            end;
           //Se cambio de edificio a domicilio no se de retirar el codigo del edificio
{         if ((combo_edificio.Text<>'') AND (calle.Text<>'')) then
            begin
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Select codigo from t_subscripcion where nosubscripcion='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;
         ZQALta_subscripcion.Open;
         codigo:=ZQAlta_subscripcion.FieldByName('Codigo').AsString;
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_codigos_retirar (codigo,ruta,direccion)VALUES("'+codigo+'",'+IntToStr(rutaactual)+',"'+diroriginal+'")');
         ZQAlta_Subscripcion.ExecSQL;
         asignarcodigo();
            end;         }


        {---------------cambio de codigo e insercion en recoleccion--------------------}

         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Update t_subscripcion SET fechamodif=CURRENT_TIMESTAMP where nosubscripcion ='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;

       {---------------------------------------------------------------------------------------}

            end;

        {------------Bitacora-----------------------------------------}
        ZQb.Close;
        ZQb.SQL.Clear;
        ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se modifico la subscripcion '+nosusbcripcion.Text+' atenc�on a:'+atenciona.Text+',Costo:'+costo.Text+',Colonia:'+colonia.Text+',calle:'+calle.Text+',ruta:'+ruta.Text+'","Jefe de circulacion")');
        ZQb.ExecSQL;
        ZQb.Close;
    {------------Bitacora-----------------------------------------}

       ShowMessage('Se actualizaron los datos de la subscripci�n');
       Aceptar.Enabled:=FALSE;

        end;

end;

procedure TFModificar_Subscripcion.areasClick(Sender: TObject);
var
nuevaruta:integer;
codigo,direccion:String;
fechaactual,fechafin:TDateTime;
i:integer;
finicio,ffin,fecha:String;
punto:tpoint;
const
  DiasSemana: array[1..7] of String = ('Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' );
const
  Mes: array[1..12] of String = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
//tiposubscripcionm,costom,telefonom,atencionam:String;
begin
if application.MessageBox (pchar('�Esta seguro que desea actualizar los datos de la subscripcion?'), pchar('Confirmar actualizaci�n'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
   //FNuevaSubscripcion.FNueva_Subscripcion.numerodeedificio := FloatToStr(combo_edificio.KeyValue);
   //FNuevaSubscripcion.FNueva_Subscripcion.numerodesubscripcion := nosusbcripcion.Text;
     {----------Limpiamos las fechas de no entrega para la suscripcion------}
     ZQtmp.Close;
     ZQtmp.SQL.Clear;
     Zqtmp.SQL.Add('Delete from t_fechas_no_entrega_subscripcion where nosubscripcion='+nosusbcripcion.Text);
     ZQtmp.ExecSQL;

     {-----------------Para calcular las fechas en las que no se entregara el periodico----}

     fechaactual:=now();
     fechafin:=now()+830;

   if entrega.Text='DE LUNES A VIERNES' then
      begin
     while fechaactual<=fechafin do
       begin
                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Sabado' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;


                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Domingo' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;

        fechaactual:=fechaactual+1;
       end; //fin del while fecha actual<fechafin

      end;

   if entrega.Text='DE LUNES SABADO' then
      begin
     while fechaactual<=fechafin do
       begin

                if (DiasSemana[DayOfWeek(fechaactual)]) = 'Domingo' then
                        begin
                         listafechas.Items.Add(DateToStr(fechaactual));
                        end;

        fechaactual:=fechaactual+1;
       end; //fin del while fecha actual<fechafin
       end;


   i:=0;
   punto.X:=1;
   punto.Y:=1;
   listafechas.ItemAtPos(punto,True);  //nos colocamos al inicio de la lista

      i:=0;
  while i<=(listafechas.Count-1) do
     begin
   fecha:=listafechas.Items.Strings[i];

   {--- determinamos la fecha de inicio y la fecha de fin --------}
    if i=0 then
       begin
       finicio:=listafechas.Items.Strings[i];
       end;
    if i=(listafechas.Count-1) then
       begin
       ffin:=listafechas.Items.Strings[i];
      end;
  {--------------------------------------------------------------}

   ZQtmp.Close;
   ZQtmp.SQL.Clear;
   ZQtmp.SQL.Add('Insert into t_fechas_no_entrega_subscripcion (nosubscripcion,fecha) VALUES ('+nosusbcripcion.Text+',"'+fecha+'")');
   ZQtmp.ExecSQL;

   if (punto.X <= listafechas.Count) then
       begin
       punto.X:=punto.x+1;
       end;
      i:=i+1;
     end;  // fin del while numero de fechas
    listafechas.Items.Clear;

   {-------------------------------------------------------------------------------------}

    ZQnosub.Close;
    ZQNosub.SQL.Clear;
    ZQNosub.SQL.Add('Select ruta from c_edificios where id_edificio='+FloatToStr(combo_edificio.KeyValue));
    ZQNosub.ExecSQL;
    ZQNosub.Open;
    nuevaruta:=ZQNosub.FieldByName('ruta').AsInteger;
     //if ((rutaactual<>nuevaruta) OR (combo_edificio.KeyValue<>edificioorg) OR (calle.Text<>callecontrol))then
     if cambiod.Checked=TRUE then
       begin             {----- Control del cambio de domicilio --------------------}
//          if ((rutaactual<>ruta.KeyValue) OR (calle.Text<>callecontrol)) then
 //         begin
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_notificacion_rutas (nosubscripcion,titular,fecha,direccion,rutaanterior,nuevaruta) VALUES ('+nosusbcripcion.text+',"'+atenciona.Text+'","'+DateToStr(now())+'","'+calle.Text+','+colonia.Text+','+cp.Text+','+descripcion.Text+'",'+IntToStr(rutaactual)+','+FloatToStr(ruta.KeyValue)+')');
         ZQAlta_Subscripcion.ExecSQL;
         {----------------------Eliminamos los cambios de domicilio de menos de 7 dias-----------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Delete from t_cambios_domicilio where nosubscripcion='+nosusbcripcion.text+' AND fecha_cambio between CURDATE()-7 AND CURDATE()+1;');
         ZQAlta_Subscripcion.ExecSQL;
         {-------------------------Eliminar cambios de domicilio de menos de 7 dias--------------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_cambio_domicilio (nosubscripcion,rutao,rutan,direccion,edificio) VALUES ('+nosusbcripcion.text+','+IntToStr(rutaactual)+','+IntToStr(nuevaruta)+',"'+diroriginal+'",'+IntToStr(edificioorg)+')');
         ZQAlta_Subscripcion.ExecSQL;
           {--- Agregamos la subscripcion a la tabla de cambios para seguimiento en circulacion------}
        direccion:=combo_edificio.Text;
        ZQAlta_Subscripcion.Close;
        ZQAlta_Subscripcion.SQL.Clear;
        ZQAlta_Subscripcion.SQL.Add('Insert into t_cambios_domicilio (nosubscripcion,direccion,fecha_cambio) VALUES ('+NoSusbcripcion.Text+',"'+direccion+'",NOW())');
        ZQAlta_Subscripcion.ExecSQL;
        {---------------------------------------------------------------------------------------}
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Update t_subscripcion SET fechamodif=CURRENT_TIMESTAMP where nosubscripcion ='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;

           //Leemos el codigo de edificio para asignarlo a la subscripcion
        ZQAlta_subscripcion.Close;
        ZQAlta_subscripcion.SQL.Clear;
        ZQAlta_subscripcion.SQL.Add('Select codigo from c_edificios where id_edificio='+FloatToStr(combo_edificio.KeyValue));
        ZQAlta_subscripcion.ExecSQL;
        ZQAlta_Subscripcion.Open;
        codigo:=ZQAlta_Subscripcion.FieldByName('codigo').AsString;
        ZQAlta_Subscripcion.Close;
        //////////////// fin de consulta de codigo edificio///////////////////
         ZQAlta_subscripcion.Close;
         ZQAlta_subscripcion.SQL.Clear;
         ZQAlta_subscripcion.SQL.Add('Update t_subscripcion Set codigo="'+codigo+'" where nosubscripcion='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;

         {---------- se insertan los datos del codigo para recoleccion------------------}
         if (calle.Text<>callecontrol) then
           begin
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Select codigo from t_subscripcion where nosubscripcion='+nosusbcripcion.text);
         ZQAlta_Subscripcion.ExecSQL;
         ZQALta_subscripcion.Open;
         codigo:=ZQAlta_subscripcion.FieldByName('Codigo').AsString;
         ZQAlta_Subscripcion.Close;
         ZQAlta_Subscripcion.SQL.Clear;
         ZQAlta_Subscripcion.SQL.Add('Insert into t_codigos_retirar (codigo,ruta,direccion)VALUES("'+codigo+'",'+IntToStr(rutaactual)+',"'+diroriginal+'")');
         ZQAlta_Subscripcion.ExecSQL;
           end;
        {---------------cambio de codigo e insercion en recoleccion--------------------}


      //    end;     // fin del if ruta - calle
      end;
     {------------Bitacora-----------------------------------------}
              ZQb.Close;
              ZQb.SQL.Clear;
              ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se modifico la subscripcion '+nosusbcripcion.Text+' atenc�on a:'+atenciona.Text+',Costo:'+costo.Text+',Edificio:'+combo_edificio.Text+'","Jefe de circulacion")');
              ZQb.ExecSQL;
              ZQb.Close;
     {------------Bitacora-----------------------------------------}

   FprincipalCirculacion.quienllamaareadeentrega:=2;
   FAreas_entrega_edificio.Enabled:=FALSE;
   FAreas_entrega_edificio := TFAreas_entrega_edificio.Create(self);
   FAreas_entrega_edificio.ShowModal;
   ZQAlta_subscripcion.Close;
   ZQAlta_subscripcion.SQL.Clear;
   ZQAlta_subscripcion.SQL.Add('Update t_subscripcion Set AtencionA="'+atenciona.Text+'",tipo_subscripcion='+FloatToStr(combo_tiposub.KeyValue)+',telefono="'+telefono.Text+'",fecha_inicio="'+DateToStr(fecha_inicio.Date)+'",fecha_fin="'+DateToStr(fecha_fin.Date)+'",Observaciones="'+observaciones.Text+'",costo='+costo.Text+',edificio='+FloatToStr(combo_edificio.KeyValue)+',formadepago="'+formapago.Text+'",ruta='+FloatToStr(ruta.KeyValue)+',codigo="'+codigo+'",email="'+email.Text+'" where nosubscripcion='+nosusbcripcion.text);
   ZQAlta_Subscripcion.ExecSQL;
   ZQAlta_Subscripcion.SQL.Clear;
   ZQAlta_Subscripcion.Close;
   ZQAlta_Subscripcion.SQL.Clear;
   ZQAlta_Subscripcion.SQL.Add('Update t_saldos  SET resta=adeudo-pagado where Nosubscripcion='+nosusbcripcion.Text);
   ZQAlta_Subscripcion.ExecSQL;
   ZQalta_subscripcion.Close;
   ZQAlta_Subscripcion.SQL.Clear;
   ZQAlta_Subscripcion.SQL.Add('Delete from t_descripcion_rutas where No_de_subscripcion='+nosusbcripcion.Text);
   ZQAlta_Subscripcion.ExecSQL;
   FModificar_Subscripcion.Close;

           end;

end;

procedure TFModificar_Subscripcion.atencionaKeyPress(Sender: TObject;
  var Key: Char);
begin
{Revisamos que en el campo atencion no se introduscan numeros}
  if not (key in [' ','a'..'z','�','�','A'..'Z', #7, #8, #13]) then
   begin
     Key := #0;
     Beep;
   end;
end;

procedure TFModificar_Subscripcion.Button1Click(Sender: TObject);
begin
   FPrincipalCirculacion.quienllamacp:=4;
   FBuscarCp.Enabled:=FALSE;
   FBuscarCP := TFbuscarCP.Create(Self);
   FBuscarCP.ShowModal;
end;

procedure TFModificar_Subscripcion.usarClick(Sender: TObject);
begin
    ZQNosub.Close;
    ZQNoSub.SQL.Clear;
    ZQNoSub.SQL.Add('Select * from t_cliente_subscriptor where id_subscriptor='+nosubscriptor.Text);
    ZQNosub.ExecSQL;
    ZQNoSub.Open;
    atenciona.Text:=ZQNosub.FieldByName('titular').AsString;
    calle.Text:=ZQNosub.FieldByName('calle').AsString;
    cp.Text:=ZQNosub.FieldByName('cp').AsString;
    colonia.Text:=ZQNosub.FieldByName('colonia').AsString;
    ciudad.Text:=ZQNoSub.FieldByName('ciudad').AsString;

end;

procedure TFModificar_Subscripcion.CancelarClick(Sender: TObject);
begin
  FModificar_Subscripcion.Close;
end;

procedure TFModificar_Subscripcion.combo_edificioCloseUp(Sender: TObject);
begin
   ZQgenerar.Close;
   ZQGenerar.SQL.Clear;
   ZQGenerar.SQL.Add('Select ruta from c_edificios where id_edificio='+FloatToStr(combo_edificio.KeyValue));
   ZQgenerar.ExecSQL;
   ZQgenerar.Open;
   ruta.KeyValue:=ZQgenerar.FieldByName('ruta').AsFloat;
end;

procedure TFModificar_Subscripcion.combo_tiposubClick(Sender: TObject);
begin
{Actualizamos el costo y la duracion segun el tipo de susbcripcion}
  ZQRCosto.SQL.Clear;
  ZQRCosto.Close;
  ZQRCosto.SQL.Add('Select costo,duracion from c_tipo_de_subscripcion where id_subscripcion = '+FloatToStr(combo_tiposub.KeyValue));
  ZQRCosto.ExecSQL;
  ZQRCosto.Open;
  Costo.Text := ZQRCosto.FieldByName('costo').AsString;
  duracionsubs := ZQRCosto.FieldByName('Duracion').AsInteger;
  Fecha_fin.Date := Fecha_inicio.Date + duracionsubs;
  {ShowMessage('El costo es: '+ZQRCosto.ParamByName('costo').AsString);}
end;

procedure TFModificar_Subscripcion.cpExit(Sender: TObject);
begin
   ZQNosub.Close;
   ZQNoSub.SQL.Clear;
   ZQNoSub.SQL.Add('Select cp,municipio,descripcion from c_cp where cp ='+cp.Text);
   ZQNoSub.ExecSQL;
   ZQNoSub.Open;
   if ZQNoSub.RecordCount =0 then
      begin
       ShowMessage('El CP no existe en la BD por favor verifique');
      end
   else begin
   ciudad.Text:= ZQNoSub.FieldByName('Municipio').AsString;
   ZQColonia.Close;
   ZQColonia.SQL.Clear;
   ZQColonia.SQL.Add('Select Descripcion from c_cp where cp='+cp.Text);
   ZQColonia.ExecSQL;
   ZQColonia.Open;


   end;
end;

procedure TFModificar_Subscripcion.cpKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFModificar_Subscripcion.EnEdificioClick(Sender: TObject);
begin
{habilitamos y deshabilitamos los campos segun selecionemos si es edificio o no}
 if enedificio.Checked = TRUE then
    begin
      combo_edificio.Enabled := TRUE;
      calle.Enabled := FALSE;
      calle.Text:='';
      colonia.Enabled:=FALSE;
     // colonia.text:='';
      cp.Enabled:=FALSE;
      cp.Text:='';
      Ciudad.Enabled:=FALSE;
      ciudad.Text:='';
      Descripcion.Enabled:=FALSE;
      descripcion.Text:='';
      areas.Visible :=TRUE;
      Lobservaciones.Font.Style := [fsBold];
      ruta.Enabled:=FALSE;

    end;
 if enedificio.Checked = FALSE then
    begin
      combo_edificio.KeyValue := 0;
      combo_edificio.Enabled := FALSE;
      calle.Enabled := TRUE;
      colonia.Enabled:=TRUE;
      cp.Enabled:=TRUE;
      Ciudad.Enabled:=TRUE;
      Descripcion.Enabled:=TRUE;
      areas.Visible:=FALSE;
      Lobservaciones.Font.Style := [];
      ruta.Enabled:=TRUE;

    end;
end;

procedure TFModificar_Subscripcion.fecha_inicioChange(Sender: TObject);
begin
 Fecha_fin.Date := Fecha_inicio.Date + Duracionsubs;
end;

procedure TFModificar_Subscripcion.FormShow(Sender: TObject);
var
nodesubscripcion:string;
edificio:string;
begin
  {de acuedo al numero de susbcripcion seleccionamos los datos de las tablas t_descripcion_ruta_edificio, t_subscripcion.NoSubscripcion }
  {y llenamos el formulario con estos datos}
   nodesubscripcion := FPrincipalCirculacion.numerodesubscripcion;
  numerodesubscripcion := FSubscripciones.no_de_subscripcion_public;
  {showMessage('Numero de subscripcion'+nodesubscripcion);}
  ZQNoSub.Close;
  ZQNoSub.SQL.Clear;
  ZQNoSub.SQL.Add('Select * from t_subscripcion where t_subscripcion.NoSubscripcion ='+nodesubscripcion );
  ZQNoSub.ExecSQL;
  ZQNoSub.Open;
  fecha_alta.Text := DateToStr(StrToDate(ZQNoSub.FieldByName('fecha_alta').AsString));
  nosubscriptor.Text := ZQNoSub.FieldByName('nosubscriptor').AsString;
  nosusbcripcion.Text := ZQNoSub.FieldByName('nosubscripcion').AsString;
  combo_tiposub.KeyValue := ZQNoSub.FieldByName('tipo_Subscripcion').AsFloat;
  costo.Text := ZQNoSub.FieldByName('costo').AsString;
  atenciona.Text := ZQNoSub.FieldByName('AtencionA').AsString;
  fecha_inicio.Date := ZQNoSub.FieldByName('fecha_inicio').AsDateTime;
  fecha_fin.Date := ZQNoSub.FieldByName('fecha_fin').AsDateTime;
  combo_edificio.KeyValue := ZQNoSub.FieldByName('edificio').AsFloat;
  telefono.Text := ZQNoSub.FieldByName('telefono').AsString;
  observaciones.Text:= ZQNoSub.FieldByName('Observaciones').AsString;
  ruta.KeyValue:= ZQNoSub.FieldByName('ruta').AsFloat;
  formapago.Text:=ZQNoSub.FieldByName('formadepago').AsString;
  email.Text:=ZQNoSub.FieldByName('email').AsString;

   if combo_edificio.Text='' then
       begin
       rutaactual:=ruta.KeyValue;
       end;
   if combo_edificio.Text<>'' then
       begin
     ZQnosub.Close;
     ZQNosub.SQL.Clear;
     ZQNosub.SQL.Add('Select ruta from c_edificios where id_edificio='+FloatToStr(combo_edificio.KeyValue));
     ZQNosub.ExecSQL;
     ZQNosub.Open;
     rutaactual:=ZQNosub.FieldByName('ruta').AsInteger;
       end;



   if email.Text='' then
      begin
  ZQNoSub.Close;
  ZQNoSub.SQL.Clear;
  ZQNoSub.SQL.Add('Select email from t_cliente_subscriptor where id_subscriptor='+Nosubscriptor.Text);
  ZQNoSub.ExecSQL;
  ZQNoSub.Open;
  email.Text:=ZQnoSub.FieldByName('email').AsString;
      end;
  {obtenemos los datos de la entrega en domicilio si es que cuenta con ellos}
  ZQNoSub.Close;
  ZQNoSub.SQL.Clear;
  ZQNoSub.SQL.Add('Select * from t_descripcion_rutas where no_de_subscripcion = '+nodesubscripcion );
  ZQNoSub.ExecSQL;
  ZQNoSub.Open;
  calle.Text := ZQNoSub.FieldByName('calle').AsString;
  callecontrol:=ZQNoSub.FieldByName('calle').AsString;
  //colonia.Text := ZQNoSub.FieldByName('colonia').AsString;
  cp.Text :=  ZQNoSub.FieldByName('cp').AsString;
  colonia.Text:=ZQNosub.FieldByName('colonia').AsString;
  ciudad.Text:=ZQNosub.FieldByName('ciudad').AsString;

  descripcion.Text := ZQNoSub.FieldByName('descripcion_domicilio').AsString;
   {Seleccionamos la ruta y sacamos los datos de la tabla para saber la descripcion de la ruta}
  {Guardamos la direccion original para usarla en caso de cambio de domicilio}
  diroriginal:=calle.Text+','+colonia.Text+descripcion.Text+','+combo_edificio.Text;
  edificioorg:=combo_edificio.KeyValue;



end;

procedure TFModificar_Subscripcion.telefonoKeyPress(Sender: TObject;
  var Key: Char);
begin
{Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789,-'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

function TFModificar_Subscripcion.asignarcodigo:boolean;
  var
codigo:String;
i,consecutivo:Integer;
nosubscripcion,nosubscriptor,edificio,ruta,consec:String;
begin

  ZQgenerar.Close;
  ZQGenerar.SQL.Clear;
  ZQGenerar.SQL.Add('Select Nosubscripcion,Nosubscriptor,Atenciona,Edificio,ruta,fecha_inicio,Fecha_fin from t_subscripcion where nosubscripcion='+numerodesubscripcion);
  ZQGenerar.ExecSQL;
  ZQGenerar.Open;

  {---------------------------------------------------------------------------}
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=4 then
      begin
        nosubscripcion:=ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=3 then
      begin
        nosubscripcion:='0'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=2 then
      begin
        nosubscripcion:='00'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscripcion').AsString)=1 then
      begin
        nosubscripcion:='000'+ZQGenerar.FieldByName('Nosubscripcion').AsString;
      end;


  {---------------------------------------------------------------------------}
     if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=4 then
      begin
        nosubscriptor:=ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=3 then
      begin
        nosubscriptor:='0'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=2 then
      begin
        nosubscriptor:='00'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;
   if Length(ZQGenerar.FieldByName('Nosubscriptor').AsString)=1 then
      begin
        nosubscriptor:='000'+ZQGenerar.FieldByName('Nosubscriptor').AsString;
      end;

   {---------------------------------------------------------------------------}
    ZQInserta.Close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Select max(id) AS Id from t_identificador_codigo');
    ZQInserta.ExecSQL;
    ZQInserta.Open;
      if ZQinserta.FieldByName('Id').IsNull=TRUE then
         begin
            consecutivo:=1;
         end
      else begin
        Consecutivo:=ZQinserta.FieldByName('Id').AsInteger+1;
      end;
    consec:=IntToStr(Consecutivo);
   // showMessage(consec);
   // ShowMessage(IntToStr(Consecutivo));
   if Length(Consec)=4 then
      begin
        consec:=Consec;
      end;
   if Length(Consec)=1 then
      begin
        consec:='0000'+Consec;
      end;
   if Length(Consec)=2 then
      begin
        consec:='000'+Consec;
      end;
   if Length(Consec)=3 then
      begin
        consec:='00'+Consec;
      end;
   if Length(Consec)=4 then
      begin
        consec:='0'+Consec;
      end;


    Codigo:=nosubscripcion+nosubscriptor+consec;
    barcode.Barcode:=codigo;
    codigo:=barcode.FullEncoded;

    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Update t_subscripcion SET codigo="'+Codigo+'" where nosubscripcion ='+nosubscripcion);
    ZQInserta.ExecSQL;

    ZQinserta.close;
    ZQinserta.SQL.Clear;
    ZQInserta.SQL.Add('Insert into t_identificador_codigo (id) VALUES('+IntToStr(consecutivo)+')');
    ZQInserta.ExecSQL;
    ZQGenerar.Next;


end;

end.