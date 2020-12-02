program BrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uHome in 'uHome.pas' {frmHome},
  uParceiros in 'uParceiros.pas' {frmParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {frmInstitucional: TFrame},
  uCarregamentos in 'uCarregamentos.pas' {frmCarregamentos: TFrame},
  uMenu in 'uMenu.pas' {FrameMenu: TFrame},
  uDespesa in 'uDespesa.pas' {Frame2: TFrame},
  uDespesaExtra in 'uDespesaExtra.pas' {Frame3: TFrame},
  uCarregamento in 'uCarregamento.pas' {Frame4: TFrame},
  Form.Main in 'Form.Main.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
