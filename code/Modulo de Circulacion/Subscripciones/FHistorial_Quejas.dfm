object FHistorialQueja: TFHistorialQueja
  Left = 360
  Top = 281
  Caption = 'Historial de la queja'
  ClientHeight = 249
  ClientWidth = 550
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
  object gridhistorial: TDBGrid
    Left = 1
    Top = 2
    Width = 546
    Height = 241
    DataSource = DShistorial
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Movimiento'
        Width = 289
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Usuario'
        Width = 120
        Visible = True
      end>
  end
  object DShistorial: TDataSource
    DataSet = ZQhistorial
    Left = 496
    Top = 168
  end
  object ZQhistorial: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 408
    Top = 168
  end
end
