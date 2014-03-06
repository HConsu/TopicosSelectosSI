object FNuevoCodigo: TFNuevoCodigo
  Left = 360
  Top = 225
  Caption = 'Asignar nuevo codigo'
  ClientHeight = 198
  ClientWidth = 480
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
    Top = 16
    Width = 97
    Height = 14
    Caption = 'No Subscripci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 35
    Width = 70
    Height = 14
    Caption = 'Atencion a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object nosubscripcionl: TLabel
    Left = 152
    Top = 16
    Width = 8
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object atencional: TLabel
    Left = 136
    Top = 35
    Width = 7
    Height = 14
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 32
    Top = 72
    Width = 88
    Height = 14
    Caption = 'Codigo actual:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 31
    Top = 144
    Width = 89
    Height = 14
    Caption = 'Codigo nuevo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cactual: TLabel
    Left = 136
    Top = 72
    Width = 43
    Height = 14
    Caption = 'cactual'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cnuevo: TLabel
    Left = 135
    Top = 145
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clOlive
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object generarb: TButton
    Left = 136
    Top = 104
    Width = 105
    Height = 25
    Caption = 'Generar'
    TabOrder = 0
    OnClick = generarbClick
  end
  object Aceptar: TButton
    Left = 135
    Top = 165
    Width = 106
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    Visible = False
    OnClick = AceptarClick
  end
  object ZQgenerar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 288
    Top = 96
  end
  object ZQinserta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 352
    Top = 96
  end
  object Barcode: TBarcode_EAN128
    TextPosition = tpBottomOut
    TextAlignment = taCenter
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -11
    TextFont.Name = 'Tahoma'
    TextFont.Style = []
    Ratio = 2.000000000000000000
    Left = 416
    Top = 96
  end
end
