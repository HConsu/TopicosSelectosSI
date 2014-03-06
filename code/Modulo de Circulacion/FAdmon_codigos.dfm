object FAdmonCodigos: TFAdmonCodigos
  Left = 0
  Top = 0
  Caption = 'Administraci'#243'n de codigos de barras'
  ClientHeight = 698
  ClientWidth = 717
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
    Left = 8
    Top = 8
    Width = 371
    Height = 14
    Caption = 'Seleccione la subscripci'#243'n y de clic en la opci'#243'n que requiere.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 37
    Top = 45
    Width = 30
    Height = 14
    Caption = 'Ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridsubscripciones: TDBGrid
    Left = 8
    Top = 104
    Width = 691
    Height = 409
    DataSource = DSSubscripciones
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NoSubscripcion'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AtencionA'
        Width = 313
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 8
    Top = 639
    Width = 134
    Height = 25
    Caption = 'Asignar nuevo codigo'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 148
    Top = 639
    Width = 138
    Height = 25
    Caption = 'Asignar codigo de edificio'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 292
    Top = 639
    Width = 155
    Height = 25
    Caption = 'Insertar para imprimir'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ruta: TDBLookupComboBox
    Left = 88
    Top = 45
    Width = 145
    Height = 21
    ListSource = DSruta
    TabOrder = 4
    OnCloseUp = rutaCloseUp
  end
  object Button4: TButton
    Left = 453
    Top = 670
    Width = 155
    Height = 25
    Caption = 'Limpiar tabla de impresi'#243'n'
    TabOrder = 5
    OnClick = Button4Click
  end
  object nosubscripcionb: TEdit
    Left = 21
    Top = 77
    Width = 68
    Height = 21
    TabOrder = 6
    OnKeyUp = nosubscripcionbKeyUp
  end
  object atencionab: TEdit
    Left = 200
    Top = 77
    Width = 241
    Height = 21
    TabOrder = 7
    OnKeyUp = atencionabKeyUp
  end
  object Button6: TButton
    Left = 453
    Top = 639
    Width = 155
    Height = 25
    Caption = 'Preparar todos en la lista'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 248
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Ver todos'
    TabOrder = 9
    OnClick = Button7Click
  end
  object Button5: TButton
    Left = 8
    Top = 670
    Width = 134
    Height = 25
    Caption = 'Agrupar codigos'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 519
    Width = 691
    Height = 98
    BevelOuter = bvLowered
    TabOrder = 11
    object Label3: TLabel
      Left = 12
      Top = 8
      Width = 47
      Height = 13
      Caption = 'Direcci'#243'n:'
    end
    object direccion: TLabel
      Left = 12
      Top = 27
      Width = 669
      Height = 54
      AutoSize = False
      Caption = 'direccion'
      WordWrap = True
    end
  end
  object Button8: TButton
    Left = 292
    Top = 670
    Width = 155
    Height = 25
    Caption = 'Exportar codigos en lista'
    TabOrder = 12
    OnClick = Button8Click
  end
  object gridentregas: TDBGrid
    Left = 379
    Top = 393
    Width = 320
    Height = 120
    DataSource = Dentregas
    TabOrder = 13
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object progreso: TProgressBar
    Left = 104
    Top = 280
    Width = 504
    Height = 25
    TabOrder = 14
    Visible = False
  end
  object DSSubscripciones: TDataSource
    DataSet = ZQSubscripciones
    Left = 536
    Top = 168
  end
  object ZQSubscripciones: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQSubscripcionesAfterScroll
    Params = <>
    Left = 440
    Top = 168
  end
  object ZQPrepara: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 552
    Top = 296
  end
  object DataSource1: TDataSource
    Left = 520
    Top = 32
  end
  object ZQruta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 104
    Top = 24
  end
  object DSruta: TDataSource
    DataSet = ZQruta
    Left = 168
    Top = 24
  end
  object ZQdireccion: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 256
    Top = 312
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 624
    Top = 640
  end
  object ZQsubscripcionese: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 424
    Top = 232
  end
  object ZQdireccione: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 400
    Top = 344
  end
  object ZQinsertar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 552
    Top = 408
  end
  object ZQentregas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 392
    Top = 472
  end
  object Dentregas: TDataSource
    DataSet = ZQentregas
    Left = 576
    Top = 456
  end
end
