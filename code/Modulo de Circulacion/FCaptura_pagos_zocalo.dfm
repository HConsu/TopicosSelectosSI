object FCapturaZocalo: TFCapturaZocalo
  Left = 0
  Top = 0
  Caption = 'Captura de pagos Zocalo'
  ClientHeight = 758
  ClientWidth = 876
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
    Left = 32
    Top = 56
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object Label2: TLabel
    Left = 32
    Top = 88
    Width = 37
    Height = 13
    Caption = 'Nombre'
  end
  object Label3: TLabel
    Left = 296
    Top = 56
    Width = 49
    Height = 13
    Caption = 'No Edici'#243'n'
  end
  object Label4: TLabel
    Left = 16
    Top = 688
    Width = 179
    Height = 14
    Caption = 'Total datado en esta edici'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object totalzocalo: TLabel
    Left = 246
    Top = 689
    Width = 31
    Height = 14
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 16
    Top = 717
    Width = 211
    Height = 16
    Caption = 'Dotacion asiganada para Zocalo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object totalcirculacion: TLabel
    Left = 246
    Top = 719
    Width = 32
    Height = 16
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object codigo: TEdit
    Left = 80
    Top = 53
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '0'
    OnChange = codigoChange
    OnKeyPress = codigoKeyPress
  end
  object Combodis: TDBLookupComboBox
    Left = 80
    Top = 84
    Width = 217
    Height = 21
    KeyField = 'id_proveedor'
    ListField = 'nombre'
    ListSource = DSvoceador
    TabOrder = 1
    OnClick = CombodisClick
  end
  object GridDis: TDBGrid
    Left = 16
    Top = 128
    Width = 841
    Height = 545
    DataSource = DSGridDis
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridDisDrawColumnCell
    OnKeyPress = GridDisKeyPress
  end
  object Checkvendedor: TCheckBox
    Left = 80
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Por vendedor'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckvendedorClick
  end
  object Checkedicion: TCheckBox
    Left = 336
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Por Edici'#243'n'
    TabOrder = 4
    OnClick = CheckedicionClick
  end
  object noedicion: TEdit
    Left = 368
    Top = 53
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 5
    Text = '0'
  end
  object vertodo: TButton
    Left = 632
    Top = 20
    Width = 145
    Height = 25
    Caption = 'Ver todos los pagos'
    TabOrder = 6
    OnClick = vertodoClick
  end
  object bmarcar: TButton
    Left = 632
    Top = 51
    Width = 145
    Height = 25
    Caption = 'Marcar pagados'
    TabOrder = 7
    OnClick = bmarcarClick
  end
  object veredicion: TButton
    Left = 439
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Ver'
    Enabled = False
    TabOrder = 8
    OnClick = veredicionClick
  end
  object Button1: TButton
    Left = 632
    Top = 82
    Width = 145
    Height = 25
    Caption = 'Realizar corte'
    TabOrder = 9
    OnClick = Button1Click
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 312
    Top = 104
  end
  object ZQGridD: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 392
    Top = 184
  end
  object DSGridDis: TDataSource
    DataSet = ZQGridD
    Left = 504
    Top = 208
  end
  object ZQvoceador: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Active = True
    SQL.Strings = (
      'Select nombre,id_proveedor from c_proveedores_zocalo')
    Params = <>
    Left = 248
    Top = 80
  end
  object DSvoceador: TDataSource
    DataSet = ZQvoceador
    Left = 208
    Top = 80
  end
  object ZQtotales: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 360
    Top = 704
  end
end
