unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TfrmLogin = class(TForm)
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
    procedure SignupButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uHome;

procedure TfrmLogin.SignupButtonClick(Sender: TObject);
begin
{ TODO : Feature: Login }

  frmHome := TfrmHome.Create(self);
  frmHome.Show;

end;

end.
