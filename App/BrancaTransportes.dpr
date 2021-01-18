program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParceiros in 'uParceiros.pas' {FrameParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {FrameInstitucional: TFrame},
  Frame.Menu in 'View\Frame.Menu.pas' {FrameMenu: TFrame},
  Frame.Despesa in 'View\Frame.Despesa.pas' {FrameDespesas: TFrame},
  Frame.DespesaExtra in 'View\Frame.DespesaExtra.pas' {FrameDespesasExtras: TFrame},
  Frame.Carregamento in 'View\Frame.Carregamento.pas' {FrameCarregamento: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain},
  Frames.Dataset in 'View\Frames.Dataset.pas' {DatasetFrame: TFrame},
  Controller.API in 'Controller\Controller.API.pas',
  Frame.Login in 'View\Frame.Login.pas' {FrameLogin: TFrame},
  Model.Entity.CADASTRO_CARREGAMENTO in '..\Model\Entity\Model.Entity.CADASTRO_CARREGAMENTO.pas',
  Model.Entity.CADASTRO_DESPESAS in '..\Model\Entity\Model.Entity.CADASTRO_DESPESAS.pas',
  Frame.Configuracao in 'View\Frame.Configuracao.pas' {FrameConfiguracoes: TFrame},
  uConfigINI in '..\Classes\uConfigINI.pas',
  UdmMain in 'UdmMain.pas' {DmMain: TDataModule},
  Frame.Sincronismo in 'View\Frame.Sincronismo.pas' {FrameSincronismo: TFrame},
  BitmapHelper in '..\Classes\BitmapHelper.pas',
  Form.Login in 'Form.Login.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDmMain, DmMain);

  Application.Run;
end.
