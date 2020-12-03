program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHome in 'uHome.pas' {frmHome},
  uParceiros in 'uParceiros.pas' {FrameParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {FrameInstitucional: TFrame},
  uCarregamentos in 'uCarregamentos.pas' {frmCarregamentos: TFrame},
  uMenu in 'uMenu.pas' {FrameMenu: TFrame},
  uDespesa in 'uDespesa.pas' {FrameDespesas: TFrame},
  uDespesaExtra in 'uDespesaExtra.pas' {FrameDespesasExtras: TFrame},
  uCarregamento in 'uCarregamento.pas' {FrameCarregamento: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain},
  Frame.Login in 'Frame.Login.pas' {FrameLogin: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
