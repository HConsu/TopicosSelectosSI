object FIncidencias: TFIncidencias
  Left = 0
  Top = 0
  Caption = 'Incidencias'
  ClientHeight = 397
  ClientWidth = 765
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
    Left = 24
    Top = 363
    Width = 93
    Height = 13
    Caption = 'Total de incidencias'
  end
  object total: TLabel
    Left = 134
    Top = 363
    Width = 6
    Height = 13
    Caption = '0'
  end
  object gridincidencias: TDBGrid
    Left = 8
    Top = 25
    Width = 749
    Height = 320
    DataSource = DSincidencias
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Direccion'
        Width = 411
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenciona'
        Width = 215
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 104
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 628
    Top = 351
    Width = 129
    Height = 38
    Caption = 'Exportar a Excel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DSincidencias: TDataSource
    DataSet = ZQincidencias
    Left = 384
    Top = 168
  end
  object ZQincidencias: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 384
    Top = 104
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 520
    Top = 160
  end
end
