object Flogin: TFlogin
  Left = 566
  Top = 338
  Caption = 'Login'
  ClientHeight = 167
  ClientWidth = 171
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
    Left = 11
    Top = 8
    Width = 45
    Height = 14
    Caption = 'Usuario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 11
    Top = 54
    Width = 70
    Height = 14
    Caption = 'Contrase'#241'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object nombre: TEdit
    Left = 11
    Top = 27
    Width = 150
    Height = 21
    TabOrder = 0
  end
  object password: TEdit
    Left = 8
    Top = 73
    Width = 150
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = passwordKeyPress
  end
  object Button1: TButton
    Left = 40
    Top = 100
    Width = 97
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ZConnection1: TZConnection
    Catalog = 'desarrollo'
    Connected = True
    Protocol = 'mysql-5'
    HostName = '192.168.15.50'
    Database = 'desarrollo'
    User = 'independiente'
    Password = 'blankenship'
    Left = 128
    Top = 112
  end
  object ZQpassword: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 24
    Top = 112
  end
  object ZQbitacora: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 128
    Top = 16
  end
end
