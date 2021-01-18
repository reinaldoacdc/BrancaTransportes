unit Frame.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TFrameLogin = class(TFrame)
    LayoutTop: TLayout;
    Image1: TImage;
    LayoutBody: TLayout;
    rectLogin: TRectangle;
    lblLOGIN: TLabel;
    LayoutRect: TLayout;
    Label2: TLabel;
    NameEdit: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    btnLogin: TRectangle;
    lblLogar: TLabel;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    procedure SignupButtonClick(Sender: TObject);
    procedure PasswordEditExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Menu, System.JSON, Controller.API, uConfigINI;

procedure TFrameLogin.PasswordEditExit(Sender: TObject);
begin
  SignupButtonClick(Sender);
end;

procedure TFrameLogin.SignupButtonClick(Sender: TObject);
begin
//  if objAPI.Login(NameEdit.Text, PasswordEdit.Text) then
//  begin
//    ConfigINI.AcessoBanco.OperadorNome := NameEdit.Text;
//    ConfigINI.UpdateFile;
//
//    FormMain.LoginSucessfull := True;
//    FormMain.LoadFrame<TFrameMenu>;
//  end
//  else
//    label1.Text := 'Login ou senha inválidos.';
end;

end.
