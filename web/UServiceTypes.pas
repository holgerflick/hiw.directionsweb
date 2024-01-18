unit UServiceTypes;

interface

uses
    WEBLib.TMSFNCMapsCommonTypes
  , System.Generics.Collections
  ;

type
 TCoordinate = class
  private
    FLatitude: Double;
    FLongitude: Double;
    function GetCoordinateRec: TTMSFNCMapsCoordinateRec;
  public
    property CoordinateRec: TTMSFNCMapsCoordinateRec read GetCoordinateRec;

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
    function GetCoordinateRecArray: TTMSFNCMapsCoordinateRecArray;

  public
    constructor Create;
    destructor Destroy; override;

    property Coordinates: TCoordinates
      read FCoordinates write FCoordinates;

    property CoordinateRecArray: TTMSFNCMapsCoordinateRecArray read GetCoordinateRecArray;

    property Distance: Integer
      read FDistance write FDistance;
    property Duration: Integer
      read FDuration write FDuration;
    property Instructions: String
      read FInstructions write FInstructions;

  end;

  TSteps = TObjectList<TStep>;

  TRoute = class
  private
    FSteps: TSteps;
    function GetTotalDistance: Integer;
    function GetTotalDuration: Integer;
    function GetCoordinateDestination: TCoordinate;
    function GetCoordinateOrigin: TCoordinate;

  public
    constructor Create;
    destructor Destroy; override;

    property Steps: TSteps read FSteps;

    property TotalDuration: Integer read GetTotalDuration;
    property TotalDistance: Integer read GetTotalDistance;

    property CoordinateOrigin: TCoordinate read GetCoordinateOrigin;
    property CoordinateDestination: TCoordinate read GetCoordinateDestination;

  end;


implementation

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

function TRoute.GetCoordinateDestination: TCoordinate;
begin
  Result := Steps.Last.Coordinates.Last;
end;

function TRoute.GetCoordinateOrigin: TCoordinate;
begin
  Result := Steps.First.Coordinates.First;
end;

function TRoute.GetTotalDistance: Integer;
var
  LStep: TStep;
begin
  Result := 0;
  for LStep in Steps do
  begin
    Result := Result + LStep.Distance;
  end;
end;

function TRoute.GetTotalDuration: Integer;
var
  LStep: TStep;

begin
  Result := 0;
  for LStep in Steps do
  begin
    Result := Result + LStep.Duration;
  end;
end;

{ TStep }

constructor TStep.Create;
begin
  inherited;

  FCoordinates := TCoordinates.Create;
end;

destructor TStep.Destroy;
begin
  FCoordinates.Free;

  inherited;
end;

function TStep.GetCoordinateRecArray: TTMSFNCMapsCoordinateRecArray;
var
  LCoordinate: TCoordinate;
  LIndex : Integer;
begin
  SetLength( Result, Coordinates.Count );

  LIndex := 0;
  for LCoordinate in Coordinates do
  begin
    Result[LIndex] := CreateCoordinate( LCoordinate.Latitude, LCoordinate.Longitude );
    Inc( LIndex );
  end;
end;

{ TCoordinate }

function TCoordinate.GetCoordinateRec: TTMSFNCMapsCoordinateRec;
begin
  Result := CreateCoordinate( Latitude, Longitude );
end;

end.
