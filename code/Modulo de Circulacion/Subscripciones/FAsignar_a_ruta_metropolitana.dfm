object FAsignarARutaMetro: TFAsignarARutaMetro
  Left = 0
  Top = 0
  Caption = 'Asignar a ruta metropolitana'
  ClientHeight = 780
  ClientWidth = 725
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
    Left = 40
    Top = 32
    Width = 110
    Height = 14
    Caption = 'Nombre de la ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 64
    Width = 96
    Height = 14
    Caption = 'Numero de ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 96
    Width = 97
    Height = 14
    Caption = 'No Subscripci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LCalle: TLabel
    Left = 40
    Top = 136
    Width = 28
    Height = 14
    Caption = 'Calle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LColonia: TLabel
    Left = 40
    Top = 168
    Width = 45
    Height = 14
    Caption = 'Colonia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Ldescripcion: TLabel
    Left = 432
    Top = 110
    Width = 113
    Height = 13
    Caption = 'Descripci'#243'n del domicilio'
  end
  object Label4: TLabel
    Left = 40
    Top = 204
    Width = 24
    Height = 16
    Caption = 'C.P.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 239
    Top = 204
    Width = 59
    Height = 16
    Caption = 'Municipio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 156
    Top = 30
    Width = 230
    Height = 21
    KeyField = 'no_ruta'
    ListField = 'Nombre_ruta'
    ListSource = DSRutas
    TabOrder = 0
    OnClick = DBLookupComboBox1Click
  end
  object NoSubscripcion: TEdit
    Left = 156
    Top = 94
    Width = 46
    Height = 21
    TabOrder = 1
  end
  object DBGridRutas: TDBGrid
    Left = 24
    Top = 243
    Width = 681
    Height = 514
    DataSource = DSGridRuta
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Asignar: TButton
    Left = 232
    Top = 92
    Width = 105
    Height = 25
    Caption = 'Asignar a esta ruta'
    TabOrder = 3
    OnClick = AsignarClick
  end
  object Subir: TButton
    Left = 448
    Top = 24
    Width = 62
    Height = 33
    Caption = 'Subir'
    TabOrder = 4
    Visible = False
    OnClick = SubirClick
  end
  object Bajar: TButton
    Left = 450
    Top = 63
    Width = 61
    Height = 33
    Caption = 'Bajar'
    TabOrder = 5
    Visible = False
    OnClick = BajarClick
  end
  object Calle: TEdit
    Left = 97
    Top = 134
    Width = 313
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object Colonia: TEdit
    Left = 97
    Top = 169
    Width = 313
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Descripcion: TEdit
    Left = 432
    Top = 134
    Width = 273
    Height = 48
    AutoSize = False
    TabOrder = 8
  end
  object numeroruta: TDBEdit
    Left = 156
    Top = 62
    Width = 46
    Height = 21
    DataField = 'no_ruta'
    DataSource = DSRutas
    TabOrder = 9
  end
  object actualizar: TButton
    Left = 589
    Top = 204
    Width = 61
    Height = 33
    Caption = 'Actualizar'
    TabOrder = 10
    OnClick = actualizarClick
  end
  object aceptar: TButton
    Left = 589
    Top = 56
    Width = 61
    Height = 33
    Caption = 'Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = aceptarClick
  end
  object CP: TEdit
    Left = 97
    Top = 201
    Width = 105
    Height = 21
    Enabled = False
    TabOrder = 12
  end
  object Municipio: TEdit
    Left = 304
    Top = 196
    Width = 257
    Height = 21
    Enabled = False
    TabOrder = 13
  end
  object ZQrutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select * from c_rutas')
    Params = <>
    Left = 440
    Top = 24
  end
  object DSRutas: TDataSource
    DataSet = ZQrutas
    Left = 496
    Top = 24
  end
  object ZQGridRuta: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 600
    Top = 440
  end
  object DSGridRuta: TDataSource
    DataSet = ZQGridRuta
    Left = 600
    Top = 496
  end
  object ZQAgregar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 352
    Top = 80
  end
  object ZSordena: TZStoredProc
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 600
    Top = 272
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 600
    Top = 544
  end
end