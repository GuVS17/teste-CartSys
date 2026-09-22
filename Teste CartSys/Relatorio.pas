unit Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, cxRadioGroup, cxLabel, cxTextEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxButtons,
  ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppTypes,
  ppCtrls, ppVar, ppPrnabl, ppBands, ppCache, ppDesignLayer, ppParameter,
  uCliente, uClienteController, dxSkinsCore, dxSkinsDefaultPainters, Vcl.Menus,
  Vcl.StdCtrls, cxMaskEdit, Vcl.ExtCtrls;

type
  TFrRelatorio = class(TForm)
    rgFiltro: TcxRadioGroup;
    gbFaixa: TcxGroupBox;
    lblIdInicial: TcxLabel;
    edtIdInicial: TcxTextEdit;
    lblIdFinal: TcxLabel;
    edtIdFinal: TcxTextEdit;
    gbCidadeEstado: TcxGroupBox;
    lblCidade: TcxLabel;
    lkpCidade: TcxLookupComboBox;
    lblEstado: TcxLabel;
    lkpEstado: TcxLookupComboBox;
    btnGerar: TcxButton;
    btnFechar: TcxButton;
    dsRelatorio: TDataSource;
    dsCidades: TDataSource;
    dsEstados: TDataSource;
    plCliente: TppDBPipeline;
    rptCliente: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    lblTitulo: TppLabel;
    lblFiltroAplicado: TppLabel;
    lblColId: TppLabel;
    lblColNome: TppLabel;
    lblColCpfCnpj: TppLabel;
    lblColCep: TppLabel;
    lblColBairro: TppLabel;
    lblColCidade: TppLabel;
    lblColEstado: TppLabel;
    linCabecalho: TppLine;
    dbId: TppDBText;
    dbNome: TppDBText;
    dbCpfCnpj: TppDBText;
    dbCep: TppDBText;
    dbBairro: TppDBText;
    dbCidade: TppDBText;
    dbEstado: TppDBText;
    svData: TppSystemVariable;
    svPagina: TppSystemVariable;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rgFiltroClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure lkpEstadoPropertiesEditValueChanged(Sender: TObject);
    procedure lkpCidadePropertiesEditValueChanged(Sender: TObject);
  private
    FController: TClienteController;
    FAtualizandoLookup: Boolean;
    function ValorLookup(ALookup: TcxLookupComboBox): Integer;
    function EstadoIdDaCidade(ACidadeId: Integer): Integer;
    function MontarFiltro(out AFiltro: TFiltroRelatorio; out AMensagem: String): Boolean;
    function TextoFiltro(const AFiltro: TFiltroRelatorio): String;
    procedure HabilitarFiltros;
    procedure LimparCamposFiltro;
    procedure FiltrarCidadesPorEstado(AEstadoId: Integer);
  public
    { Public declarations }
  end;

var
  FrRelatorio: TFrRelatorio;

implementation

{$R *.dfm}

function TFrRelatorio.ValorLookup(ALookup: TcxLookupComboBox): Integer;
begin
  if VarIsNull(ALookup.EditValue) or (VarToStr(ALookup.EditValue) = '') then
    Result := 0
  else
    Result := ALookup.EditValue;
end;

function TFrRelatorio.EstadoIdDaCidade(ACidadeId: Integer): Integer;
begin
  Result := 0;
  if ACidadeId <= 0 then
    Exit;
  if FController.QryCidades.Locate('ID', ACidadeId, []) then
    Result := FController.QryCidades.FieldByName('ESTADOID').AsInteger;
end;

procedure TFrRelatorio.FiltrarCidadesPorEstado(AEstadoId: Integer);
begin
  if AEstadoId > 0 then
  begin
    FController.QryCidades.Filter := 'ESTADOID = ' + IntToStr(AEstadoId);
    FController.QryCidades.Filtered := True;
  end
  else
  begin
    FController.QryCidades.Filtered := False;
    FController.QryCidades.Filter := '';
  end;
end;

procedure TFrRelatorio.HabilitarFiltros;
begin
  gbFaixa.Enabled := rgFiltro.ItemIndex = 1;
  gbCidadeEstado.Enabled := rgFiltro.ItemIndex = 2;
end;

procedure TFrRelatorio.LimparCamposFiltro;
begin
  FAtualizandoLookup := True;
  try
    edtIdInicial.Clear;
    edtIdFinal.Clear;
    lkpCidade.Clear;
    lkpEstado.Clear;
    FiltrarCidadesPorEstado(0);
  finally
    FAtualizandoLookup := False;
  end;
end;

function TFrRelatorio.MontarFiltro(out AFiltro: TFiltroRelatorio;
  out AMensagem: String): Boolean;
begin
  Result := False;
  AMensagem := '';
  AFiltro.Tipo := TTipoFiltroRelatorio(rgFiltro.ItemIndex);
  AFiltro.IdInicial := StrToIntDef(Trim(edtIdInicial.Text), 0);
  AFiltro.IdFinal := StrToIntDef(Trim(edtIdFinal.Text), 0);
  AFiltro.CidadeId := ValorLookup(lkpCidade);
  AFiltro.EstadoId := ValorLookup(lkpEstado);

  case AFiltro.Tipo of
    tfrFaixaId:
    begin
      if (AFiltro.IdInicial <= 0) or (AFiltro.IdFinal <= 0) then
      begin
        AMensagem := 'Informe o ID inicial e o ID final.';
        Exit;
      end;
      if AFiltro.IdInicial > AFiltro.IdFinal then
      begin
        AMensagem := 'O ID inicial n'#227'o pode ser maior que o ID final.';
        Exit;
      end;
    end;
    tfrCidadeEstado:
    begin
      if (AFiltro.CidadeId <= 0) and (AFiltro.EstadoId <= 0) then
      begin
        AMensagem := 'Selecione a cidade e/ou o estado.';
        Exit;
      end;
    end;
  end;

  Result := True;
end;

function TFrRelatorio.TextoFiltro(const AFiltro: TFiltroRelatorio): String;
begin
  case AFiltro.Tipo of
    tfrFaixaId:
      Result := 'Filtro: ID ' + IntToStr(AFiltro.IdInicial) + ' a ' + IntToStr(AFiltro.IdFinal);
    tfrCidadeEstado:
      Result := 'Filtro: Cidade/Estado';
  else
    Result := 'Filtro: Todos';
  end;
end;

procedure TFrRelatorio.FormCreate(Sender: TObject);
begin
  FController := TClienteController.Create;

  dsCidades.DataSet := FController.QryCidades;
  dsEstados.DataSet := FController.QryEstados;
  dsRelatorio.DataSet := FController.QryRelatorio;

  lkpCidade.Properties.ListSource := dsCidades;
  lkpCidade.Properties.KeyFieldNames := 'ID';
  lkpCidade.Properties.ListFieldNames := 'NOMEUF';

  lkpEstado.Properties.ListSource := dsEstados;
  lkpEstado.Properties.KeyFieldNames := 'ID';
  lkpEstado.Properties.ListFieldNames := 'NOME';

  lkpEstado.Properties.OnEditValueChanged := lkpEstadoPropertiesEditValueChanged;
  lkpCidade.Properties.OnEditValueChanged := lkpCidadePropertiesEditValueChanged;

  rgFiltro.ItemIndex := 0;
  HabilitarFiltros;
end;

procedure TFrRelatorio.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TFrRelatorio.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
    Exit;
  Key := #0;
  Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TFrRelatorio.rgFiltroClick(Sender: TObject);
begin
  LimparCamposFiltro;
  HabilitarFiltros;
end;

procedure TFrRelatorio.lkpEstadoPropertiesEditValueChanged(Sender: TObject);
begin
  if FAtualizandoLookup then
    Exit;

  FAtualizandoLookup := True;
  try
    lkpCidade.Clear;
    FiltrarCidadesPorEstado(ValorLookup(lkpEstado));
  finally
    FAtualizandoLookup := False;
  end;
end;

procedure TFrRelatorio.lkpCidadePropertiesEditValueChanged(Sender: TObject);
var
  CidadeId: Integer;
  EstadoId: Integer;
begin
  if FAtualizandoLookup then
    Exit;

  CidadeId := ValorLookup(lkpCidade);
  if CidadeId <= 0 then
    Exit;

  EstadoId := EstadoIdDaCidade(CidadeId);
  if EstadoId <= 0 then
    Exit;

  FAtualizandoLookup := True;
  try
    lkpEstado.EditValue := EstadoId;
    FiltrarCidadesPorEstado(EstadoId);
    lkpCidade.EditValue := CidadeId;
  finally
    FAtualizandoLookup := False;
  end;
end;

procedure TFrRelatorio.btnGerarClick(Sender: TObject);
var
  Filtro: TFiltroRelatorio;
  Mensagem: String;
begin
  if not MontarFiltro(Filtro, Mensagem) then
  begin
    ShowMessage(Mensagem);
    Exit;
  end;

  FController.MontarRelatorio(Filtro);
  if FController.QryRelatorio.IsEmpty then
  begin
    ShowMessage('Nenhum cliente encontrado para o filtro informado.');
    Exit;
  end;

  lblFiltroAplicado.Caption := TextoFiltro(Filtro);
  rptCliente.Reset;
  rptCliente.Print;
end;

procedure TFrRelatorio.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
