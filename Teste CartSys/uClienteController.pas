unit uClienteController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uCliente, uClienteDAO, uViaCEP;

type
  TResultadoCEP = record
    Sucesso: Boolean;
    Mensagem: string;
    Endereco: string;
    Bairro: string;
    CidadeId: Integer;
  end;

  TClienteController = class
  private
    FDAO: TClienteDAO;
    function GetQryPesquisa: TFDQuery;
    function GetQryCidades: TFDQuery;
    function GetQryEstados: TFDQuery;
    function GetQryRelatorio: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    function Salvar(ACliente: TCliente; out AMensagem: string): Boolean;
    function Excluir(AId: Integer; out AMensagem: string): Boolean;
    function BuscarPorId(AId: Integer): TCliente;
    procedure Pesquisar(const AFiltro: TFiltroCliente);
    procedure CarregarLookups;
    function ConsultarCEP(const ACep: string; out AResultado: TResultadoCEP): Boolean;
    procedure MontarRelatorio(const AFiltro: TFiltroRelatorio);
    property QryPesquisa: TFDQuery read GetQryPesquisa;
    property QryCidades: TFDQuery read GetQryCidades;
    property QryEstados: TFDQuery read GetQryEstados;
    property QryRelatorio: TFDQuery read GetQryRelatorio;
  end;

implementation

constructor TClienteController.Create;
begin
  inherited Create;
  FDAO := TClienteDAO.Create;
  FDAO.CarregarCidades;
  FDAO.CarregarEstados;
end;

destructor TClienteController.Destroy;
begin
  FDAO.Free;
  inherited Destroy;
end;

function TClienteController.Salvar(ACliente: TCliente; out AMensagem: String): Boolean;
begin
  Result := False;
  if not ACliente.Validar(AMensagem) then
    Exit;
  try
    if ACliente.ID = 0 then
      Result := FDAO.Inserir(ACliente)
    else
      Result := FDAO.Alterar(ACliente);
    if Result then
      AMensagem := 'Cliente gravado com sucesso.';
  except
    on E: Exception do
    begin
      AMensagem := E.Message;
      Result := False;
    end;
  end;
end;

function TClienteController.Excluir(AId: Integer; out AMensagem: string): Boolean;
begin
  Result := False;
  if AId <= 0 then
  begin
    AMensagem := 'Selecione um cliente para excluir.';
    Exit;
  end;
  if not TCliente.PodeExcluir(AId) then
  begin
    AMensagem := 'Este cliente não pode ser excluído.';
    Exit;
  end;
  try
    Result := FDAO.Excluir(AId);
    if Result then
      AMensagem := 'Cliente excluído com sucesso.';
  except
    on E: Exception do
    begin
      AMensagem := E.Message;
      Result := False;
    end;
  end;
end;

function TClienteController.BuscarPorId(AId: Integer): TCliente;
begin
  Result := FDAO.BuscarPorId(AId);
end;

procedure TClienteController.Pesquisar(const AFiltro: TFiltroCliente);
begin
  FDAO.Pesquisar(AFiltro);
end;

procedure TClienteController.CarregarLookups;
begin
  FDAO.CarregarCidades;
  FDAO.CarregarEstados;
end;

function TClienteController.ConsultarCEP(const ACep: string;
  out AResultado: TResultadoCEP): Boolean;
var
  Endereco: TEnderecoCEP;
  CepLimpo: string;
begin
  Result := False;
  AResultado.Sucesso := False;
  AResultado.Mensagem := '';
  AResultado.Endereco := '';
  AResultado.Bairro := '';
  AResultado.CidadeId := 0;
  CepLimpo := TCliente.SomenteNumeros(ACep);
  if Length(CepLimpo) <> 8 then
  begin
    AResultado.Mensagem := 'CEP inválido.';
    Exit;
  end;
  try
    Endereco := TViaCEP.Consultar(CepLimpo);
  except
    on E: Exception do
    begin
      AResultado.Mensagem := 'Não foi possível consultar o CEP. ' + E.Message;
      Exit;
    end;
  end;
  if not Endereco.Encontrado then
  begin
    AResultado.Mensagem := 'CEP não encontrado.';
    Exit;
  end;
  AResultado.Sucesso := True;
  AResultado.Endereco := Endereco.Logradouro;
  AResultado.Bairro := Endereco.Bairro;
  AResultado.CidadeId := FDAO.BuscarCidadePorNomeUF(Endereco.Localidade, Endereco.UF);
  Result := True;
  if AResultado.CidadeId = 0 then
    AResultado.Mensagem :=
      'CEP válido, mas a cidade não está cadastrada no sistema.';
end;

procedure TClienteController.MontarRelatorio(const AFiltro: TFiltroRelatorio);
begin
  FDAO.MontarRelatorio(AFiltro);
end;

function TClienteController.GetQryPesquisa: TFDQuery;
begin
  Result := FDAO.QryPesquisa;
end;
function TClienteController.GetQryCidades: TFDQuery;
begin
  Result := FDAO.QryCidades;
end;
function TClienteController.GetQryEstados: TFDQuery;
begin
  Result := FDAO.QryEstados;
end;
function TClienteController.GetQryRelatorio: TFDQuery;
begin
  Result := FDAO.QryRelatorio;
end;

end.
