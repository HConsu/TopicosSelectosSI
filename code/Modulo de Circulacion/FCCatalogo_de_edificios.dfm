object FCEdificios: TFCEdificios
  Left = 552
  Top = 200
  Caption = 'Catalogo de Edificios'
  ClientHeight = 519
  ClientWidth = 922
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 69
    Height = 16
    Caption = 'No Edificio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 15
    Top = 63
    Width = 102
    Height = 16
    Caption = 'Nombre Edificio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 544
    Top = 50
    Width = 295
    Height = 16
    Caption = 'Asignar a la  ruta metropolitana seleccionada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 544
    Top = 260
    Width = 251
    Height = 16
    Caption = 'Asignar a la ruta foranea seleccionada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 80
    Top = 123
    Width = 36
    Height = 16
    Caption = 'Ruta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 135
    Top = 125
    Width = 105
    Height = 17
    DataField = 'ruta'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 53
    Top = 92
    Width = 64
    Height = 16
    Caption = 'Direcci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 68
    Top = 149
    Width = 48
    Height = 16
    Caption = 'Codigo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object fullcodigo: TDBText
    Left = 135
    Top = 148
    Width = 130
    Height = 17
    DataField = 'codigo'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBEdit1: TDBEdit
    Left = 123
    Top = 31
    Width = 97
    Height = 21
    DataField = 'id_edificio'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 123
    Top = 62
    Width = 309
    Height = 21
    DataField = 'descripcion'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBGridedificio: TDBGrid
    Left = 8
    Top = 232
    Width = 473
    Height = 177
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 32
    Top = 184
    Width = 420
    Height = 33
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBGridmetro: TDBGrid
    Left = 512
    Top = 103
    Width = 377
    Height = 114
    DataSource = DSrutasmetro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGridfor: TDBGrid
    Left = 512
    Top = 311
    Width = 377
    Height = 114
    DataSource = DSrutasforaneas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object asignarm: TButton
    Left = 648
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Asignar'
    TabOrder = 6
    OnClick = asignarmClick
  end
  object asignarf: TButton
    Left = 648
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Asignar'
    Enabled = False
    TabOrder = 7
    OnClick = asignarfClick
  end
  object salir: TButton
    Left = 321
    Top = 448
    Width = 136
    Height = 33
    Caption = 'Salir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = salirClick
  end
  object DBEdit3: TDBEdit
    Left = 123
    Top = 91
    Width = 309
    Height = 21
    DataField = 'direccion'
    DataSource = DataSource1
    TabOrder = 9
  end
  object Button1: TButton
    Left = 271
    Top = 145
    Width = 90
    Height = 25
    Caption = 'Generar codigo'
    TabOrder = 10
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 367
    Top = 145
    Width = 114
    Height = 25
    Caption = 'Preparar para imprimir'
    TabOrder = 11
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 367
    Top = 118
    Width = 114
    Height = 25
    Caption = 'Limpiar tabla imprimir'
    TabOrder = 12
    OnClick = Button3Click
  end
  object MainMenu1: TMainMenu
    Left = 40
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
  object ZTEdificio: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 'c_edificios'
    Left = 120
    Top = 424
  end
  object DataSource1: TDataSource
    DataSet = ZTEdificio
    Left = 176
    Top = 424
  end
  object DSrutasmetro: TDataSource
    DataSet = ZTRutasmetro
    Left = 816
    Top = 144
  end
  object ZTRutasmetro: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 'c_rutas'
    Left = 760
    Top = 144
  end
  object ZTrutasforaneas: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 'c_rutas_foraneas'
    Left = 664
    Top = 376
  end
  object DSrutasforaneas: TDataSource
    DataSet = ZTrutasforaneas
    Left = 728
    Top = 376
  end
  object ZQasignarm: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 744
    Top = 72
  end
  object ZQasignarf: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 648
    Top = 432
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
    Left = 440
    Top = 64
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 512
    Top = 232
  end
  object ZQprepara: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 496
    Top = 152
  end
end
