object FChoferDot: TFChoferDot
  Left = 0
  Top = 0
  Caption = 'Administraci'#243'n de dotaciones por ruta'
  ClientHeight = 668
  ClientWidth = 1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 24
    Width = 107
    Height = 14
    Caption = 'Seleccione la ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Vendedores: TLabel
    Left = 48
    Top = 56
    Width = 72
    Height = 14
    Caption = 'Vendedores'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 516
    Top = 56
    Width = 208
    Height = 14
    Caption = 'Vendedores sin una ruta asignada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 144
    Top = 631
    Width = 142
    Height = 14
    Caption = 'Dotacion total de ruta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ltotal: TLabel
    Left = 290
    Top = 631
    Width = 33
    Height = 14
    Caption = 'ltotal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Crutas: TDBLookupComboBox
    Left = 162
    Top = 21
    Width = 145
    Height = 21
    ListSource = DSrutas
    TabOrder = 0
    OnCloseUp = CrutasCloseUp
  end
  object gridruta: TDBGrid
    Left = 16
    Top = 76
    Width = 398
    Height = 549
    DataSource = DSvendedores
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 158
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dotacion'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Municipio'
        Width = 119
        Visible = True
      end>
  end
  object gridsinruta: TDBGrid
    Left = 501
    Top = 76
    Width = 533
    Height = 549
    DataSource = DSsinruta
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 219
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dotacion'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Municipio'
        Width = 158
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 420
    Top = 270
    Width = 75
    Height = 25
    Caption = '<- Agregar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 420
    Top = 239
    Width = 75
    Height = 25
    Caption = 'Quitar ->'
    TabOrder = 4
    OnClick = Button2Click
  end
  object DSrutas: TDataSource
    DataSet = ZQrutas
    Left = 328
    Top = 16
  end
  object ZQrutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 384
    Top = 16
  end
  object ZQvendedores: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 248
    Top = 176
  end
  object DSvendedores: TDataSource
    DataSet = ZQvendedores
    Left = 192
    Top = 216
  end
  object DSsinruta: TDataSource
    DataSet = ZQsinruta
    Left = 616
    Top = 248
  end
  object ZQsinruta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 672
    Top = 232
  end
  object ZQtotal: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 448
    Top = 536
  end
end
