﻿unit UDirectionsService;

interface

uses
  XData.Service.Common
  , UDirectionsTypes
  ;

type
  [ServiceContract]
  IDirectionsService = interface(IInvokable)
    ['{4BF57EA8-0300-49F7-A996-99676B596561}']

    function DrivingDirections( Origin, Destination: String ): TRoute;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IDirectionsService));

end.
