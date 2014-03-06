object FCod_vendedores: TFCod_vendedores
  Left = 0
  Top = 0
  Caption = 'Administracion de rutas por codigos'
  ClientHeight = 543
  ClientWidth = 762
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
    Left = 24
    Top = 56
    Width = 102
    Height = 14
    Caption = 'Puntos de venta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 400
    Top = 56
    Width = 151
    Height = 14
    Caption = 'Puntos de venta en ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 400
    Top = 16
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
  object gridpuntos: TDBGrid
    Left = 8
    Top = 75
    Width = 274
    Height = 406
    DataSource = DSpuntos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Cod'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 143
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Municipio'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dotacion'
        Visible = True
      end>
  end
  object gridruta: TDBGrid
    Left = 383
    Top = 75
    Width = 362
    Height = 406
    DataSource = DSvendedores
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Cod'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dotacion'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 125
        Visible = True
      end>
  end
  object Cruta: TDBLookupComboBox
    Left = 481
    Top = 32
    Width = 145
    Height = 21
    ListSource = DSruta
    TabOrder = 2
    OnCloseUp = CrutaCloseUp
  end
  object Button1: TButton
    Left = 288
    Top = 216
    Width = 89
    Height = 25
    Caption = 'Agregar ->'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 247
    Width = 89
    Height = 25
    Caption = '<- Quitar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 288
    Top = 487
    Width = 171
    Height = 25
    Caption = 'Generar codigos seleccionados'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 604
    Top = 514
    Width = 131
    Height = 25
    Caption = 'Exportar a Excel'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 288
    Top = 514
    Width = 171
    Height = 25
    Caption = 'Preparar seleccionados para imp'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 603
    Top = 487
    Width = 132
    Height = 25
    Caption = 'Limpiar tabla'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 465
    Top = 487
    Width = 126
    Height = 25
    Caption = 'Seleccionar todos'
    TabOrder = 9
    OnClick = Button7Click
  end
  object ZQpuntos: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 128
    Top = 120
  end
  object ZQruta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 352
    Top = 24
  end
  object ZQvendedores: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 472
    Top = 168
  end
  object DSpuntos: TDataSource
    DataSet = ZQpuntos
    Left = 152
    Top = 216
  end
  object DSvendedores: TDataSource
    DataSet = ZQvendedores
    Left = 528
    Top = 248
  end
  object DSruta: TDataSource
    DataSet = ZQruta
    Left = 304
    Top = 32
  end
  object ZQactualiza: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 304
    Top = 304
  end
  object ZQinserta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 344
    Top = 376
  end
  object Barcode: TBarcode_EAN128
    TextPosition = tpBottomOut
    TextAlignment = taCenter
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -11
    TextFont.Name = 'Tahoma'
    TextFont.Style = []
    Ratio = 2.000000000000000000
    Left = 320
    Top = 432
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 608
    Top = 344
  end
end
