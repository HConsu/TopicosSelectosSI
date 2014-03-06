object FPassword: TFPassword
  Left = 486
  Top = 279
  Caption = 'Password'
  ClientHeight = 156
  ClientWidth = 192
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
    Left = 24
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object nombre: TEdit
    Left = 24
    Top = 27
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object password: TEdit
    Left = 24
    Top = 75
    Width = 137
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = passwordKeyPress
  end
  object Button1: TButton
    Left = 56
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ZConnection1: TZConnection
    Catalog = 'independiente'
    Connected = True
    Protocol = 'mysql-5'
    HostName = '192.168.15.50'
    Database = 'desarrollo'
    User = 'independiente'
    Password = 'blankenship'
    Left = 144
    Top = 96
  end
  object ZQpassword: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 16
    Top = 104
  end
  object ZQbitacora: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 160
    Top = 32
  end
end
