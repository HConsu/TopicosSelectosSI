object Fver: TFver
  Left = 0
  Top = 0
  Caption = 'Ver notas'
  ClientHeight = 274
  ClientWidth = 677
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
    Left = 16
    Top = 8
    Width = 204
    Height = 16
    Caption = 'Mostrando notas del la subscripcion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object nosubscripcion: TLabel
    Left = 240
    Top = 8
    Width = 91
    Height = 14
    Caption = 'nosubscripcion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridnotas: TDBGrid
    Left = 8
    Top = 30
    Width = 661
    Height = 203
    DataSource = DSver
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Fecha'
        Width = 148
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nota'
        Width = 493
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 586
    Top = 241
    Width = 83
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DSver: TDataSource
    DataSet = ZQver
    Left = 456
    Top = 224
  end
  object ZQver: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 400
    Top = 224
  end
end
