unit UServiceTypes;

interface

uses
  System.Generics.Collections
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

  end;

  TSteps = TObjectList<TStep>;

  TRoute = class
  private
    FSteps: TSteps;
    FTotalDistance: Integer;
    FTotalDuration: Integer;

  public
    constructor Create;
    destructor Destroy; override;

    property Steps: TSteps read FSteps;

    property TotalDuration: Integer read FTotalDuration write FTotalDuration;
    property TotalDistance: Integer read FTotalDistance write FTotalDistance;
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

end.
