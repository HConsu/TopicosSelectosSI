unit FC_Catalogo_de_repartidores_y_choferes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Mask, ComCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset, jpeg;

type
  TFC_Catalogo_repartidores_choferes = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    DBGrid: TDBGrid;
    TChofRepar: TZTable;
    DSChofRep: TDataSource;
    Image1: TImage;
    Label6: TLabel;
    tipo: TComboBox;
    id: TEdit;
    Nombre: TEdit;
    Telefono: TEdit;
    Direccion: TEdit;
    fechaa: TDateTimePicker;
    observaciones: TMemo;
    Aceptar: TButton;
    Cancelar: TButton;
    ZQact: TZQuery;
    DataSource1: TDataSource;
    procedure AceptarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure TChofReparAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FC_Catalogo_repartidores_choferes: TFC_Catalogo_repartidores_choferes;

implementation

{$R *.dfm}
Uses FPrincipal;

procedure TFC_Catalogo_repartidores_choferes.AceptarClick(Sender: TObject);

begin

  if id.Text = '' then
     begin
     //ShowMessage('Insert');
      ZQAct.Close;
      ZQAct.SQL.Clear;
      ZQAct.SQL.Add('Insert into c_repartidores_choferes (nombre,telefono,direccion,fecha_alta,observaciones,tipo) VALUES ("'+nombre.Text+'","'+telefono.Text+'","'+direccion.Text+'","'+DateToStr(fechaa.Date)+'","'+Observaciones.Text+'","'+tipo.Text+'")');
      ZQAct.ExecSQL;
      TChofRepar.Close;
      TChofRepar.Open;
      TChofRepar.Active:=TRUE;
      DBGrid.Refresh;
      ShowMessage('Se Agrego el nuevo '+tipo.Text+' correctamente');
     end
  else  begin
     //ShowMessage('Update');
     ZQAct.Close;
     ZQAct.SQL.Clear;
     ZQAct.SQL.Add('Update c_repartidores_choferes SET nombre="'+nombre.Text+'",telefono="'+telefono.Text+'",direccion="'+direccion.Text+'",observaciones="'+Observaciones.Text+'",tipo="'+tipo.Text+'" Where id_repartidor='+id.Text);
     ZQAct.ExecSQL;
     TChofRepar.Close;
     TChofRepar.Open;
     TChofRepar.Active:=TRUE;
     DBGrid.Refresh;
     ShowMessage('Se Actualizaron los datos del '+tipo.Text+' correctamente');
  end;

end;

procedure TFC_Catalogo_repartidores_choferes.CancelarClick(Sender: TObject);
begin
     FC_Catalogo_repartidores_choferes.Close;
end;

procedure TFC_Catalogo_repartidores_choferes.DBGridCellClick(Column: TColumn);
begin
    id.Text:=DBGrid.Fields[0].AsString;
    nombre.Text:=DBGrid.Fields[1].AsString;
    tipo.Text:=DBGrid.Fields[7].AsString;
    telefono.Text:=DbGrid.Fields[2].AsString;
    direccion.Text:=DBGrid.Fields[3].AsString;
     if (DBGrid.Fields[5].AsString) <> '' then
         begin
        Fechaa.Date:=StrToDate(DBGrid.Fields[5].AsString);
         end;
    Observaciones.Text:=DbGrid.Fields[6].AsString;
end;

procedure TFC_Catalogo_repartidores_choferes.TChofReparAfterScroll(
  DataSet: TDataSet);
begin
if DBGrid.Fields[0].AsString<>'' then
  begin
   id.Text:=DBGrid.Fields[0].AsString;
    nombre.Text:=DBGrid.Fields[1].AsString;
    tipo.Text:=DBGrid.Fields[7].AsString;
    telefono.Text:=DbGrid.Fields[2].AsString;
    direccion.Text:=DBGrid.Fields[3].AsString;
     if (DBGrid.Fields[5].AsString) <> '' then
         begin
        Fechaa.Date:=StrToDate(DBGrid.Fields[5].AsString);
         end;
    Observaciones.Text:=DbGrid.Fields[6].AsString;
  end;
end;

end.
