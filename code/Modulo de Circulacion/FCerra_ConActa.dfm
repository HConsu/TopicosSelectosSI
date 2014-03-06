object FCierreConActa: TFCierreConActa
  Left = 0
  Top = 0
  Caption = 'Datos del motivo de cierre'
  ClientHeight = 209
  ClientWidth = 472
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
    Width = 443
    Height = 32
    AutoSize = False
    Caption = 
      'Por favor indique porque se est'#225' cerrando esta queja, si existe ' +
      'alg'#250'n documento que lo avale indique el numero de documento.'
    WordWrap = True
  end
  object motivo: TMemo
    Left = 8
    Top = 54
    Width = 456
    Height = 118
    Lines.Strings = (
      'motivo')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 336
    Top = 176
    Width = 128
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ZQcomentarios: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 224
    Top = 112
  end
end
