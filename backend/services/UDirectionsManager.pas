unit UDirectionsManager;

interface

uses
    VCL.TMSFNCCustomComponent
  , VCL.TMSFNCCloudBase
  , VCL.TMSFNCDirections
  , TMSFNCMapsCommonTypes

  , System.Generics.Collections

  , UDirectionsTypes
  , UApiKeys
  ;

type
  TRouteById = TDictionary<String, TRoute>;


type
  TDirectionsManager = class
  private
    FRoutes: TRouteById;
    FDirections: TTMSFNCDirections;

  public
    constructor Create;
    destructor Destroy; override;

    function GetDrivingDirections( AOrigin, ADestination: String ): TRoute;
  end;

implementation

uses
    System.TimeSpan
  , System.SysUtils
  , System.Threading

  , XData.Sys.Exceptions
  ;


{ TDirectionsManager }

constructor TDirectionsManager.Create;
begin
  FRoutes := TRouteById.Create;

  FDirections := TTMSFNCDirections.Create(nil);
  FDirections.APIKey := TApiKeys.Google;
  FDirections.Service := dsGoogle;
end;

destructor TDirectionsManager.Destroy;
begin
  FDirections.Free;
  FRoutes.Free;

  inherited;
end;

function TDirectionsManager.GetDrivingDirections(AOrigin,
  ADestination: String): TRoute;
var
  LGuid: TGuid;
  LId: String;
  LTaskWait: IFuture<TRoute>;
  LTaskRetrieve: ITask;
  LTimes: Integer;

begin
  Result := nil;

  CreateGUID(LGuid);
  LId := GUIDToString(LGuid);

  LTaskRetrieve := TTask.Create(
    procedure
    begin
      FDirections.GetDirections( AOrigin, ADestination,
        procedure(const ARequest: TTMSFNCDirectionsRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult)
        begin
          if ARequestResult.Success then
          begin
            if ARequest.Items.Count > 0 then begin
              var ARoute := ARequest.Items[0];

              var LRoute := TRoute.Create;
              for var LGoogleStep in ARoute.Steps do
              begin
                var LStep := TStep.Create;
                LStep.AssignFrom(LGoogleStep);
                LRoute.AddStep(LStep);
              end;

              // TODO: monitor...
              TMonitor.Enter(FRoutes);
              try
                FRoutes.Add( ARequest.Id, LRoute );
              finally
                TMonitor.Exit(FRoutes);
              end;
            end;
          end;
        end, LId
      );
    end
  );

  LTaskRetrieve.Start;

  LTaskWait := TTask.Future<TRoute>(
    function: TRoute
    begin
      LTimes := 0;

      var LRoute := nil;

      while (LRoute = nil) AND (LTimes < 20) do
      begin
        Sleep(500);

        TMonitor.Enter(FRoutes);
        try
          if FRoutes.ContainsKey(LId) then
          begin
            LRoute := FRoutes[LId];
          end;
        finally
          TMonitor.Exit(FRoutes);
        end;

        Inc(LTimes);
      end;

      Result := LRoute;
    end
  );

  Result := LTaskWait.Value;

  if Result = nil then
  begin
    raise EXDataHttpException.Create(404, 'No route found.');
  end;
end;

end.
