unit UDirectionsServiceImpl;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  UDirectionsTypes,
  UDirectionsService;

type
  [ServiceImplementation]
  TDirectionsService = class(TInterfacedObject, IDirectionsService)
    function GetDrivingDirections( AOrigin, ADestination: String ): TRoute;
  end;

implementation


{ TDirectionsService }

function TDirectionsService.GetDrivingDirections(
  AOrigin,
  ADestination: String): TRoute;
begin
  Result := TRoute.Create;
end;

initialization
  RegisterServiceType(TDirectionsService);

end.
