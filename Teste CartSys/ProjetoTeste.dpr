program ProjetoTeste;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrPrincipal},
  CadastroClientes in 'CadastroClientes.pas' {FrCadCliente},
  Relatorio in 'Relatorio.pas' {FrRelatorio},
  uDMConexao in 'uDMConexao.pas' {DMConexao: TDataModule},
  uCliente in 'uCliente.pas',
  uClienteController in 'uClienteController.pas',
  uClienteDAO in 'uClienteDAO.pas',
  uViaCEP in 'uViaCEP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TFrPrincipal, FrPrincipal);
  Application.Run;
end.
