unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,

  System.Net.HttpClient,
  Data.FireDACJSONReflect, FireDAC.Stan.StorageBin;

const
  CodigoProjeto = '';
  API           = '';
  Link          = 'https://android.googleapis.com/gcm/send';

type
{$METHODINFO ON}
  TSmServicos = class(TDataModule)
    fdConn: TFDConnection;
    qryDispositivos: TFDQuery;
    qryDispositivosid: TFDAutoIncField;
    qryDispositivostipo_device: TStringField;
    qryDispositivosdevice_id: TStringField;
    qryDispositivosdevice_token: TStringField;
    qryDispositivosnome: TStringField;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    qryAuxiliar: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function Dispositivos: TFDJSONDataSets;
    function RegistrarDispositivo(ADeviceToken, ADeviceID, ATipoDevice, ANome: string): Boolean;
    function EnviarPushUnico(AID_Usuario: Integer; AMensagem: String): boolean;
    function EnviarPushMultiplo(AMensagem: String): boolean;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TSmServicos.Dispositivos: TFDJSONDataSets;
begin
  qryDispositivos.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, qryDispositivos);
end;

function TSmServicos.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSmServicos.EnviarPushMultiplo(AMensagem: String): boolean;
const
  SQL = 'SELECT * FROM TDEVROCKS.DISPOSITIVOS';
var
  Client        : THTTPClient;
  v_Json        : TJSONObject;
  v_JsonData    : TJSONObject;
  v_RegisterIDs : TJSONArray;
  v_Data        : TStringStream;
  v_response    : TStringStream;

  token : string;

  RegisterIDs : TJSONArray;
begin
  qryAuxiliar.Active := False;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Text := SQL;
  qryAuxiliar.Active := True;

  if qryAuxiliar.IsEmpty then
  begin
    Result := False;
    exit;
  end;


  qryAuxiliar.First;
  while not qryAuxiliar.Eof do
  begin
    token := qryAuxiliar.FieldByName('DEVICE_TOKEN').AsString;
    try
    //  EnviarAndroidPush('mensagem', Memo1.Lines.Text, Edit1.Text);
      try
        RegisterIDs :=  TJSONArray.Create;
        RegisterIDs.Add(token);

        v_JsonData := TJSONObject.Create;
        v_JsonData.AddPair('id', CodigoProjeto);
        v_JsonData.AddPair('message', AMensagem);
        v_JsonData.AddPair('campo_extra', '11111');

        v_Json := TJSONObject.Create;
        v_Json.AddPair('registration_ids', RegisterIDs);
        v_Json.AddPair('data', v_JsonData);

        Client := THTTPClient.Create;
        Client.ContentType := 'application/json';
        Client.CustomHeaders['Authorization'] := 'key=' + API;

        v_Data := TStringStream.Create(v_Json.ToString);
        v_Data.Position := 0;

        v_response := TStringStream.Create;

        Client.Post(Link, v_Data, v_response);
        v_response.Position := 0;

        Result := True;
      finally

      end;
   except
      Result := False;

    end;
    qryAuxiliar.Next;
  end;

end;

function TSmServicos.EnviarPushUnico(AID_Usuario: Integer; AMensagem: String): boolean;
const
  SQL = 'SELECT * FROM TDEVROCKS.DISPOSITIVOS WHERE ID =:ID';
var
  Client        : THTTPClient;
  v_Json        : TJSONObject;
  v_JsonData    : TJSONObject;
  v_RegisterIDs : TJSONArray;
  v_Data        : TStringStream;
  v_response    : TStringStream;

  token : string;

  RegisterIDs : TJSONArray;
begin
  qryAuxiliar.Active := False;
  qryAuxiliar.SQL.Clear;
  qryAuxiliar.SQL.Text := SQL;
  qryAuxiliar.ParamByName('ID').AsInteger := AID_Usuario;
  qryAuxiliar.Active := True;

  if qryAuxiliar.IsEmpty then
  begin
    Result := False;
    exit;
  end;

  token := qryAuxiliar.FieldByName('DEVICE_TOKEN').AsString;
  try
  //  EnviarAndroidPush('mensagem', Memo1.Lines.Text, Edit1.Text);
    try
      RegisterIDs :=  TJSONArray.Create;
      RegisterIDs.Add(token);

      v_JsonData := TJSONObject.Create;
      v_JsonData.AddPair('id', CodigoProjeto);
      v_JsonData.AddPair('message', AMensagem);

      v_JsonData.AddPair('campo_extra', '11111');

      v_Json := TJSONObject.Create;
      v_Json.AddPair('registration_ids', RegisterIDs);
      v_Json.AddPair('data', v_JsonData);

      Client := THTTPClient.Create;
      Client.ContentType := 'application/json';
      Client.CustomHeaders['Authorization'] := 'key=' + API;

      v_Data := TStringStream.Create(v_Json.ToString);
      v_Data.Position := 0;

      v_response := TStringStream.Create;

      Client.Post(Link, v_Data, v_response);
      v_response.Position := 0;

      Result := True;
    finally

    end;
 except
    Result := False;

  end;

end;

function TSmServicos.RegistrarDispositivo(ADeviceToken, ADeviceID, ATipoDevice,
  ANome: string): Boolean;
const
  SQL =
    'INSERT INTO TDEVROCKS.DISPOSITIVOS ' +
    '(                                  ' +
    '   TIPO_DEVICE    ,                ' +
    '   DEVICE_ID      ,                ' +
    '   DEVICE_TOKEN   ,                ' +
    '   NOME                            ' +
    ')                                  ' +
    'VALUES                             ' +
    '(                                  ' +
    '   :TIPO_DEVICE    ,               ' +
    '   :DEVICE_ID      ,               ' +
    '   :DEVICE_TOKEN   ,               ' +
    '   :NOME                           ' +
    ');                                 ';
begin
  try
    qryAuxiliar.Active := False;
    qryAuxiliar.SQL.Clear;
    qryAuxiliar.SQL.Text := SQL;
    qryAuxiliar.ParamByName('TIPO_DEVICE').AsString  := ATipoDevice;
    qryAuxiliar.ParamByName('DEVICE_ID').AsString    := ADeviceID;
    qryAuxiliar.ParamByName('DEVICE_TOKEN').AsString := ADeviceToken;
    qryAuxiliar.ParamByName('NOME').AsString         := ANome;
    qryAuxiliar.ExecSQL;

    Result := True;
  except
    Result := False;
  end;
end;

function TSmServicos.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

