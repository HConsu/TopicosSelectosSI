object FListaCorreos: TFListaCorreos
  Left = 0
  Top = 0
  Caption = 'Configurar correos al que se notificara la entrega de rutas'
  ClientHeight = 301
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 279
    Height = 13
    Caption = 'Configurar correos al que se notificara la entrega de rutas'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 59
    Width = 609
    Height = 142
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Correo'
        Width = 276
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 296
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 40
    Top = 216
    Width = 440
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 496
    Top = 256
    Width = 122
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ZTable1: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 't_correo_notificacion_ruta'
    Left = 352
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = ZTable1
    Left = 416
    Top = 248
  end
end
