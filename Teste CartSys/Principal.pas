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

procedure TFrPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
