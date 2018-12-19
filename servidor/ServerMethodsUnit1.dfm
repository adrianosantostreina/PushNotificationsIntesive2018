object SmServicos: TSmServicos
  OldCreateOrder = False
  Height = 354
  Width = 370
  object fdConn: TFDConnection
    Params.Strings = (
      'Database=tdevrocks'
      'User_Name=root'
      'Password=s32]4]381a'
      'Server=192.168.1.90'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object qryDispositivos: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM TDEVROCKS.DISPOSITIVOS')
    Left = 64
    Top = 96
    object qryDispositivosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryDispositivostipo_device: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'tipo_device'
      Origin = 'tipo_device'
      Size = 45
    end
    object qryDispositivosdevice_id: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'device_id'
      Origin = 'device_id'
      Size = 500
    end
    object qryDispositivosdevice_token: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'device_token'
      Origin = 'device_token'
      Size = 500
    end
    object qryDispositivosnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 45
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'D:\Eventos\Intensive Delphi 2018\PushNotifications\Exemplo 1\Dat' +
      'aSnap\Win32\Debug\libmysql.dll'
    Left = 208
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 208
    Top = 96
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 208
    Top = 160
  end
  object qryAuxiliar: TFDQuery
    Connection = fdConn
    Left = 208
    Top = 224
  end
end
