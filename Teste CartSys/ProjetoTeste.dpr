program ProjetoTeste;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrPrincipal, FrPrincipal);
  Application.Run;
end.
