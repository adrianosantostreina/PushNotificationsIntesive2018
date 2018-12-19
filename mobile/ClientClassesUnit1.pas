// 
// Created by the DataSnap proxy generator.
// 14/12/2018 17:03:44
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TSmServicosClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FDispositivosCommand: TDSRestCommand;
    FDispositivosCommand_Cache: TDSRestCommand;
    FRegistrarDispositivoCommand: TDSRestCommand;
    FEnviarPushUnicoCommand: TDSRestCommand;
    FEnviarPushMultiploCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function Dispositivos(const ARequestFilter: string = ''): TFDJSONDataSets;
    function Dispositivos_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function RegistrarDispositivo(ADeviceToken: string; ADeviceID: string; ATipoDevice: string; ANome: string; const ARequestFilter: string = ''): Boolean;
    function EnviarPushUnico(AID_Usuario: Integer; AMensagem: string; const ARequestFilter: string = ''): Boolean;
    function EnviarPushMultiplo(AMensagem: string; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TSmServicos_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSmServicos_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSmServicos_Dispositivos: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSmServicos_Dispositivos_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSmServicos_RegistrarDispositivo: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'ADeviceToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ADeviceID'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ATipoDevice'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ANome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSmServicos_EnviarPushUnico: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'AID_Usuario'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'AMensagem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSmServicos_EnviarPushMultiplo: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AMensagem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TSmServicosClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TSmServicos.EchoString';
    FEchoStringCommand.Prepare(TSmServicos_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TSmServicosClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TSmServicos.ReverseString';
    FReverseStringCommand.Prepare(TSmServicos_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TSmServicosClient.Dispositivos(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FDispositivosCommand = nil then
  begin
    FDispositivosCommand := FConnection.CreateCommand;
    FDispositivosCommand.RequestType := 'GET';
    FDispositivosCommand.Text := 'TSmServicos.Dispositivos';
    FDispositivosCommand.Prepare(TSmServicos_Dispositivos);
  end;
  FDispositivosCommand.Execute(ARequestFilter);
  if not FDispositivosCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FDispositivosCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FDispositivosCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FDispositivosCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSmServicosClient.Dispositivos_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FDispositivosCommand_Cache = nil then
  begin
    FDispositivosCommand_Cache := FConnection.CreateCommand;
    FDispositivosCommand_Cache.RequestType := 'GET';
    FDispositivosCommand_Cache.Text := 'TSmServicos.Dispositivos';
    FDispositivosCommand_Cache.Prepare(TSmServicos_Dispositivos_Cache);
  end;
  FDispositivosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FDispositivosCommand_Cache.Parameters[0].Value.GetString);
end;

function TSmServicosClient.RegistrarDispositivo(ADeviceToken: string; ADeviceID: string; ATipoDevice: string; ANome: string; const ARequestFilter: string): Boolean;
begin
  if FRegistrarDispositivoCommand = nil then
  begin
    FRegistrarDispositivoCommand := FConnection.CreateCommand;
    FRegistrarDispositivoCommand.RequestType := 'GET';
    FRegistrarDispositivoCommand.Text := 'TSmServicos.RegistrarDispositivo';
    FRegistrarDispositivoCommand.Prepare(TSmServicos_RegistrarDispositivo);
  end;
  FRegistrarDispositivoCommand.Parameters[0].Value.SetWideString(ADeviceToken);
  FRegistrarDispositivoCommand.Parameters[1].Value.SetWideString(ADeviceID);
  FRegistrarDispositivoCommand.Parameters[2].Value.SetWideString(ATipoDevice);
  FRegistrarDispositivoCommand.Parameters[3].Value.SetWideString(ANome);
  FRegistrarDispositivoCommand.Execute(ARequestFilter);
  Result := FRegistrarDispositivoCommand.Parameters[4].Value.GetBoolean;
end;

function TSmServicosClient.EnviarPushUnico(AID_Usuario: Integer; AMensagem: string; const ARequestFilter: string): Boolean;
begin
  if FEnviarPushUnicoCommand = nil then
  begin
    FEnviarPushUnicoCommand := FConnection.CreateCommand;
    FEnviarPushUnicoCommand.RequestType := 'GET';
    FEnviarPushUnicoCommand.Text := 'TSmServicos.EnviarPushUnico';
    FEnviarPushUnicoCommand.Prepare(TSmServicos_EnviarPushUnico);
  end;
  FEnviarPushUnicoCommand.Parameters[0].Value.SetInt32(AID_Usuario);
  FEnviarPushUnicoCommand.Parameters[1].Value.SetWideString(AMensagem);
  FEnviarPushUnicoCommand.Execute(ARequestFilter);
  Result := FEnviarPushUnicoCommand.Parameters[2].Value.GetBoolean;
end;

function TSmServicosClient.EnviarPushMultiplo(AMensagem: string; const ARequestFilter: string): Boolean;
begin
  if FEnviarPushMultiploCommand = nil then
  begin
    FEnviarPushMultiploCommand := FConnection.CreateCommand;
    FEnviarPushMultiploCommand.RequestType := 'GET';
    FEnviarPushMultiploCommand.Text := 'TSmServicos.EnviarPushMultiplo';
    FEnviarPushMultiploCommand.Prepare(TSmServicos_EnviarPushMultiplo);
  end;
  FEnviarPushMultiploCommand.Parameters[0].Value.SetWideString(AMensagem);
  FEnviarPushMultiploCommand.Execute(ARequestFilter);
  Result := FEnviarPushMultiploCommand.Parameters[1].Value.GetBoolean;
end;

constructor TSmServicosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSmServicosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSmServicosClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FDispositivosCommand.DisposeOf;
  FDispositivosCommand_Cache.DisposeOf;
  FRegistrarDispositivoCommand.DisposeOf;
  FEnviarPushUnicoCommand.DisposeOf;
  FEnviarPushMultiploCommand.DisposeOf;
  inherited;
end;

end.
