program GetDirectionsEx;

uses
  Vcl.Forms,
  WEBLib.Forms,
  UFrmDirections in 'UFrmDirections.pas' {FrmDirections: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDirections, FrmDirections);
  Application.Run;
end.
