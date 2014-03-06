object FQuejasSubscripciones: TFQuejasSubscripciones
  Left = 0
  Top = 0
  Caption = 'Quejas de la subscripcion'
  ClientHeight = 283
  ClientWidth = 694
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
  object GridQuejas: TDBGrid
    Left = -1
    Top = 0
    Width = 697
    Height = 246
    DataSource = DSquejas
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
        FieldName = 'Folio'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 128
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 214
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Solucion'
        Width = 210
        Visible = True
      end>
  end
  object DSquejas: TDataSource
    DataSet = ZQquejas
    Left = 624
    Top = 136
  end
  object ZQquejas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 544
    Top = 136
  end
end
