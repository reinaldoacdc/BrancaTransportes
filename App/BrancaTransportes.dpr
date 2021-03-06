program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uParceiros in 'uParceiros.pas' {FrameParceiros: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain},
  Frames.Dataset in 'View\Frames.Dataset.pas' {DatasetFrame: TFrame},
  Controller.API in 'Controller\Controller.API.pas',
  uConfigINI in '..\Classes\uConfigINI.pas',
  UdmMain in 'UdmMain.pas' {DmMain: TDataModule},
  BitmapHelper in '..\Classes\BitmapHelper.pas',
  Form.Login in 'View\Form.Login.pas' {Form1},
  Form.Sincronismo in 'View\Form.Sincronismo.pas' {FormSincronismo},
  Form.Despesa in 'View\Form.Despesa.pas' {FormDespesa},
  Form.Configuracao in 'View\Form.Configuracao.pas' {FormConfiguracao},
  Form.DespesaExtra in 'View\Form.DespesaExtra.pas' {FormDespesaExtra},
  Form.Carregamento in 'View\Form.Carregamento.pas' {FormCarregamento},
  Model.Entity.CADASTRO_CARREGAMENTO in 'Model\Entity\Model.Entity.CADASTRO_CARREGAMENTO.pas' {/  Model.Entity.CADASTRO_DESPESAS in 'Model\Entity\Model.Entity.CADASTRO_DESPESAS.pas';},
  Model.Entity.CADASTRO_DESPESAS in 'Model\Entity\Model.Entity.CADASTRO_DESPESAS.pas',
  Form.Institucional in 'View\Form.Institucional.pas' {FormInstitucional},
  Form.Parceiros in 'View\Form.Parceiros.pas' {FormParceiros};
  //Model.Connection in 'Model\Connection\Model.Connection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDmMain, DmMain);
  Application.Run;
end.
