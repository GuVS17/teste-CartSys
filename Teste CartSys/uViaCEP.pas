unit uViaCEP;

interface

uses
  System.SysUtils, System.JSON, System.Net.HttpClient, uCliente;

type
  TEnderecoCEP = record
    Encontrado: Boolean;
    Logradouro: String;
    Bairro: String;
    Localidade: String;
    UF: String;
  end;
  TViaCEP = class
  public
    class function Consultar(const ACep: String): TEnderecoCEP;
  end;

implementation

class function TViaCEP.Consultar(const ACep: String): TEnderecoCEP;
var
  Http: THTTPClient;
  Resp: IHTTPResponse;
  Json: TJSONObject;
  CepLimpo: String;
  ValorErro: TJSONValue;
begin
  Result.Encontrado := False;
  Result.Logradouro := '';
  Result.Bairro := '';
  Result.Localidade := '';
  Result.UF := '';

  CepLimpo := TCliente.SomenteNumeros(ACep);
  if Length(CepLimpo) <> 8 then
    Exit;

  Http := THTTPClient.Create;
  Json := nil;
  try
    Http.ConnectionTimeout := 8000;
    Http.ResponseTimeout := 8000;
    Resp := Http.Get('https://viacep.com.br/ws/' + CepLimpo + '/json/');
    if Resp.StatusCode <> 200 then
      Exit;

    Json := TJSONObject.ParseJSONValue(Resp.ContentAsString) as TJSONObject;
    if Json = nil then
      Exit;

    ValorErro := Json.GetValue('erro');
    if ValorErro <> nil then
      Exit;

    Result.Logradouro := Json.GetValue('logradouro').Value;
    Result.Bairro := Json.GetValue('bairro').Value;
    Result.Localidade := Json.GetValue('localidade').Value;
    Result.UF := Json.GetValue('uf').Value;
    Result.Encontrado := True;
  finally
    Json.Free;
    Http.Free;
  end;
end;

end.
