unit Frame.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Gestures;

type
  TFrameMenu = class(TFrame)
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
    btnConfiguracoes: TRectangle;
    Label4: TLabel;
    ScaledLayout1: TScaledLayout;
    ScrollBox1: TScrollBox;
    procedure btnNovoCarregamentoClick(Sender: TObject);
    procedure btnNovaDespesaClick(Sender: TObject);
    procedure btnNovaDespesaExtraClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Form.Login, uCarregamentos, Form.Despesa,
  Form.DespesaExtra, Frame.Carregamento, Form.Configuracao;

procedure TFrameMenu.btnConfiguracoesClick(Sender: TObject);
begin
  if not (Assigned(FormConfiguracao)) then
    Application.CreateForm(TFormConfiguracao, FormConfiguracao);
  FormConfiguracao.Show;
end;

procedure TFrameMenu.btnNovaDespesaClick(Sender: TObject);
begin
  if not (Assigned(FormDespesa)) then
    Application.CreateForm(TFormDespesa, FormDespesa);

  FormDespesa.Show;
  //LoadFrame<TFrameDespesas>;
  //FormMain.LoadFrame<TFrameDespesas>;
  //if not FormMain.LoginSucessfull then
  //  FormMain.LoadFrame<TFrameLogin>
  //else
  //  FormMain.LoadListatem('DESPESA');
end;

procedure TFrameMenu.btnNovaDespesaExtraClick(Sender: TObject);
begin
  if not (Assigned(FormDespesaExtra)) then
    Application.CreateForm(TFormDespesaExtra, FormDespesaExtra);
  FormDespesaExtra.Show;
end;

procedure TFrameMenu.btnNovoCarregamentoClick(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameCarregamento>;
  //if not FormMain.LoginSucessfull then
  //  FormMain.LoadFrame<TFrameLogin>;
end;

end.
