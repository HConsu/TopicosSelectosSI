object FactivarEntrega: TFactivarEntrega
  Left = 0
  Top = 0
  Caption = 'Activar desactivar entrega'
  ClientHeight = 265
  ClientWidth = 470
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
  object activo: TCheckBox
    Left = 88
    Top = 8
    Width = 289
    Height = 25
    Caption = 
      'Enviar notificaci'#243'n de entrega de la ruta de ventas a los correo' +
      's indicados?'
    TabOrder = 0
    WordWrap = True
    OnClick = activoClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 449
    Height = 169
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Correo'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 304
    Top = 231
    Width = 153
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object DataSource1: TDataSource
    DataSet = ZTable1
    Left = 112
    Top = 96
  end
  object ZTable1: TZTable
    Connection = Flogin.ZConnection1
    Active = True
    TableName = 't_correo_notificacion_ruta_ventas'
    Left = 176
    Top = 120
  end
  object ZQactivo: TZQuery
    Connection = Flogin.ZConnection1
    Params = <>
    Left = 408
    Top = 24
  end
  object ZQbitacora: TZQuery
    Connection = Flogin.ZConnection1
    Params = <>
    Left = 392
    Top = 136
  end
end
