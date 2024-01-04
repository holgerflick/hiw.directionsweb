unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, UServerContainer, AdvMemo, System.Actions, Vcl.ActnList;

type
  TFrmMain = class(TForm)
    Log: TAdvMemo;
    btnStartStop: TButton;
    btnSwagger: TButton;
    ActionList1: TActionList;
    actStartServer: TAction;
    actStopServer: TAction;
    actSwaggerUI: TAction;
    procedure actStartServerExecute(Sender: TObject);
    procedure actStopServerExecute(Sender: TObject);
    procedure actSwaggerUIExecute(Sender: TObject);
    procedure actSwaggerUIUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FServerContainer: TServerContainer;

    procedure ToggleServer( AActive: Boolean );
    procedure UpdateInterface;
  public
    property Server: TServerContainer read FServerContainer;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  WinApi.ShellAPI
  ;

procedure TFrmMain.actStartServerExecute(Sender: TObject);
begin
  ToggleServer( True );
end;

procedure TFrmMain.actStopServerExecute(Sender: TObject);
begin
  ToggleServer( False );
end;

procedure TFrmMain.actSwaggerUIExecute(Sender: TObject);
begin
  ShellExecute(
      self.Handle
    , 'open'
    , pChar( Server.SwaggerUIUrl )
    , ''
    , ''
    , SW_NORMAL
    );
end;

procedure TFrmMain.actSwaggerUIUpdate(Sender: TObject);
begin
  actSwaggerUI.Enabled := Server.Active;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FServerContainer.Free;
end;

procedure TFrmMain.ToggleServer(AActive: Boolean);
begin
  Server.Active := AActive;
  UpdateInterface;
end;

procedure TFrmMain.UpdateInterface;
begin
  if Server.Active then
  begin
    btnStartStop.Action := actStopServer;
  end
  else
  begin
    btnStartStop.Action := actStartServer;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FServerContainer := TServerContainer.Create(nil);

  UpdateInterface;
end;

end.
