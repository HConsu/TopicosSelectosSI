object FcomentariosQuejas: TFcomentariosQuejas
  Left = 0
  Top = 0
  Caption = 'Comentarios del cliente'
  ClientHeight = 206
  ClientWidth = 472
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
    Left = 24
    Top = 16
    Width = 151
    Height = 16
    Caption = 'Comentarios del cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object comentarios: TMemo
    Left = 8
    Top = 38
    Width = 456
    Height = 129
    Lines.Strings = (
      'comentarios')
    TabOrder = 0
  end
  object Aceptar: TButton
    Left = 349
    Top = 173
    Width = 115
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = AceptarClick
  end
  object ZQcomentarios: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 344
    Top = 56
  end
end