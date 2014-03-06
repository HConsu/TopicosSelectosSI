object FPassword: TFPassword
  Left = 265
  Top = 279
  Caption = 'Solicitar Autorizaci'#243'n'
  ClientHeight = 125
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 16
    Width = 176
    Height = 13
    Caption = 'Introduzca su c'#243'digo de autorizaci'#243'n'
  end
  object codigo: TEdit
    Left = 72
    Top = 35
    Width = 152
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = codigoKeyPress
  end
  object Button1: TButton
    Left = 56
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 157
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ZQautorizacion: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 256
    Top = 40
  end
end
