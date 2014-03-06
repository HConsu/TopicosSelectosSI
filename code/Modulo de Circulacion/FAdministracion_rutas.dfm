object FAdmon_rutas: TFAdmon_rutas
  Left = 0
  Top = 93
  Caption = 'Administraci'#243'n de rutas'
  ClientHeight = 741
  ClientWidth = 1142
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
    Left = 22
    Top = 18
    Width = 58
    Height = 13
    Caption = 'Tipo de ruta'
  end
  object Label2: TLabel
    Left = 22
    Top = 48
    Width = 23
    Height = 13
    Caption = 'Ruta'
  end
  object Label3: TLabel
    Left = 7
    Top = 649
    Width = 41
    Height = 16
    Caption = 'Titular'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 681
    Width = 59
    Height = 16
    Caption = 'Direcci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 654
    Top = 649
    Width = 41
    Height = 16
    Caption = 'Titular'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 654
    Top = 681
    Width = 59
    Height = 16
    Caption = 'Direcci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object dir: TLabel
    Left = 87
    Top = 683
    Width = 505
    Height = 46
    AutoSize = False
    WordWrap = True
  end
  object tit: TLabel
    Left = 87
    Top = 651
    Width = 505
    Height = 24
    AutoSize = False
  end
  object dird: TLabel
    Left = 726
    Top = 683
    Width = 382
    Height = 46
    AutoSize = False
    Visible = False
    WordWrap = True
  end
  object Label7: TLabel
    Left = 8
    Top = 625
    Width = 66
    Height = 13
    Caption = 'Total en ruta:'
  end
  object Label8: TLabel
    Left = 629
    Top = 623
    Width = 66
    Height = 13
    Caption = 'Total en ruta:'
  end
  object tot: TLabel
    Left = 86
    Top = 625
    Width = 17
    Height = 13
    AutoSize = False
    Caption = '0'
  end
  object totd: TLabel
    Left = 710
    Top = 623
    Width = 17
    Height = 13
    AutoSize = False
    Caption = '0'
  end
  object titd: TLabel
    Left = 719
    Top = 649
    Width = 382
    Height = 26
    AutoSize = False
    Visible = False
  end
  object Label9: TLabel
    Left = 22
    Top = 76
    Width = 33
    Height = 13
    Caption = 'Edificio'
  end
  object Label10: TLabel
    Left = 22
    Top = 118
    Width = 192
    Height = 13
    Caption = 'Total de subscripciones en la ruta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object totalruta: TLabel
    Left = 235
    Top = 118
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object altas: TLabel
    Left = 488
    Top = 110
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cancelados: TLabel
    Left = 488
    Top = 127
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Ruta: TDBLookupComboBox
    Left = 102
    Top = 42
    Width = 177
    Height = 21
    ListSource = DSrutas
    TabOrder = 0
    OnCloseUp = RutaCloseUp
  end
  object tiporuta: TComboBox
    Left = 102
    Top = 15
    Width = 177
    Height = 21
    TabOrder = 1
    OnChange = tiporutaChange
    Items.Strings = (
      'Ruta Metropolitana'
      'Ruta foranea'
      'Ruta Edificio'
      'Sin ruta')
  end
  object DBGridSubs: TDBGrid
    Left = 8
    Top = 144
    Width = 1063
    Height = 473
    DataSource = DSSubsruta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGridSubsCellClick
    OnKeyPress = DBGridSubsKeyPress
    OnKeyUp = DBGridSubsKeyUp
  end
  object ver: TButton
    Left = 285
    Top = 12
    Width = 122
    Height = 28
    Caption = 'Ver ruta subscripciones'
    TabOrder = 3
    OnClick = verClick
  end
  object Subir: TButton
    Left = 1077
    Top = 327
    Width = 58
    Height = 33
    Caption = 'Subir'
    TabOrder = 4
    OnClick = SubirClick
  end
  object Bajar: TButton
    Left = 1077
    Top = 366
    Width = 58
    Height = 34
    Caption = 'Bajar'
    TabOrder = 5
    OnClick = BajarClick
  end
  object BRemision: TButton
    Left = 922
    Top = 96
    Width = 186
    Height = 28
    Caption = 'Ver y modificar hojas de remisi'#243'n'
    Enabled = False
    TabOrder = 6
    Visible = False
  end
  object actualizar: TButton
    Left = 922
    Top = 62
    Width = 186
    Height = 28
    Caption = 'Actualizar remis'#243'n'
    TabOrder = 7
    Visible = False
    OnClick = actualizarClick
  end
  object Progreso: TProgressBar
    Left = 398
    Top = 406
    Width = 257
    Height = 25
    TabOrder = 8
    Visible = False
  end
  object Progresototal: TProgressBar
    Left = 305
    Top = 376
    Width = 470
    Height = 24
    TabOrder = 9
    Visible = False
  end
  object Exportexel: TButton
    Left = 285
    Top = 46
    Width = 122
    Height = 28
    Caption = 'Exportar a Exel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = ExportexelClick
  end
  object asignarrutas: TButton
    Left = 480
    Top = 47
    Width = 233
    Height = 28
    Caption = 'Asignar rutas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    Visible = False
    OnClick = asignarrutasClick
  end
  object DBGridRuta: TDBGrid
    Left = 606
    Top = 145
    Width = 465
    Height = 473
    DataSource = DSgridseleccionruta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
    OnCellClick = DBGridRutaCellClick
  end
  object agregar: TButton
    Left = 536
    Top = 406
    Width = 64
    Height = 35
    Caption = 'Pasar a -->'
    TabOrder = 13
    Visible = False
    OnClick = agregarClick
  end
  object quitar: TButton
    Left = 536
    Top = 447
    Width = 64
    Height = 36
    Caption = '<-- Pasar a'
    TabOrder = 14
    Visible = False
    OnClick = quitarClick
  end
  object Seleccionarruta: TDBLookupComboBox
    Left = 718
    Top = 42
    Width = 185
    Height = 21
    ListSource = DSrutadestino
    TabOrder = 15
    Visible = False
  end
  object rutaprincipal: TComboBox
    Left = 718
    Top = 15
    Width = 185
    Height = 21
    TabOrder = 16
    Text = 'rutaprincipal'
    Visible = False
    OnChange = rutaprincipalChange
    Items.Strings = (
      'Ruta Metropolitana'
      'Ruta foranea'
      'Ruta Edificio'
      'Sin ruta')
  end
  object verruta: TButton
    Left = 918
    Top = 27
    Width = 81
    Height = 28
    Caption = 'Ver ruta'
    TabOrder = 17
    Visible = False
    OnClick = verrutaClick
  end
  object Button1: TButton
    Left = 480
    Top = 78
    Width = 233
    Height = 28
    Caption = 'Imprimir hojas de notificaci'#243'n de ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 479
    Top = 76
    Width = 233
    Height = 28
    Caption = 'Imprimir hojas de ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    OnClick = Button2Click
  end
  object edificios: TDBLookupComboBox
    Left = 102
    Top = 69
    Width = 177
    Height = 21
    ListSource = DSedificio
    TabOrder = 20
    Visible = False
    OnCloseUp = edificiosCloseUp
  end
  object Button3: TButton
    Left = 285
    Top = 80
    Width = 122
    Height = 25
    Caption = 'Ver cancelados de la ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 285
    Top = 111
    Width = 122
    Height = 25
    Caption = 'Ver nuevos de la ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 479
    Top = 16
    Width = 233
    Height = 28
    Caption = 'Buscar Subscriptor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
    OnClick = Button5Click
  end
  object ZQRutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 158
    Top = 2
  end
  object DSrutas: TDataSource
    DataSet = ZQRutas
    Left = 206
    Top = 2
  end
  object ZQSubsruta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQSubsrutaAfterScroll
    Params = <>
    Left = 494
    Top = 186
  end
  object DSSubsruta: TDataSource
    DataSet = ZQSubsruta
    Left = 566
    Top = 186
  end
  object ZQActualiza: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 598
    Top = 258
  end
  object ZQcuentarutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 454
    Top = 258
  end
  object ZQcuentaregistros: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 526
    Top = 258
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 646
    Top = 186
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 654
    Top = 144
  end
  object ZQrutadestino: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 790
    Top = 44
  end
  object DSrutadestino: TDataSource
    DataSet = ZQrutadestino
    Left = 846
    Top = 44
  end
  object ZQgridseleccionruta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 766
    Top = 424
  end
  object DSgridseleccionruta: TDataSource
    DataSet = ZQgridseleccionruta
    Left = 870
    Top = 416
  end
  object ZQtmp2: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 734
    Top = 264
  end
  object DSedificio: TDataSource
    DataSet = ZQedificio
    Left = 208
    Top = 72
  end
  object ZQedificio: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 152
    Top = 64
  end
  object ZQtotal: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 280
    Top = 160
  end
  object DSrutae: TDataSource
    DataSet = ZQtotal
    Left = 352
    Top = 160
  end
  object ZQnuevos: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 424
    Top = 168
  end
  object ZQreporte: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 720
    Top = 112
  end
  object Compuesto: TQRCompositeReport
    Options = []
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrinterSettings.Orientation = poPortrait
    PrinterSettings.PaperSize = Letter
    PageCount = 0
    Left = 808
    Top = 112
  end
end
