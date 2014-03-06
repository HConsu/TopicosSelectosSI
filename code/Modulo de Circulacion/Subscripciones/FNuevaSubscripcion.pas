unit FNuevaSubscripcion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, jpeg, ExtCtrls, pBarcode, pCode128, pEAN128;

type
  TFNueva_Subscripcion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lobservaciones: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Linconsistencias: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Fecha_alta: TEdit;
    NoSubscripcion: TEdit;
    atenciona: TEdit;
    combo_tiposub: TDBLookupComboBox;
    combo_edificio: TDBLookupComboBox;
    Telefono: TEdit;
    fecha_inicio: TDateTimePicker;
    fecha_fin: TDateTimePicker;
    calle: TEdit;
    cp: TEdit;
    ciudad: TEdit;
    descripcion: TEdit;
    observaciones: TEdit;
    inconsistencias: TEdit;
    NoSubscriptor: TEdit;
    ZQTipo_subscripcion: TZQuery;
    ZQEdificio: TZQuery;
    ZQRuta: TZQuery;
    DSTipoSubscripcion: TDataSource;
    DSEdificio: TDataSource;
    DSRuta: TDataSource;
    Asignar: TButton;
    Cancelar: TButton;
    ZQAlta_subscripcion: TZQuery;
    LabelCosto: TLabel;
    Costo: TEdit;
    ZQRCosto: TZReadOnlyQuery;
    EnEdificio: TCheckBox;
    areas: TButton;
    ZQNoSub: TZQuery;
    Image1: TImage;
    ZQcolonia: TZQuery;
    DScolonia: TDataSource;
    LEmail: TLabel;
    email: TEdit;
    Buscar: TButton;
    colonia: TEdit;
    Button1: TButton;
    ruta: TDBLookupComboBox;
    Label5: TLabel;
    formapago: TComboBox;
    ZQgenerar: TZQuery;
    ZQinserta: TZQuery;
    Barcode: TBarcode_EAN128;
    ZQb: TZQuery;
    Label10: TLabel;
    entrega: TComboBox;
    listafechas: TListBox;
    ZQtmp: TZQuery;
    procedure CancelarClick(Sender: TObject);
    procedure AsignarClick(Sender: TObject);
    procedure combo_tiposubClick(Sender: TObject);
    procedure EnEdificioClick(Sender: TObject);
    procedure areasClick(Sender: TObject);
    procedure fecha_inicioChange(Sender: TObject);
    procedure TelefonoKeyPress(Sender: TObject; var Key: Char);
    procedure atencionaKeyPress(Sender: TObject; var Key: Char);
    procedure cpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cpExit(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function asignarcodigo:boolean;
    procedure combo_edificioCloseUp(Sender: TObject);
  private
    { Private declarations }
     punto:tpoint;
  public
    duracionsubs:integer;
    numerodesubscripcion:string;
    numerodeedificio:string;
    {Callepublic:String;
    Coloniapublic:string;
    CPpublic:String;
    Ciudadpublic:string;
    Descripcionpublic:String;}


    { Public declarations }
  end;

var
  FNueva_Subscripcion: TFNueva_Subscripcion;

implementation

Uses FAlta_Subscripciones, FAreas_de_entrega_en_edificio,
  FAsignar_a_ruta_metropolitana,Fprincipal,F_BuscarCP,FReactivar_suscripcion;
{$R *.dfm}

procedure TFNueva_Subscripcion.areasClick(Sender: TObject);
var
codigo:String;
direccion:String;
fechaactual,fechafin:TDateTime;
i:integer;
finicio,ffin,fecha:String;
const
  DiasSemana: array[1..7] of String = ('Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' );
const
  Mes: array[1..12] of String = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
begin
  {para poder ordenar o agregar datos de la ruta en edificios primero insertamos los datos de la subscripcion en la BD}
  {Verificamos que los campos no vaya vacios}
  if NoSubscriptor.Text = '' then
   begin
     ShowMessage('El numero de subscriptor no puede estar vacio');
   end;
  if NoSubscripcion.Text = '' then
   begin
     ShowMessage('El número de subscripción no puede estar vacio');
   end;
  if Combo_tiposub.KeyValue = NULL then
   begin
     ShowMessage('Seleccione el tipo de subscripción');
   end;
  if EnEdificio.Checked = TRUE then
   begin
      if combo_edificio.KeyValue = 0 then
       Begin
        ShowMessage('Seleccione el edificio de entrega');
       End;
   end;
  if atenciona.Text = '' then
   begin
     ShowMessage('Indique en atención a quien estará la subscripción');
   end;
  if telefono.Text = '' then
   begin
     ShowMessage('Indique el teléfono del subscriptor, sino tiene introduzca un 0 ');
   end;
       if application.MessageBox (pchar('Esta accion dara de alta la subscripción, ¿desea continuar?'), pchar('Confirmar alta'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
            if ((NoSubscriptor.Text <> '') AND (NoSubscripcion.Text <> '') AND (Combo_tiposub.KeyValue <> NULL) AND (atenciona.Text <> '') AND (telefono.Text <> '') AND (combo_edificio.KeyValue <> NULL)) then
              begin

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
   ZQtmp.SQL.Add('Insert into t_fechas_no_entrega_subscripcion (nosubscripcion,fecha) VALUES ('+NoSubscripcion.Text+',"'+fecha+'")');
   ZQtmp.ExecSQL;

   if (punto.X <= listafechas.Count) then
       begin
       punto.X:=punto.x+1;
       end;
      i:=i+1;
     end;  // fin del while numero de fechas
    listafechas.Items.Clear;

   {-------------------------------------------------------------------------------------}

              numerodeedificio := FloatToStr(combo_edificio.KeyValue);

              //Leemos el codigo de edificio para asignarlo a la subscripcion
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Select codigo from c_edificios where id_edificio='+numerodeedificio);
              ZQAlta_subscripcion.ExecSQL;
              ZQAlta_Subscripcion.Open;
              codigo:=ZQAlta_Subscripcion.FieldByName('codigo').AsString;
              ZQAlta_Subscripcion.Close;
              //////////////// fin de consulta de codigo edificio///////////////////
              numerodesubscripcion := NoSubscripcion.Text;
               if FPrincipalCirculacion.quienllamanueva=1 then
                begin
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Insert into t_subscripcion (NoSubscriptor,AtencionA,Edificio,Fecha_alta,Fecha_inicio,fecha_fin,telefono,Tipo_Subscripcion,Costo,formadepago,ruta) VALUES ('+Nosubscriptor.Text+',"'+AtencionA.Text+'",'+FloatToStr(combo_edificio.KeyValue)+',CURDATE(),"'+DateToStr(fecha_inicio.Date)+'","'+DateToStr(fecha_fin.Date)+'","'+telefono.Text+'",'+FloatToStr(combo_tiposub.KeyValue)+','+costo.text+',"'+formapago.Text+'",'+FloatToStr(ruta.KeyValue)+')');
              ZQAlta_subscripcion.ExecSQL;
                end;
              if FPrincipalCirculacion.quienllamanueva=2 then
                 begin
                 try
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Insert into t_subscripcion (Nosubscripcion,NoSubscriptor,AtencionA,Edificio,Fecha_alta,Fecha_inicio,fecha_fin,telefono,Tipo_Subscripcion,Costo,formadepago,ruta) VALUES ("'+numerodesubscripcion+'",'+Nosubscriptor.Text+',"'+AtencionA.Text+'",'+FloatToStr(combo_edificio.KeyValue)+',CURDATE(),"'+DateToStr(fecha_inicio.Date)+'","'+DateToStr(fecha_fin.Date)+'","'+telefono.Text+'",'+FloatToStr(combo_tiposub.KeyValue)+','+costo.text+',"'+formapago.Text+'",'+FloatToStr(ruta.KeyValue)+')');
              ZQAlta_subscripcion.ExecSQL;
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Update t_cancelacion SET reactivado="s" where nosubscripcion='+numerodesubscripcion);
              ZQAlta_subscripcion.ExecSQL;
                 Except
                    ShowMessage('Ocurrio un error, No fue posible reactivar la suscripcion');
                 end;
                 end;
              {Actualizamos el estatus del subscriptor}
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Update t_cliente_subscriptor SET Estatus ="Activo" Where id_subscriptor='+Nosubscriptor.Text);
              ZQAlta_subscripcion.ExecSQL;
              {fin de actualizacion de estatus del subscriptor}
             {------------Bitacora-----------------------------------------}
              ZQb.Close;
              ZQb.SQL.Clear;
              ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se dio de alta la subscripcion '+nosubscripcion.Text+' atencíon a:'+atenciona.Text+',Costo:'+costo.Text+',Edificio:'+combo_edificio.Text+'","Jefe de circulacion")');
              ZQb.ExecSQL;
              ZQb.Close;
             {------------Bitacora-----------------------------------------}
              Asignar.Enabled := FALSE;
              FPrincipalCirculacion.quienllamaareadeentrega:=1;
              FAreas_entrega_edificio.Enabled := FALSE;
              FAreas_entrega_edificio := TFAreas_entrega_edificio.Create(self);
              FAreas_entrega_edificio.ShowModal;
              end
              else begin
                 ShowMessage('Error, Verifique que no falten datos.');
              end;
           end




end;

procedure TFNueva_Subscripcion.atencionaKeyPress(Sender: TObject;
  var Key: Char);
begin
 {Revisamos que en el campo atencion no se introduscan numeros}
  if not (key in [' ','a'..'z','ñ','Ñ','A'..'Z', #7, #8, #13]) then
   begin
     Key := #0;
     Beep;
   end;
end;

procedure TFNueva_Subscripcion.BuscarClick(Sender: TObject);
begin
   FPrincipalCirculacion.quienllamacp:=2;
   FbuscarCP.Enabled:=FALSE;
   FbuscarCP:= TFbuscarCP.Create(Self);
   FbuscarCP.ShowModal;
end;

procedure TFNueva_Subscripcion.Button1Click(Sender: TObject);
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

procedure TFNueva_Subscripcion.CancelarClick(Sender: TObject);
begin
  FNueva_Subscripcion.Close;

end;

procedure TFNueva_Subscripcion.EnEdificioClick(Sender: TObject);
begin
{habilitamos y deshabilitamos los campos segun selecionemos si es edificio o no}
 if enedificio.Checked = TRUE then
    begin
      combo_edificio.Enabled := TRUE;
      calle.Enabled := FALSE;
      calle.Text:='';
      colonia.text:='';
      cp.Enabled:=FALSE;
      cp.Text:='';
      Ciudad.Enabled:=FALSE;
      ciudad.Text:='';
      Descripcion.Enabled:=FALSE;
      descripcion.Text:='';
      areas.Visible :=TRUE;
      asignar.Enabled:=FALSE;
      Lobservaciones.Font.Style := [fsBold];
      Linconsistencias.Font.Style := [fsBold];
      ruta.Enabled:=FALSE;

    end;
 if enedificio.Checked = FALSE then
    begin
      combo_edificio.KeyValue := 0;
      combo_edificio.Enabled := FALSE;
      cp.Enabled:=TRUE;
      Ciudad.Enabled:=TRUE;
      Descripcion.Enabled:=TRUE;
      areas.Visible:=FALSE;
      Asignar.Enabled:=TRUE;
      Lobservaciones.Font.Style := [];
      Linconsistencias.Font.Style := [];
      ruta.Enabled:=TRUE;
    end;

end;

procedure TFNueva_Subscripcion.fecha_inicioChange(Sender: TObject);
begin
  Fecha_fin.Date := Fecha_inicio.Date + Duracionsubs;
end;

procedure TFNueva_Subscripcion.FormShow(Sender: TObject);
begin
  {Establecemos la fecha de captura a la fechan de hoy y obtenemos el numero de susbcriptor
  de la variable publica en FSubscripciones}
  fecha_inicio.Date:=now()+3;
  fecha_alta.Text := DateToStr(now);
  if FPrincipalCirculacion.quienllamanueva=1 then
    begin
  Nosubscriptor.Text:=FSubscripciones.no_de_subscriptor_public;
  ZQNoSub.SQL.Clear;
  ZQNoSub.SQL.Add('Select MAX(NoSubscripcion +1) AS No from t_subscripcion');
  ZQNoSub.ExecSQL;
  ZQNoSub.Open;
  Nosubscripcion.Text := ZQNoSub.FieldByName('No').AsString;
  combo_edificio.KeyValue := 0;
  ZQNoSub.Close;
  ZQNoSub.SQL.Clear;
  ZQNoSub.SQL.Add('Select * from t_cliente_subscriptor where id_subscriptor='+Nosubscriptor.Text);
  ZQNoSub.ExecSQL;
  ZQNoSub.Open;
  calle.Text:=ZQNoSub.FieldByName('calle').AsString;
  colonia.Text:=ZQNoSub.FieldByName('colonia').AsString;
  cp.Text:=ZQNoSub.FieldByName('cp').AsString;
  ciudad.Text:=ZQNoSub.FieldByName('ciudad').AsString;
  atenciona.Text:=ZQNoSub.FieldByName('titular').AsString;
  email.Text:=ZQnoSub.FieldByname('email').AsString;
  ruta.KeyValue:=0;
  ZQColonia.Close;
  ZQColonia.SQL.Clear;
  ZQColonia.SQL.Add('Select Descripcion from c_cp where cp='+cp.Text);
  ZQColonia.ExecSQL;
  ZQColonia.Open;
    end;

  if FPrincipalCirculacion.quienllamanueva=2 then
    begin

     Nosubscriptor.Text:=FSubscripciones.no_de_subscriptor_public;
     Nosubscripcion.Text := FReactivar.DBGrid1.Fields[1].AsString;
      combo_edificio.KeyValue := 0;
      ZQNoSub.Close;
      ZQNoSub.SQL.Clear;
      ZQNoSub.SQL.Add('Select * from t_cliente_subscriptor where id_subscriptor='+Nosubscriptor.Text);
      ZQNoSub.ExecSQL;
      ZQNoSub.Open;
      calle.Text:=ZQNoSub.FieldByName('calle').AsString;
      colonia.Text:=ZQNoSub.FieldByName('colonia').AsString;
      cp.Text:=ZQNoSub.FieldByName('cp').AsString;
      ciudad.Text:=ZQNoSub.FieldByName('ciudad').AsString;
      atenciona.Text:=ZQNoSub.FieldByName('titular').AsString;
      email.Text:=ZQnoSub.FieldByname('email').AsString;
      ruta.KeyValue:=0;
      ZQColonia.Close;
      ZQColonia.SQL.Clear;
      ZQColonia.SQL.Add('Select Descripcion from c_cp where cp='+cp.Text);
      ZQColonia.ExecSQL;
      ZQColonia.Open;
      FReactivar.Close;
    end;



end;

procedure TFNueva_Subscripcion.TelefonoKeyPress(Sender: TObject; var Key: Char);
begin
  {Revisamos que en el campo telefono no se introduscan letras}
if ( StrScan('0123456789,-'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

procedure TFNueva_Subscripcion.AsignarClick(Sender: TObject);
var
codigo:String;
direccion:String;
fechaactual,fechafin:TDateTime;
i:integer;
finicio,ffin,fecha:String;
const
  DiasSemana: array[1..7] of String = ('Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' );
const
  Mes: array[1..12] of String = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
begin
   {para poder ordenar o agregar datos de la ruta en edificios primero insertamos los datos de la subscripcion en la BD}
  {Verificamos que los campos no vaya vacios}
  if NoSubscriptor.Text = '' then
   begin
     ShowMessage('El numero de subscriptor no puede estar vacio');
   end;
  if NoSubscripcion.Text = '' then
   begin
     ShowMessage('El número de subscripción no puede estar vacio');
   end;
  if Combo_tiposub.KeyValue = NULL then
   begin
     ShowMessage('Seleccione el tipo de subscripción');
   end;
  if EnEdificio.Checked = TRUE then
   begin
      if combo_edificio.KeyValue = 0 then
       Begin
        ShowMessage('Seleccione el edificio de entrega');
       End;
   end;
  if atenciona.Text = '' then
   begin
     ShowMessage('Indique en atención a quien estará la subscripción');
   end;
  if telefono.Text = '' then
   begin
     ShowMessage('Indique el teléfono del subscriptor, sino tiene introduzca un 0 ');
   end;
       if application.MessageBox (pchar('Esta accion dara de alta la subscripción, ¿desea continuar?'), pchar('Confirmar alta'), (MB_YESNO + MB_ICONQUESTION)) = IDYES then
           begin
            if ((NoSubscriptor.Text <> '') AND (NoSubscripcion.Text <> '') AND (Combo_tiposub.KeyValue <> NULL) AND (atenciona.Text <> '') AND (telefono.Text <> '') AND (combo_edificio.KeyValue <> NULL)) then
              begin

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
   ZQtmp.SQL.Add('Insert into t_fechas_no_entrega_subscripcion (nosubscripcion,fecha) VALUES ('+NoSubscripcion.Text+',"'+fecha+'")');
   ZQtmp.ExecSQL;

   if (punto.X <= listafechas.Count) then
       begin
       punto.X:=punto.x+1;
       end;
      i:=i+1;
     end;  // fin del while numero de fechas
    listafechas.Items.Clear;

   {-------------------------------------------------------------------------------------}

              {Asignamos las variables para pasarlas entre formularios
               Callepublic:=calle.Text;
               Coloniapublic:=colonia.text;
               CPpublic:=cp.Text;
               Ciudadpublic:= ciudad.Text;
               Descripcionpublic:= descripcion.Text;   }

              {insertamos los datos de la subscripcion en t_subscripciones}
              numerodeedificio := FloatToStr(combo_edificio.KeyValue);
              numerodesubscripcion := NoSubscripcion.Text;
              if FPrincipalCirculacion.quienllamanueva=1 then
                begin
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Insert into t_subscripcion (NoSubscriptor,AtencionA,Edificio,Fecha_alta,Fecha_inicio,fecha_fin,telefono,Tipo_Subscripcion,Costo,formadepago,ruta) VALUES ('+Nosubscriptor.Text+',"'+AtencionA.Text+'",'+FloatToStr(combo_edificio.KeyValue)+',CURDATE(),"'+DateToStr(fecha_inicio.Date)+'","'+DateToStr(fecha_fin.Date)+'","'+telefono.Text+'",'+FloatToStr(combo_tiposub.KeyValue)+','+costo.text+',"'+formapago.Text+'",'+FloatToStr(ruta.KeyValue)+')');
              ZQAlta_subscripcion.ExecSQL;
                end;
              if FPrincipalCirculacion.quienllamanueva=2 then
                 begin
                 try
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Insert into t_subscripcion (Nosubscripcion,NoSubscriptor,AtencionA,Edificio,Fecha_alta,Fecha_inicio,fecha_fin,telefono,Tipo_Subscripcion,Costo,formadepago,ruta) VALUES ("'+numerodesubscripcion+'",'+Nosubscriptor.Text+',"'+AtencionA.Text+'",'+FloatToStr(combo_edificio.KeyValue)+',CURDATE(),"'+DateToStr(fecha_inicio.Date)+'","'+DateToStr(fecha_fin.Date)+'","'+telefono.Text+'",'+FloatToStr(combo_tiposub.KeyValue)+','+costo.text+',"'+formapago.Text+'",'+FloatToStr(ruta.KeyValue)+')');
              ZQAlta_subscripcion.ExecSQL;
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Update t_cancelacion SET reactivado="s" where nosubscripcion='+numerodesubscripcion);
              ZQAlta_subscripcion.ExecSQL;
                 Except
                    ShowMessage('Ocurrio un error, No fue posible reactivar la suscripcion');
                 end;
                 end;
              ZQAlta_subscripcion.Close;
              ZQAlta_subscripcion.SQL.Clear;
              ZQAlta_subscripcion.SQL.Add('Insert into t_descripcion_rutas (no_ruta,Orden_en_el_reparto,no_de_subscripcion,calle,colonia,cp,ciudad,descripcion_domicilio) Values');
              ZQAlta_subscripcion.SQL.Add('('+FloatToStr(ruta.KeyValue)+',0,'+nosubscripcion.Text+',"'+calle.Text+'","'+colonia.Text+'",'+cp.Text+',"'+ciudad.Text+'","'+descripcion.Text+'")');
              ZQAlta_subscripcion.ExecSQL;

              {--- Agregamos la subscripcion a la tabla de altas para seguimiento en circulacion------}
              direccion:=calle.Text+','+colonia.Text+','+cp.Text+','+ciudad.Text+','+descripcion.Text;
              ZQAlta_subscripcion.Close;
              ZQalta_subscripcion.SQL.Clear;
              ZQalta_subscripcion.SQL.Add('Insert into t_altas (nosubscripcion,direccion,fecha_alta) VALUES ('+nosubscripcion.Text+',"'+direccion+'",NOW())');
              ZQAlta_Subscripcion.ExecSQL;

              {---------------------------------------------------------------------------------------}
              {abrir formulario para asigancion de rutas}
              //FAsignarARutaMetro.Enabled := False;
              //FAsignarARutaMetro := TFAsignarARutaMetro.Create(Self);
              //FAsignarARutaMetro.ShowModal;
              areas.Enabled:=FALSE;
              asignar.Enabled:=FALSE;
      {------------Bitacora-----------------------------------------}
        ZQb.Close;
        ZQb.SQL.Clear;
        ZQb.SQL.Add('Insert into b_subscripciones (Descripcion,usuario) VALUES("Se dio de alta la subscripcion '+nosubscripcion.Text+' atencíon a:'+atenciona.Text+',Costo:'+costo.Text+',Colonia:'+colonia.Text+',calle:'+calle.Text+',ruta:'+ruta.Text+'","Jefe de circulacion")');
        ZQb.ExecSQL;
        ZQb.Close;
       {------------Bitacora-----------------------------------------}
              ShowMessage('La subscripcion fue dada de alta correctamente');
              asignarcodigo();
              end
              else begin
                 ShowMessage('Error, Verifique que no falten datos.');
              end;
           end

  {ZQAlta_subscripcion.Close;
  ZQAlta_subscripcion.SQL.Clear;
  ZQAlta_subscripcion.SQL.Add('Insert into t_subscripcion (NoSubscriptor,AtencionA,Edificio,Ruta,Fecha_alta,Fecha_inicio,Fecha_fin,telefono,Observaciones,Tipo_Subscripcion,Inconsistencias,costo) Values ("'+Nosubscriptor.Text+'","'+AtencionA.Text+'",'+FloatToStr(combo_edificio.KeyValue)+','+FloatToStr(combo_ruta.KeyValue)+',"'+Fecha_alta.Text+'",'+DateToStr(Fecha_inicio.Date)+','+DateToStr(fecha_fin.Date)+',"'+telefono.Text+'","'+Observaciones.Text+'",'+FloatToStr(combo_tiposub.KeyValue)+',"'+Inconsistencias.Text+'",'+(Costo.Text)+')');
  ZQAlta_subscripcion.ExecSQL;}


end;

procedure TFNueva_Subscripcion.combo_edificioCloseUp(Sender: TObject);
begin
   ZQgenerar.Close;
   ZQGenerar.SQL.Clear;
   ZQGenerar.SQL.Add('Select ruta from c_edificios where id_edificio='+FloatToStr(combo_edificio.KeyValue));
   ZQgenerar.ExecSQL;
   ZQgenerar.Open;
   ruta.KeyValue:=ZQgenerar.FieldByName('ruta').AsFloat;
end;

procedure TFNueva_Subscripcion.combo_tiposubClick(Sender: TObject);
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
    if Costo.Text='0' then
       begin
         formapago.Text:='CORTESIA';
       end;
  {ShowMessage('El costo es: '+ZQRCosto.ParamByName('costo').AsString);}
  end;

procedure TFNueva_Subscripcion.cpExit(Sender: TObject);
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

procedure TFNueva_Subscripcion.cpKeyPress(Sender: TObject; var Key: Char);
begin
if ( StrScan('0123456789'+chr(7)+chr(8), Key) = nil ) then
   begin
     Key := #0;
     beep;
   end;
end;

function TFNueva_subscripcion.asignarcodigo:boolean;
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
