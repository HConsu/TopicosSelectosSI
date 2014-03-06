object FReactivar: TFReactivar
  Left = 0
  Top = 0
  Caption = 'Reactivar suscripcion'
  ClientHeight = 281
  ClientWidth = 768
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
    Top = 16
    Width = 491
    Height = 16
    Caption = 
      'Se encontraron las siguientes suscripciones, Haga soble clic en ' +
      'la que desea reactivar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 38
    Width = 752
    Height = 235
    DataSource = DSreactiva
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nosubscripcion'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 177
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenciona'
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Calle'
        Width = 190
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Colonia'
        Width = 202
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion_dir'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Area'
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_sol_cancelacion'
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_ultimo_ejemplar'
        Width = 119
        Visible = True
      end>
  end
  object ZQreactiva: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 456
    Top = 112
  end
  object DSreactiva: TDataSource
    DataSet = ZQreactiva
    Left = 320
    Top = 120
  end
end
