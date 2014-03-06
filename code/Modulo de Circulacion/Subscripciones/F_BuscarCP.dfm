object FbuscarCP: TFbuscarCP
  Left = 0
  Top = 0
  Caption = 'Buscar codigo postal/colonia'
  ClientHeight = 434
  ClientWidth = 609
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
    Left = 16
    Top = 32
    Width = 21
    Height = 13
    Caption = 'C.P.'
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 35
    Height = 13
    Caption = 'Colonia'
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 43
    Height = 13
    Caption = 'Municipio'
  end
  object alta: TButton
    Left = 66
    Top = 137
    Width = 82
    Height = 25
    Caption = 'Dar de alta'
    Enabled = False
    TabOrder = 0
    OnClick = altaClick
  end
  object GridCP: TDBGrid
    Left = 8
    Top = 168
    Width = 593
    Height = 249
    DataSource = DSbuscar
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cp: TEdit
    Left = 66
    Top = 29
    Width = 111
    Height = 21
    TabOrder = 2
    Text = 'cp'
    OnKeyPress = cpKeyPress
    OnKeyUp = cpKeyUp
  end
  object colonia: TEdit
    Left = 65
    Top = 61
    Width = 336
    Height = 21
    TabOrder = 3
    Text = 'colonia'
    OnKeyUp = coloniaKeyUp
  end
  object municipio: TDBLookupComboBox
    Left = 65
    Top = 93
    Width = 240
    Height = 21
    KeyField = 'clv_municipio'
    ListField = 'municipio'
    ListSource = DSmunicipio
    TabOrder = 4
    OnClick = municipioClick
    OnKeyUp = municipioKeyUp
  end
  object nuevo: TCheckBox
    Left = 16
    Top = 6
    Width = 73
    Height = 17
    Caption = 'Nuevo'
    TabOrder = 5
    OnClick = nuevoClick
  end
  object Button1: TButton
    Left = 154
    Top = 137
    Width = 87
    Height = 25
    Caption = 'Seleccionar'
    TabOrder = 6
    OnClick = Button1Click
  end
  object ZQbuscar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 216
    Top = 8
  end
  object DSbuscar: TDataSource
    DataSet = ZQbuscar
    Left = 256
    Top = 8
  end
  object ZQalta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 16
    Top = 129
  end
  object ZQmunicipio: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      
        'Select DISTINCT municipio,clv_municipio from c_municipios order ' +
        'by municipio')
    Params = <>
    Left = 344
    Top = 96
  end
  object DSmunicipio: TDataSource
    DataSet = ZQmunicipio
    Left = 416
    Top = 96
  end
end