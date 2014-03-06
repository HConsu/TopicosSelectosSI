object FDescripcionIncidente: TFDescripcionIncidente
  Left = 0
  Top = 0
  Caption = 'Descripcion del incidente'
  ClientHeight = 171
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 151
    Height = 14
    Caption = 'Descripci'#243'n del incidente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 32
    Width = 464
    Height = 105
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Aceptar: TButton
    Left = 397
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = AceptarClick
  end
  object ZQincidente: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 392
    Top = 48
  end
  object DSincidente: TDataSource
    Left = 320
    Top = 48
  end
end
