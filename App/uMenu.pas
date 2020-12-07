unit uMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrameMenu = class(TFrame)
    LogoBackgroundRect: TRectangle;
    LogoCenterLayout: TLayout;
    LogoImage: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Login, uCarregamentos, uCarregamento, uDespesa,
  uDespesaExtra;

procedure TFrameMenu.Button1Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameCarregamento>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

procedure TFrameMenu.Button2Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesas>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

procedure TFrameMenu.Button3Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesasExtras>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

end.
