object FQuejasCerradas: TFQuejasCerradas
  Left = 206
  Top = 113
  Caption = 'Quejas ya resueltas'
  ClientHeight = 528
  ClientWidth = 807
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
    Top = 325
    Width = 40
    Height = 13
    Caption = 'Titular:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 344
    Width = 63
    Height = 13
    Caption = 'Atencion a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 365
    Width = 42
    Height = 13
    Caption = 'Motivo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 25
    Top = 417
    Width = 68
    Height = 13
    Caption = 'Descripci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 25
    Top = 473
    Width = 50
    Height = 13
    Caption = 'Soluci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object titular: TLabel
    Left = 80
    Top = 328
    Width = 3
    Height = 13
  end
  object atenciona: TLabel
    Left = 104
    Top = 347
    Width = 3
    Height = 13
  end
  object motivo: TLabel
    Left = 80
    Top = 368
    Width = 3
    Height = 13
  end
  object descripcion: TLabel
    Left = 99
    Top = 417
    Width = 585
    Height = 42
    AutoSize = False
    WordWrap = True
  end
  object solucion: TLabel
    Left = 91
    Top = 473
    Width = 593
    Height = 47
    AutoSize = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 25
    Top = 384
    Width = 92
    Height = 14
    Caption = 'Fecha soluci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lfsolucion: TLabel
    Left = 120
    Top = 384
    Width = 3
    Height = 13
  end
  object label20: TLabel
    Left = 392
    Top = 384
    Width = 73
    Height = 14
    Caption = 'Fecha Cierre'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lfcierre: TLabel
    Left = 480
    Top = 384
    Width = 3
    Height = 13
  end
  object GridQuejas: TDBGrid
    Left = 8
    Top = 16
    Width = 791
    Height = 297
    DataSource = DSquejas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = GridQuejasCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Folio'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'No. Subscripcion'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Motivo'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha de queja'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Estatus'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Otro motivo'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ruta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_resuelto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha_cierre'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 720
    Top = 476
    Width = 79
    Height = 25
    Caption = 'Salir'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 640
    Top = 319
    Width = 159
    Height = 25
    Caption = 'Ver historial de queja'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ZQuejas: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQuejasAfterScroll
    Params = <>
    Left = 736
    Top = 208
  end
  object DSquejas: TDataSource
    DataSet = ZQuejas
    Left = 664
    Top = 208
  end
  object ZQtmp: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    Params = <>
    Left = 608
    Top = 208
  end
end
