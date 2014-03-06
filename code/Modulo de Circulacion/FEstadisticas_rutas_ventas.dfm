object FestadisticasVEntas: TFestadisticasVEntas
  Left = 0
  Top = 0
  Caption = 'FestadisticasVEntas'
  ClientHeight = 440
  ClientWidth = 794
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
    Left = 204
    Top = 28
    Width = 75
    Height = 13
    Caption = 'Responsable:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object responsable: TLabel
    Left = 290
    Top = 28
    Width = 69
    Height = 13
    Caption = 'responsable'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridestadisticas: TDBGrid
    Left = 8
    Top = 51
    Width = 772
    Height = 329
    DataSource = DSEstadisticas
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
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Entregadas'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NoEntregadas'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Duplicadas'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora inicio'
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora fin'
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tiempo de ruta'
        Width = 123
        Visible = True
      end>
  end
  object crutas: TDBLookupComboBox
    Left = 56
    Top = 24
    Width = 129
    Height = 21
    ListSource = DSrutas
    TabOrder = 1
    OnCloseUp = crutasCloseUp
  end
  object Button1: TButton
    Left = 280
    Top = 397
    Width = 163
    Height = 25
    Caption = 'Ver orden en que se entrego'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 449
    Top = 397
    Width = 163
    Height = 25
    Caption = 'Ordenar ruta '
    Enabled = False
    TabOrder = 3
  end
  object Button3: TButton
    Left = 618
    Top = 397
    Width = 163
    Height = 25
    Caption = 'Exportar a Exel'
    Enabled = False
    TabOrder = 4
  end
  object Button4: TButton
    Left = 120
    Top = 397
    Width = 154
    Height = 25
    Caption = 'Ver incidencias'
    TabOrder = 5
  end
  object DSEstadisticas: TDataSource
    DataSet = ZQestadisticas
    Left = 688
    Top = 168
  end
  object DSrutas: TDataSource
    DataSet = ZQrutas
    Left = 232
    Top = 72
  end
  object ZQestadisticas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 536
    Top = 224
  end
  object ZQrutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 160
    Top = 72
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 432
    Top = 80
  end
end
