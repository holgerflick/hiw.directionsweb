unit UDirectionsTypes;

interface

uses
    TMSFNCMapsCommonTypes
  , TMSFNCMaps.GoogleMaps
  , VCL.TMSFNCDirections

  , System.Generics.Collections
  ;

type

  TCoordinate = class
  private
    FLatitude: Double;
    FLongitude: Double;
  public
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
  end;

  TCoordinates = TObjectList<TCoordinate>;

  TStep = class
  private
    FDistance: Integer;
    FDuration: Integer;
    FInstructions: String;
    FCoordinates: TCoordinates;


  public
    constructor Create;
    destructor Destroy; override;


    property Coordinates: TCoordinates
      read FCoordinates write FCoordinates;

    property Distance: Integer
      read FDistance write FDistance;
    property Duration: Integer
      read FDuration write FDuration;
    property Instructions: String
      read FInstructions write FInstructions;

    procedure AssignFrom( ADirectionsStep: TTMSFNCDirectionsStep );
  end;

  TSteps = TObjectList<TStep>;

  TRoute = class
  private
    FSteps: TSteps;
    function GetTotalDistance: Integer;
    function GetTotalDuration: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property TotalDuration: Integer read GetTotalDuration;
    property TotalDistance: Integer read GetTotalDistance;

    property Steps: TSteps read FSteps;
  end;


implementation

{ TStep }

procedure TStep.AssignFrom(ADirectionsStep: TTMSFNCDirectionsStep);
begin
  self.Coordinates.Clear;

  for var LCoordinate in ADirectionsStep.Coordinates do
  begin
    var LNewCoord := TCoordinate.Create;
    LNewCoord.Latitude := LCoordinate.Latitude;
    LNewCoord.Longitude := LCoordinate.Longitude;

    self.Coordinates.Add( LNewCoord );
  end;

  self.Distance := ADirectionsStep.Distance;
  self.Duration := ADirectionsStep.Duration;
  self.Instructions := ADirectionsStep.Instructions;
end;

constructor TStep.Create;
begin
  FCoordinates := TCoordinates.Create;
end;

destructor TStep.Destroy;
begin
  FCoordinates.Free;

  inherited;
end;

{ TRoute }

constructor TRoute.Create;
begin
  inherited;

  FSteps := TSteps.Create;
end;

destructor TRoute.Destroy;
begin
  FSteps.Free;

  inherited;
end;

function TRoute.GetTotalDistance: Integer;
begin
  Result := 0;
  for var LStep in self.Steps do
  begin
    Result := Result + LStep.Distance;
  end;
end;

function TRoute.GetTotalDuration: Integer;
begin
  Result := 0;
  for var LStep in self.Steps do
  begin
    Result := Result + LStep.Duration;
  end;
end;

end.
