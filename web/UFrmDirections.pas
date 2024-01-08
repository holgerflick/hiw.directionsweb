unit UFrmDirections;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, Vcl.StdCtrls, WEBLib.StdCtrls,
  VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser, VCL.TMSFNCMaps,
  VCL.TMSFNCLeaflet, Vcl.Controls, WEBLib.WebCtrls, VCL.TMSFNCGoogleMaps;

type
  TFrmDirections = class(TWebForm)
    divMap: TWebHTMLDiv;
    txtOrigin: TWebEdit;
    txtDestination: TWebEdit;
    Maps: TTMSFNCLeaflet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDirections: TFrmDirections;

implementation

{$R *.dfm}

end.