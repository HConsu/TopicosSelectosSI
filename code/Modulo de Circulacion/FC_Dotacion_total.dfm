object FCTotal_dotacion: TFCTotal_dotacion
  Left = 0
  Top = 0
  Caption = 'Total de dotaci'#243'n'
  ClientHeight = 171
  ClientWidth = 331
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
    Width = 167
    Height = 16
    Caption = 'Indique la nueva dotaci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBNavigator1: TDBNavigator
    Left = 48
    Top = 88
    Width = 222
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbEdit, nbCancel, nbRefresh]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 116
    Top = 130
    Width = 109
    Height = 25
    Caption = 'Regresar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DBEdit1: TDBEdit
    Left = 48
    Top = 48
    Width = 121
    Height = 21
    DataField = 'dotaciontotal'
    DataSource = DataSource1
    TabOrder = 2
  end
  object ZTable1: TZTable
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    TableName = 'c_totales_dotacion'
    Left = 296
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = ZTable1
    Left = 280
    Top = 24
  end
end
