program AppBrancaTransportes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHome in 'uHome.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
