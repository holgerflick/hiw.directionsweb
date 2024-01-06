unit UDirectionsManager;

interface

uses
    VCL.TMSFNCCustomComponent
  , VCL.TMSFNCCloudBase
  , VCL.TMSFNCDirections
  , TMSFNCMapsCommonTypes

  , UDirectionsTypes
  , UApiKeys
  ;


type
  TDirectionsManager = class
  public
    function GetDrivingDirections( AOrigin, ADestination: String ): TRoute;
  end;

implementation


{ TDirectionsManager }

function TDirectionsManager.GetDrivingDirections(AOrigin,
  ADestination: String): TRoute;
var
  LDirections: TTMSFNCDirections;

begin
  Result := TRoute.Create;

  LDirections := TTMSFNCDirections.Create(nil);
  try
    LDirections.APIKey := TApiKeys.Google;
    LDirections.Service := dsGoogle;

    LDirections.GetDirections( AOrigin, ADestination,
      procedure(const ARequest: TTMSFNCDirectionsRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult)
      begin
        if ARequestResult.Success then
        begin
          if ARequest.Items.Count > 0 then begin
            var ARoute := ARequest.Items[0];

            for var LGoogleStep in ARoute.Steps do
            begin
              var LStep := TStep.Create;
              LStep.AssignFrom(LGoogleStep);
              Result.AddStep(LStep);
            end;
          end;
        end;
      end
    );

  finally
    LDirections.Free;
  end;

end;

end.
