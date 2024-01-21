unit UFrmDirections;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls,
  Vcl.Controls, WEBLib.WebCtrls,
 
  UServiceManager
  ;

type
  TFrmDirections = class(TWebForm)
    txtOrigin: TWebEdit;
    txtDestination: TWebEdit;
    btnGetDirections: TWebButton;
    divMap: TWebHTMLDiv;
    Map: TWebLeafletMaps;
    procedure btnGetDirectionsClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
  strict private
    [async]
    procedure GetDirections;

  private

    FServiceManager: TServiceManager;


    function GetOrigin: String;
    function GetDestination: String;

    procedure UpdateTable;

  public

    property Origin: String read GetOrigin;
    property Destination: String read GetDestination;
  end;

var
  FrmDirections: TFrmDirections;

implementation

uses
  UServiceTypes;


{$R *.dfm}

function TFrmDirections.GetDestination: String;
begin
  Result := txtDestination.Text;
end;

procedure TFrmDirections.GetDirections;
begin
  await( FServiceManager.RequestRoute( Origin, Destination ) );

  UpdateTable;
end;

function TFrmDirections.GetOrigin: String;
begin
  Result := txtOrigin.Text;
end;

procedure TFrmDirections.UpdateTable;
var
  LHook: TJSElement;
  LRoute: TRoute;
  LStep: TStep;

  LTable: TJSHTMLElement;
  LTh: TJSHTMLElement;
  LTr: TJSHTMLElement;
  LTd: TJSHTMLElement;

  LTHead,
  LTBody: TJSHTMLElement;

  LColumns: array of string;
  LColumn: String;
  LColumnq: TObject;

  LStepNo: Integer;
  LIndex: Integer;

  // LPoly: TTMSFNCMapsPolyline;

begin
  LRoute := FServiceManager.Route;

  // get root
  LHook := document.getElementById('hookTable');

  // all elements will be children of this element...
  // remove any existing text first

  (*
  LHook.innerHTML := Format(
    '''
    Route found with total distance of %d meters. It will
    take you %d minutes to drive there.
    ''', [ LRoute.TotalDistance, LRoute.TotalDuration DIV 60 ] );

   *)

  LHook.innerHTML := '';

  // add table
  LTable := document.createHTMLElement('table');      // <table></table>
  LTable.className := 'table table-hover';            // <table class="table table-hover"></table>

  // add header

  LColumns := [
      '#'
    , '<i class="bi bi-signpost"></i> Distance/<i>km</i>'
    , '<i class="bi bi-watch"></i> Duration/<i>min</i>'
    , '<i class="bi bi-card-text"></i> Instructions' ];

  LTHead := document.createHTMLElement('thead');

  LTr := document.createHTMLElement('tr');

  for LColumn in LColumns  do
  begin
    LTh := document.createHTMLElement('th');
    LTh.innerHTML := LColumn;
    LTr.appendChild(LTh);
  end;
  LTHead.appendChild(LTr);

  // add body
  LTBody := document.createHTMLElement('tbody');

  Map.BeginUpdate;
  try
    Map.ClearMarkers;
    Map.ClearPolylines;

    LStepNo := 1;
    for LStep in LRoute.Steps do
    begin
      LTr := document.createHTMLElement('tr');

//      LPoly := Map.AddPolyline( LStep.CoordinateRecArray );
//      LPoly.StrokeColor := clRed;
//      LPoly.StrokeWidth := 5;
//      LPoly.StrokeOpacity := 0.6;

      LIndex := 0;
      for LColumn in LColumns do
      begin
        Inc(LIndex);

        LTd := document.createHTMLElement('td');

        if LIndex <> 4 then
        begin
          LTd.className := 'text-monospace text-right'
        end;

        if LIndex = 1 then      // #
        begin
          LTd.innerHTML := LStepNo.ToString;
        end;

        if LIndex = 2 then      // Distance
        begin
          LTd.innerHTML := Format( '%.1f', [LStep.Distance/1000] );
        end;

        if LIndex = 3 then      // Duration
        begin
          LTd.innerHTML := Format( '%.1f', [LStep.Duration/60] );
        end;

        if LIndex = 4 then
        begin
          LTd.classList.add('user-select-all');
          LTd.innerHTML := LStep.Instructions;
        end;

        LTr.appendChild(LTd);
      end;

      LTBody.appendChild(LTr);

      Inc(LStepNo);
    end;

    // finally, add the table to the document
    // make this the last line, otherwise performance will be worse
    LTable.appendChild(LTHead);
    LTable.appendChild(LTBody);
    LHook.appendChild(LTable);

    Map.AddMarker(
      LRoute.CoordinateOrigin.Latitude,
      LRoute.CoordinateOrigin.Longitude
      );

    Map.AddMarker(
      LRoute.CoordinateDestination.Latitude,
      LRoute.CoordinateDestination.Longitude
      );


    Map.SetZoom(11);

//    Map.ZoomToBounds(Map.Markers.ToCoordinateArray);
  finally
    Map.EndUpdate;
  end;

end;

procedure TFrmDirections.btnGetDirectionsClick(Sender: TObject);
begin
  GetDirections;
end;

procedure TFrmDirections.WebFormCreate(Sender: TObject);
begin
  FServiceManager := TServiceManager.Create(Self);

  txtOrigin.Text := 'Barefoot Beach, Bonita Springs, FL';
  txtDestination.Text := 'Dali Museum, Tampa, FL';
end;

end.
