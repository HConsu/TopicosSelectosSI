object FNuevosR: TFNuevosR
  Left = 0
  Top = 0
  Caption = 'Nuevas subscripciones de la ruta'
  ClientHeight = 335
  ClientWidth = 712
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
  object mostrando: TLabel
    Left = 8
    Top = 303
    Width = 327
    Height = 13
    Caption = 'Mostrando las nuevas subscripciones de los ultimos 7 dias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridnuevas: TDBGrid
    Left = 3
    Top = 8
    Width = 701
    Height = 289
    DataSource = DSNuevas
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
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AtencionA'
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_alta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Observaciones'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Inconsistencias'
        Width = 119
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 568
    Top = 303
    Width = 136
    Height = 25
    Caption = 'Exportar a Exel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DSNuevas: TDataSource
    DataSet = ZQnuevas
    Left = 544
    Top = 136
  end
  object ZQnuevas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 424
    Top = 136
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 608
    Top = 224
  end
end
