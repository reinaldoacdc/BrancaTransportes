program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHome in 'uHome.pas' {frmHome},
  uParceiros in 'uParceiros.pas' {FrameParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {FrameInstitucional: TFrame},
  uMenu in 'uMenu.pas' {FrameMenu: TFrame},
  uDespesa in 'uDespesa.pas' {FrameDespesas: TFrame},
  uDespesaExtra in 'uDespesaExtra.pas' {FrameDespesasExtras: TFrame},
  Frame.Carregamento in 'View\Frame.Carregamento.pas' {FrameCarregamento: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain},
  Frame.ListaCarregamento in 'Frame.ListaCarregamento.pas' {FrameListaCarregamento: TFrame},
  Frames.Dataset in 'View\Frames.Dataset.pas' {DatasetFrame: TFrame},
  Controller.API in 'Controller\Controller.API.pas',
  Frame.Login in 'View\Frame.Login.pas' {FrameLogin: TFrame},
  Model.Carregamento in '..\Server\Model.Carregamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
