object FBuscarSupervisor: TFBuscarSupervisor
  Left = 0
  Top = 0
  Caption = 'Buscar subscriptor'
  ClientHeight = 462
  ClientWidth = 843
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
    Top = 70
    Width = 37
    Height = 13
    Caption = 'Nombre'
  end
  object Label3: TLabel
    Left = 32
    Top = 8
    Width = 213
    Height = 13
    Caption = 'Capture el criterio para buscar el subscriptor'
  end
  object Label4: TLabel
    Left = 512
    Top = 8
    Width = 239
    Height = 28
    AutoSize = False
    Caption = 
      'Seleccione un subscriptor para mostrar en la parte de abajo los ' +
      'datos de la subscripci'#243'n.'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 32
    Top = 312
    Width = 79
    Height = 13
    Caption = 'No. Subscripci'#243'n'
  end
  object Label6: TLabel
    Left = 32
    Top = 344
    Width = 55
    Height = 13
    Caption = 'Atenci'#243'n a:'
  end
  object Label7: TLabel
    Left = 32
    Top = 376
    Width = 47
    Height = 13
    Caption = 'Direcci'#243'n:'
  end
  object nosubscripcion: TLabel
    Left = 136
    Top = 311
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object atenciona: TLabel
    Left = 106
    Top = 344
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object direccion: TLabel
    Left = 106
    Top = 376
    Width = 549
    Height = 49
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label11: TLabel
    Left = 288
    Top = 311
    Width = 23
    Height = 13
    Caption = 'Ruta'
  end
  object ruta: TLabel
    Left = 344
    Top = 311
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 472
    Top = 311
    Width = 37
    Height = 13
    Caption = 'Edificio:'
  end
  object edificio: TLabel
    Left = 528
    Top = 311
    Width = 4
    Height = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gridsubscripciones: TDBGrid
    Left = 8
    Top = 94
    Width = 825
    Height = 195
    DataSource = DSsubscripciones
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridsubscripcionesCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Nosubscripcion'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Atenciona'
        Width = 216
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ruta'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Edificio'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Calle'
        Width = 198
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Colonia'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descripcion'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Telefono'
        Width = 91
        Visible = True
      end>
  end
  object bnombre: TEdit
    Left = 80
    Top = 67
    Width = 217
    Height = 21
    TabOrder = 1
    OnKeyUp = bnombreKeyUp
  end
  object bdireccion: TEdit
    Left = 416
    Top = 67
    Width = 201
    Height = 21
    TabOrder = 2
    OnKeyPress = bdireccionKeyPress
    OnKeyUp = bdireccionKeyUp
  end
  object Button1: TButton
    Left = 720
    Top = 400
    Width = 97
    Height = 33
    Caption = 'Salir'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ZQsubscripciones: TZQuery
    Connection = FPrincipalCirculacion.ZConexion
    AfterScroll = ZQsubscripcionesAfterScroll
    Params = <>
    Left = 480
    Top = 192
  end
  object DSsubscripciones: TDataSource
    DataSet = ZQsubscripciones
    Left = 384
    Top = 192
  end
end