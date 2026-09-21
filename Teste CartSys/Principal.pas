unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    Sistema1: TMenuItem;
    Cadastros1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Cliente1: TMenuItem;
    Relatrios2: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
    procedure Relatrios2Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrPrincipal: TFrPrincipal;

implementation

{$R *.dfm}

uses Relatorio, CadastroClientes;

procedure TFrPrincipal.Cliente1Click(Sender: TObject);
begin
  FrCadCliente := TFrCadCliente.Create(nil);
  FrCadCliente.ShowModal;
  FrCadCliente.Release;
end;

procedure TFrPrincipal.Relatrios2Click(Sender: TObject);
begin
  FrRelatorio := TFrRelatorio.Create(nil);
  FrRelatorio.ShowModal;
  FrRelatorio.Release;
end;

procedure TFrPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
