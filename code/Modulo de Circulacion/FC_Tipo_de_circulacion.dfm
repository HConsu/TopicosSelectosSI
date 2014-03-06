object FCTipo_Circulacion: TFCTipo_Circulacion
  Left = 297
  Top = 309
  Caption = 'Catalogo de tipo de circulaci'#243'n'
  ClientHeight = 462
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ID: TLabel
    Left = 56
    Top = 64
    Width = 14
    Height = 16
    Caption = 'ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 56
    Top = 96
    Width = 123
    Height = 16
    Caption = 'Tipo de circulaci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 128
    Width = 79
    Height = 16
    Caption = 'Descripci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBEdit1: TDBEdit
    Left = 80
    Top = 64
    Width = 57
    Height = 21
    DataField = 'id_tipo'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 184
    Top = 96
    Width = 209
    Height = 21
    DataField = 'Nombre_tipo'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 144
    Top = 128
    Width = 449
    Height = 41
    AutoSize = False
    DataField = 'Descripcion'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBNavigator1: TDBNavigator
    Left = 112
    Top = 184
    Width = 370
    Height = 33
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 224
    Width = 513
    Height = 161
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = ZTable1
    Left = 592
    Top = 208
  end
  object ZTable1: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 'c_tipo_circulacion'
    Left = 592
    Top = 248
  end
end
