program AppBrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uHome in 'uHome.pas' {frmHome},
  uParceiros in 'uParceiros.pas' {frmParceiros: TFrame},
  uInstitucional in 'uInstitucional.pas' {frmInstitucional: TFrame},
  uCarregamentos in 'uCarregamentos.pas' {frmCarregamentos: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmHome, frmHome);
  Application.Run;
end.
