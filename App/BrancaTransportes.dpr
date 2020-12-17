program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParceiros in 'uParceiros.pas' {FrameParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {FrameInstitucional: TFrame},
  Frame.Menu in 'View\Frame.Menu.pas' {FrameMenu: TFrame},
  uDespesa in 'uDespesa.pas' {FrameDespesas: TFrame},
  uDespesaExtra in 'uDespesaExtra.pas' {FrameDespesasExtras: TFrame},
  Frame.Carregamento in 'View\Frame.Carregamento.pas' {FrameCarregamento: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain},
  Frame.ListaCarregamento in 'Frame.ListaCarregamento.pas' {FrameListaCarregamento: TFrame},
  Frames.Dataset in 'View\Frames.Dataset.pas' {DatasetFrame: TFrame},
  Controller.API in 'Controller\Controller.API.pas',
  Frame.Login in 'View\Frame.Login.pas' {FrameLogin: TFrame},
  Model.Entity.CADASTRO_CARREGAMENTO in '..\Model\Entity\Model.Entity.CADASTRO_CARREGAMENTO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
