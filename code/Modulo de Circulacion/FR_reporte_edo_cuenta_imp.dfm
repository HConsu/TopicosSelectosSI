object FR_Edo_cuenta: TFR_Edo_cuenta
  Left = 0
  Top = 0
  Caption = 'Reporte estado de cuenta'
  ClientHeight = 644
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object ReporteEdoCuenta: TQuickRep
    Left = 9
    Top = 24
    Width = 816
    Height = 1056
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRLOOPBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      '0')
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = Letter
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2794.000000000000000000
      100.000000000000000000
      2159.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object TitleBand1: TQRBand
      Left = 38
      Top = 123
      Width = 740
      Height = 90
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        238.125000000000000000
        1957.916666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRLabel2: TQRLabel
        Left = 228
        Top = 6
        Width = 277
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666660000
          603.250000000000000000
          15.875000000000000000
          732.895833333333400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'REPORTE DE ESTADO DE CUENTA'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object QRLabel3: TQRLabel
        Left = 8
        Top = 32
        Width = 110
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          84.666666666666680000
          291.041666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Codigo Distribuidor'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 8
        Top = 55
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          21.166666666666670000
          145.520833333333300000
          174.625000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Distribuidor'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 328
        Top = 32
        Width = 21
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          867.833333333333500000
          84.666666666666680000
          55.562500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'De:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 426
        Top = 32
        Width = 14
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1127.125000000000000000
          84.666666666666680000
          37.041666666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'A:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object codigo: TQRLabel
        Left = 136
        Top = 32
        Width = 39
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          359.833333333333400000
          84.666666666666680000
          103.187500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'codigo'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object Nombre: TQRLabel
        Left = 96
        Top = 55
        Width = 46
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          254.000000000000000000
          145.520833333333300000
          121.708333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Nombre'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object fechai: TQRLabel
        Left = 355
        Top = 32
        Width = 35
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          939.270833333333400000
          84.666666666666680000
          92.604166666666680000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'fechai'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object fechaf: TQRLabel
        Left = 446
        Top = 32
        Width = 35
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1180.041666666667000000
          84.666666666666680000
          92.604166666666680000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'fechaf'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel23: TQRLabel
        Left = 328
        Top = 55
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          867.833333333333500000
          145.520833333333300000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Tarifa:'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object tarifa: TQRLabel
        Left = 375
        Top = 55
        Width = 29
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          992.187500000000000000
          145.520833333333300000
          76.729166666666680000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'tarifa'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel25: TQRLabel
        Left = 367
        Top = 55
        Width = 8
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.270833333333330000
          971.020833333333400000
          145.520833333333300000
          21.166666666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '$'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object SummaryBand1: TQRBand
      Left = 38
      Top = 269
      Width = 740
      Height = 108
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = DetailBand1
      Size.Values = (
        285.750000000000000000
        1957.916666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object SumaD: TQRExpr
        Left = 437
        Top = 16
        Width = 44
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1156.229166666667000000
          42.333333333333340000
          116.416666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel13: TQRLabel
        Left = 119
        Top = 16
        Width = 114
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          42.333333333333340000
          301.625000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Total de dotaciones'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel14: TQRLabel
        Left = 119
        Top = 39
        Width = 107
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          103.187500000000000000
          283.104166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Total devoluciones'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel15: TQRLabel
        Left = 119
        Top = 62
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          164.041666666666700000
          166.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Total venta'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel16: TQRLabel
        Left = 352
        Top = 16
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          931.333333333333500000
          42.333333333333340000
          174.625000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ejemplares'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel17: TQRLabel
        Left = 352
        Top = 39
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          931.333333333333500000
          103.187500000000000000
          174.625000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ejemplares'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel18: TQRLabel
        Left = 352
        Top = 62
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          931.333333333333500000
          164.041666666666700000
          174.625000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Ejemplares'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object SumaDev: TQRExpr
        Left = 437
        Top = 39
        Width = 56
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1156.229166666667000000
          103.187500000000000000
          148.166666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object Sumav: TQRExpr
        Left = 437
        Top = 62
        Width = 40
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1156.229166666667000000
          164.041666666666700000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object SumaVentas: TQRExpr
        Left = 200
        Top = 62
        Width = 76
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          529.166666666666800000
          164.041666666666700000
          201.083333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object totaldev: TQRLabel
        Left = 239
        Top = 39
        Width = 45
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          632.354166666666800000
          103.187500000000000000
          119.062500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'totaldev'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object totaldot: TQRLabel
        Left = 242
        Top = 16
        Width = 44
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          640.291666666666800000
          42.333333333333340000
          116.416666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'totaldot'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel20: TQRLabel
        Left = 230
        Top = 40
        Width = 8
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.270833333333330000
          608.541666666666800000
          105.833333333333300000
          21.166666666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '$'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel21: TQRLabel
        Left = 191
        Top = 63
        Width = 8
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.270833333333330000
          505.354166666666700000
          166.687500000000000000
          21.166666666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '$'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel22: TQRLabel
        Left = 234
        Top = 16
        Width = 8
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          50.270833333333330000
          619.125000000000000000
          42.333333333333340000
          21.166666666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '$'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object PageHeaderBand1: TQRBand
      Left = 38
      Top = 38
      Width = 740
      Height = 85
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        224.895833333333300000
        1957.916666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRImage1: TQRImage
        Left = 232
        Top = 0
        Width = 273
        Height = 57
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          150.812500000000000000
          613.833333333333400000
          0.000000000000000000
          722.312500000000000000)
        XLColumn = 0
        Picture.Data = {
          0A544A504547496D61676595510000FFD8FFE000104A46494600010201004800
          480000FFE10D1B4578696600004D4D002A000000080007011200030000000100
          010000011A00050000000100000062011B0005000000010000006A0128000300
          00000100020000013100020000001C0000007201320002000000140000008E87
          69000400000001000000A4000000D0000AFC8000002710000AFC800000271041
          646F62652050686F746F73686F70204353332057696E646F777300323030393A
          30373A30312031373A30393A32320000000003A00100030000000100010000A0
          0200040000000100000115A00300040000000100000033000000000000000601
          0300030000000100060000011A0005000000010000011E011B00050000000100
          00012601280003000000010002000002010004000000010000012E0202000400
          00000100000BE50000000000000048000000010000004800000001FFD8FFE000
          104A46494600010200004800480000FFED000C41646F62655F434D0001FFEE00
          0E41646F626500648000000001FFDB0084000C08080809080C09090C110B0A0B
          11150F0C0C0F1518131315131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E
          0E14140E0E0E0E14110C0C0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC0001108001D00A003012200
          021101031101FFDD0004000AFFC4013F00000105010101010101000000000000
          00030001020405060708090A0B01000105010101010101000000000000000100
          02030405060708090A0B1000010401030204020507060805030C330100021103
          04211231054151611322718132061491A1B14223241552C16233347282D14307
          259253F0E1F163733516A2B283264493546445C2A3743617D255E265F2B384C3
          D375E3F3462794A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F6
          37475767778797A7B7C7D7E7F711000202010204040304050607070605350100
          021103213112044151617122130532819114A1B14223C152D1F0332462E17282
          92435315637334F1250616A2B283072635C2D2449354A317644555367465E2F2
          B384C3D375E3F34694A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6
          E6F62737475767778797A7B7C7FFDA000C03010002110311003F006FABFD32BE
          ADD70E164D96B2A78B5E4D6EDAE969F6FB9F52BA7A5740B3AE55D1B1ACEA02E1
          90EA721F6399B3631963DDE8BDACFA7EA36BFA4CFE6D03EA85D8F8BF597D7C9B
          194541B703658431B24E837BD95B7FE9ADABB3B2CFD61C4C8CAEAF8791D2DB96
          F7D34D76D65D534D77B6A7DFB2966D635AEF4B73EFFA762A18C44C05D5F1EBFD
          D7A7E672658E79C624888C06510098FEB7D7F2D427C73FEAFA1C0CAE934D5F5A
          874665B77D94DF553BCBA5FB5ED63DDEFF004766EDCF567A87D53CB1D4F3717A
          5D8E7D1835D6FB1D916B587F48D759F4CD3E9FF834D9B918CFFAF6DCB6DAC763
          7DAA97FAE0835ED0CAC39DEB6CD9B5AE1FE956DDFD57A49CCFACA7ED98FB7271
          696527D464584537B1CCAFFD2BB73BF33D4463181E207F7CF5FD1E1923267E62
          23118DC89E5F1CA40C7887BB3C98A1294BFAFC339BCDBFEAB75F6E663E18687B
          F2986CAAC65AD35ED6EDF51CE7FA5FE0FD4AFF00EDCFD1ABD99F555D8BD01B99
          EADB6F53378C7F4AAB18FA8B8DC71F6336D7F4FF0033DDF42E5B9475BE8D5E77
          4327368DACC3BA9796BDA431EE187B19696FF33BBD2B3F9DF4D46EC9C4ABA4E3
          B1B7D79069EA7F687B71CFAA7D33976646F6B2A6BDEED953F73B6313862C604B
          5BD3BEDF2B14B9CE689C571E1F5478B86128FB9EBCD03FE07EAF1BCBE6FD57EB
          B858B6655A1AE66380EC86576B5EFAC11BB758C6D5FBBFB88E7EA67D6116FA33
          51B4D66D6B05ECDC5A0869DAC356EFA4E6FBFF009AFF00845D375C3936E1F52B
          716CA8D59D56CAAAC7C67DB9177E8B67EB16321CC76EDD5D6E757FA1A56ABB1E
          C6F59AB3C8FD0D585654E804BF739F4DB0DADADDEEF6D4F4472F0B3BF4EAB25F
          13CE21127DBE2227FA32F9A3084843D5FD794A0F9E607D59EB99F8EDC9A80AEA
          B1C5957AD6B585EE6EEDECAD9E96EF6FA767F989B1FEADF5CBE9C8B40150C4B4
          D178B6E6336BDA18E77B9F5FA7B36D8C77A9BFDEBB4E8D466E4742C1A6AA862D
          F8D7BDD69CCC776EAC7E9DCDB71EAB051BAD7FA957E919FE0ECBBFC22AB66366
          DFF57FAEB5D4DB6DB91965D58343AB75803715BEA558CF6D967A7FA377FA4FA0
          9BEC47841F57CB7FF3593FD2397DC9C7F562B2080D25E989CBEDF17EE7AA1EBF
          99E607D54FAC07A93BA6EC1EB36B1717FAADF4FD324B1AFDFE97E758D73366DF
          53FB0B4DDF5529AB17A5D94BDF95979E4B6CACDCD349FD05B7BDF4DB4B5BF45D
          5EFA9FEAFF009EBAC01ECFAD363DD5BFD3B306B636D0C7166E6DB7BDD5FAA1BB
          1AFDAFDDB37AA38D43F168FAB94DA35C42E6DEE6825AD8C6BEADCE76D1B5BEA3
          9ACF7278C301E3AF5E9EA8B04FE239F201A887A38BF5771E332C39647D57FE72
          31F95E399F563AC5D9597552629C3B3D3B2FBAC656C0E3B5CDAF76C7FE936D8C
          FA0955F557EB0D9959189B365D8CD6BDE1F6B402C7EFF4DF53FD2DAF6BBD27AE
          A6BC9C62CEB382E7E332EBF34DD57DB587ECEEAC8C7FD2FBDACAAFD9E959B1BB
          FF009D626C3EB5D3BF6B7517E4F53C7BBF55AA96DC628639CD764B9D5D5EA3DE
          DBF67A8DDCFADFF9E99ECE3B164EA4F5FEF339E7B9AE1991089E18C6BF573BD7
          DAF5FA7D3EAE3C8F3D85F543AADD9D8D8F9570A68CAA9D73322BB196821A1A76
          3006B7D47FE919F9DFCDFE92BFE6D41DF54FACBB332E9A1ED7518B6FA5F69B2D
          6B1AE73B69AD83F46EFD27E96BDECFF49FA25BD8BD57A503F55A7331C7D9A970
          BFF48CFD1938BE9C5BFE8BF49ECF7FA689D3FA9F4FB31BA9E1B32B1197BBA859
          75672B69A8D6EB996FDA2ADDE9B321CC635EFAB6BFF9F65690C78F6BFC7FA9C5
          C2A9737CD8265C22A80AF6E5C31FD7E4C5EEFEF7F370788CEC3EA1D3F29F8998
          D7D77D704B677020EAC7B5F5D2E639AE5D2743E918B78637299616B9BEE63ABB
          585D31BBE9319E9BBDADF7E3DF7D3ECF5EAFB3BFE9E47D69C86E67587DACC86E
          6ED636B37D75EC612DDD22BF6E4EFDBFE97D453E85D6ABE9EE6D7750D6D2082E
          35D4E7B9C78DCEF5BF434FF29D563A8E2631C841D637D5B79866CBCAC651F4E5
          31122200C7D55FD7F5BB97FD44A2C71389D42FA5A06E35D958B5C01E0EE69A5E
          F62E7FAC7D5EEAFD20875E4DD8EF12CC9A64B3FAAF6FA4E7D2FF00EBFF00DB8B
          BEE959F4751C61902C0F1A96ED126B238FCDDCD7FF00C17EE2BEE01CDDAEEFAE
          80C1FDED7F75FF009EAC1C18E62E3A5F50E5C3E27CCE19F0E5FD608E928CA223
          2FF1F878BFC67FFFD0D077D49CB2F739D8175D2E275BF1EB064FF21963FF00F0
          4536FD51CB67D0E85493E36DEE79FF00A3954B3FE82F424940072E3F73EA41FF
          00A4E94A7F169FFE29FF00023931FF00E928C1E0C7D5EEB2DD19D1B099FF005B
          A1FF00FB716DE895F4AFAD74E94E2D74C71E9330D91FE63177092907074E1FA5
          35327DEB5F73DDF1F73DCFFBB78A7607D75772EBFE57D4DFFA8B1A86EE99F5C3
          F39D93AE9FD280E7FEBEBB9587D780FB7E01B5D91B373BECCDA051B3ED107D37
          58FCD76CF57D2F53ECCDF4FE9FFC2FA69EC0F3F6746FAD85AEDDF6888D49CA1F
          FA5D68754C5EBBD53228B2EE9D6D14D0D735F5D5955CBE7696FBC3EAD9F451BA
          90A7D2B7F683B30BF7D1EA90DA87B367E8F6063BD2F4BED5FCEECFFB5FE97FDA
          6F4946FF00B0C1F54F50FB57DB5BEB6E1EFF00A56FD9376BF66FD9DBBFA37A3F
          A3F53D3F53F4BEB248D1A57743EAB65C2C183796ED76F6BB22B00BDDA30B5ADB
          9CDAD94B4FE8FF00E2EBF53FC258A63A267493FB3F246E11B5B915435B3B9CC6
          3BD7DDFA5FE6DF7FF39557FCCAD8FAD1FD1A8DE6F18FEA7E97ECB26D3ED3B1AD
          E28D9FBEFBFF00EB5FA5FE6F38FECFF5727D53D53D0F528FB4EEDDB7D1F45FE8
          FA9B7F59FB27FDCBFF000FEAFF004BFD0249423A275015FF0043CA3B34633ED2
          C60D773DC4FA791EEFD21FA6F7EFD9E97A7FE11546F44FAD8D1A37201EF19207
          FE8F5D5F56F47D0C6DC6D157AD5C7A2016F0EF4FED131FABEFD9FF005EF47D4F
          D1AC4ABECDB46BD5F6FDA323D5D34F53FC2FDA3D3FF05E9EDFB37F82FF00AF7A
          89234698E95F5C470727FF006287FE97526E07D756F0EC8F9DF5BBFEAEC72BED
          18DE937D639FBB753BBD60C9E6CF57D5D8ED9B3EDBBFED9FE0BD7FB2FF00DE7F
          A09C8ABD2BB5EA13E9E5702BDFEB40F5366E76EFB77D9F77D93FC07D9FD5F452
          4B97F61FAD194D74D75E506B8B1FB861DB0E69DAF63F735DEF63BE9289FABDD6
          9C22CE8F8760F3AB1D87EFC6B2872DEE89E87DB6BF43EDFE8FD8D9E97DA3FA3F
          A714FA7B23FED5FD2F57FC2FF3BBFD9E8ADE4D3C1D787EB4CF8FEF343DAF77C3
          DBE3FF00B87CF8FD52CC221DD0A8F8D77BD87FF6F2C6FF00D04277D49CB74EDE
          9D755FD5C8C7B07F9B6B03BFF055E8C928C8E5CEFC1F6C436E33F8B436FBCFF8
          71C993FF004A09BE738FF53BEB061DDEBE0EFAAC1DAC663ED3DE1FB321FBBFED
          A5BD8AFF00AD6C61664F4F0F744B9CCB292C71F1635F631F5BBF91F43FE11750
          9251C78FF4255FDD9717FDF2DCDCDF3474E67109CBA1CB8BDA9FFE37ECBFFFD9
          FFED124E50686F746F73686F7020332E30003842494D04250000000000100000
          00000000000000000000000000003842494D042F00000000004A009F01004800
          0000480000000000000000000000D00200004002000000000000000000001803
          0000640200000001C0030000B004000001000F2701006C6C756E000000000000
          000000FF3842494D03ED00000000001000480000000100020048000000010002
          3842494D042600000000000E000000000000000000003F8000003842494D040D
          000000000004000000783842494D04190000000000040000001E3842494D03F3
          000000000009000000000000000001003842494D040A00000000000100003842
          494D271000000000000A000100000000000000023842494D03F5000000000048
          002F66660001006C66660006000000000001002F6666000100A1999A00060000
          00000001003200000001005A00000006000000000001003500000001002D0000
          00060000000000013842494D03F80000000000700000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF03E800000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          03E800003842494D040000000000000200013842494D04020000000000040000
          00003842494D043000000000000201013842494D042D00000000000600010000
          00023842494D0408000000000010000000010000024000000240000000003842
          494D041E000000000004000000003842494D041A000000000349000000060000
          00000000000000000033000001150000000A0055006E007400690074006C0065
          0064002D00310000000100000000000000000000000000000000000000010000
          0000000000000000011500000033000000000000000000000000000000000100
          00000000000000000000000000000000000010000000010000000000006E756C
          6C0000000200000006626F756E64734F626A6300000001000000000000526374
          310000000400000000546F70206C6F6E6700000000000000004C6566746C6F6E
          67000000000000000042746F6D6C6F6E670000003300000000526768746C6F6E
          670000011500000006736C69636573566C4C73000000014F626A630000000100
          0000000005736C6963650000001200000007736C69636549446C6F6E67000000
          000000000767726F757049446C6F6E6700000000000000066F726967696E656E
          756D0000000C45536C6963654F726967696E0000000D6175746F47656E657261
          7465640000000054797065656E756D0000000A45536C69636554797065000000
          00496D672000000006626F756E64734F626A6300000001000000000000526374
          310000000400000000546F70206C6F6E6700000000000000004C6566746C6F6E
          67000000000000000042746F6D6C6F6E670000003300000000526768746C6F6E
          67000001150000000375726C54455854000000010000000000006E756C6C5445
          5854000000010000000000004D7367655445585400000001000000000006616C
          74546167544558540000000100000000000E63656C6C54657874497348544D4C
          626F6F6C010000000863656C6C54657874544558540000000100000000000968
          6F727A416C69676E656E756D0000000F45536C696365486F727A416C69676E00
          00000764656661756C740000000976657274416C69676E656E756D0000000F45
          536C69636556657274416C69676E0000000764656661756C740000000B626743
          6F6C6F7254797065656E756D0000001145536C6963654247436F6C6F72547970
          65000000004E6F6E6500000009746F704F75747365746C6F6E67000000000000
          000A6C6566744F75747365746C6F6E67000000000000000C626F74746F6D4F75
          747365746C6F6E67000000000000000B72696768744F75747365746C6F6E6700
          000000003842494D042800000000000C000000013FF00000000000003842494D
          0414000000000004000000023842494D040C000000000C0100000001000000A0
          0000001D000001E00000366000000BE500180001FFD8FFE000104A4649460001
          0200004800480000FFED000C41646F62655F434D0001FFEE000E41646F626500
          648000000001FFDB0084000C08080809080C09090C110B0A0B11150F0C0C0F15
          18131315131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E0E14140E0E0E0E
          14110C0C0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0CFFC0001108001D00A003012200021101031101FF
          DD0004000AFFC4013F0000010501010101010100000000000000030001020405
          060708090A0B0100010501010101010100000000000000010002030405060708
          090A0B1000010401030204020507060805030C33010002110304211231054151
          611322718132061491A1B14223241552C16233347282D14307259253F0E1F163
          733516A2B283264493546445C2A3743617D255E265F2B384C3D375E3F3462794
          A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F637475767778797
          A7B7C7D7E7F71100020201020404030405060707060535010002110321311204
          4151617122130532819114A1B14223C152D1F0332462E1728292435315637334
          F1250616A2B283072635C2D2449354A317644555367465E2F2B384C3D375E3F3
          4694A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F62737475767
          778797A7B7C7FFDA000C03010002110311003F006FABFD32BEADD70E164D96B2
          A78B5E4D6EDAE969F6FB9F52BA7A5740B3AE55D1B1ACEA02E190EA721F6399B3
          631963DDE8BDACFA7EA36BFA4CFE6D03EA85D8F8BF597D7C9B194541B7036584
          31B24E837BD95B7FE9ADABB3B2CFD61C4C8CAEAF8791D2DB96F7D34D76D65D53
          4D77B6A7DFB2966D635AEF4B73EFFA762A18C44C05D5F1EBFDD7A7E672658E79
          C624888C06510098FEB7D7F2D427C73FEAFA1C0CAE934D5F5A874665B77D94DF
          553BCBA5FB5ED63DDEFF004766EDCF567A87D53CB1D4F3717A5D8E7D1835D6FB
          1D916B587F48D759F4CD3E9FF834D9B918CFFAF6DCB6DAC7637DAA97FAE0835E
          D0CAC39DEB6CD9B5AE1FE956DDFD57A49CCFACA7ED98FB7271696527D4645845
          37B1CCAFFD2BB73BF33D4463181E207F7CF5FD1E1923267E6223118DC89E5F1C
          A40C7887BB3C98A1294BFAFC339BCDBFEAB75F6E663E18687BF2986CAAC65AD3
          5ED6EDF51CE7FA5FE0FD4AFF00EDCFD1ABD99F555D8BD01B99EADB6F53378C7F
          4AAB18FA8B8DC71F6336D7F4FF0033DDF42E5B9475BE8D5E774327368DACC3BA
          9796BDA431EE187B19696FF33BBD2B3F9DF4D46EC9C4ABA4E3B1B7D79069EA7F
          687B71CFAA7D33976646F6B2A6BDEED953F73B6313862C604B5BD3BEDF2B14B9
          CE689C571E1F5478B86128FB9EBCD03FE07EAF1BCBE6FD57EBB858B6655A1AE6
          6380EC86576B5EFAC11BB758C6D5FBBFB88E7EA67D6116FA3351B4D66D6B05EC
          DC5A0869DAC356EFA4E6FBFF009AFF00845D375C3936E1F52B716CA8D59D56CA
          AAC7C67DB9177E8B67EB16321CC76EDD5D6E757FA1A56ABB1EC6F59AB3C8FD0D
          585654E804BF739F4DB0DADADDEEF6D4F4472F0B3BF4EAB25F13CE21127DBE22
          27FA32F9A3084843D5FD794A0F9E607D59EB99F8EDC9A80AEAB1C5957AD6B585
          EE6EEDECAD9E96EF6FA767F989B1FEADF5CBE9C8B40150C4B4D178B6E6336BDA
          18E77B9F5FA7B36D8C77A9BFDEBB4E8D466E4742C1A6AA862DF8D7BDD69CCC77
          6EAC7E9DCDB71EAB051BAD7FA957E919FE0ECBBFC22AB66366DFF57FAEB5D4DB
          6DB91965D58343AB75803715BEA558CF6D967A7FA377FA4FA09BEC47841F57CB
          7FF3593FD2397DC9C7F562B2080D25E989CBEDF17EE7AA1EBF99E607D54FAC07
          A93BA6EC1EB36B1717FAADF4FD324B1AFDFE97E758D73366DF53FB0B4DDF5529
          AB17A5D94BDF95979E4B6CACDCD349FD05B7BDF4DB4B5BF45D5EFA9FEAFF009E
          BAC01ECFAD363DD5BFD3B306B636D0C7166E6DB7BDD5FAA1BB1AFDAFDDB37AA3
          8D43F168FAB94DA35C42E6DEE6825AD8C6BEADCE76D1B5BEA39ACF7278C301E3
          AF5E9EA8B04FE239F201A887A38BF5771E332C39647D57FE7231F95E399F563A
          C5D9597552629C3B3D3B2FBAC656C0E3B5CDAF76C7FE936D8CFA0955F557EB0D
          9959189B365D8CD6BDE1F6B402C7EFF4DF53FD2DAF6BBD27AEA6BC9C62CEB382
          E7E332EBF34DD57DB587ECEEAC8C7FD2FBDACAAFD9E959B1BBFF009D626C3EB5
          D3BF6B7517E4F53C7BBF55AA96DC628639CD764B9D5D5EA3DEDBF67A8DDCFADF
          F9E99ECE3B164EA4F5FEF339E7B9AE1991089E18C6BF573BD7DAF5FA7D3EAE3C
          8F3D85F543AADD9D8D8F9570A68CAA9D73322BB196821A1A763006B7D47FE919
          F9DFCDFE92BFE6D41DF54FACBB332E9A1ED7518B6FA5F69B2D6B1AE73B69AD83
          F46EFD27E96BDECFF49FA25BD8BD57A503F55A7331C7D9A970BFF48CFD1938BE
          9C5BFE8BF49ECF7FA689D3FA9F4FB31BA9E1B32B1197BBA85975672B69A8D6EB
          996FDA2ADDE9B321CC635EFAB6BFF9F65690C78F6BFC7FA9C5C2A9737CD8265C
          22A80AF6E5C31FD7E4C5EEFEF7F370788CEC3EA1D3F29F8998D7D77D704B6770
          20EAC7B5F5D2E639AE5D2743E918B78637299616B9BEE63ABB585D31BBE9319E
          9BBDADF7E3DF7D3ECF5EAFB3BFE9E47D69C86E67587DACC86E6ED636B37D75EC
          612DDD22BF6E4EFDBFE97D453E85D6ABE9EE6D7750D6D2082E35D4E7B9C78DCE
          F5BF434FF29D563A8E2631C841D637D5B79866CBCAC651F4E531122200C7D55F
          D7F5BB97FD44A2C71389D42FA5A06E35D958B5C01E0EE69A5EF62E7FAC7D5EEA
          FD20875E4DD8EF12CC9A64B3FAAF6FA4E7D2FF00EBFF00DB8BBEE959F4751C61
          902C0F1A96ED126B238FCDDCD7FF00C17EE2BEE01CDDAEEFAE80C1FDED7F75FF
          009EAC1C18E62E3A5F50E5C3E27CCE19F0E5FD608E928CA2232FF1F878BFC67F
          FFD0D077D49CB2F739D8175D2E275BF1EB064FF21963FF00F04536FD51CB67D0
          E85493E36DEE79FF00A3954B3FE82F424940072E3F73EA41FF00A4E94A7F169F
          FE29FF00023931FF00E928C1E0C7D5EEB2DD19D1B099FF005BA1FF00FB716DE8
          95F4AFAD74E94E2D74C71E9330D91FE63177092907074E1FA535327DEB5F73DD
          F1F73DCFFBB78A7607D75772EBFE57D4DFFA8B1A86EE99F5C3F39D93AE9FD280
          E7FEBEBB9587D780FB7E01B5D91B373BECCDA051B3ED107D3758FCD76CF57D2F
          53ECCDF4FE9FFC2FA69EC0F3F6746FAD85AEDDF6888D49CA1FFA5D68754C5EBB
          D53228B2EE9D6D14D0D735F5D5955CBE7696FBC3EAD9F451BA90A7D2B7F683B3
          0BF7D1EA90DA87B367E8F6063BD2F4BED5FCEECFFB5FE97FDA6F4946FF00B0C1
          F54F50FB57DB5BEB6E1EFF00A56FD9376BF66FD9DBBFA37A3FA3F53D3F53F4BE
          B248D1A57743EAB65C2C183796ED76F6BB22B00BDDA30B5ADB9CDAD94B4FE8FF
          00E2EBF53FC258A63A267493FB3F246E11B5B915435B3B9CC63BD7DDFA5FE6DF
          7FF39557FCCAD8FAD1FD1A8DE6F18FEA7E97ECB26D3ED3B1ADE28D9FBEFBFF00
          EB5FA5FE6F38FECFF5727D53D53D0F528FB4EEDDB7D1F45FE8FA9B7F59FB27FD
          CBFF000FEAFF004BFD0249423A275015FF0043CA3B34633ED2C60D773DC4FA79
          1EEFD21FA6F7EFD9E97A7FE11546F44FAD8D1A37201EF19207FE8F5D5F56F47D
          0C6DC6D157AD5C7A2016F0EF4FED131FABEFD9FF005EF47D4FD1AC4ABECDB46B
          D5F6FDA323D5D34F53FC2FDA3D3FF05E9EDFB37F82FF00AF7A89234698E95F5C
          470727FF006287FE97526E07D756F0EC8F9DF5BBFEAEC72BED18DE937D639FBB
          753BBD60C9E6CF57D5D8ED9B3EDBBFED9FE0BD7FB2FF00DE7FA09C8ABD2BB5EA
          13E9E5702BDFEB40F5366E76EFB77D9F77D93FC07D9FD5F4524B97F61FAD194D
          74D75E506B8B1FB861DB0E69DAF63F735DEF63BE9289FABDD69C22CE8F8760F3
          AB1D87EFC6B2872DEE89E87DB6BF43EDFE8FD8D9E97DA3FA3FA714FA7B23FED5
          FD2F57FC2FF3BBFD9E8ADE4D3C1D787EB4CF8FEF343DAF77C3DBE3FF00B87CF8
          FD52CC221DD0A8F8D77BD87FF6F2C6FF00D04277D49CB74EDE9D755FD5C8C7B0
          7F9B6B03BFF055E8C928C8E5CEFC1F6C436E33F8B436FBCFF871C993FF004A09
          BE738FF53BEB061DDEBE0EFAAC1DAC663ED3DE1FB321FBBFEDA5BD8AFF00AD6C
          61664F4F0F744B9CCB292C71F1635F631F5BBF91F43FE117509251C78FF4255F
          DD9717FDF2DCDCDF3474E67109CBA1CB8BDA9FFE37ECBFFFD9003842494D0421
          00000000005500000001010000000F00410064006F0062006500200050006800
          6F0074006F00730068006F00700000001300410064006F006200650020005000
          68006F0074006F00730068006F0070002000430053003300000001003842494D
          04060000000000070001000000010100FFE10FCD687474703A2F2F6E732E6164
          6F62652E636F6D2F7861702F312E302F003C3F787061636B657420626567696E
          3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B
          633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F6265
          3A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F
          726520342E312D633033362034362E3237363732302C204D6F6E204665622031
          3920323030372032323A34303A30382020202020202020223E203C7264663A52
          444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
          313939392F30322F32322D7264662D73796E7461782D6E7323223E203C726466
          3A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A
          64633D22687474703A2F2F7075726C2E6F72672F64632F656C656D656E74732F
          312E312F2220786D6C6E733A7861703D22687474703A2F2F6E732E61646F6265
          2E636F6D2F7861702F312E302F2220786D6C6E733A7861704D4D3D2268747470
          3A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C
          6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861
          702F312E302F73547970652F5265736F75726365526566232220786D6C6E733A
          70686F746F73686F703D22687474703A2F2F6E732E61646F62652E636F6D2F70
          686F746F73686F702F312E302F2220786D6C6E733A746966663D22687474703A
          2F2F6E732E61646F62652E636F6D2F746966662F312E302F2220786D6C6E733A
          657869663D22687474703A2F2F6E732E61646F62652E636F6D2F657869662F31
          2E302F222064633A666F726D61743D22696D6167652F6A70656722207861703A
          43726561746F72546F6F6C3D2241646F62652050686F746F73686F7020435333
          2057696E646F777322207861703A437265617465446174653D22323030392D30
          372D30315431373A30393A32322D30363A303022207861703A4D6F6469667944
          6174653D22323030392D30372D30315431373A30393A32322D30363A30302220
          7861703A4D65746164617461446174653D22323030392D30372D30315431373A
          30393A32322D30363A303022207861704D4D3A446F63756D656E7449443D2275
          7569643A36443644394432333934363644453131424130424437454439393433
          3636354322207861704D4D3A496E7374616E636549443D22757569643A364536
          4439443233393436364445313142413042443745443939343336363543222070
          686F746F73686F703A436F6C6F724D6F64653D2233222070686F746F73686F70
          3A49434350726F66696C653D22735247422049454336313936362D322E312220
          70686F746F73686F703A486973746F72793D222220746966663A4F7269656E74
          6174696F6E3D22312220746966663A585265736F6C7574696F6E3D2237323030
          30302F31303030302220746966663A595265736F6C7574696F6E3D2237323030
          30302F31303030302220746966663A5265736F6C7574696F6E556E69743D2232
          2220746966663A4E61746976654469676573743D223235362C3235372C323538
          2C3235392C3236322C3237342C3237372C3238342C3533302C3533312C323832
          2C3238332C3239362C3330312C3331382C3331392C3532392C3533322C333036
          2C3237302C3237312C3237322C3330352C3331352C33333433323B3137383742
          3738424330383144353536383941354644313843353838383435312220657869
          663A506978656C5844696D656E73696F6E3D223237372220657869663A506978
          656C5944696D656E73696F6E3D2235312220657869663A436F6C6F7253706163
          653D22312220657869663A4E61746976654469676573743D2233363836342C34
          303936302C34303936312C33373132312C33373132322C34303936322C343039
          36332C33373531302C34303936342C33363836372C33363836382C3333343334
          2C33333433372C33343835302C33343835322C33343835352C33343835362C33
          373337372C33373337382C33373337392C33373338302C33373338312C333733
          38322C33373338332C33373338342C33373338352C33373338362C3337333936
          2C34313438332C34313438342C34313438362C34313438372C34313438382C34
          313439322C34313439332C34313439352C34313732382C34313732392C343137
          33302C34313938352C34313938362C34313938372C34313938382C3431393839
          2C34313939302C34313939312C34313939322C34313939332C34313939342C34
          313939352C34313939362C34323031362C302C322C342C352C362C372C382C39
          2C31302C31312C31322C31332C31342C31352C31362C31372C31382C32302C32
          322C32332C32342C32352C32362C32372C32382C33303B443241463246443641
          3145333444434434373444333339414442464543394436223E203C7861704D4D
          3A4465726976656446726F6D2073745265663A696E7374616E636549443D2275
          7569643A36433644394432333934363644453131424130424437454439393433
          36363543222073745265663A646F63756D656E7449443D22757569643A364336
          4439443233393436364445313142413042443745443939343336363543222F3E
          203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C
          2F783A786D706D6574613E202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020202020202020202020202020202020202020202020
          2020202020202020202020203C3F787061636B657420656E643D2277223F3EFF
          E20C584943435F50524F46494C4500010100000C484C696E6F021000006D6E74
          725247422058595A2007CE00020009000600310000616373704D534654000000
          0049454320735247420000000000000000000000010000F6D6000100000000D3
          2D48502020000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000116370727400000150000000
          3364657363000001840000006C77747074000001F000000014626B7074000002
          04000000147258595A00000218000000146758595A0000022C00000014625859
          5A0000024000000014646D6E640000025400000070646D6464000002C4000000
          88767565640000034C0000008676696577000003D4000000246C756D69000003
          F8000000146D6561730000040C0000002474656368000004300000000C725452
          430000043C0000080C675452430000043C0000080C625452430000043C000008
          0C7465787400000000436F70797269676874202863292031393938204865776C
          6574742D5061636B61726420436F6D70616E7900006465736300000000000000
          12735247422049454336313936362D322E310000000000000000000000127352
          47422049454336313936362D322E310000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0058595A20000000000000F35100010000000116CC58595A2000000000000000
          00000000000000000058595A200000000000006FA2000038F50000039058595A
          2000000000000062990000B785000018DA58595A2000000000000024A000000F
          840000B6CF64657363000000000000001649454320687474703A2F2F7777772E
          6965632E636800000000000000000000001649454320687474703A2F2F777777
          2E6965632E636800000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000006465736300000000000000
          2E4945432036313936362D322E312044656661756C742052474220636F6C6F75
          72207370616365202D207352474200000000000000000000002E494543203631
          3936362D322E312044656661756C742052474220636F6C6F7572207370616365
          202D207352474200000000000000000000000000000000000000000000646573
          63000000000000002C5265666572656E63652056696577696E6720436F6E6469
          74696F6E20696E2049454336313936362D322E3100000000000000000000002C
          5265666572656E63652056696577696E6720436F6E646974696F6E20696E2049
          454336313936362D322E31000000000000000000000000000000000000000000
          000000000076696577000000000013A4FE00145F2E0010CF140003EDCC000413
          0B00035C9E0000000158595A2000000000004C09560050000000571FE76D6561
          730000000000000001000000000000000000000000000000000000028F000000
          0273696720000000004352542063757276000000000000040000000005000A00
          0F00140019001E00230028002D00320037003B00400045004A004F0054005900
          5E00630068006D00720077007C00810086008B00900095009A009F00A400A900
          AE00B200B700BC00C100C600CB00D000D500DB00E000E500EB00F000F600FB01
          010107010D01130119011F0125012B01320138013E0145014C01520159016001
          67016E0175017C0183018B0192019A01A101A901B101B901C101C901D101D901
          E101E901F201FA0203020C0214021D0226022F02380241024B0254025D026702
          71027A0284028E029802A202AC02B602C102CB02D502E002EB02F50300030B03
          160321032D03380343034F035A03660372037E038A039603A203AE03BA03C703
          D303E003EC03F9040604130420042D043B0448045504630471047E048C049A04
          A804B604C404D304E104F004FE050D051C052B053A0549055805670577058605
          9605A605B505C505D505E505F6060606160627063706480659066A067B068C06
          9D06AF06C006D106E306F507070719072B073D074F076107740786079907AC07
          BF07D207E507F8080B081F08320846085A086E0882089608AA08BE08D208E708
          FB09100925093A094F09640979098F09A409BA09CF09E509FB0A110A270A3D0A
          540A6A0A810A980AAE0AC50ADC0AF30B0B0B220B390B510B690B800B980BB00B
          C80BE10BF90C120C2A0C430C5C0C750C8E0CA70CC00CD90CF30D0D0D260D400D
          5A0D740D8E0DA90DC30DDE0DF80E130E2E0E490E640E7F0E9B0EB60ED20EEE0F
          090F250F410F5E0F7A0F960FB30FCF0FEC1009102610431061107E109B10B910
          D710F511131131114F116D118C11AA11C911E81207122612451264128412A312
          C312E31303132313431363138313A413C513E5140614271449146A148B14AD14
          CE14F01512153415561578159B15BD15E0160316261649166C168F16B216D616
          FA171D17411765178917AE17D217F7181B18401865188A18AF18D518FA192019
          45196B199119B719DD1A041A2A1A511A771A9E1AC51AEC1B141B3B1B631B8A1B
          B21BDA1C021C2A1C521C7B1CA31CCC1CF51D1E1D471D701D991DC31DEC1E161E
          401E6A1E941EBE1EE91F131F3E1F691F941FBF1FEA20152041206C209820C420
          F0211C2148217521A121CE21FB22272255228222AF22DD230A23382366239423
          C223F0241F244D247C24AB24DA250925382568259725C725F726272657268726
          B726E827182749277A27AB27DC280D283F287128A228D429062938296B299D29
          D02A022A352A682A9B2ACF2B022B362B692B9D2BD12C052C392C6E2CA22CD72D
          0C2D412D762DAB2DE12E162E4C2E822EB72EEE2F242F5A2F912FC72FFE303530
          6C30A430DB3112314A318231BA31F2322A3263329B32D4330D3346337F33B833
          F1342B3465349E34D83513354D358735C235FD3637367236AE36E93724376037
          9C37D738143850388C38C839053942397F39BC39F93A363A743AB23AEF3B2D3B
          6B3BAA3BE83C273C653CA43CE33D223D613DA13DE03E203E603EA03EE03F213F
          613FA23FE24023406440A640E74129416A41AC41EE4230427242B542F7433A43
          7D43C044034447448A44CE45124555459A45DE4622466746AB46F04735477B47
          C04805484B489148D7491D496349A949F04A374A7D4AC44B0C4B534B9A4BE24C
          2A4C724CBA4D024D4A4D934DDC4E254E6E4EB74F004F494F934FDD5027507150
          BB51065150519B51E65231527C52C75313535F53AA53F65442548F54DB552855
          7555C2560F565C56A956F75744579257E0582F587D58CB591A596959B85A075A
          565AA65AF55B455B955BE55C355C865CD65D275D785DC95E1A5E6C5EBD5F0F5F
          615FB36005605760AA60FC614F61A261F56249629C62F06343639763EB644064
          9464E9653D659265E7663D669266E8673D679367E9683F689668EC6943699A69
          F16A486A9F6AF76B4F6BA76BFF6C576CAF6D086D606DB96E126E6B6EC46F1E6F
          786FD1702B708670E0713A719571F0724B72A67301735D73B87414747074CC75
          28758575E1763E769B76F8775677B37811786E78CC792A798979E77A467AA57B
          047B637BC27C217C817CE17D417DA17E017E627EC27F237F847FE5804780A881
          0A816B81CD8230829282F4835783BA841D848084E3854785AB860E867286D787
          3B879F8804886988CE8933899989FE8A648ACA8B308B968BFC8C638CCA8D318D
          988DFF8E668ECE8F368F9E9006906E90D6913F91A89211927A92E3934D93B694
          20948A94F4955F95C99634969F970A977597E0984C98B89924999099FC9A689A
          D59B429BAF9C1C9C899CF79D649DD29E409EAE9F1D9F8B9FFAA069A0D8A147A1
          B6A226A296A306A376A3E6A456A4C7A538A5A9A61AA68BA6FDA76EA7E0A852A8
          C4A937A9A9AA1CAA8FAB02AB75ABE9AC5CACD0AD44ADB8AE2DAEA1AF16AF8BB0
          00B075B0EAB160B1D6B24BB2C2B338B3AEB425B49CB513B58AB601B679B6F0B7
          68B7E0B859B8D1B94AB9C2BA3BBAB5BB2EBBA7BC21BC9BBD15BD8FBE0ABE84BE
          FFBF7ABFF5C070C0ECC167C1E3C25FC2DBC358C3D4C451C4CEC54BC5C8C646C6
          C3C741C7BFC83DC8BCC93AC9B9CA38CAB7CB36CBB6CC35CCB5CD35CDB5CE36CE
          B6CF37CFB8D039D0BAD13CD1BED23FD2C1D344D3C6D449D4CBD54ED5D1D655D6
          D8D75CD7E0D864D8E8D96CD9F1DA76DAFBDB80DC05DC8ADD10DD96DE1CDEA2DF
          29DFAFE036E0BDE144E1CCE253E2DBE363E3EBE473E4FCE584E60DE696E71FE7
          A9E832E8BCE946E9D0EA5BEAE5EB70EBFBEC86ED11ED9CEE28EEB4EF40EFCCF0
          58F0E5F172F1FFF28CF319F3A7F434F4C2F550F5DEF66DF6FBF78AF819F8A8F9
          38F9C7FA57FAE7FB77FC07FC98FD29FDBAFE4BFEDCFF6DFFFFFFEE000E41646F
          626500648000000001FFDB0084000C08080809080C09090C110B0A0B11150F0C
          0C0F1518131315131318110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C010D0B0B0D0E0D100E0E10140E0E0E14140E
          0E0E0E14110C0C0C0C0C11110C0C0C0C0C0C110C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC0001108003301150301220002110103
          1101FFDD00040012FFC4013F0000010501010101010100000000000000030001
          020405060708090A0B0100010501010101010100000000000000010002030405
          060708090A0B1000010401030204020507060805030C33010002110304211231
          054151611322718132061491A1B14223241552C16233347282D14307259253F0
          E1F163733516A2B283264493546445C2A3743617D255E265F2B384C3D375E3F3
          462794A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F637475767
          778797A7B7C7D7E7F71100020201020404030405060707060535010002110321
          3112044151617122130532819114A1B14223C152D1F0332462E1728292435315
          637334F1250616A2B283072635C2D2449354A317644555367465E2F2B384C3D3
          75E3F34694A485B495C4D4E4F4A5B5C5D5E5F55666768696A6B6C6D6E6F62737
          475767778797A7B7C7FFDA000C03010002110311003F00CDC9BB23ED376AEFE7
          1DFE1C8FCE3DA56E74FF00AA1D6F3F0EACCA6E636BB9BB9A1D7DB3131AED6B9A
          B9EC935FDA6E9347F38FE419FA457AA7D548FF009B783B76FF0035A6DE39770B
          3F0404E7212BD05EEF53F13E67272D831CF1800CA42278874E178CEA1F543ADF
          4FC2B732EB98EAE96EE706DF6C91C69B9AD6A85BF553AD55D30F5275CC348A85
          DB45F66EDA46F8FA3B3FE928757E8BF5A31316FC9CE7346183EFDD6B9C21CEDA
          C966F3F9CE5D9E747FCCB7FD18FB0B79FA3F41BFF453E38E3232B8CA3C31BA25
          872F37971C7098E5C79BDCCBC129638FA787D3E8F9BE6F53E6B49CBBAEAE9697
          0758E0C6CE418971DBE2B5FAAFD58EB7D2B0DD9991635D5B48690DC8B265C63F
          3C356474E35FED0C5D68FE7ABE019FA4D5E8BF5F63FE6EDB3B63D4AFE9F1F493
          31C04B1CE46EE2346C737CC4F1733CB62881C39A553B06FE68EDEA7CDFD6C9F1
          77FEC41FEF4BD6C9F177FEC41FEF5E89D4BA07D57C2E8EFCEBBA7D6E6D4C6BDD
          B25A4CEDFCE553EB3FD59E855741B3A861E3578D6D2D6D8D741821C5A36BC7F6
          91972F300FA81A1C55AECB31FC5704E501EDCC0C93F6A3223D3C7E9FF59FD778
          6F5B27C5DFFB107FBD6E1FAABD7074D3D4BD46FA22AF5E3ED166EDB1BFF776EE
          5D1D7F56FEAEF4EFABDF6DCAC3AF25ECA05D6BCC82E25BBA18EFF06DD569661A
          0FD51B4D0D15D07089AD8E321AD35FB5AE3F9DB53A1CBE878CFE8F1000B0E6F8
          A5980C10223EEFB5294C7A65FDDF5BE5DEB64F8BBFF620FF007A5EB64F8BBFF6
          20FF007AEE3A2FD56E878FD09BD4FA8E3332AD753EBBA01DA1B1BDACAD9FD44B
          AC7D5AE8393D01DD5307159896369F5D9208111BCB2D67F5533D89F0DD8BAE2E
          1EB4D8FF004A72FEE70704B878FDAF72BD1EE7F8FC4F0FEB64F8BBFF00620FF7
          A5EB64F8BBFF00620FF7AEFBA77D5FFABCEFAB55676460D563FECDEAD8F6C824
          86EE716BBF3549BF56FEAE750FABC3328C1AF1DD6506DADC0925A402E1B9FF00
          E13847EEF3AF986A38AB55A7E2B80120E39D467ED1957A78BFF0C7CFFD6C9F17
          7FEC41FEF4BD6C9F177FEC41FEF5DAFD57FAABD1ECE8ECEA7D468664BED6BAC0
          D00EC6B1B3C37F39DED47C8FAB7F577AA7427751C1C46E2586A7595388220B37
          7B6DAFF77D880C133106C6A38847C174BE29CBC7218704888CFDA96403D0327F
          8FC5FA2F07EB64F8BBFF00620FF7A5EB64F8BBFF00620FF7AEEFEACFD5DE8199
          F57F1F2F2B0EAB6D735E5F609D61CE1E28985F573EAC756E86DC9C6C26D22C6B
          FD3B249782D2E66E73BF3FDCD4872F3201121EA1C406AB67F15C1094E271CEB1
          CFDA94ABD3C5EAFF0059FD4780F5B27C5DFF00B107FBD6D749FAB3D6BAB620CB
          C6B1ADACB8B61F9164CB7FA81CB73EA77D57E8F95D2866E6E3D5936DAF706E87
          606B4ECF6B7E4B77EABD9D3ACE9AE3D3A8FB3638BAC68AC3B709061CE1FD64FC
          582F84CCE9216003AB173BF13E0192382078B14C427390FD5FE969F3F17E8BE7
          8CE9F92FC7B031D61CBAED7D62B1738B5E19B6431FF9B66EFDE59E6DCA060EF0
          4720E41FEF5DEFD54E93D373B1732FC8A99659F6CB46E6173741B4EBB5CDF76A
          A87D5DFAAFD37A8E7F50C8CBAD96D18F90FAAAA5B2350493EABBE93B6B534E12
          44387F4BC7B3243E21084B98F76CC70989151D7D7E9E08FAFD4F23EB64F8BBFF
          00620FF7A5EB64F8BBFF00620FF7AF44A3EAF7D54EA832F1EAC014BB16C3439E
          0169DC3F3D87F39677D53FAB7D2323F68539D8F4E4BF1324D2D780468D1DF543
          EEF3B03881E2BD7FBABBFD298383248E39C4E2E1E2811EAAC9F29FE71E33D6C9
          F177FEC41FEF5670B07ACE7EFF00B1517647A71BF65E4C4FD19F72EEBA7FD5FF
          00AA9997E7E357D3D80E2DBE93DC493A91BBF47AFB113EA963F4EC1C8EA5D3B1
          5805F8D7458F039ACC9C76BBF94C6A74797371E29692B1A770C797E2B018F21C
          78A5EE6310970E41E9E0C95EA3C193FACF9E6433A862DCEA3259655733E931D7
          90448DDFBC87EB64F8BBFF00620FF7AEF327A2748EB9F5AF21B65636E1D6C398
          387596BBF9AF74FF0037E92B55F40FAA7939B93D31BD39ADB3198C73DE0103DE
          34D8F9FCD43EEF224D485598C6FAD2EFF4AE28C63C78A467C11CB9040698C4EB
          F7B27F59F39F5727C5DFFB107FBD1B1BD5B1E3D77595D13B5D736E738309FA2E
          7EBF4513AEF4EA3A5F56C8C163A92CA9C366F0776D700F6EE8FEB2874CBABA6E
          2E665518AF3A6E2C2E6107E935EA1A22547A1A2DFE212C432406928894749ED2
          FF001FFE8BBD85D1B23219B6F65803D9B7D4AEE7398F0DFE6F271EC69FE73F7E
          BB3F9D41CEFAA5D728713865D9B5762DB9CC7FFDB6F77FD43D6DF4AB1B5C6D7E
          180FD4BB1F78DDE7E8B16EB3D435FA8CD493A021C2401F9BBCEF72B63146435B
          FA1717273D9F164354627F46425C1F9F147FC67CCADC0EB9482EB7132580724D
          8F8FBD55F5B27C5DFF00B107FBD7ADB1E0B87A2E0DB23DEC2216575EFAB3D3BA
          AD66D6D75D394D1FCE860FA5E1686FD36A64B96357195F8166C3F1889988E6C4
          200FE944C8F0FF007A0F9C7AD933CBBFF620FF007A4B5FFE67756FB40A7662C1
          9F76BE23F37E924A0F6F2762E97DEB96FF00390DB8B7E9FE33FFD0C9C973BED3
          77BDE3F48FFF00040FE71EEBD4FEAB13FF0036F08C927D23AC41E5DF9ABCBB21
          B67DA6E86DDFCE3F8708FA456AE1FD6DEBD838B5E2D0E70AAA1B581CDADC63FA
          CE59D832471CA4657A8AD1EABE23CA64E670E3863310632123C4787F47FAAC7A
          9647D6B7E3DCDCEB334E24FBFD4A4EC807DBBA47EF2EE7389FF998F3267EC2DD
          635FA0DFCC5C4667D69FAC1D4B16CC3BB7BEAB400F15B180E8777D260F256075
          5FADF9581FB3DB8B92FC635FA50DA44EC036FF0039B53E19220CAB8A5C51AD77
          62E6395CB923878860C3ED64E39084846261E9FEA47D6E274E73BF6862FE91FF
          00CF57FE080FCE6AF45FAF848FABD69048FD257A86EE3F4BF757138FF577EB1B
          6D65B5E164B5D5B839A6C7B1A25A7709F51CD5B5D419F5BBA9E29C4CF7E3D34B
          88719B6963A5A646B5EE43171084E3C12B90D34573BED4F99E5F28CD84470CAE
          7738717CD1F96317A2FACE4FFCD4C93247E859A8127967E6A8FD6527FE68E419
          23F415EA049E59F9AB1B2BF6E66613F0B33AAE0D7458D0D706BC17408FCFAD9F
          C952CAB3232B09D8397D771FD07B431C2BA897408FCF1FD5560991E2A84BD51E
          1E9FD673211C58FDAE2CF8BF5798E6970F14BD1FABFEA7FAB76BAB073BEA85C1
          925C71044093F45BF989B2370FA9AF990E181ACB759F4FFD1FFDF563E1E53707
          1062B3EB0BDD5B4433F57DEE68F06D96225DD5716EC57E25FD5EFB6BB186B796
          E3B43882369F7EDFA48D48D9E12098F0FE8FFDF31F1628D446584A31CDEF7156
          4E2E1FEEFB4ECE06458CFAAF464630F56D66235D58DB32E6B3E8FA6DFE50FA0B
          3BA8BBEB259D06FC8C9BB16BA9F8E5F65629B058D0E6EE35FBACFE73F3551E97
          9BD2BA4D7E963752CF7D533E9BD95BDA0FF277B3DAA5D4BAA747EA55FA597959
          EEAB935D7E9D6D3FD6D8DF72263231AA20F0D55FA551CB861989128CA0727B9C
          660659383F74465175F024FD4C66A49FB0BB5DBAFD077E629748967D52A4BE41
          188492441FA2E3F415AC2FB351D0EB341B063D744B0B88366D0D9FA5FE9161E5
          FD62E9B9F8DF62B1996E6590D76C7358E77F24BAB44408A3D447858CE6848C81
          D212CDEEF17E970FABF47FC274BEACD8E3F55F11F51DEF6D2436447B9A5DA6C1
          FCA5545BF5A32BA43B2AEB7168659439EFA9F4D82C6B769DC0CDBF4F6AA7D3FA
          B747E8AFB28C5AF28B3710E63AC163370D0B99B9C8BD47AFE0F52A3D0BB1B2BD
          17B4B8B6B7FA7B9ADFA45DB1DBB6376A5C12E0009D446A81D171CF88679CA201
          84F27B9C738094E11F9B8781BFF54FFF0012B8DA9335BCC9107E93FF00352FAA
          449FAAF8C4927DB66A46D3F4ECFCD55703AFF4DC5A2BE998F8D70AD8D31B9CD7
          43483639CEB373BF34A8F4BFAC1D2F1F1EAE9B898F7FA4370697B81201DCF7B9
          CF73BF3528C08E1FEAC787FE8ADCB9E13F7AAFF5998658E9FA03DDFF00D58DBF
          A94EDDF57A9D4B8EFB01246D3F4DDF9A9BEA535EDE8EF0FDD3F68BBE93769FA5
          FBAB2FA6758E8BD2DAEAF13EDA2B792E2C739AF6CF77377CED56D9F5A701A08F
          5B2F524CB9B5BA27F3469F452840810BDE238539F34252CFC27D39B20C80C851
          8F0F1FA6BFEA89BEA49270332493FAEDDCB76FEEA5F53DE0FED46EE25CDCEB24
          16ED8078FEB2A181D57A474FADF562E5E631B6D8EB5DBEBADFEE77D2E5BF4745
          4F1BF64E2E6599B8BD5B369BAE717580D6D73092777BAADBB134464383D37C37
          7F5659E5C190F3379047DDE138FD32FD0FDEE18FA5E82ABBEB3655F95E8BB1F1
          E9A2F7D550BAAB0B9CD6FD1B03858DDCDF72AFF534DBEAF57F59E2CB0663B7B9
          ADDADDD1EEF4E7F3155C8EA8326A350EBF6521DA17371835DFE7B7E8AA9D2D8D
          E955D95F4FEBD5EDB5DBDFEBD2E71988FA4E42A42513C32205DEB1EBE1C4912C
          32C3961EE6284A7C022230C83E43C52E3C9ED3BBF5789FDA7D73527F5A1C88FC
          DFFA481F57C9FF009C7D78493FA4AF42D803477E77E72CCC63D531AEC8BB13AC
          E13DF96FF52DDFA7BA36FB439BEC41A2BFACF8B97939789958975B9843AD8BAB
          2096F1B18FDBB10B90E1F44BD3291DBF7B8993831CFDEACF8BF5B8F1C23C52E0
          F563F6B8AF8A3FEADDBE8CF1FF003AFADB0B8931410D22340DECEFCEE558BAFF
          00AC17F54CAC6C234D38F8E2B2CB2FA9EEDE5EDDCED8F658C6BB6382E3EDC0FA
          E23A93BAA5755BF6A746E7E3DB51690006EDF49AE2DDBED47C9EBFF5E9959659
          8B935E905ECA013FE735AE6A68CB40894671F519683712659725C738CB1E5E5F
          2138F1E322538CB8278E3084A423FA7F2391F5A4E5B7AE64B72AE0FBC6CDE69A
          8ECFA0DFA3BCB9CB3B1F20D3607B87AC3F72CA647E10A573335CF75B7D797BDE
          4B9CEB090493C93B82143FC2FF00F3C2A7237227B9BD5DDC5011C5181313C311
          03C3C311E91D1EA7A2FD603BBE9D1834B74745405911F499ED1FF49CBA6A33DD
          93925B4BF739821C48FA23F7DEE5E63B6CFDDBFF00CF0B43A6759EA1D3AC0E60
          BADAE41757638387B676FF00D529B1E72284B668735F0D8CF8A78EB8AB489E1F
          FA4FA8066FAC10E3B870E812429074F683F45CDE2560749EBF566D6C01AF66DF
          A7B9C016FC755B35DCCB4863A43C6B3234EEAE466242C170B2E09E3918CC5533
          F43DD13DF74C6B1C6D492F74ED8F6F333AC732922C7AF77FFFD1D0B3EADB85F6
          3DBD15F612F71DD63AC703279DAD7D6D45AFA6754ABF98E935D5E6DC7693FE75
          BEA2F4049346380DA23EC679F37CC4F4966C921D8CE54F09B3EB5810CAEFAC78
          56C0CFFCF61A87661FD66B3F9C665BBE25DFF925DFA49CC04DEEF9D1E8FD6DDF
          4B16F77C413FC547F61F57FF00B856FF009ABD1D2494F9C7EC4EAFFF0070ADFF
          00352FD89D63FEE1DBFE6AF4749253E73FB13AC7FDC3B7FCD4BF62758FFB876F
          F9ABD1962FD63EAEEC3A9B898C4FDB3274616824B1B3EEB368FF00A0929E4FF6
          2758FF00B876FF009A9BF62758FF00B876FF009ABB1ABAF60B319C1F63DD763D
          7B9EDB18E63DFB47B9ED6BC0FCE557A8F57CDABA7D23F98C9CD0EB039C2054CE
          7D31B41F52EFDC494D1666FD656608C11D389AC57E96EDAEDD11B67E92A7D3F0
          FA96189FD9D7BAD2EFA60010D88F6FF2B77B96E8EB1D4B26F66160E3065A2A63
          EEB6F98ACB84ED7011BD4B1FACE6D9D69D836B195D2C259C3B7B881BBD467FC1
          B9253819585D4ADC6AF1EAE9B756DAC69227DDF9D648F73DEFFE522369EAA1C4
          1E9B61AA2BADADD8D915B4EEB19BA3DDEAC2ECAF7BEBA5EF63439ED692D693B4
          123C5E7E8AE7F03EB2752C9BB5C56D98ED6BDD63AA0FF686031FA47FB2CDF1F9
          A929CF1466863EBFD9991B6E07D67023738976F2676FB7737D893E8CDB043BA5
          E400186A6B5A400185DBDCDE3F3D9FA372BF8DF59F3DD84FC9B7137B9F6B6BC6
          6B03807177D264BB77D0FDF5B7D3CF507525D9E2B6D8E32D6573ED6FEE39CEFA
          4E494F35655D42B0CF47A75A0B592C00486EE249ADFF00D8156FD8B23F62758F
          FB876FF9ABB1EA9D56FC5CAAB1AA15B77B77BEDBB7444EDF4EA6D7EEB2E5519F
          58F28F50CB6BB1CFD8B11AFDCE876F05BF467F37F4AEFCD494F33FB13AC7FDC3
          B7FCD4BF62758FFB876FF9ABA467D67CB0C7DB91866A6D36065AC6CB9E3731CF
          6766FD2B362B54756CBB6C2C7D45AEC5A7D6CA0D1CBDCDDF5E33377F27DC929E
          47F62758FF00B876FF009A97EC4EB1FF0070EDFF003574C3EB0E5FD8FD62DA0D
          963DAD6417FA7587073BF59B48DBBDBB7FC1AB34F56B7232194B04FA357AF936
          31A434E9ECAAA16FBFF49F4D253C7FEC4EAFFF0070EDFF00352FD87D5FFEE15B
          FE6ADBA3ACE5656EEA376358F756F6D7854B1CF6B1CF76EF6BD9F45EF637FC22
          DEE8FD42CEA184326CAC54E2E734B0126369DBDE1253C38E89D60718770F8351
          19D3BEB157FCDD392CF8170FFBF2F4249253C236BFAD8DD36E511E0E970FFA7B
          941F87D76DFE7FA78BBC7D4C7AC9FBF6872EF9240807716BA3394758C8C7FBA7
          85F397FD5FBADFE73A189F1ADAFACFFE0766D4277D516BC7FC9B9951FE43F70F
          BAC67FDF97A5A49A70E33BC43621F10E6E1F2E7C9F59197FD27CBFFE6766D6ED
          F8B4E4B1C38DED20FF009D5B9CB4B169FACB430557F4EBAF6EBFA5ADF04FFC63
          1DE9EEFE52EF924CFBBC07CB71F23FF7CCA7E2BCC4856511CDFDF152FF001B1F
          03C8FABD7663EC591AFE769C03C4EEDDBB6A4BAE493BDAFEB159F7D1FE661FF3
          BFEF9FFFD2F55497CAA924A7EAA497CAA924A7EAA497CAA924A7EAA497CAA924
          A7EAA558FF004F1FCCFF0037DFF9EE7F37FE097CBC924A7EA5B3E90FA1C1FA5C
          FF00E72A4EFCDFA3CF7FFBEAF9612494FD53DCF1FC537E776E3E6BE5749253F4
          DF5DDBFB232B74C6C33B67F1D9EED9FBE8DD3A3EC18F1B23D36C7A53B38FF07B
          BDDB7FACBE5E49253F540FA238FE1F2525F2AA4929FAA0F2DE39EFCFF652FDEE
          3FD7F797CAE924A7EA8EE78E7FD6521F49DC76E39FED2F95D2494FD4DFE0CFD1
          E7FB3CA90FA478EDC73F35F2BA4929FAA07038F971F24EDE3B7C97CAC924A7EA
          A497CAA924A7EAA497CAA924A7EAA497CAA924A7EAA497CAA924A7EAA497CAA9
          24A7FFD9}
        Stretch = True
      end
      object QRLabel1: TQRLabel
        Left = 200
        Top = 63
        Width = 332
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.854166666666680000
          529.166666666666800000
          166.687500000000000000
          878.416666666666800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'DEPARTAMENTO DE CIRCULACI'#211'N'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 14
      end
      object QRExpr1: TQRExpr
        Left = 624
        Top = 8
        Width = 103
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1651.000000000000000000
          21.166666666666670000
          272.520833333333400000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'APPSTARTDATE'
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 213
      Width = 740
      Height = 28
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333340000
        1957.916666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRLabel7: TQRLabel
        Left = 48
        Top = 6
        Width = 40
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          127.000000000000000000
          15.875000000000000000
          105.833333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Fecha'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 136
        Top = 6
        Width = 48
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          359.833333333333400000
          15.875000000000000000
          127.000000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Edicion'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel9: TQRLabel
        Left = 216
        Top = 6
        Width = 57
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          571.500000000000000000
          15.875000000000000000
          150.812500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Dotacion'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel10: TQRLabel
        Left = 304
        Top = 6
        Width = 72
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          804.333333333333200000
          15.875000000000000000
          190.500000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Devoluci'#243'n'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel11: TQRLabel
        Left = 399
        Top = 6
        Width = 60
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1055.687500000000000000
          15.875000000000000000
          158.750000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Vendidos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel12: TQRLabel
        Left = 576
        Top = 6
        Width = 45
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1524.000000000000000000
          15.875000000000000000
          119.062500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Pago $'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel19: TQRLabel
        Left = 488
        Top = 6
        Width = 49
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1291.166666666667000000
          15.875000000000000000
          129.645833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Venta $'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLabel24: TQRLabel
        Left = 642
        Top = 7
        Width = 61
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1698.625000000000000000
          18.520833333333330000
          161.395833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Adeudo $'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object DetailBand1: TQRBand
      Left = 38
      Top = 241
      Width = 740
      Height = 28
      Frame.Color = clBlack
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        74.083333333333340000
        1957.916666666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object edicion: TQRDBText
        Left = 136
        Top = 6
        Width = 42
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          359.833333333333400000
          15.875000000000000000
          111.125000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'edicion'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Fecha: TQRDBText
        Left = 34
        Top = 6
        Width = 84
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          89.958333333333340000
          15.875000000000000000
          222.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'Fecha Edicion'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Dotacion: TQRDBText
        Left = 216
        Top = 6
        Width = 52
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          571.500000000000000000
          15.875000000000000000
          137.583333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'Dotacion'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object devolucion: TQRDBText
        Left = 304
        Top = 6
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          804.333333333333200000
          15.875000000000000000
          166.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'Devolucion'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object Pago: TQRDBText
        Left = 576
        Top = 5
        Width = 29
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1524.000000000000000000
          13.229166666666670000
          76.729166666666680000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'pago'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object vendidos: TQRDBText
        Left = 399
        Top = 5
        Width = 51
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1055.687500000000000000
          13.229166666666670000
          134.937500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'vendidos'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object adeudo: TQRDBText
        Left = 642
        Top = 6
        Width = 43
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1698.625000000000000000
          15.875000000000000000
          113.770833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataField = 'adeudo'
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object ventas: TQRDBText
        Left = 488
        Top = 5
        Width = 38
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1291.166666666667000000
          13.229166666666670000
          100.541666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
    end
  end
end
