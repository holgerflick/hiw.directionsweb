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

uses
  UDirectionsManager
  ;


{ TDirectionsService }

function TDirectionsService.GetDrivingDirections(
  AOrigin,
  ADestination: String): TRoute;
var
  LManager: TDirectionsManager;

begin
  LManager := TDirectionsManager.Create;
  try
    Result := LManager.GetDrivingDirections(AOrigin, ADestination);
  finally
    LManager.Free;
  end;
end;

initialization
  RegisterServiceType(TDirectionsService);

end.
