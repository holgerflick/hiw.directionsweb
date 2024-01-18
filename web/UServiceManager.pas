unit UServiceManager;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, WEBLib.REST,
  UServiceTypes, WEBLib.TMSFNCPersistence;

type
  TServiceManager = class(TWebDataModule)
    Client: TWebHttpRequest;
    procedure WebDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FRoute: TRoute;

    procedure ProcessDrivingDirections(AResponse: JSValue);
  public
    { Public declarations }

    [async]
    procedure RequestRoute( AOrigin, ADestination: String );

  published
    property Route: TRoute read FRoute;
  end;


type
  TDrivingDirectionsPostData = class
  private
    FOrigin: String;
    FDestination: String;

  public
    constructor Create(AOrigin, ADestination: String );
  published
    property Origin: String read FOrigin write FOrigin;
    property Destination: String read FDestination write FDestination;
  end;

//{
//  "Origin": "string",
//  "Destination": "string"
//}

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceManager.ProcessDrivingDirections(AResponse: JSValue);
var
  LStepsArr: TJSArray;
  LRouteObj: TJSObject;
  j,
  i: Integer;
  LStepObj: TJSObject;
  LStep: TStep;

  LCoordinateArr: TJSArray;
  LCoordinateObj: TJSObject;
  LCoordinate: TCoordinate;


begin
  FRoute.Free;

  FRoute := TRoute.Create;

  LRouteObj := TJSObject( AResponse );

  LStepsArr := TJSArray( LRouteObj['Steps'] );

  for i := 0 to LStepsArr.Length - 1 do
  begin
    LStepObj := TJSObject( LStepsArr[i] );

    LCoordinateArr := TJSArray( LStepObj['Coordinates'] );

    LStep := TStep.Create;
    LStep.Distance := JS.toInteger( LStepObj['Distance'] );
    LStep.Duration := JS.toInteger( LStepObj['Duration'] );
    LStep.Instructions := JS.toString( LStepObj['Instructions'] );

    for j := 0 to LCoordinateArr.Length - 1 do
    begin
      LCoordinateObj := TJSObject(LCoordinateArr[j]);

      LCoordinate := TCoordinate.Create;
      LCoordinate.Latitude :=  JS.toNumber( LCoordinateObj['Latitude'] );
      LCoordinate.Longitude := JS.toNumber( LCoordinateObj['Longitude'] );

      LStep.Coordinates.Add( LCoordinate );
    end;

    FRoute.Steps.Add(LStep);
  end;
end;

procedure TServiceManager.RequestRoute(AOrigin, ADestination: String);
var
  LPayload: TDrivingDirectionsPostData;
  LBodyString: String;
  LReq: TJSXMLHttpRequest;

begin
  LPayload := TDrivingDirectionsPostData.Create( AOrigin, ADestination );

  LBodyString := TTMSFNCObjectPersistence.SaveObjectToString(LPayload);
  Client.PostData := LBodyString;

  Client.Headers.Clear;
  Client.Headers.Add( 'Content-Type=application/json' );

  LReq := await( TJSXMLHttpRequest, Client.Perform );

  if LReq.Status = 200 then
  begin
    ProcessDrivingDirections(LReq.response);
  end;

end;

procedure TServiceManager.WebDataModuleCreate(Sender: TObject);
begin
  FRoute := nil;
end;

{ TDrivingDirectionsPostData }

constructor TDrivingDirectionsPostData.Create(AOrigin, ADestination: String);
begin
  inherited Create;

  self.Origin := AOrigin;
  self.Destination := ADestination;
end;

end.
