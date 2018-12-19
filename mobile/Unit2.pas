unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  REST.Backend.PushTypes, System.JSON, REST.Backend.EMSPushDevice,
  System.PushNotification, REST.Backend.EMSProvider, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memDeviceToken: TMemo;
    memDeviceID: TMemo;
    memMensagem: TMemo;
    Button1: TButton;
    edtNome: TEdit;
    PushEvents1: TPushEvents;
    EMSProvider1: TEMSProvider;
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses ClientModuleUnit1;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ClientModule1.SmServicosClient.RegistrarDispositivo(
    memDeviceToken.Lines.Text,
    memDeviceID.Lines.Text,
    'ANDROID',
    edtNome.Text
  );
end;

procedure TForm2.FormActivate(Sender: TObject);
var
  Notifcacao : TPushData;
  I          : Integer;
begin
  try
    Notifcacao := Self.PushEvents1.StartupNotification;
    if Assigned(Notifcacao) then
    begin
      if not PushEvents1.StartupNotification.GCM.Message.Equals(EmptyStr) then
      begin
        for I := 0 to Pred(Notifcacao.Extras.Count) do
          memMensagem.Lines.Add(Notifcacao.Extras[I].Key + ' - ' + Notifcacao.Extras[I].Value);
      end;

      if not PushEvents1.StartupNotification.APS.Alert.Equals(EmptyStr) then
      begin
        for I := 0 to Pred(Notifcacao.Extras.Count) do
          memMensagem.Lines.Add(Notifcacao.Extras[I].Key + ' - ' + Notifcacao.Extras[I].Value);
      end;

    end;
  finally
    Notifcacao.DisposeOf;
  end;

end;

procedure TForm2.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  memDeviceToken.Lines.Add(PushEvents1.DeviceToken);
  memDeviceID.Lines.Add(PushEvents1.DeviceID);
end;

procedure TForm2.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
var
  I : Integer;
begin
  memMensagem.Lines.Add(AData.Message);
  memMensagem.Lines.Add(EmptyStr);
  memMensagem.Lines.Add('--------');
  memMensagem.Lines.Add(EmptyStr);

  for I := 0 to Pred(ADAta.Extras.Count) do
    memMensagem.Lines.Add(AData.Extras[I].Key + ' - ' + AData.Extras[I].Value);

end;

end.
