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

uses Form.Main, uMenu, System.JSON;

procedure TFrameLogin.SignupButtonClick(Sender: TObject);
var
  JSonObject : TJSONObject;
 JSonData   : String;
begin
  JSonData := NetHTTPRequest1.Get(Format('http://192.168.15.184:9000/login?user=%s&password=%s', [NameEdit.Text, PasswordEdit.Text])).ContentAsString;
  JSonObject := TJSonObject.ParseJSONValue(JSonData) as TJSonObject;

  label1.Text := JSonObject.GetValue('access').Value;


  if JSonObject.GetValue('access').Value = 'True' then
  begin
    FormMain.LoginSucessfull := True;
    FormMain.LoadFrame<TFrameMenu>;
  end
  else
    label1.Text := 'Login ou senha inválidos.';

end;

end.
