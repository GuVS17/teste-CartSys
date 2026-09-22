unit CadastroClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxButtons,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxClasses,
  uCliente, uClienteController, Vcl.Menus, dxSkinsCore, dxSkinsDefaultPainters,
  Vcl.ComCtrls, dxCore, cxDateUtils, dxDateRanges, Vcl.StdCtrls;

type
  TFrCadCliente = class(TForm)
    btnNovo: TcxButton;
    btnEditar: TcxButton;
    btnExcluir: TcxButton;
    btnSalvar: TcxButton;
    btnCancelar: TcxButton;
    gbDados: TcxGroupBox;
    lblId: TcxLabel;
    edtId: TcxTextEdit;
    lblNome: TcxLabel;
    edtNome: TcxTextEdit;
    lblCep: TcxLabel;
    edtCep: TcxMaskEdit;
    lblCpfCnpj: TcxLabel;
    edtCpfCnpj: TcxTextEdit;
    lblEndereco: TcxLabel;
    edtEndereco: TcxTextEdit;
    lblNumero: TcxLabel;
    edtNumero: TcxTextEdit;
    lblComplemento: TcxLabel;
    edtComplemento: TcxTextEdit;
    lblBairro: TcxLabel;
    edtBairro: TcxTextEdit;
    lblCidade: TcxLabel;
    lblDataNasc: TcxLabel;
    edtDataNasc: TcxDateEdit;
    gbPesquisa: TcxGroupBox;
    lblPesqId: TcxLabel;
    edtPesqId: TcxTextEdit;
    lblPesqNome: TcxLabel;
    edtPesqNome: TcxTextEdit;
    lblPesqCpf: TcxLabel;
    edtPesqCpf: TcxTextEdit;
    lblPesqCep: TcxLabel;
    edtPesqCep: TcxTextEdit;
    lblPesqCidade: TcxLabel;
    lblPesqEstado: TcxLabel;
    lkpPesqEstado: TcxLookupComboBox;
    lblPesqData: TcxLabel;
    edtPesqData: TcxDateEdit;
    btnPesquisar: TcxButton;
    btnLimparFiltro: TcxButton;
    grdPesquisa: TcxGrid;
    tvPesquisa: TcxGridDBTableView;
    tvPesquisaID: TcxGridDBColumn;
    tvPesquisaNOME: TcxGridDBColumn;
    tvPesquisaCPF_CNPJ: TcxGridDBColumn;
    tvPesquisaCEP: TcxGridDBColumn;
    tvPesquisaBAIRRO: TcxGridDBColumn;
    tvPesquisaCIDADE: TcxGridDBColumn;
    tvPesquisaESTADO: TcxGridDBColumn;
    tvPesquisaDATANASCIMENTO: TcxGridDBColumn;
    lvPesquisa: TcxGridLevel;
    dsPesquisa: TDataSource;
    dsCidades: TDataSource;
    dsEstados: TDataSource;
    edtCidade: TcxTextEdit;
    edtCidadePesq: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLimparFiltroClick(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure tvPesquisaCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
        TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
        var AHandled: Boolean);
  private
    FController: TClienteController;
    FCliente: TCliente;
    FEditando: Boolean;
    FCarregando: Boolean;
    FInserindo: Boolean;
    function ValorLookup(ALookup: TcxLookupComboBox): Integer;
    function ValorData(AEdit: TcxDateEdit): TDate;
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure ClienteParaTela;
    procedure TelaParaCliente;
    procedure CarregarPorId(AId: Integer);
    procedure AplicarPesquisa;
    procedure ConsultarCep;
  public
    { Public declarations }
  end;

var
  FrCadCliente: TFrCadCliente;

implementation

{$R *.dfm}

function TFrCadCliente.ValorLookup(ALookup: TcxLookupComboBox): Integer;
begin
  if VarIsNull(ALookup.EditValue) or (VarToStr(ALookup.EditValue) = '') then
    Result := 0
  else
    Result := ALookup.EditValue;
end;

function TFrCadCliente.ValorData(AEdit: TcxDateEdit): TDate;
begin
  if VarIsNull(AEdit.EditValue) or (VarToStr(AEdit.EditValue) = '') then
    Result := 0
  else
    Result := AEdit.Date;
end;

procedure TFrCadCliente.HabilitarCampos(AHabilitar: Boolean);
begin
  edtNome.Enabled        := AHabilitar;
  edtCep.Enabled         := AHabilitar;
  edtCpfCnpj.Enabled     := AHabilitar;
  edtEndereco.Enabled    := AHabilitar;
  edtNumero.Enabled      := AHabilitar;
  edtComplemento.Enabled := AHabilitar;
  edtBairro.Enabled      := AHabilitar;
  edtCidade.Enabled      := AHabilitar;
  edtDataNasc.Enabled    := AHabilitar;

  btnNovo.Enabled     := not AHabilitar;
  btnEditar.Enabled   := (not AHabilitar) and (FCliente.ID > 0);
  btnExcluir.Enabled  := (not AHabilitar) and (FCliente.ID > 0);
  btnSalvar.Enabled   := AHabilitar;
  btnCancelar.Enabled := AHabilitar;
end;

procedure TFrCadCliente.ClienteParaTela;
begin
  FCarregando := True;
  try
    if FCliente.ID > 0 then
      edtId.Text := IntToStr(FCliente.ID)
    else
      edtId.Text := '';

    edtNome.Text        := FCliente.Nome;
    edtCep.Text         := FCliente.Cep;
    edtCpfCnpj.Text     := FCliente.CpfCnpj;
    edtEndereco.Text    := FCliente.Endereco;
    edtNumero.Text      := FCliente.Numero;
    edtComplemento.Text := FCliente.Complemento;
    edtBairro.Text      := FCliente.Bairro;

    edtCidade.Text := FController.NomeCidadePorId(FCliente.CidadeId);

    if FCliente.DataNascimento > 0 then
      edtDataNasc.EditValue := TDateTime(FCliente.DataNascimento)
    else
      edtDataNasc.Clear;
  finally
    FCarregando := False;
  end;
end;

procedure TFrCadCliente.TelaParaCliente;
begin
  FCliente.Nome           := Trim(edtNome.Text);
  FCliente.Cep            := edtCep.Text;
  FCliente.CpfCnpj        := edtCpfCnpj.Text;
  FCliente.Endereco       := Trim(edtEndereco.Text);
  FCliente.Numero         := Trim(edtNumero.Text);
  FCliente.Complemento    := Trim(edtComplemento.Text);
  FCliente.Bairro         := Trim(edtBairro.Text);
  FCliente.CidadeId       := 0;
  FCliente.DataNascimento := ValorData(edtDataNasc);
end;

procedure TFrCadCliente.CarregarPorId(AId: Integer);
var
  Cliente: TCliente;
begin
  Cliente := FController.BuscarPorId(AId);
  if Cliente = nil then
  begin
    ShowMessage('Cliente não encontrado.');
    Exit;
  end;

  FCliente.Free;
  FCliente := Cliente;
  FInserindo := False;
  ClienteParaTela;
  HabilitarCampos(False);
end;

procedure TFrCadCliente.AplicarPesquisa;
var
  Filtro: TFiltroCliente;
begin
  Filtro.Id             := StrToIntDef(Trim(edtPesqId.Text), 0);
  Filtro.Nome           := Trim(edtPesqNome.Text);
  Filtro.CpfCnpj        := Trim(edtPesqCpf.Text);
  Filtro.Cep            := Trim(edtPesqCep.Text);
  Filtro.CidadeId       := 0;
  Filtro.CidadeNome     := Trim(edtCidadePesq.Text);
  Filtro.EstadoId       := ValorLookup(lkpPesqEstado);
  Filtro.DataNascimento := ValorData(edtPesqData);
  FController.Pesquisar(Filtro);
end;

procedure TFrCadCliente.ConsultarCep;
var
  Resultado: TResultadoCEP;
begin
  if FCarregando or (not FEditando) then
    Exit;
  if TCliente.SomenteNumeros(edtCep.Text) = '' then
    Exit;

  if not FController.ConsultarCEP(edtCep.Text, Resultado) then
  begin
    ShowMessage(Resultado.Mensagem);
    if edtCep.CanFocus then
      edtCep.SetFocus;
    Exit;
  end;

  edtEndereco.Text := Resultado.Endereco;
  edtBairro.Text := Resultado.Bairro;
  if Resultado.CidadeId > 0 then
    edtCidade.Text := Resultado.CidadeNome;

  if Resultado.Mensagem <> '' then
    ShowMessage(Resultado.Mensagem);
end;

procedure TFrCadCliente.FormCreate(Sender: TObject);
begin
  FController := TClienteController.Create;
  FCliente := TCliente.Create;
  FEditando := False;
  FCarregando := False;
  FInserindo := False;

  dsCidades.DataSet := FController.QryCidades;
  dsEstados.DataSet := FController.QryEstados;
  dsPesquisa.DataSet := FController.QryPesquisa;

  lkpPesqEstado.Properties.ListSource := dsEstados;
  lkpPesqEstado.Properties.KeyFieldNames := 'ID';
  lkpPesqEstado.Properties.ListFieldNames := 'NOME';

  ClienteParaTela;
  HabilitarCampos(False);
  AplicarPesquisa;
end;

procedure TFrCadCliente.FormDestroy(Sender: TObject);
begin
  FCliente.Free;
  FController.Free;
end;

procedure TFrCadCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
    Exit;
  if ActiveControl is TcxGridSite then
    Exit;

  Key := #0;
  Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TFrCadCliente.btnNovoClick(Sender: TObject);
begin
  FCliente.Limpar;
  FCliente.ID := FController.ProximoId;
  ClienteParaTela;
  FInserindo := True;
  FEditando := True;
  HabilitarCampos(True);
  if edtNome.CanFocus then
    edtNome.SetFocus;
end;

procedure TFrCadCliente.btnEditarClick(Sender: TObject);
begin
  if FCliente.ID <= 0 then
  begin
    ShowMessage('Selecione um cliente para editar.');
    Exit;
  end;

  FEditando := True;
  HabilitarCampos(True);
  if edtNome.CanFocus then
    edtNome.SetFocus;
end;

procedure TFrCadCliente.btnExcluirClick(Sender: TObject);
var
  Mensagem: String;
begin
  if FCliente.ID <= 0 then
  begin
    ShowMessage('Selecione um cliente para excluir.');
    Exit;
  end;

  if not TCliente.PodeExcluir(FCliente.ID) then
  begin
    ShowMessage('Este cliente n'#227'o pode ser exclu'#237'do.');
    Exit;
  end;

  if MessageDlg('Confirma a exclusão deste cliente?', mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if FController.Excluir(FCliente.ID, Mensagem) then
  begin
    ShowMessage(Mensagem);
    FCliente.Limpar;
    ClienteParaTela;
    HabilitarCampos(False);
    AplicarPesquisa;
  end
  else
    ShowMessage(Mensagem);
end;

procedure TFrCadCliente.btnSalvarClick(Sender: TObject);
var
  Mensagem: String;
  IdCidade: Integer;
begin
  TelaParaCliente;

  IdCidade := FController.BuscarCidade(Trim(edtCidade.Text), '');
  if IdCidade = 0 then
  begin
    ShowMessage('Cidade não encontrada. Digite o nome exatamente como cadastrado.');
    if edtCidade.CanFocus then
      edtCidade.SetFocus;
    Exit;
  end;

  FCliente.CidadeId := IdCidade;

  if not FController.Salvar(FCliente, FInserindo, Mensagem) then
  begin
    ShowMessage(Mensagem);
    Exit;
  end;

  ShowMessage(Mensagem);
  FInserindo := False;
  FEditando := False;
  ClienteParaTela;
  HabilitarCampos(False);
  AplicarPesquisa;
end;

procedure TFrCadCliente.btnCancelarClick(Sender: TObject);
var
  IdAtual: Integer;
  Cliente: TCliente;
begin
  FEditando := False;
  IdAtual := FCliente.ID;
  if FInserindo then
    FController.DevolverId(IdAtual);
  FInserindo := False;
  Cliente := FController.BuscarPorId(IdAtual);
  if Cliente <> nil then
  begin
    Cliente.Free;
    CarregarPorId(IdAtual);
  end
  else
  begin
    FCliente.Limpar;
    ClienteParaTela;
    HabilitarCampos(False);
  end;
end;

procedure TFrCadCliente.btnPesquisarClick(Sender: TObject);
begin
  AplicarPesquisa;
end;

procedure TFrCadCliente.btnLimparFiltroClick(Sender: TObject);
begin
  edtPesqId.Clear;
  edtPesqNome.Clear;
  edtPesqCpf.Clear;
  edtPesqCep.Clear;
  edtCidadePesq.Clear;
  lkpPesqEstado.Clear;
  edtPesqData.Clear;
  AplicarPesquisa;
end;

procedure TFrCadCliente.edtCepExit(Sender: TObject);
begin
  ConsultarCep;
end;

procedure TFrCadCliente.tvPesquisaCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift:
    TShiftState; var AHandled: Boolean);
begin
  if FEditando then
    Exit;
  if FController.QryPesquisa.IsEmpty then
    Exit;
  CarregarPorId(FController.QryPesquisa.FieldByName('ID').AsInteger);
end;

end.
