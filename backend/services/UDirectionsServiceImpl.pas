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
    function DrivingDirections( Origin, Destination: String ): TRoute;
  end;

implementation

uses
  UDirectionsManager
  ;


{ TDirectionsService }

function TDirectionsService.DrivingDirections(
  Origin,
  Destination: String): TRoute;
var
  LManager: TDirectionsManager;

begin
  LManager := TDirectionsManager.Create;
  try
    Result := LManager.GetDrivingDirections(Origin, Destination);
  finally
    LManager.Free;
  end;
end;

initialization
  RegisterServiceType(TDirectionsService);

end.
