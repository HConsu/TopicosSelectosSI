object FHistorialEntrega: TFHistorialEntrega
  Left = 0
  Top = 0
  Caption = 'Historial de entrega'
  ClientHeight = 617
  ClientWidth = 655
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
    Left = 16
    Top = 8
    Width = 225
    Height = 14
    Caption = 'Historial de entrega de la suscripci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lnosubs: TLabel
    Left = 259
    Top = 8
    Width = 8
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Entregas: TLabel
    Left = 8
    Top = 41
    Width = 58
    Height = 16
    Caption = 'Entregas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Incidencias: TLabel
    Left = 330
    Top = 41
    Width = 72
    Height = 16
    Caption = 'Incidencias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 60
    Width = 297
    Height = 541
    DataSource = DShistorial
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
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Width = 125
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 330
    Top = 60
    Width = 303
    Height = 541
    DataSource = DSincidencia
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 193
        Visible = True
      end>
  end
  object DShistorial: TDataSource
    DataSet = ZQhistorial
    Left = 120
    Top = 200
  end
  object ZQhistorial: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 152
    Top = 272
  end
  object ZQincidencia: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 496
    Top = 208
  end
  object DSincidencia: TDataSource
    DataSet = ZQincidencia
    Left = 440
    Top = 176
  end
end
