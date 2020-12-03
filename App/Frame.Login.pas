unit Frame.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts;

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
    procedure SignupButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, uMenu;

procedure TFrameLogin.SignupButtonClick(Sender: TObject);
begin
  if (NameEdit.Text = 'ADMIN') and (PasswordEdit.Text = '123') then
  begin
    FormMain.LoginSucessfull := True;
    FormMain.LoadFrame<TFrameMenu>;
  end;

end;

end.
