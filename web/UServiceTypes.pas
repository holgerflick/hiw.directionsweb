unit UServiceTypes;

interface

uses
  JS
  , System.Generics.Collections
  ;

type
 TCoordinate = class
  private
    FLatitude: Double;
    FLongitude: Double;
    function GetJSArray: TJSArray;
  public

    property ToJSArray: TJSArray read GetJSArray;

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
    function GetCoordinateArray: TJSArray;

  public
    constructor Create;
    destructor Destroy; override;

    property Coordinates: TCoordinates
      read FCoordinates write FCoordinates;


    property CoordinateArray: TJSArray read GetCoordinateArray;

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


function TStep.GetCoordinateArray: TJSArray;
var
  LCoordinate: TCoordinate;

begin
  Result := TJSArray.new;

  for LCoordinate in self.Coordinates do
  begin
    Result.push(LCoordinate.ToJSArray);
  end;
end;

{ TCoordinate }

function TCoordinate.GetJSArray: TJSArray;
var
  LCoordinate: array of Double;

begin
  SetLength(LCoordinate, 2);
  LCoordinate[0] := self.Latitude;
  LCoordinate[1] := self.Longitude;

  Result := JS.toArray( LCoordinate );
end;

end.
