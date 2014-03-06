object FCambio_Factura: TFCambio_Factura
  Left = 0
  Top = 0
  Caption = 'Cambiar numero de factura'
  ClientHeight = 401
  ClientWidth = 674
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
    Top = 24
    Width = 340
    Height = 13
    Caption = 
      'Seleccione la subscripcion a la que desea cambiar el numero de F' +
      'actura'
  end
  object Label2: TLabel
    Left = 17
    Top = 291
    Width = 73
    Height = 25
    AutoSize = False
    Caption = 'Nuevo numero de factura'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 400
    Top = 291
    Width = 266
    Height = 47
    AutoSize = False
    Caption = 
      'En esta pantalla solo se mostraran las subscripciones canceladas' +
      ' que tienen adeudo y por tanto requieren la cancelaci'#243'n de factu' +
      'ra y asignaci'#243'n de una nueva.'
    WordWrap = True
  end
  object GridFactura: TDBGrid
    Left = 8
    Top = 43
    Width = 658
    Height = 230
    DataSource = DSFactura
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object factura: TEdit
    Left = 96
    Top = 295
    Width = 105
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 216
    Top = 286
    Width = 105
    Height = 25
    Caption = 'Asignar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Salir: TButton
    Left = 280
    Top = 344
    Width = 121
    Height = 33
    Caption = 'Salir'
    TabOrder = 3
    OnClick = SalirClick
  end
  object ZQfactura: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    SQL.Strings = (
      
        'Select NoSubscriptor,NoSubscripcion,factura,Fecha_sol_cancelacio' +
        'n AS "Fecha cancelaci'#243'n", Adeudo_de_subscripcion AS Adeudo,descr' +
        'ipcion from t_cancelacion where cambiar_factura = 1')
    Params = <>
    Left = 80
    Top = 336
  end
  object ZQcfactura: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 224
    Top = 312
  end
  object DSFactura: TDataSource
    DataSet = ZQfactura
    Left = 176
    Top = 336
  end
end
