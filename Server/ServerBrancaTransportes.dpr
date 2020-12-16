program ServerBrancaTransportes;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Horse,
  Horse.Jhonson,
  System.JSON,
  Encriptacao in 'Classes\Encriptacao.pas',
  uConfigINI in 'Classes\uConfigINI.pas',
  uDAO in 'Classes\uDAO.pas',
  Model.Carregamento in 'Model.Carregamento.pas',
  Controller.Carregamento in 'Controller\Controller.Carregamento.pas';
var
  App : THorse;
begin
  App := THorse.Create(9000);
  App.Use(JHonson);

  Controller.Carregamento.Registry(App);

  App.Start;
end.
