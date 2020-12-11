unit Frame.Menu;

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
    GridLayout1: TGridLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Rectangle4: TRectangle;
    Label4: TLabel;
    procedure Rectangle1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Login, uCarregamentos, uDespesa,
  uDespesaExtra, Frame.Carregamento;

procedure TFrameMenu.Label2Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesas>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

procedure TFrameMenu.Label3Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesasExtras>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

procedure TFrameMenu.Rectangle1Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameCarregamento>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

end.
