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
    btnNovoCarregamento: TRectangle;
    lblNovoCarregamento: TLabel;
    btnNovaDespesa: TRectangle;
    lblNovaDespesa: TLabel;
    btnNovaDespesaExtra: TRectangle;
    lblNovaDespesaExtra: TLabel;
    Rectangle4: TRectangle;
    Label4: TLabel;
    ScaledLayout1: TScaledLayout;
    procedure btnNovoCarregamentoClick(Sender: TObject);
    procedure btnNovaDespesaClick(Sender: TObject);
    procedure btnNovaDespesaExtraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Login, uCarregamentos, Frame.Despesa,
  uDespesaExtra, Frame.Carregamento;

procedure TFrameMenu.btnNovaDespesaClick(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesas>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>
  else
    FormMain.LoadListatem('DESPESA');
end;

procedure TFrameMenu.btnNovaDespesaExtraClick(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameDespesasExtras>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

procedure TFrameMenu.btnNovoCarregamentoClick(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameCarregamento>;
  if not FormMain.LoginSucessfull then
    FormMain.LoadFrame<TFrameLogin>;
end;

end.
