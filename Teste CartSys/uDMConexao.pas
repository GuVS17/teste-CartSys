unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.UI, Vcl.Dialogs, FireDAC.DApt;

type
  TDMConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    function CaminhoBanco: String;
    procedure ConfigurarConexao;
    { Private declarations }
  public
    procedure Conectar;
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDMConexao.CaminhoBanco: String;
var
  Pasta, PastaPai, Arquivo: String;
begin
  Pasta := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  Result := '';

  While True do
  begin
    Arquivo := Pasta + 'Dados\DADOS.FDB';
    if FileExists(Arquivo) then
    begin
      Result := Arquivo;
      Exit;
    end;

    PastaPai := IncludeTrailingPathDelimiter(ExpandFileName(Pasta + '..\'));
    if PastaPai = Pasta then
      Break;
    Pasta := PastaPai;
  end;

  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Dados\DADOS.FDB';
end;

procedure TDMConexao.Conectar;
var
  ArquivoBanco: String;
begin
  ArquivoBanco := CaminhoBanco;
  if not FileExists(ArquivoBanco) then
  begin
    ShowMessage('Banco de dados não encontrado:' + sLineBreak + ArquivoBanco);
    Exit;
  end;

  ConfigurarConexao;
  FDConnection.Connected := True;
end;

procedure TDMConexao.ConfigurarConexao;
begin
  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := 'FB';
  FDConnection.Params.Database := CaminhoBanco;
  FDConnection.Params.UserName := 'SYSDBA';
  FDConnection.Params.Password := 'masterkey';
  FDConnection.Params.Values['CharacterSet'] := 'UTF8';
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
 Conectar;
end;

end.
