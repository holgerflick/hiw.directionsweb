unit UServerContainer;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Aurelius.Drivers.Interfaces,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, XData.Server.Module,
  XData.Comp.Server, Sparkle.Comp.ForwardMiddleware, Sparkle.Comp.CorsMiddleware;

type
  TServerContainer = class(TDataModule)
    Dispatcher: TSparkleHttpSysDispatcher;
    Server: TXDataServer;
    ServerCORS: TSparkleCorsMiddleware;
    ServerForward: TSparkleForwardMiddleware;
    procedure ServerForwardAcceptHost(Sender: TObject; const Value: string; var
        Accept: Boolean);
    procedure ServerForwardAcceptProxy(Sender: TObject; const Value: string; var
        Accept: Boolean);
  private
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function GetBaseUrl: String;
    function GetSwaggerUIUrl: String;
  public
    procedure Start;
    procedure Stop;

    property BaseUrl: String read GetBaseUrl;
    property SwaggerUIUrl: String read GetSwaggerUIUrl;

    property Active: Boolean read GetActive write SetActive;

  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServerContainer }

function TServerContainer.GetActive: Boolean;
begin
  Result := Dispatcher.Active;
end;

function TServerContainer.GetBaseUrl: String;
begin
  Result := Server.BaseUrl.Replace( '+', 'localhost' );
end;

function TServerContainer.GetSwaggerUIUrl: String;
begin
  Result := BaseUrl + '/swaggerui';
end;

procedure TServerContainer.ServerForwardAcceptHost(Sender: TObject; const
    Value: string; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TServerContainer.ServerForwardAcceptProxy(Sender: TObject; const
    Value: string; var Accept: Boolean);
begin
   Accept := True;
end;

procedure TServerContainer.SetActive(const Value: Boolean);
begin
  Dispatcher.Active := Value;
end;

procedure TServerContainer.Start;
begin
  Dispatcher.Active := True;
end;

procedure TServerContainer.Stop;
begin
  Dispatcher.Active := False;
end;

end.
