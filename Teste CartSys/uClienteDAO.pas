unit uClienteDAO;

interface

uses
  FireDAC.Comp.Client, uCliente, uDMConexao, System.SysUtils, Data.DB;

type
  TClienteDAO = class
  private
    FQryPesquisa: TFDQuery;
    FQryCidades: TFDQuery;
    FQryEstados: TFDQuery;
    FQryRelatorio: TFDQuery;
    function NovaQuery: TFDQuery;
    function CpfCnpjJaExiste(const ACpfCnpj: String; AIdAtual: Integer): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente): Boolean;
    function Excluir(AId: Integer): Boolean;
    function BuscarPorId(AId: Integer): TCliente;
    procedure Pesquisar(const AFiltro: TFiltroCliente);
    procedure CarregarCidades;
    procedure CarregarEstados;
    procedure MontarRelatorio(const AFiltro: TFiltroRelatorio);
    property QryPesquisa: TFDQuery read FQryPesquisa;
    property QryCidades: TFDQuery read FQryCidades;
    property QryEstados: TFDQuery read FQryEstados;
    property QryRelatorio: TFDQuery read FQryRelatorio;
    function ProximoId: Integer;
    procedure DevolverId(AId: Integer);
    function NomeCidadePorId(AId: Integer): String;
    function BuscarCidade(const ANome, AUF: string): Integer;
  end;

implementation

constructor TClienteDAO.Create;
begin
  inherited Create;
  FQryPesquisa := NovaQuery;
  FQryCidades := NovaQuery;
  FQryEstados := NovaQuery;
  FQryRelatorio := NovaQuery;
end;

destructor TClienteDAO.Destroy;
begin
  FQryPesquisa.Free;
  FQryCidades.Free;
  FQryEstados.Free;
  FQryRelatorio.Free;
  inherited Destroy;
end;

function TClienteDAO.NovaQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DMConexao.FDConnection;
end;

function TClienteDAO.CpfCnpjJaExiste(const ACpfCnpj: string; AIdAtual: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := NovaQuery;
  try
    Qry.SQL.Text :=
      'SELECT COUNT(*) AS QTD FROM CLIENTE ' +
      'WHERE CPF_CNPJ = :CPF_CNPJ AND ID <> :ID';
    Qry.ParamByName('CPF_CNPJ').AsString := ACpfCnpj;
    Qry.ParamByName('ID').AsInteger := AIdAtual;
    Qry.Open;
    Result := Qry.FieldByName('QTD').AsInteger > 0;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.Inserir(ACliente: TCliente): Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;
  if CpfCnpjJaExiste(ACliente.CpfCnpj, 0) then
    raise Exception.Create('Já existe um cliente com este CPF/CNPJ.');
  if ACliente.ID <= 0 then
    ACliente.ID := ProximoId;
  Qry := NovaQuery;
  try
    Qry.SQL.Text :=
      'INSERT INTO CLIENTE (ID, NOME, CEP, CPF_CNPJ, ENDERECO, NUMERO, ' +
      'COMPLEMENTO, BAIRRO, CIDADE, DATANASCIMENTO) VALUES (' +
      ':ID, :NOME, :CEP, :CPF_CNPJ, :ENDERECO, :NUMERO, ' +
      ':COMPLEMENTO, :BAIRRO, :CIDADE, :DATANASCIMENTO)';
    Qry.ParamByName('ID').AsInteger := ACliente.ID;
    Qry.ParamByName('NOME').AsString := ACliente.Nome;
    Qry.ParamByName('CEP').AsString := ACliente.Cep;
    Qry.ParamByName('CPF_CNPJ').AsString := ACliente.CpfCnpj;
    Qry.ParamByName('ENDERECO').AsString := ACliente.Endereco;
    Qry.ParamByName('NUMERO').AsString := ACliente.Numero;
    Qry.ParamByName('COMPLEMENTO').AsString := ACliente.Complemento;
    Qry.ParamByName('BAIRRO').AsString := ACliente.Bairro;
    Qry.ParamByName('CIDADE').AsInteger := ACliente.CidadeId;
    if ACliente.DataNascimento > 0 then
      Qry.ParamByName('DATANASCIMENTO').AsDate := ACliente.DataNascimento
    else
      Qry.ParamByName('DATANASCIMENTO').Clear;
    Qry.ExecSQL;
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.Alterar(ACliente: TCliente): Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;
  if CpfCnpjJaExiste(ACliente.CpfCnpj, ACliente.ID) then
    raise Exception.Create('J'#225' existe um cliente com este CPF/CNPJ.');
  Qry := NovaQuery;
  try
    Qry.SQL.Text :=
      'UPDATE CLIENTE SET NOME = :NOME, CEP = :CEP, CPF_CNPJ = :CPF_CNPJ, ' +
      'ENDERECO = :ENDERECO, NUMERO = :NUMERO, COMPLEMENTO = :COMPLEMENTO, ' +
      'BAIRRO = :BAIRRO, CIDADE = :CIDADE, DATANASCIMENTO = :DATANASCIMENTO ' +
      'WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := ACliente.ID;
    Qry.ParamByName('NOME').AsString := ACliente.Nome;
    Qry.ParamByName('CEP').AsString := ACliente.Cep;
    Qry.ParamByName('CPF_CNPJ').AsString := ACliente.CpfCnpj;
    Qry.ParamByName('ENDERECO').AsString := ACliente.Endereco;
    Qry.ParamByName('NUMERO').AsString := ACliente.Numero;
    Qry.ParamByName('COMPLEMENTO').AsString := ACliente.Complemento;
    Qry.ParamByName('BAIRRO').AsString := ACliente.Bairro;
    Qry.ParamByName('CIDADE').AsInteger := ACliente.CidadeId;
    if ACliente.DataNascimento > 0 then
      Qry.ParamByName('DATANASCIMENTO').AsDate := ACliente.DataNascimento
    else
      Qry.ParamByName('DATANASCIMENTO').Clear;
    Qry.ExecSQL;
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.Excluir(AId: Integer): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := NovaQuery;
  try
    Qry.SQL.Text := 'DELETE FROM CLIENTE WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.ExecSQL;
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.BuscarPorId(AId: Integer): TCliente;
var
  Qry: TFDQuery;
begin
  Result := nil;
  Qry := NovaQuery;
  try
    Qry.SQL.Text :=
      'SELECT ID, NOME, CEP, CPF_CNPJ, ENDERECO, NUMERO, COMPLEMENTO, ' +
      'BAIRRO, CIDADE, DATANASCIMENTO FROM CLIENTE WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.Open;
    if Qry.IsEmpty then
      Exit;

    Result := TCliente.Create;
    Result.ID := Qry.FieldByName('ID').AsInteger;
    Result.Nome := Qry.FieldByName('NOME').AsString;
    Result.Cep := Qry.FieldByName('CEP').AsString;
    Result.CpfCnpj := Qry.FieldByName('CPF_CNPJ').AsString;
    Result.Endereco := Qry.FieldByName('ENDERECO').AsString;
    Result.Numero := Qry.FieldByName('NUMERO').AsString;
    Result.Complemento := Qry.FieldByName('COMPLEMENTO').AsString;
    Result.Bairro := Qry.FieldByName('BAIRRO').AsString;
    Result.CidadeId := Qry.FieldByName('CIDADE').AsInteger;
    if Qry.FieldByName('DATANASCIMENTO').IsNull then
      Result.DataNascimento := 0
    else
      Result.DataNascimento := Qry.FieldByName('DATANASCIMENTO').AsDateTime;
  finally
    Qry.Free;
  end;
end;

procedure TClienteDAO.Pesquisar(const AFiltro: TFiltroCliente);
var
  SQL: String;
begin
  SQL :=
    'SELECT CL.ID, CL.NOME, CL.CEP, CL.CPF_CNPJ, CL.ENDERECO, CL.NUMERO, ' +
    'CL.COMPLEMENTO, CL.BAIRRO, CL.CIDADE AS CIDADEID, CI.NOME AS CIDADE, ' +
    'ES.ID AS ESTADOID, ES.NOME AS ESTADO, ES.UF, CL.DATANASCIMENTO ' +
    'FROM CLIENTE CL ' +
    'LEFT JOIN CIDADE CI ON CI.ID = CL.CIDADE ' +
    'LEFT JOIN ESTADO ES ON ES.ID = CI.ESTADOID ' +
    'WHERE 1 = 1';

  if AFiltro.Id > 0 then
    SQL := SQL + ' AND CL.ID = :ID';
  if Trim(AFiltro.Nome) <> '' then
    SQL := SQL + ' AND UPPER(CL.NOME) LIKE :NOME';
  if Trim(AFiltro.CpfCnpj) <> '' then
    SQL := SQL + ' AND CL.CPF_CNPJ LIKE :CPF_CNPJ';
  if Trim(AFiltro.Cep) <> '' then
    SQL := SQL + ' AND CL.CEP LIKE :CEP';
  if Trim(AFiltro.CidadeNome) <> '' then
    SQL := SQL + ' AND UPPER(CI.NOME) LIKE :CIDADENOME';
  if AFiltro.EstadoId > 0 then
    SQL := SQL + ' AND ES.ID = :ESTADOID';
  if AFiltro.DataNascimento > 0 then
    SQL := SQL + ' AND CL.DATANASCIMENTO = :DATANASCIMENTO';
  SQL := SQL + ' ORDER BY CL.ID';

  FQryPesquisa.Close;
  FQryPesquisa.SQL.Text := SQL;
  if AFiltro.Id > 0 then
    FQryPesquisa.ParamByName('ID').AsInteger := AFiltro.Id;
  if Trim(AFiltro.Nome) <> '' then
    FQryPesquisa.ParamByName('NOME').AsString := '%' + UpperCase(Trim(AFiltro.Nome)) + '%';
  if Trim(AFiltro.CpfCnpj) <> '' then
    FQryPesquisa.ParamByName('CPF_CNPJ').AsString :=
      '%' + TCliente.SomenteNumeros(AFiltro.CpfCnpj) + '%';
  if Trim(AFiltro.Cep) <> '' then
    FQryPesquisa.ParamByName('CEP').AsString :=
      '%' + TCliente.SomenteNumeros(AFiltro.Cep) + '%';
  if Trim(AFiltro.CidadeNome) <> '' then
    FQryPesquisa.ParamByName('CIDADENOME').AsString :=
      '%' + UpperCase(Trim(AFiltro.CidadeNome)) + '%';
  if AFiltro.EstadoId > 0 then
    FQryPesquisa.ParamByName('ESTADOID').AsInteger := AFiltro.EstadoId;
  if AFiltro.DataNascimento > 0 then
    FQryPesquisa.ParamByName('DATANASCIMENTO').AsDate := AFiltro.DataNascimento;
  FQryPesquisa.Open;
end;

procedure TClienteDAO.CarregarCidades;
begin
  FQryCidades.Close;
  FQryCidades.SQL.Text :=
    'SELECT CI.ID, CI.NOME || '' / '' || ES.UF AS NOMEUF, CI.NOME, ' +
    'ES.ID AS ESTADOID, ES.UF, ES.NOME AS ESTADO ' +
    'FROM CIDADE CI ' +
    'JOIN ESTADO ES ON ES.ID = CI.ESTADOID ' +
    'ORDER BY CI.NOME, ES.UF';
  FQryCidades.Open;
end;

procedure TClienteDAO.CarregarEstados;
begin
  FQryEstados.Close;
  FQryEstados.SQL.Text :=
    'SELECT ID, NOME, UF FROM ESTADO ORDER BY NOME';
  FQryEstados.Open;
end;

procedure TClienteDAO.MontarRelatorio(const AFiltro: TFiltroRelatorio);
var
  SQL: String;
begin
  SQL :=
    'SELECT CL.ID, CL.NOME, CL.CPF_CNPJ, CL.CEP, CL.BAIRRO, ' +
    'CI.NOME AS CIDADE, ES.NOME AS ESTADO, ES.UF ' +
    'FROM CLIENTE CL ' +
    'LEFT JOIN CIDADE CI ON CI.ID = CL.CIDADE ' +
    'LEFT JOIN ESTADO ES ON ES.ID = CI.ESTADOID ' +
    'WHERE 1 = 1';
  case AFiltro.Tipo of
    tfrFaixaId:
      SQL := SQL + ' AND CL.ID BETWEEN :IDINI AND :IDFIM';
    tfrCidadeEstado:
    begin
      if AFiltro.CidadeId > 0 then
        SQL := SQL + ' AND CL.CIDADE = :CIDADEID';
      if AFiltro.EstadoId > 0 then
        SQL := SQL + ' AND ES.ID = :ESTADOID';
    end;
  end;
  SQL := SQL + ' ORDER BY CL.ID';
  FQryRelatorio.Close;
  FQryRelatorio.SQL.Text := SQL;
  if AFiltro.Tipo = tfrFaixaId then
  begin
    FQryRelatorio.ParamByName('IDINI').AsInteger := AFiltro.IdInicial;
    FQryRelatorio.ParamByName('IDFIM').AsInteger := AFiltro.IdFinal;
  end;
  if AFiltro.Tipo = tfrCidadeEstado then
  begin
    if AFiltro.CidadeId > 0 then
      FQryRelatorio.ParamByName('CIDADEID').AsInteger := AFiltro.CidadeId;
    if AFiltro.EstadoId > 0 then
      FQryRelatorio.ParamByName('ESTADOID').AsInteger := AFiltro.EstadoId;
  end;
  FQryRelatorio.Open;
end;

function TClienteDAO.NomeCidadePorId(AId: Integer): string;
var
  Qry: TFDQuery;
begin
  Result := '';
  if AId <= 0 then
    Exit;

  Qry := NovaQuery;
  try
    Qry.SQL.Text := 'SELECT NOME FROM CIDADE WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('NOME').AsString;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.ProximoId: Integer;
var
  Qry: TFDQuery;
begin
  Qry := NovaQuery;
  try
    Qry.Open('SELECT GEN_ID(SEQ_CLIENTE, 1) AS ID FROM RDB$DATABASE');
    Result := Qry.FieldByName('ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TClienteDAO.DevolverId(AId: Integer);
var
  Qry: TFDQuery;
  Atual: Integer;
begin
  if AId <= 0 then
    Exit;

  Qry := NovaQuery;
  try
    Qry.Open('SELECT GEN_ID(SEQ_CLIENTE, 0) AS ID FROM RDB$DATABASE');
    Atual := Qry.FieldByName('ID').AsInteger;
    Qry.Close;

    if Atual <> AId then
      Exit;

    Qry.SQL.Text := 'SELECT GEN_ID(SEQ_CLIENTE, -1) AS ID FROM RDB$DATABASE';
    Qry.Open;
  finally
    Qry.Free;
  end;
end;

function TClienteDAO.BuscarCidade(const ANome, AUF: string): Integer;
var
  Qry: TFDQuery;
  SQL: string;
begin
  Result := 0;
  if Trim(ANome) = '' then
    Exit;

  Qry := NovaQuery;
  try
    SQL :=
      'SELECT CI.ID FROM CIDADE CI ' +
      'JOIN ESTADO ES ON ES.ID = CI.ESTADOID ' +
      'WHERE UPPER(CI.NOME) = UPPER(:NOME)';
    if Trim(AUF) <> '' then
      SQL := SQL + ' AND ES.UF = :UF';

    Qry.SQL.Text := SQL;
    Qry.ParamByName('NOME').AsString := Trim(ANome);
    if Trim(AUF) <> '' then
      Qry.ParamByName('UF').AsString := UpperCase(Trim(AUF));
    Qry.Open;
    if not Qry.IsEmpty then
      Result := Qry.FieldByName('ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

end.
