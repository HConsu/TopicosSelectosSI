object FGrupos_codigos: TFGrupos_codigos
  Left = 0
  Top = 0
  Caption = 'Listado de codigos agrupados'
  ClientHeight = 490
  ClientWidth = 782
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
    Left = 25
    Top = 31
    Width = 272
    Height = 14
    Caption = 'Codigos que tienen mas de una subscripcion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 383
    Top = 31
    Width = 362
    Height = 14
    Caption = 'Direcciones y titulares agrupados en el codigo seleccionado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridcodigos: TDBGrid
    Left = 16
    Top = 51
    Width = 305
    Height = 400
    DataSource = DScodigos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Width = 115
        Visible = True
      end>
  end
  object gridsubscripciones: TDBGrid
    Left = 344
    Top = 51
    Width = 430
    Height = 400
    DataSource = DSagrupados
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NoSubs'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Calle'
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Colonia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Titular'
        Width = 157
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 600
    Top = 457
    Width = 145
    Height = 25
    Caption = 'Exportar a Excel'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 457
    Width = 145
    Height = 25
    Caption = 'Exportar a Excel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ZQCodigos: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQCodigosAfterScroll
    Params = <>
    Left = 112
    Top = 216
  end
  object DScodigos: TDataSource
    DataSet = ZQCodigos
    Left = 136
    Top = 296
  end
  object ZQagrupados: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 520
    Top = 224
  end
  object DSagrupados: TDataSource
    DataSet = ZQagrupados
    Left = 632
    Top = 312
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 464
    Top = 392
  end
end
