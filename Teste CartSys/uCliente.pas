unit uCliente;

interface

uses
  System.SysUtils, System.DateUtils;

type
  TFiltroCliente = record
    Id: Integer;
    Nome: String;
    CpfCnpj: String;
    Cep: String;
    CidadeId: Integer;
    CidadeNome: String;
    EstadoId: Integer;
    DataNascimento: TDate;
  end;

  TTipoFiltroRelatorio = (tfrTodos, tfrFaixaId, tfrCidadeEstado);

  TFiltroRelatorio = record
    Tipo: TTipoFiltroRelatorio;
    IdInicial: Integer;
    IdFinal: Integer;
    CidadeId: Integer;
    EstadoId: Integer;
  end;

  TCliente = class
  private
    FID: Integer;
    FNome: String;
    FCep: String;
    FCpfCnpj: String;
    FEndereco: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;
    FCidadeId: Integer;
    FDataNascimento: TDate;
  public
    constructor Create;
    procedure Limpar;
    function Validar(out AMensagem: String): Boolean;
    class function PodeExcluir(AId: Integer): Boolean;
    class function SomenteNumeros(const AValor: String): String;
    property ID: Integer Read FID Write FID;
    property Nome: String Read FNome Write FNome;
    property Cep: String Read FCep Write FCep;
    property CpfCnpj: String Read FCpfCnpj Write FCpfCnpj;
    property Endereco: String Read FEndereco Write FEndereco;
    property Numero: String Read FNumero Write FNumero;
    property Complemento: String Read FComplemento Write FComplemento;
    property Bairro: String Read FBairro Write FBairro;
    property CidadeId: Integer Read FCidadeId Write FCidadeId;
    property DataNascimento: TDate Read FDataNascimento Write FDataNascimento;
  end;

implementation

function CpfValido(const ACpf: String): Boolean;
var
  Numeros: String;
  I, Soma, Digito1, Digito2: Integer;
begin
  Result := False;
  Numeros := TCliente.SomenteNumeros(ACpf);
  if Length(Numeros) <> 11 then
    Exit;
  if Numeros = StringOfChar(Numeros[1], 11) then
    Exit;
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(Numeros[I]) * (11 - I);
  Digito1 := (Soma * 10) mod 11;
  if Digito1 >= 10 then
    Digito1 := 0;
  if Digito1 <> StrToInt(Numeros[10]) then
    Exit;
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(Numeros[I]) * (12 - I);
  Digito2 := (Soma * 10) mod 11;
  if Digito2 >= 10 then
    Digito2 := 0;
  Result := Digito2 = StrToInt(Numeros[11]);
end;

function CnpjValido(const ACnpj: String): Boolean;
var
  Numeros: String;
  I, Soma, Digito1, Digito2: Integer;
  Peso1: array[1..12] of Integer;
  Peso2: array[1..13] of Integer;
begin
  Result := False;
  Numeros := TCliente.SomenteNumeros(ACnpj);
  if Length(Numeros) <> 14 then
    Exit;
  if Numeros = StringOfChar(Numeros[1], 14) then
    Exit;
  Peso1[1] := 5;  Peso1[2] := 4;  Peso1[3] := 3;  Peso1[4] := 2;
  Peso1[5] := 9;  Peso1[6] := 8;  Peso1[7] := 7;  Peso1[8] := 6;
  Peso1[9] := 5;  Peso1[10] := 4; Peso1[11] := 3; Peso1[12] := 2;
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(Numeros[I]) * Peso1[I];
  Digito1 := Soma mod 11;
  if Digito1 < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Digito1;
  if Digito1 <> StrToInt(Numeros[13]) then
    Exit;
  Peso2[1] := 6;  Peso2[2] := 5;  Peso2[3] := 4;  Peso2[4] := 3;
  Peso2[5] := 2;  Peso2[6] := 9;  Peso2[7] := 8;  Peso2[8] := 7;
  Peso2[9] := 6;  Peso2[10] := 5; Peso2[11] := 4; Peso2[12] := 3;
  Peso2[13] := 2;
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(Numeros[I]) * Peso2[I];
  Digito2 := Soma mod 11;
  if Digito2 < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Digito2;
  Result := Digito2 = StrToInt(Numeros[14]);
end;

class function TCliente.SomenteNumeros(const AValor: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AValor) do
    if CharInSet(AValor[I], ['0'..'9']) then
      Result := Result + AValor[I];
end;

class function TCliente.PodeExcluir(AId: Integer): Boolean;
begin
  Result := not ((AId = 1) or (AId = 5) or (AId = 8) or (AId = 10) or (AId = 15));
end;

constructor TCliente.Create;
begin
  inherited Create;
  Limpar;
end;

procedure TCliente.Limpar;
begin
  FID := 0;
  FNome := '';
  FCep := '';
  FCpfCnpj := '';
  FEndereco := '';
  FNumero := '';
  FComplemento := '';
  FBairro := '';
  FCidadeId := 0;
  FDataNascimento := 0;
end;

function TCliente.Validar(out AMensagem: String): Boolean;
var
  Doc: String;
  CepLimpo: String;
begin
  Result := False;
  AMensagem := '';
  if Trim(FNome) = '' then
  begin
    AMensagem := 'Informe o nome do cliente.';
    Exit;
  end;
  CepLimpo := SomenteNumeros(FCep);
  if Length(CepLimpo) <> 8 then
  begin
    AMensagem := 'Informe um CEP válido com 8 dígitos.';
    Exit;
  end;
  Doc := SomenteNumeros(FCpfCnpj);
  if Length(Doc) = 11 then
  begin
    if not CpfValido(Doc) then
    begin
      AMensagem := 'CPF inválido.';
      Exit;
    end;
  end
  else if Length(Doc) = 14 then
  begin
    if not CnpjValido(Doc) then
    begin
      AMensagem := 'CNPJ inválido.';
      Exit;
    end;
  end
  else
  begin
    AMensagem := 'Informe um CPF (11 dígitos) ou CNPJ (14 dígitos).';
    Exit;
  end;
  if FCidadeId <= 0 then
  begin
    AMensagem := 'Selecione a cidade.';
    Exit;
  end;
  if (FDataNascimento > 0) and (FDataNascimento > Date) then
  begin
    AMensagem := 'A data de nascimento não pode ser futura.';
    Exit;
  end;
  FCep := CepLimpo;
  FCpfCnpj := Doc;
  FNome := Trim(FNome);
  Result := True;
end;

end.
