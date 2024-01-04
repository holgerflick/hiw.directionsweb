program XDataDirectionsServer;

uses
  Vcl.Forms,
  UServerContainer in 'UServerContainer.pas' {ServerContainer: TDataModule},
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UDirectionsService in 'services\UDirectionsService.pas',
  UDirectionsServiceImpl in 'services\UDirectionsServiceImpl.pas',
  UDirectionsTypes in 'services\UDirectionsTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
