object FSuspenderEntrega: TFSuspenderEntrega
  Left = 0
  Top = 0
  Caption = 'Suspender entrega de subscripci'#243'n'
  ClientHeight = 541
  ClientWidth = 917
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
    Left = 536
    Top = 272
    Width = 320
    Height = 14
    Caption = 'O indique las condiciones y de clic en calcular fechas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 595
    Top = 368
    Width = 13
    Height = 13
    Caption = 'De'
  end
  object Label4: TLabel
    Left = 734
    Top = 368
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 628
    Height = 14
    Caption = 
      'Seleccione la subscripcion e indique la(s) fechas en las que se ' +
      'suspendera la entrega de la subscripcion.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 376
    Width = 443
    Height = 14
    Caption = 
      'Fechas programadas en que  se suspendera le entrega de la subscr' +
      'ipcion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridsubscripciones: TDBGrid
    Left = 8
    Top = 65
    Width = 505
    Height = 295
    DataSource = DSsubscripciones
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridsubscripcionesCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Nosubscripcion'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenciona'
        Width = 219
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Calle'
        Width = 163
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Colonia'
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Telefono'
        Visible = True
      end>
  end
  object calendario: TMonthCalendar
    Left = 527
    Top = 96
    Width = 191
    Height = 154
    Date = 40885.657762731480000000
    TabOrder = 1
  end
  object listafechas: TListBox
    Left = 776
    Top = 96
    Width = 121
    Height = 154
    ItemHeight = 13
    TabOrder = 2
    OnMouseUp = listafechasMouseUp
  end
  object Button1: TButton
    Left = 720
    Top = 160
    Width = 50
    Height = 25
    Caption = 'Agregar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 720
    Top = 191
    Width = 50
    Height = 25
    Caption = 'Quitar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object bsubs: TEdit
    Left = 16
    Top = 38
    Width = 65
    Height = 21
    TabOrder = 5
    OnKeyUp = bsubsKeyUp
  end
  object batencion: TEdit
    Left = 104
    Top = 38
    Width = 169
    Height = 21
    TabOrder = 6
    OnKeyUp = batencionKeyUp
  end
  object sabados: TCheckBox
    Left = 568
    Top = 300
    Width = 129
    Height = 17
    Caption = 'No entregar Sabados'
    TabOrder = 7
    OnClick = sabadosClick
  end
  object de: TDateTimePicker
    Left = 616
    Top = 364
    Width = 96
    Height = 21
    Date = 40885.598875868040000000
    Time = 40885.598875868040000000
    TabOrder = 8
  end
  object a: TDateTimePicker
    Left = 763
    Top = 364
    Width = 93
    Height = 21
    Date = 40885.598972083330000000
    Time = 40885.598972083330000000
    TabOrder = 9
  end
  object Aceptar: TButton
    Left = 663
    Top = 424
    Width = 115
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 10
    OnClick = AceptarClick
  end
  object periodo: TCheckBox
    Left = 568
    Top = 343
    Width = 146
    Height = 17
    Caption = 'No entregar en el periodo'
    TabOrder = 11
    OnClick = periodoClick
  end
  object domingos: TCheckBox
    Left = 568
    Top = 322
    Width = 129
    Height = 17
    Caption = 'No entregar Domingos'
    TabOrder = 12
    OnClick = domingosClick
  end
  object Button3: TButton
    Left = 763
    Top = 316
    Width = 126
    Height = 25
    Caption = 'Calcular'
    TabOrder = 13
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 800
    Top = 65
    Width = 75
    Height = 25
    Caption = 'Limpiar'
    TabOrder = 14
    OnClick = Button4Click
  end
  object gridfechas: TDBGrid
    Left = 16
    Top = 396
    Width = 161
    Height = 137
    DataSource = DSfechas
    TabOrder = 15
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 139
        Visible = True
      end>
  end
  object Button5: TButton
    Left = 216
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Eliminar fecha'
    TabOrder = 16
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 216
    Top = 439
    Width = 75
    Height = 25
    Caption = 'Eliminar todas'
    TabOrder = 17
    OnClick = Button6Click
  end
  object programados: TCheckBox
    Left = 335
    Top = 28
    Width = 170
    Height = 31
    Caption = 'Mostrar solo los programados para no entregar'
    TabOrder = 18
    WordWrap = True
    OnClick = programadosClick
  end
  object exportar: TButton
    Left = 527
    Top = 56
    Width = 130
    Height = 25
    Caption = 'Exportar a Excel'
    Enabled = False
    TabOrder = 19
    OnClick = exportarClick
  end
  object DSsubscripciones: TDataSource
    DataSet = ZQsubscripciones
    Left = 432
    Top = 185
  end
  object DataSource2: TDataSource
    Left = 720
    Top = 88
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 704
    Top = 32
  end
  object ZQsubscripciones: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 336
    Top = 185
  end
  object DSfechas: TDataSource
    DataSet = ZQfechas
    Left = 136
    Top = 464
  end
  object ZQfechas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 72
    Top = 456
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 632
    Top = 40
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Host = 'smtp.gmail.com'
    Password = 'saca730802uu7@'
    Port = 587
    SASLMechanisms = <>
    UseTLS = utUseExplicitTLS
    Username = 'angcartagena'
    Left = 536
    Top = 424
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 600
    Top = 424
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.gmail.com:587'
    Host = 'smtp.gmail.com'
    MaxLineAction = maException
    Port = 587
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 536
    Top = 480
  end
  object ZQcorreos: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 848
    Top = 432
  end
end
