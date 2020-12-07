unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;


type TDadosAcesso = record
  Servidor :String;
  Caminho :String;
  Usuario :String;
  Senha :String;
end;


type
  TdmPrincipal = class(TDataModule)
    Fconnection: TFDConnection;
    Fquery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Fparams :TDadosAcesso;

    procedure AbreBanco;
    procedure FechaBanco;
  public
    function Login(username, password :String) :Boolean;
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses uConfigINI;

{$R *.dfm}

{ TdmPrincipal }

procedure TdmPrincipal.AbreBanco;
begin
  Fconnection.DriverName := 'FB';
  Fconnection.Params.Values['Server'] := Fparams.Servidor;
  Fconnection.Params.Database := Fparams.Caminho;
  Fconnection.Params.UserName := Fparams.Usuario;
  Fconnection.Params.Password := Fparams.Senha; //Crypt(crDecriptar, Fparams.Senha, kCh);

  Fconnection.Connected := True;
end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  if Self.Fparams.Caminho = '' then
  begin
    Fparams.Servidor :=  ConfigINI.AcessoBanco.Servidor;
    Fparams.Caminho  :=  ConfigINI.AcessoBanco.Caminho;
    Fparams.Usuario  :=  ConfigINI.AcessoBanco.Usuario;
    Fparams.Senha    :=  ConfigINI.AcessoBanco.Senha;
  end;

  AbreBanco;
end;

procedure TdmPrincipal.DataModuleDestroy(Sender: TObject);
begin
  FechaBanco;
end;

procedure TdmPrincipal.FechaBanco;
begin
  Fconnection.Connected := False;
end;

function TdmPrincipal.Login(username, password: String): Boolean;
begin
  Result := False;
  Fquery.SQL.Text := Format('SELECT CODIGO FROM USUARIOS WHERE LOGIN = ''%s'' AND SENHA = ''%s'' ;',
                            [username, password]);
  Fquery.Open;

  if Fquery.Fields[0].AsInteger > 0 then
    Result := True;
end;

end.
