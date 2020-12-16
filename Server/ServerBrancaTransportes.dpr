program ServerBrancaTransportes;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  System.JSON,
  Encriptacao in 'Classes\Encriptacao.pas',
  uConfigINI in 'Classes\uConfigINI.pas',
  uDAO in 'Classes\uDAO.pas',
  Controller.Carregamento in 'Controller\Controller.Carregamento.pas',
  Model.Connection in 'Model\Connection\Model.Connection.pas',
  Model.DaoGeneric in 'Model\Connection\Model.DaoGeneric.pas',
  Model.Entity.CADASTRO_CARREGAMENTO in 'Model\Entity\Model.Entity.CADASTRO_CARREGAMENTO.pas';

var
  App : THorse;
begin
  App := THorse.Create(9000);
  App.Use(JHonson);
  App.Use(CORS);

  Controller.Carregamento.Registry(App);

  App.Start;
end.
