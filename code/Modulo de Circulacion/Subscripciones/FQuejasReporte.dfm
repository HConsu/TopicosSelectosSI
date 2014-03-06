object FQuejasR: TFQuejasR
  Left = 0
  Top = 113
  Caption = 'Reportes de quejas'
  ClientHeight = 536
  ClientWidth = 980
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
    Left = 32
    Top = 24
    Width = 229
    Height = 13
    Caption = 'Seleccione el periodo que desa consultar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 31
    Top = 59
    Width = 33
    Height = 14
    Caption = 'Inicio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 200
    Top = 59
    Width = 17
    Height = 14
    Caption = 'Fin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 31
    Top = 404
    Width = 75
    Height = 13
    Caption = 'No de quejas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object total: TLabel
    Left = 111
    Top = 404
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object estatus: TLabel
    Left = 423
    Top = 404
    Width = 43
    Height = 13
    Caption = 'estatus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 31
    Top = 432
    Width = 121
    Height = 13
    Caption = 'Datos del Subscriptor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 31
    Top = 453
    Width = 63
    Height = 13
    Caption = 'Atenci'#243'n a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 32
    Top = 472
    Width = 55
    Height = 13
    Caption = 'Direcci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 31
    Top = 496
    Width = 108
    Height = 13
    Caption = 'Quejas levantadas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 352
    Top = 496
    Width = 92
    Height = 13
    Caption = 'Quejas abiertas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object atenciona: TLabel
    Left = 107
    Top = 453
    Width = 47
    Height = 13
    Caption = 'atenciona'
  end
  object direccion: TLabel
    Left = 107
    Top = 472
    Width = 42
    Height = 13
    Caption = 'direccion'
  end
  object tquejas: TLabel
    Left = 149
    Top = 497
    Width = 36
    Height = 13
    Caption = 'tquejas'
  end
  object tquejasa: TLabel
    Left = 460
    Top = 496
    Width = 42
    Height = 13
    Caption = 'tquejasa'
  end
  object finicio: TDateTimePicker
    Left = 70
    Top = 56
    Width = 89
    Height = 21
    Date = 40820.597459490740000000
    Time = 40820.597459490740000000
    TabOrder = 0
    OnChange = finicioChange
  end
  object ffin: TDateTimePicker
    Left = 223
    Top = 56
    Width = 89
    Height = 21
    Date = 40820.597537071760000000
    Time = 40820.597537071760000000
    TabOrder = 1
    OnChange = ffinChange
  end
  object GridQuejas: TDBGrid
    Left = 8
    Top = 83
    Width = 964
    Height = 310
    DataSource = DSQuejas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = GridQuejasCellClick
    OnDrawColumnCell = GridQuejasDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Folio'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nosubscripcion'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Responsable'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 231
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Solucion'
        Width = 239
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'status'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_cierre'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 736
    Top = 17
    Width = 105
    Height = 25
    Caption = 'Reporte'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 736
    Top = 48
    Width = 105
    Height = 25
    Caption = 'Exportar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Checkrutas: TCheckBox
    Left = 368
    Top = 33
    Width = 185
    Height = 17
    Caption = 'Solo de la ruta seleccionada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = CheckrutasClick
  end
  object rutas: TDBLookupComboBox
    Left = 392
    Top = 56
    Width = 145
    Height = 21
    Enabled = False
    KeyField = 'no_ruta'
    ListField = 'Nombre_ruta'
    ListSource = DSrutas
    TabOrder = 6
    OnCloseUp = rutasCloseUp
  end
  object Button3: TButton
    Left = 704
    Top = 399
    Width = 129
    Height = 25
    Caption = 'Ver historial de queja'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 839
    Top = 399
    Width = 129
    Height = 25
    Caption = 'Quejas del subscriptor'
    TabOrder = 8
    OnClick = Button4Click
  end
  object DSQuejas: TDataSource
    DataSet = ZQuejas
    Left = 632
    Top = 128
  end
  object ZQuejas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQuejasAfterScroll
    Params = <>
    Left = 568
    Top = 120
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 856
    Top = 48
  end
  object DSrutas: TDataSource
    DataSet = ZQrutas
    Left = 640
    Top = 32
  end
  object ZQrutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select no_ruta,Nombre_ruta,id_responsable_ruta from c_rutas')
    Params = <>
    Left = 584
    Top = 32
  end
  object ZQdatos: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 720
    Top = 448
  end
end
