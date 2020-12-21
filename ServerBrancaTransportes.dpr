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
  Controller.Carregamento in 'Controller\Controller.Carregamento.pas',
  Model.Connection in 'Model\Connection\Model.Connection.pas',
  Model.DaoGeneric in 'Model\Connection\Model.DaoGeneric.pas',
  Model.Entity.CADASTRO_CARREGAMENTO in 'Model\Entity\Model.Entity.CADASTRO_CARREGAMENTO.pas',
  uDAO in 'Classes\uDAO.pas',
  Controller.Despesa in 'Controller\Controller.Despesa.pas',
  Model.Entity.CADASTRO_DESPESAS in 'Model\Entity\Model.Entity.CADASTRO_DESPESAS.pas';

var
  App : THorse;
begin
  App := THorse.Create(9000);
  App.Use(JHonson);
  App.Use(CORS);

  Controller.Carregamento.Registry(App);
  Controller.Despesa.Registry(App);

  App.Start;
end.
