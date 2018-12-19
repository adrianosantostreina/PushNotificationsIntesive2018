object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 558
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 64
    Height = 13
    Caption = 'Device Token'
  end
  object Label2: TLabel
    Left = 8
    Top = 149
    Width = 93
    Height = 13
    Caption = 'Mensagem a enviar'
  end
  object Label3: TLabel
    Left = 8
    Top = 270
    Width = 61
    Height = 13
    Caption = 'Log de envio'
  end
  object Label4: TLabel
    Left = 8
    Top = 380
    Width = 170
    Height = 13
    Caption = 'Dispositivos registrados no servidor'
  end
  object Button1: TButton
    Left = 633
    Top = 24
    Width = 232
    Height = 25
    Caption = 'Envio Local'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MemoMensagem: TMemo
    Left = 8
    Top = 168
    Width = 619
    Height = 91
    Lines.Strings = (
      'Oi, tudo bem?')
    TabOrder = 1
  end
  object MemoToken: TMemo
    Left = 8
    Top = 26
    Width = 619
    Height = 114
    Lines.Strings = (
      
        'APA91bEABUXQIdbg0euRSKdYMgGFZ_d5hYRJXa5OQVUtKjosXEbySjFC0_2MO91P' +
        '3HKtY2Ctusr5yX2E3EhlmL'
      'Kz-y-p7miaEJefy4-kjTnbw8RChTST2c58lO0UkDsyp6DJFYc1LVpu')
    TabOrder = 2
  end
  object MemoResposta: TMemo
    Left = 8
    Top = 289
    Width = 619
    Height = 80
    Lines.Strings = (
      'MemoResposta')
    TabOrder = 3
  end
  object Button2: TButton
    Left = 633
    Top = 430
    Width = 232
    Height = 25
    Caption = 'Enviar para todos'
    TabOrder = 4
    OnClick = Button2Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 399
    Width = 619
    Height = 122
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button3: TButton
    Left = 633
    Top = 399
    Width = 232
    Height = 25
    Caption = 'Enviar para selecionado'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 527
    Width = 217
    Height = 25
    Caption = 'Dispositivos'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 633
    Top = 55
    Width = 232
    Height = 25
    Caption = 'Registra Dispositivo no DataSnap'
    TabOrder = 8
    OnClick = Button5Click
  end
  object DataSource1: TDataSource
    DataSet = MemDevices
    Left = 56
    Top = 456
  end
  object MemDevices: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 408
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 56
    Top = 504
  end
end
