object FC_CP: TFC_CP
  Left = 132
  Top = 0
  Caption = 'Catalogo de codigos postales'
  ClientHeight = 714
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 58
    Width = 13
    Height = 13
    Caption = 'CP'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 43
    Height = 13
    Caption = 'Municipio'
  end
  object GridCP: TDBGrid
    Left = 8
    Top = 96
    Width = 878
    Height = 610
    DataSource = DScp
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = GridCPKeyPress
  end
  object buscar: TEdit
    Left = 70
    Top = 55
    Width = 89
    Height = 21
    TabOrder = 1
    OnKeyPress = buscarKeyPress
  end
  object municipios: TDBLookupComboBox
    Left = 70
    Top = 28
    Width = 145
    Height = 21
    KeyField = 'Municipio'
    ListField = 'Municipio'
    ListSource = DSmunicipios
    TabOrder = 2
    OnClick = municipiosClick
    OnKeyUp = municipiosKeyUp
  end
  object descripcion: TEdit
    Left = 432
    Top = 55
    Width = 249
    Height = 21
    TabOrder = 3
    Text = 'Descripci'#243'n'
    OnKeyPress = descripcionKeyPress
  end
  object Button2: TButton
    Left = 704
    Top = 53
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ZQcp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 744
    Top = 120
  end
  object DScp: TDataSource
    DataSet = ZQcp
    Left = 792
    Top = 120
  end
  object DSmunicipios: TDataSource
    DataSet = ZQmunicipios
    Left = 288
    Top = 8
  end
  object ZQmunicipios: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select Distinct (Municipio) from c_cp order by municipio')
    Params = <>
    DataSource = DScp
    Left = 216
    Top = 32
  end
  object ZQup: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 744
    Top = 272
  end
end
