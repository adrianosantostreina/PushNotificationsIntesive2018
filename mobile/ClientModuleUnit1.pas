unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FSmServicosClient: TSmServicosClient;
    function GetSmServicosClient: TSmServicosClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SmServicosClient: TSmServicosClient read GetSmServicosClient write FSmServicosClient;

end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FSmServicosClient.Free;
  inherited;
end;

function TClientModule1.GetSmServicosClient: TSmServicosClient;
begin
  if FSmServicosClient = nil then
    FSmServicosClient:= TSmServicosClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FSmServicosClient;
end;

end.
