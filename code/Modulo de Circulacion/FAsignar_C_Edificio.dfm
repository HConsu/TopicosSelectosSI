object FAsignarCEdificio: TFAsignarCEdificio
  Left = 0
  Top = 0
  Caption = 'Asignar codigo de edificio'
  ClientHeight = 439
  ClientWidth = 648
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
    Left = 24
    Top = 16
    Width = 101
    Height = 14
    Caption = 'Subscripcion No:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 38
    Width = 70
    Height = 14
    Caption = 'Atencion a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 101
    Width = 49
    Height = 14
    Caption = 'Edificios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 344
    Top = 101
    Width = 164
    Height = 14
    Caption = 'Subscriptores en el edificio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object nosubscripcion: TLabel
    Left = 144
    Top = 16
    Width = 8
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object atenciona: TLabel
    Left = 120
    Top = 38
    Width = 7
    Height = 14
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridedificios: TDBGrid
    Left = 8
    Top = 121
    Width = 305
    Height = 289
    DataSource = DSEdificios
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridedificiosCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 101
        Visible = True
      end>
  end
  object gridsubscripciones: TDBGrid
    Left = 319
    Top = 121
    Width = 321
    Height = 289
    DataSource = DSSubscriptores
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Nosubscripcion'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atencion'
        Width = 234
        Visible = True
      end>
  end
  object Asignar: TButton
    Left = 112
    Top = 73
    Width = 89
    Height = 25
    Caption = 'Asignar'
    TabOrder = 2
    OnClick = AsignarClick
  end
  object ZQedificios: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQedificiosAfterScroll
    Params = <>
    Left = 104
    Top = 256
  end
  object ZQSubscriptores: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 464
    Top = 256
  end
  object DSEdificios: TDataSource
    DataSet = ZQedificios
    Left = 208
    Top = 256
  end
  object DSSubscriptores: TDataSource
    DataSet = ZQSubscriptores
    Left = 568
    Top = 264
  end
  object ZQasignar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 224
    Top = 64
  end
end
