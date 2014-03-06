object FImpCodigo: TFImpCodigo
  Left = 0
  Top = 0
  Caption = 'Imprimir Codigo de barras de subscriptor'
  ClientHeight = 643
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object codigojpg: TImage
    Left = 56
    Top = 456
    Width = 257
    Height = 41
    Center = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 282
    Height = 13
    Caption = 'Seleccione el edificio para el que desea generar los codigos'
  end
  object Button1: TButton
    Left = 16
    Top = 304
    Width = 185
    Height = 25
    Caption = 'Generar codigos'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GridCodigos: TDBGrid
    Left = 16
    Top = 81
    Width = 409
    Height = 217
    DataSource = DSGenerar
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 207
    Top = 304
    Width = 202
    Height = 25
    Caption = 'Imprimir codigos'
    TabOrder = 2
    OnClick = Button2Click
  end
  object cruta: TDBLookupComboBox
    Left = 16
    Top = 54
    Width = 145
    Height = 21
    KeyField = 'id_edificio'
    ListField = 'Descripcion'
    ListSource = DSedificios
    TabOrder = 3
    OnCloseUp = crutaCloseUp
  end
  object ZQgenerar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 200
    Top = 552
  end
  object DSGenerar: TDataSource
    DataSet = ZQgenerar
    Left = 128
    Top = 552
  end
  object Barcode: TBarcode_EAN128
    Image = codigojpg
    LeftMargin = 15
    TopMargin = 10
    DisplayText = dtBarcode
    TextPosition = tpBottomOut
    TextAlignment = taCenter
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -11
    TextFont.Name = 'Tahoma'
    TextFont.Style = []
    Barcode = '00'
    Ratio = 2.000000000000000000
    Left = 80
    Top = 400
  end
  object ZQinserta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 176
    Top = 384
  end
  object ZQedificios: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select id_edificio,Descripcion from c_edificios')
    Params = <>
    Left = 360
    Top = 48
  end
  object DSedificios: TDataSource
    DataSet = ZQedificios
    Left = 360
    Top = 112
  end
end
