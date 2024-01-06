unit UApiKeys;

interface

type
  TApiKeys = class
  public
    class function Google: String;

  end;

implementation

{ TApiKeys }

class function TApiKeys.Google: String;
begin
  Result := 'AIzaSyAIL0abIiThGNcEPCeaZzX76QeN_VrjTqE';
end;

end.
