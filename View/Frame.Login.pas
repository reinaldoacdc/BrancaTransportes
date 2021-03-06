unit Frame.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TFrameLogin = class(TFrame)
    LogoBackgroundRect: TRectangle;
    LogoCenterLayout: TLayout;
    LogoImage: TImage;
    FormLayout: TLayout;
    FormBackgroundRect: TRectangle;
    NameEdit: TEdit;
    PasswordEdit: TEdit;
    SignupButton: TButton;
    FormShadowEffect: TShadowEffect;
    FooterSpaceLayout: TLayout;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    Label1: TLabel;
    procedure SignupButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Menu, System.JSON, Controller.API;

procedure TFrameLogin.SignupButtonClick(Sender: TObject);
begin
  if objAPI.Login(NameEdit.Text, PasswordEdit.Text) then
  begin
    FormMain.LoginSucessfull := True;
    FormMain.LoadFrame<TFrameMenu>;
  end
  else
    label1.Text := 'Login ou senha inválidos.';

end;

end.
