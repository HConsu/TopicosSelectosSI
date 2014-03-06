object FAgruparCodigos: TFAgruparCodigos
  Left = 0
  Top = 0
  Caption = 'Agrupar subscripciones'
  ClientHeight = 384
  ClientWidth = 654
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
    Top = 24
    Width = 99
    Height = 14
    Caption = 'No subscripcion:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 52
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
  object Nosubscripcion: TLabel
    Left = 144
    Top = 24
    Width = 8
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object atenciona: TLabel
    Left = 128
    Top = 52
    Width = 7
    Height = 14
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 360
    Top = 8
    Width = 286
    Height = 37
    AutoSize = False
    Caption = 
      'Al agrupar codigos esta indicando que las subscripciones se entr' +
      'egaran en el mismo domicilio que el del subscriptor seleccionado' +
      ' en la lista.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 432
    Top = 89
    Width = 89
    Height = 25
    Caption = 'Agrupar con'
    TabOrder = 0
    OnClick = Button1Click
  end
  object gridsubscripciones: TDBGrid
    Left = 8
    Top = 120
    Width = 638
    Height = 256
    DataSource = DSsubscripciones
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NoSubscripcion'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenciona'
        Width = 448
        Visible = True
      end>
  end
  object nosubscripcionb: TEdit
    Left = 14
    Top = 93
    Width = 81
    Height = 21
    TabOrder = 2
    OnKeyUp = nosubscripcionbKeyUp
  end
  object atencionab: TEdit
    Left = 112
    Top = 93
    Width = 201
    Height = 21
    TabOrder = 3
    OnKeyUp = atencionabKeyUp
  end
  object ZQsubscripciones: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 312
    Top = 176
  end
  object DSsubscripciones: TDataSource
    DataSet = ZQsubscripciones
    Left = 408
    Top = 216
  end
  object ZQagrupar: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 568
    Top = 88
  end
end
