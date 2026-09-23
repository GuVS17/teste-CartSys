object FrPrincipal: TFrPrincipal
  Left = 0
  Top = 0
  Caption = 'CartSys - Controle de Clientes'
  ClientHeight = 441
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 422
    Align = alClient
    BevelOuter = bvNone
    Color = 15724527
    ParentBackground = False
    TabOrder = 0
  end
  object stbRodape: TStatusBar
    Left = 0
    Top = 422
    Width = 784
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object MenuPrincipal: TMainMenu
    Left = 24
    Top = 16
    object Sistema1: TMenuItem
      Caption = 'Sistema'
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Relatrios2: TMenuItem
        Caption = 'Relat'#243'rio'
        OnClick = Relatrios2Click
      end
    end
  end
end
