unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  System.Net.HttpClient,
  System.JSON, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids,

  Data.FireDACJSONReflect, FireDAC.Stan.StorageBin;

type
  TForm2 = class(TForm)
    Button1: TButton;
    MemoMensagem: TMemo;
    MemoToken: TMemo;
    MemoResposta: TMemo;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Button3: TButton;
    DataSource1: TDataSource;
    MemDevices: TFDMemTable;
    Button4: TButton;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function EnviarAndroidPush(AOperacao, AMensagem,
      AToken: String): Boolean;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses ClientModuleUnit1;

procedure TForm2.Button1Click(Sender: TObject);
var
  Client      : THTTPClient;
  v_Json        : TJSONObject;
  v_JsonData   : TJSONObject;
  v_RegisterIDs : TJSONArray;
  v_Data        : TStringStream;
  v_response    : TStringStream;

  token : string;
  CodigoProjeto : string;
  API           : string;
  Link          : string;

  RegisterIDs : TJSONArray;
begin
  token := MemoToken.Lines.Text;
  CodigoProjeto := '';
  API           := '';
  Link          := 'https://android.googleapis.com/gcm/send';

//  EnviarAndroidPush('mensagem', Memo1.Lines.Text, Edit1.Text);
  try
    RegisterIDs :=  TJSONArray.Create;
    RegisterIDs.Add(MemoToken.Lines.Text);

    v_JsonData := TJSONObject.Create;
    v_JsonData.AddPair('id', CodigoProjeto);
    v_JsonData.AddPair('message', MemoMensagem.Lines.Text);
    v_JsonData.AddPair('campo_extra', '11111');

    v_Json := TJSONObject.Create;
    v_Json.AddPair('registration_ids', RegisterIDs);
    v_Json.AddPair('data', v_JsonData);

    Client := THTTPClient.Create;
    Client.ContentType := 'application/json';
    Client.CustomHeaders['Authorization'] := 'key=' + API;

    MemoResposta.Lines.Clear;
    MemoResposta.lines.add(v_Json.ToString);

    v_Data := TStringStream.Create(v_Json.ToString);
    v_Data.Position := 0;

    v_response := TStringStream.Create;

    Client.Post(Link, v_Data, v_response);
    v_response.Position := 0;

    MemoResposta.Lines.Add(v_response.DataString);

  finally

  end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ClientModule1.SmServicosClient.EnviarPushMultiplo(MemoMensagem.Lines.Text);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if ClientModule1.SmServicosClient.EnviarPushUnico(MemDevices.FieldByName('ID').AsInteger, MemoMensagem.Lines.Text) then
    ShowMessage('Enviado com sucesso')
  else
    ShowMessage('Erro')
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  dadosDispositivos: TFDJSONDataSets;
begin
  dadosDispositivos := ClientModule1.SmServicosClient.Dispositivos;
  MemDevices.Active := False;
  if TFDJSONDataSetsReader.GetListCount(dadosDispositivos) = 1 then
    MemDevices.AppendData(TFDJSONDataSetsReader.GetListValue(dadosDispositivos, 0));
  //MemDevices.Active := True;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  if ClientModule1.SmServicosClient.RegistrarDispositivo(
    MemoToken.Lines.Text,
    '44444',
    'ANDROID',
    'ADRIANO 2 mesmo dispositivo'
  ) then
    ShowMessage('Gravado com sucesso')
  else
    ShowMessage('Erro');
end;

function TForm2.EnviarAndroidPush(AOperacao, AMensagem,
  AToken: String): Boolean;
var
  LClient          : THTTPClient;
  AJson            : TJSONObject;
  AJsonData        : TJSONObject;
  ARegisterIds     : TJSONArray;
  AData            : TStringStream;
  AResponseContent : TStringStream;
  DeviceToken      : String;
  I                : Integer;
begin
(*
  try
    LClient := THTTPClient.Create;
    ARegisterIds := TJSONArray.Create();
    AJson := TJSONObject.Create();
    try
      //Registra o TOKEN do celular a enviar
      ARegisterIds.Add(AToken);
      AJsonData := TJSONObject.Create();
      AJsonData.AddPair('id', CODIGO_APP_GCM {YOUR_GCM_SENDERID});

      //Enviamos um campo com o tipo de mensagem para identificar no cliente
      // 0 = Matrícula    -> Cliente acabou de se matricular no serviço
      // 1 = Valor        -> Lojista solicitando um pagamento
      // 2 = Autorização  -> Cliente autorizou o pagamento e o lojista recebe
      // 3 = Confirmação  -> Lojista recebeu e cliente recebe confirmação de operação efetuada
      AJsonData.AddPair('operacao', AOperacao);
      AJsonData.AddPair('mensagem', AMensagem);

      AJson.AddPair('registration_ids', ARegisterIds);
      AJson.AddPair('data', AJsonData);

      LClient.ContentType                    := 'application/json';
      LClient.CustomHeaders['Authorization'] := 'key=' + CODIGO_API_GCM {YOUR_API_ID"};
      AData := TStringStream.Create(AJson.ToString);
      AData.Position := 0;
      AResponseContent := TStringStream.Create();

      //Envia a notificação
      LClient.Post(LinkDoServico, AData, AResponseContent);
      AResponseContent.Position := 0;

      Result := True;
      ShowMessage('Enviado');
    except
      Result := False;
    end;
  finally
    LClient.Free;
  end;
*)
end;

end.
