program ProjetoTeste;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrPrincipal},
  CadastroClientes in 'CadastroClientes.pas' {FrCadCliente},
  Relatorio in 'Relatorio.pas' {FrRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrPrincipal, FrPrincipal);
  Application.Run;
end.
