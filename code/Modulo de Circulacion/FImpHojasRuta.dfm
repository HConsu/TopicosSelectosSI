object Fimprimirrutas: TFimprimirrutas
  Left = 0
  Top = 0
  Caption = 'Imprimir hojas de ruta'
  ClientHeight = 540
  ClientWidth = 650
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
    Left = 40
    Top = 32
    Width = 232
    Height = 13
    Caption = 'Seleccione el tipo de reporte de rutas que desea'
  end
  object Label2: TLabel
    Left = 40
    Top = 104
    Width = 199
    Height = 13
    Caption = 'Imprimir todas las rutas de subscripciones'
  end
  object Label3: TLabel
    Left = 40
    Top = 336
    Width = 158
    Height = 13
    Caption = 'Imprimir todas las rutas foraneas'
  end
  object Label4: TLabel
    Left = 40
    Top = 157
    Width = 223
    Height = 13
    Caption = 'Imprimir lista de entregas en todos los edificios'
  end
  object Label5: TLabel
    Left = 40
    Top = 80
    Width = 96
    Height = 16
    Caption = 'Subscripciones'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 40
    Top = 304
    Width = 193
    Height = 16
    Caption = 'Rutas foraneas y vendedores'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 352
    Top = 104
    Width = 158
    Height = 13
    Caption = 'Imprimir solo la ruta seleccionada'
  end
  object Label8: TLabel
    Left = 352
    Top = 157
    Width = 171
    Height = 13
    Caption = 'Imprimir solo el edificio seleccionado'
  end
  object Label9: TLabel
    Left = 40
    Top = 387
    Width = 158
    Height = 13
    Caption = 'Imprimir solo la ruta seleccionada'
  end
  object Button1: TButton
    Left = 40
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 40
    Top = 355
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 40
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 552
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 3
  end
  object Button5: TButton
    Left = 552
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 4
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 352
    Top = 123
    Width = 158
    Height = 21
    KeyField = 'no_ruta'
    ListField = 'Nombre_ruta'
    ListSource = DSMetro
    TabOrder = 5
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 352
    Top = 176
    Width = 158
    Height = 21
    KeyField = 'id_edificio'
    ListField = 'descripcion'
    ListSource = DSEdificio
    TabOrder = 6
  end
  object Button6: TButton
    Left = 204
    Top = 406
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 7
  end
  object DBLookupComboBox3: TDBLookupComboBox
    Left = 40
    Top = 406
    Width = 145
    Height = 21
    KeyField = 'id_ruta'
    ListField = 'Nombre_ruta'
    ListSource = DSforaneas
    TabOrder = 8
  end
  object DSMetro: TDataSource
    DataSet = ZQmetro
    Left = 504
    Top = 72
  end
  object DSEdificio: TDataSource
    DataSet = ZQedificio
    Left = 488
    Top = 200
  end
  object DSforaneas: TDataSource
    DataSet = ZQforaneas
    Left = 248
    Top = 368
  end
  object ZQmetro: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select * from c_rutas')
    Params = <>
    Left = 552
    Top = 72
  end
  object ZQedificio: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select * from c_edificios')
    Params = <>
    Left = 424
    Top = 200
  end
  object ZQforaneas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select * from c_rutas_foraneas')
    Params = <>
    Left = 304
    Top = 368
  end
end
