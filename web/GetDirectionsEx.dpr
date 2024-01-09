program GetDirectionsEx;

uses
  Vcl.Forms,
  WEBLib.Forms,
  UFrmDirections in 'UFrmDirections.pas' {FrmDirections: TWebForm} {*.html},
  UServiceTypes in 'UServiceTypes.pas',
  UServiceManager in 'UServiceManager.pas' {ServiceManager: TWebDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDirections, FrmDirections);
  Application.Run;
end.
