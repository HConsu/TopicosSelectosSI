object FCanceladasR: TFCanceladasR
  Left = 0
  Top = 0
  Caption = 'Subscripciones Canceladas en la ruta'
  ClientHeight = 348
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mostrando: TLabel
    Left = 8
    Top = 327
    Width = 263
    Height = 13
    Caption = 'Mostrando los cancelados en los ultimos 7 dias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridcancelados: TDBGrid
    Left = 0
    Top = 8
    Width = 756
    Height = 306
    DataSource = DSCancelados
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NoSubscripcion'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AtencionA'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Calle'
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Colonia'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 109
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_sol_cancelacion'
        Width = 137
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 643
    Top = 320
    Width = 113
    Height = 25
    Caption = 'Exportar a Exel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 456
    Top = 320
    Width = 181
    Height = 25
    Caption = 'Ver todos los cancelados de la ruta'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ZQcancelados: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 464
    Top = 144
  end
  object DSCancelados: TDataSource
    DataSet = ZQcancelados
    Left = 544
    Top = 136
  end
  object Excel: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 672
    Top = 144
  end
end
