object FrCadCliente: TFrCadCliente
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 624
  ClientWidth = 872
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
  object pcPrincipal: TcxPageControl
    Left = 0
    Top = 0
    Width = 872
    Height = 624
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tsPesquisa
    Properties.CustomButtons.Buttons = <>
    OnChange = pcPrincipalChange
    ClientRectBottom = 620
    ClientRectLeft = 4
    ClientRectRight = 868
    ClientRectTop = 24
    object tsPesquisa: TcxTabSheet
      Caption = 'Pesquisa'
      ImageIndex = 0
      DesignSize = (
        864
        596)
      object gbPesquisa: TcxGroupBox
        Left = 8
        Top = 8
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Pesquisa'
        TabOrder = 0
        DesignSize = (
          848
          580)
        Height = 580
        Width = 848
        object lblPesqId: TcxLabel
          Left = 12
          Top = 20
          Caption = 'ID'
          Transparent = True
        end
        object edtPesqId: TcxTextEdit
          Left = 12
          Top = 36
          TabOrder = 0
          Width = 60
        end
        object lblPesqNome: TcxLabel
          Left = 80
          Top = 20
          Caption = 'Nome'
          Transparent = True
        end
        object edtPesqNome: TcxTextEdit
          Left = 80
          Top = 36
          TabOrder = 1
          Width = 160
        end
        object lblPesqCpf: TcxLabel
          Left = 248
          Top = 20
          Caption = 'CPF/CNPJ'
          Transparent = True
        end
        object edtPesqCpf: TcxTextEdit
          Left = 248
          Top = 36
          TabOrder = 2
          Width = 110
        end
        object lblPesqCep: TcxLabel
          Left = 366
          Top = 20
          Caption = 'CEP'
          Transparent = True
        end
        object edtPesqCep: TcxTextEdit
          Left = 366
          Top = 36
          TabOrder = 3
          Width = 80
        end
        object lblPesqCidade: TcxLabel
          Left = 454
          Top = 20
          Caption = 'Cidade'
          Transparent = True
        end
        object edtCidadePesq: TcxTextEdit
          Left = 454
          Top = 36
          TabOrder = 4
          Width = 178
        end
        object lblPesqEstado: TcxLabel
          Left = 12
          Top = 68
          Caption = 'Estado'
          Transparent = True
        end
        object lkpPesqEstado: TcxLookupComboBox
          Left = 12
          Top = 84
          Properties.DropDownAutoSize = True
          Properties.KeyFieldNames = 'ID'
          Properties.ListColumns = <
            item
              FieldName = 'NOME'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dsEstados
          TabOrder = 5
          Width = 180
        end
        object lblPesqData: TcxLabel
          Left = 200
          Top = 68
          Caption = 'Nascimento'
          Transparent = True
        end
        object edtPesqData: TcxDateEdit
          Left = 200
          Top = 84
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 6
          Width = 110
        end
        object btnPesquisar: TcxButton
          Left = 320
          Top = 84
          Width = 80
          Height = 21
          Caption = '&Pesquisar'
          TabOrder = 7
          OnClick = btnPesquisarClick
        end
        object btnLimparFiltro: TcxButton
          Left = 408
          Top = 84
          Width = 80
          Height = 21
          Caption = '&Limpar'
          TabOrder = 8
          OnClick = btnLimparFiltroClick
        end
        object btnNovo: TcxButton
          Left = 496
          Top = 84
          Width = 80
          Height = 21
          Caption = '&Novo'
          TabOrder = 9
          OnClick = btnNovoClick
        end
        object grdPesquisa: TcxGrid
          Left = 12
          Top = 118
          Width = 824
          Height = 446
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 10
          object tvPesquisa: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnCellDblClick = tvPesquisaCellDblClick
            DataController.DataSource = dsPesquisa
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object tvPesquisaID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Width = 50
            end
            object tvPesquisaNOME: TcxGridDBColumn
              Caption = 'Nome'
              DataBinding.FieldName = 'NOME'
              Width = 180
            end
            object tvPesquisaCPF_CNPJ: TcxGridDBColumn
              Caption = 'CPF/CNPJ'
              DataBinding.FieldName = 'CPF_CNPJ'
              Width = 110
            end
            object tvPesquisaCEP: TcxGridDBColumn
              DataBinding.FieldName = 'CEP'
              Width = 70
            end
            object tvPesquisaBAIRRO: TcxGridDBColumn
              Caption = 'Bairro'
              DataBinding.FieldName = 'BAIRRO'
              Width = 110
            end
            object tvPesquisaCIDADE: TcxGridDBColumn
              Caption = 'Cidade'
              DataBinding.FieldName = 'CIDADE'
              Width = 110
            end
            object tvPesquisaESTADO: TcxGridDBColumn
              Caption = 'Estado'
              DataBinding.FieldName = 'ESTADO'
              Width = 100
            end
            object tvPesquisaDATANASCIMENTO: TcxGridDBColumn
              Caption = 'Nascimento'
              DataBinding.FieldName = 'DATANASCIMENTO'
              Width = 90
            end
          end
          object lvPesquisa: TcxGridLevel
            GridView = tvPesquisa
          end
        end
      end
    end
    object tsCadastro: TcxTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object btnEditar: TcxButton
        Left = 8
        Top = 8
        Width = 80
        Height = 25
        Caption = '&Editar'
        TabOrder = 0
        OnClick = btnEditarClick
      end
      object btnExcluir: TcxButton
        Left = 92
        Top = 8
        Width = 80
        Height = 25
        Caption = 'E&xcluir'
        TabOrder = 1
        OnClick = btnExcluirClick
      end
      object btnSalvar: TcxButton
        Left = 176
        Top = 8
        Width = 80
        Height = 25
        Caption = '&Salvar'
        TabOrder = 2
        OnClick = btnSalvarClick
      end
      object btnCancelar: TcxButton
        Left = 260
        Top = 8
        Width = 80
        Height = 25
        Caption = '&Cancelar'
        TabOrder = 3
        OnClick = btnCancelarClick
      end
      object btnVoltar: TcxButton
        Left = 344
        Top = 8
        Width = 80
        Height = 25
        Caption = '&Voltar'
        TabOrder = 4
        OnClick = btnVoltarClick
      end
      object gbDados: TcxGroupBox
        Left = 8
        Top = 40
        Caption = 'Dados do cliente'
        TabOrder = 5
        Height = 232
        Width = 848
        object lblId: TcxLabel
          Left = 12
          Top = 20
          Caption = 'ID'
          Transparent = True
        end
        object edtId: TcxTextEdit
          Left = 12
          Top = 36
          Properties.ReadOnly = True
          TabOrder = 0
          Width = 70
        end
        object lblNome: TcxLabel
          Left = 92
          Top = 20
          Caption = 'Nome'
          Transparent = True
        end
        object edtNome: TcxTextEdit
          Left = 92
          Top = 36
          Properties.MaxLength = 80
          TabOrder = 1
          Width = 500
        end
        object lblCep: TcxLabel
          Left = 12
          Top = 68
          Caption = 'CEP'
          Transparent = True
        end
        object edtCep: TcxMaskEdit
          Left = 12
          Top = 84
          Properties.EditMask = '00000-000;0;_'
          Properties.MaxLength = 0
          TabOrder = 2
          Text = '        '
          OnExit = edtCepExit
          Width = 90
        end
        object lblCpfCnpj: TcxLabel
          Left = 112
          Top = 68
          Caption = 'CPF/CNPJ'
          Transparent = True
        end
        object edtCpfCnpj: TcxTextEdit
          Left = 112
          Top = 84
          Properties.MaxLength = 14
          TabOrder = 3
          Width = 130
        end
        object lblDataNasc: TcxLabel
          Left = 252
          Top = 68
          Caption = 'Nascimento'
          Transparent = True
        end
        object edtDataNasc: TcxDateEdit
          Left = 252
          Top = 84
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 4
          Width = 110
        end
        object lblEndereco: TcxLabel
          Left = 12
          Top = 116
          Caption = 'Endere'#231'o'
          Transparent = True
        end
        object edtEndereco: TcxTextEdit
          Left = 12
          Top = 132
          Properties.MaxLength = 100
          TabOrder = 5
          Width = 520
        end
        object lblNumero: TcxLabel
          Left = 542
          Top = 116
          Caption = 'N'#250'mero'
          Transparent = True
        end
        object edtNumero: TcxTextEdit
          Left = 542
          Top = 132
          Properties.MaxLength = 20
          TabOrder = 6
          Width = 90
        end
        object lblComplemento: TcxLabel
          Left = 12
          Top = 164
          Caption = 'Complemento'
          Transparent = True
        end
        object edtComplemento: TcxTextEdit
          Left = 12
          Top = 180
          Properties.MaxLength = 60
          TabOrder = 7
          Width = 200
        end
        object lblBairro: TcxLabel
          Left = 222
          Top = 164
          Caption = 'Bairro'
          Transparent = True
        end
        object edtBairro: TcxTextEdit
          Left = 222
          Top = 180
          Properties.MaxLength = 100
          TabOrder = 8
          Width = 220
        end
        object lblCidade: TcxLabel
          Left = 452
          Top = 164
          Caption = 'Cidade'
          Transparent = True
        end
        object edtCidade: TcxTextEdit
          Left = 454
          Top = 180
          TabOrder = 9
          Width = 178
        end
      end
    end
  end
  object dsPesquisa: TDataSource
    Left = 760
    Top = 8
  end
  object dsCidades: TDataSource
    Left = 800
    Top = 8
  end
  object dsEstados: TDataSource
    Left = 840
    Top = 8
  end
end
