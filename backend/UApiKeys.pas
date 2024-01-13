unit UApiKeys;

interface

type
  TApiKeys = class
  public
    class function Google: String;

  end;

implementation

uses
  System.IOUtils
  ;

{ TApiKeys }

class function TApiKeys.Google: String;
begin
  Result := TFile.ReadAllText(
    TPath.Combine( TPath.GetAppPath,
    'apikey.txt' )
  );
end;

end.
