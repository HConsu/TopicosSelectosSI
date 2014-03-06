object FRemisionRutas: TFRemisionRutas
  Left = 0
  Top = 0
  Caption = 'Consulta de remisi'#243'n por ruta'
  ClientHeight = 593
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 241
    Height = 14
    Caption = 'Seleccione la fecha  para ver la remisi'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 41
    Width = 90
    Height = 14
    Caption = 'Filtrar por ruta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 560
    Width = 98
    Height = 14
    Caption = 'Total de la ruta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ltotal: TLabel
    Left = 129
    Top = 560
    Width = 33
    Height = 14
    Caption = 'ltotal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 67
    Width = 77
    Height = 14
    Caption = 'Responsable'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object responsable: TLabel
    Left = 131
    Top = 68
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridremision: TDBGrid
    Left = 8
    Top = 96
    Width = 673
    Height = 449
    DataSource = Dsremision
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Edicion'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nombre'
        Width = 340
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dotacion'
        Width = 93
        Visible = True
      end>
  end
  object fecha: TDateTimePicker
    Left = 271
    Top = 8
    Width = 100
    Height = 21
    Date = 41305.719322638890000000
    Time = 41305.719322638890000000
    TabOrder = 1
    OnChange = fechaChange
  end
  object Crutas: TDBLookupComboBox
    Left = 129
    Top = 38
    Width = 120
    Height = 21
    ListSource = DSrutas
    TabOrder = 2
    OnCloseUp = CrutasCloseUp
  end
  object Button1: TButton
    Left = 456
    Top = 41
    Width = 137
    Height = 25
    Caption = 'Exportar a Excel'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ZQrutas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 264
    Top = 48
  end
  object ZQremision: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 312
    Top = 160
  end
  object DSrutas: TDataSource
    DataSet = ZQrutas
    Left = 320
    Top = 48
  end
  object Dsremision: TDataSource
    DataSet = ZQremision
    Left = 368
    Top = 160
  end
  object ZQvendedores: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 472
    Top = 160
  end
  object ZQtotal: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 560
    Top = 160
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 624
    Top = 24
  end
  object ZQresponsable: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 384
    Top = 320
  end
end
