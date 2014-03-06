object FOrdenEntregaVentas: TFOrdenEntregaVentas
  Left = 0
  Top = 0
  Caption = 'FOrdenEntregaVentas'
  ClientHeight = 546
  ClientWidth = 733
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
    Left = 8
    Top = 8
    Width = 485
    Height = 13
    Caption = 
      'A continuaci'#243'n se muestra el orden en el que se entregaron las s' +
      'ubscripciones en el d'#237'a seleccionado.'
  end
  object Fecha: TLabel
    Left = 32
    Top = 32
    Width = 34
    Height = 14
    Caption = 'Fecha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 32
    Width = 99
    Height = 13
    Caption = 'Tiempo de recorrido:'
  end
  object tiempo: TLabel
    Left = 248
    Top = 32
    Width = 43
    Height = 14
    Caption = 'tiempo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridentregas: TDBGrid
    Left = 8
    Top = 50
    Width = 715
    Height = 487
    DataSource = DSentregas
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 238
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Municipio'
        Width = 386
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Visible = True
      end>
  end
  object ZQsubscripciones: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 136
    Top = 104
  end
  object ZQdireccion: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 232
    Top = 168
  end
  object ZQinsertar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 304
    Top = 232
  end
  object ZQentregas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 408
    Top = 296
  end
  object DSentregas: TDataSource
    DataSet = ZQsubscripciones
    Left = 232
    Top = 104
  end
end
