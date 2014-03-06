object FAltaQueja: TFAltaQueja
  Left = 0
  Top = 0
  Caption = 'Alta de queja'
  ClientHeight = 648
  ClientWidth = 653
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
    Left = 71
    Top = 57
    Width = 75
    Height = 13
    Caption = 'No Subscripci'#243'n'
  end
  object Label2: TLabel
    Left = 70
    Top = 84
    Width = 37
    Height = 13
    Caption = 'Nombre'
  end
  object TLabel
    Left = 56
    Top = 320
    Width = 75
    Height = 13
    Caption = 'No Subscripcion'
  end
  object Label3: TLabel
    Left = 56
    Top = 352
    Width = 56
    Height = 13
    Caption = 'Atenci'#243'n A:'
  end
  object Label4: TLabel
    Left = 56
    Top = 449
    Width = 43
    Height = 13
    Caption = 'Direcci'#243'n'
  end
  object Label5: TLabel
    Left = 56
    Top = 288
    Width = 22
    Height = 13
    Caption = 'Folio'
  end
  object Label6: TLabel
    Left = 232
    Top = 16
    Width = 156
    Height = 19
    Caption = 'Buscar  Subscriptor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 233
    Top = 256
    Width = 155
    Height = 19
    Caption = 'Detalle de la queja'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 56
    Top = 521
    Width = 114
    Height = 13
    Caption = 'Descripci'#243'n de la queja:'
  end
  object Label9: TLabel
    Left = 472
    Top = 288
    Width = 29
    Height = 13
    Caption = 'Fecha'
  end
  object Label10: TLabel
    Left = 58
    Top = 426
    Width = 32
    Height = 13
    Caption = 'Motivo'
  end
  object LDescripcion: TLabel
    Left = 339
    Top = 426
    Width = 32
    Height = 13
    Caption = 'Motivo'
    Visible = False
  end
  object Label11: TLabel
    Left = 296
    Top = 320
    Width = 23
    Height = 13
    Caption = 'Ruta'
  end
  object Label12: TLabel
    Left = 56
    Top = 384
    Width = 30
    Height = 13
    Caption = 'Titular'
  end
  object CheckSubscripcion: TCheckBox
    Left = 48
    Top = 56
    Width = 17
    Height = 17
    TabOrder = 0
    OnClick = CheckSubscripcionClick
  end
  object CheckAtenciona: TCheckBox
    Left = 47
    Top = 83
    Width = 17
    Height = 17
    TabOrder = 1
    OnClick = CheckAtencionaClick
  end
  object NoSubscripcionb: TEdit
    Left = 152
    Top = 54
    Width = 145
    Height = 21
    Enabled = False
    TabOrder = 2
    OnKeyPress = NoSubscripcionbKeyPress
  end
  object Nombre: TEdit
    Left = 129
    Top = 81
    Width = 225
    Height = 21
    Enabled = False
    TabOrder = 3
    OnKeyPress = NombreKeyPress
  end
  object Buscar: TButton
    Left = 384
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 4
    OnClick = BuscarClick
  end
  object DBGridSubscripciones: TDBGrid
    Left = 8
    Top = 121
    Width = 637
    Height = 129
    DataSource = DSSubscripciones
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGridSubscripcionesCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'No Subscripci'#243'n'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenci'#243'n a'
        Width = 129
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_alta'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_inicio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fin'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'telefono'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Observaciones'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipo_subscripcion'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Titular'
        Width = 71
        Visible = True
      end>
  end
  object Direccion: TMemo
    Left = 56
    Top = 468
    Width = 225
    Height = 44
    Lines.Strings = (
      'Direccion')
    TabOrder = 6
  end
  object Atenciona: TEdit
    Left = 120
    Top = 352
    Width = 289
    Height = 21
    TabOrder = 7
  end
  object NoSubscripcion: TEdit
    Left = 137
    Top = 317
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object Folio: TEdit
    Left = 96
    Top = 285
    Width = 81
    Height = 21
    TabOrder = 9
  end
  object descripcion: TMemo
    Left = 56
    Top = 540
    Width = 553
    Height = 54
    Lines.Strings = (
      '')
    TabOrder = 10
  end
  object Aceptar: TButton
    Left = 208
    Top = 608
    Width = 89
    Height = 32
    Caption = 'Aceptar'
    Enabled = False
    TabOrder = 11
    OnClick = AceptarClick
  end
  object Cancelar: TButton
    Left = 303
    Top = 608
    Width = 90
    Height = 32
    Caption = 'Cancelar'
    TabOrder = 12
    OnClick = CancelarClick
  end
  object Fecha: TEdit
    Left = 515
    Top = 285
    Width = 102
    Height = 21
    Enabled = False
    TabOrder = 13
  end
  object MotivoQueja: TDBLookupComboBox
    Left = 120
    Top = 422
    Width = 145
    Height = 21
    KeyField = 'id_motivo'
    ListField = 'motivo'
    ListSource = DSMotivoqueja
    TabOrder = 14
    OnClick = MotivoQuejaClick
  end
  object Descripcionmotivo: TEdit
    Left = 391
    Top = 423
    Width = 210
    Height = 21
    TabOrder = 15
    Visible = False
  end
  object ruta: TEdit
    Left = 324
    Top = 317
    Width = 47
    Height = 21
    TabOrder = 16
  end
  object titular: TEdit
    Left = 96
    Top = 379
    Width = 313
    Height = 21
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
  end
  object Button1: TButton
    Left = 472
    Top = 90
    Width = 173
    Height = 25
    Caption = 'Ver otras quejas del subscriptor'
    TabOrder = 18
    OnClick = Button1Click
  end
  object Imprimir: TButton
    Left = 399
    Top = 608
    Width = 90
    Height = 32
    Caption = 'Imprimir'
    Enabled = False
    TabOrder = 19
    OnClick = ImprimirClick
  end
  object Button2: TButton
    Left = 488
    Top = 320
    Width = 157
    Height = 25
    Caption = 'Ver Historial de entregas'
    TabOrder = 20
    OnClick = Button2Click
  end
  object ZQSubscripcion: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 232
    Top = 136
  end
  object DSSubscripciones: TDataSource
    DataSet = ZQSubscripcion
    Left = 312
    Top = 136
  end
  object ZQQueja: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 440
    Top = 176
  end
  object DSMotivoqueja: TDataSource
    DataSet = ZQMotivoQueja
    Left = 512
    Top = 440
  end
  object ZQMotivoQueja: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    SQL.Strings = (
      'Select * from c_motivo_queja')
    Params = <>
    Left = 576
    Top = 472
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 424
    Top = 488
  end
end
