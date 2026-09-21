object DMConexao: TDMConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 116
  Width = 321
  object FDConnection: TFDConnection
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 128
    Top = 16
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 232
    Top = 16
  end
end
