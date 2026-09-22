object FrRelatorio: TFrRelatorio
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Relatório de Clientes'
  ClientHeight = 259
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 466
    Height = 259
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object btnFechar: TcxButton
      Left = 112
      Top = 225
      Width = 80
      Height = 25
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnGerar: TcxButton
      Left = 8
      Top = 225
      Width = 95
      Height = 25
      Caption = '&Gerar'
      TabOrder = 1
      OnClick = btnGerarClick
    end
    object gbCidadeEstado: TcxGroupBox
      Left = 8
      Top = 130
      Caption = 'Cidade / Estado'
      TabOrder = 2
      Height = 89
      Width = 449
      object lblCidade: TcxLabel
        Left = 12
        Top = 20
        Caption = 'Cidade'
        Transparent = True
      end
      object lkpCidade: TcxLookupComboBox
        Left = 12
        Top = 36
        Properties.DropDownAutoSize = True
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NOMEUF'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsCidades
        TabOrder = 0
        Width = 165
      end
      object lblEstado: TcxLabel
        Left = 184
        Top = 20
        Caption = 'Estado'
        Transparent = True
      end
      object lkpEstado: TcxLookupComboBox
        Left = 184
        Top = 36
        Properties.DropDownAutoSize = True
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NOME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsEstados
        TabOrder = 1
        Width = 105
      end
    end
    object gbFaixa: TcxGroupBox
      Left = 8
      Top = 56
      Caption = 'Faixa de ID'
      TabOrder = 3
      Height = 73
      Width = 449
      object lblIdInicial: TcxLabel
        Left = 12
        Top = 20
        Caption = 'ID inicial'
        Transparent = True
      end
      object edtIdInicial: TcxTextEdit
        Left = 12
        Top = 36
        TabOrder = 0
        Width = 80
      end
      object lblIdFinal: TcxLabel
        Left = 108
        Top = 20
        Caption = 'ID final'
        Transparent = True
      end
      object edtIdFinal: TcxTextEdit
        Left = 108
        Top = 36
        TabOrder = 1
        Width = 80
      end
    end
    object rgFiltro: TcxRadioGroup
      Left = 8
      Top = 8
      Caption = 'Filtro'
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Todos'
        end
        item
          Caption = 'Id inicial e Id final'
        end
        item
          Caption = 'Cidade/Estado'
        end>
      ItemIndex = 0
      TabOrder = 4
      OnClick = rgFiltroClick
      Height = 49
      Width = 449
    end
  end
  object dsRelatorio: TDataSource
    Left = 24
    Top = 128
  end
  object dsCidades: TDataSource
    Left = 64
    Top = 128
  end
  object dsEstados: TDataSource
    Left = 104
    Top = 128
  end
  object plCliente: TppDBPipeline
    DataSource = dsRelatorio
    UserName = 'plCliente'
    Left = 24
    Top = 176
  end
  object rptCliente: TppReport
    AutoStop = False
    DataPipeline = plCliente
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Relatorio de Clientes'
    PrinterSetup.PaperName = 'Custom'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 10000
    PrinterSetup.mmMarginLeft = 10000
    PrinterSetup.mmMarginRight = 10000
    PrinterSetup.mmMarginTop = 10000
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 256
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    Left = 64
    Top = 176
    Version = '19.04'
    mmColumnWidth = 0
    DataPipelineName = 'plCliente'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 28000
      mmPrintPosition = 0
      object lblTitulo: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTitulo'
        Border.mmPadding = 0
        Caption = 'Relatório de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 5821
        mmLeft = 0
        mmTop = 794
        mmWidth = 55033
        BandType = 0
        LayerName = BandLayer
      end
      object lblFiltroAplicado: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblFiltroAplicado'
        Border.mmPadding = 0
        Caption = 'Filtro: Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 0
        mmTop = 7408
        mmWidth = 17463
        BandType = 0
        LayerName = BandLayer
      end
      object lblColId: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColId'
        Border.mmPadding = 0
        Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 0
        mmTop = 16933
        mmWidth = 3704
        BandType = 0
        LayerName = BandLayer
      end
      object lblColNome: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColNome'
        Border.mmPadding = 0
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 13229
        mmTop = 16933
        mmWidth = 8467
        BandType = 0
        LayerName = BandLayer
      end
      object lblColCpfCnpj: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColCpfCnpj'
        Border.mmPadding = 0
        Caption = 'CPF/CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 63500
        mmTop = 16933
        mmWidth = 16933
        BandType = 0
        LayerName = BandLayer
      end
      object lblColCep: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColCep'
        Border.mmPadding = 0
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 92604
        mmTop = 16933
        mmWidth = 6350
        BandType = 0
        LayerName = BandLayer
      end
      object lblColBairro: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColBairro'
        Border.mmPadding = 0
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 110331
        mmTop = 16933
        mmWidth = 9525
        BandType = 0
        LayerName = BandLayer
      end
      object lblColCidade: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColCidade'
        Border.mmPadding = 0
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 140494
        mmTop = 16933
        mmWidth = 11113
        BandType = 0
        LayerName = BandLayer
      end
      object lblColEstado: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblColEstado'
        Border.mmPadding = 0
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 166688
        mmTop = 16933
        mmWidth = 11113
        BandType = 0
        LayerName = BandLayer
      end
      object linCabecalho: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'linCabecalho'
        Border.mmPadding = 0
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 21167
        mmWidth = 190000
        BandType = 0
        LayerName = BandLayer
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4233
      mmPrintPosition = 0
      object dbId: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbId'
        Border.mmPadding = 0
        DataField = 'ID'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 0
        mmTop = 0
        mmWidth = 11906
        BandType = 4
        LayerName = BandLayer
      end
      object dbNome: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbNome'
        Border.mmPadding = 0
        DataField = 'NOME'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 13229
        mmTop = 0
        mmWidth = 48683
        BandType = 4
        LayerName = BandLayer
      end
      object dbCpfCnpj: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbCpfCnpj'
        Border.mmPadding = 0
        DataField = 'CPF_CNPJ'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 63500
        mmTop = 0
        mmWidth = 27252
        BandType = 4
        LayerName = BandLayer
      end
      object dbCep: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbCep'
        Border.mmPadding = 0
        DataField = 'CEP'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 92604
        mmTop = 0
        mmWidth = 15875
        BandType = 4
        LayerName = BandLayer
      end
      object dbBairro: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbBairro'
        Border.mmPadding = 0
        DataField = 'BAIRRO'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 110331
        mmTop = 0
        mmWidth = 27781
        BandType = 4
        LayerName = BandLayer
      end
      object dbCidade: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbCidade'
        Border.mmPadding = 0
        DataField = 'CIDADE'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 140494
        mmTop = 0
        mmWidth = 24606
        BandType = 4
        LayerName = BandLayer
      end
      object dbEstado: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'dbEstado'
        Border.mmPadding = 0
        DataField = 'ESTADO'
        DataPipeline = plCliente
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plCliente'
        mmHeight = 3175
        mmLeft = 166688
        mmTop = 0
        mmWidth = 23283
        BandType = 4
        LayerName = BandLayer
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 7938
      mmPrintPosition = 0
      object svData: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'svData'
        Border.mmPadding = 0
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 0
        mmTop = 2117
        mmWidth = 33338
        BandType = 8
        LayerName = BandLayer
      end
      object svPagina: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'svPagina'
        Border.mmPadding = 0
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 150284
        mmTop = 2117
        mmWidth = 39688
        BandType = 8
        LayerName = BandLayer
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'BandLayer'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
end
