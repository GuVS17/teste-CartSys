unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TFrPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    Sistema1: TMenuItem;
    Cadastros1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Cliente1: TMenuItem;
    Relatrios2: TMenuItem;
    pnlFundo: TPanel;
    stbRodape: TStatusBar;
    procedure Cliente1Click(Sender: TObject);
    procedure Relatrios2Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AtualizarStatus;
  public
    { Public declarations }
  end;

var
  FrPrincipal: TFrPrincipal;

implementation

{$R *.dfm}

uses Relatorio, CadastroClientes, uDMConexao;

procedure TFrPrincipal.AtualizarStatus;
var
  CaminhoBanco: string;
begin
  stbRodape.Panels[0].Text := FormatDateTime('dddddd', Date);
  CaminhoBanco := '';
  if Assigned(DMConexao) and Assigned(DMConexao.FDConnection) then
    CaminhoBanco := DMConexao.FDConnection.Params.Database;
  if CaminhoBanco = '' then
    stbRodape.Panels[1].Text := 'Banco: n'#227'o conectado'
  else
    stbRodape.Panels[1].Text := 'Banco: ' + CaminhoBanco;
end;

procedure TFrPrincipal.FormCreate(Sender: TObject);
begin
  AtualizarStatus;
end;

procedure TFrPrincipal.Cliente1Click(Sender: TObject);
begin
  FrCadCliente := TFrCadCliente.Create(nil);
  try
    FrCadCliente.ShowModal;
  finally
    FrCadCliente.Release;
  end;
end;

procedure TFrPrincipal.Relatrios2Click(Sender: TObject);
begin
  FrRelatorio := TFrRelatorio.Create(nil);
  try
    FrRelatorio.ShowModal;
  finally
    FrRelatorio.Release;
  end;
end;

procedure TFrPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
