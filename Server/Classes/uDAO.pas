unit uDAO;

interface

uses System.SysUtils
   , FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB , Firedac.Comp.Client
   , Model.Carregamento;

type TDadosAcesso = record
  Servidor :String;
  Caminho :String;
  Usuario :String;
  Senha :String;
end;

type TDao = class(TObject)
private
  FDPhysFBDriverLink: TFDPhysFBDriverLink;
  Fparams :TDadosAcesso;
  Fquery :TFDQuery;

  procedure AbreBanco;
  procedure FechaBanco;
protected
  Fconnection :TFDConnection;
public
  function Login(username, password :String) :Boolean;
  function ListaCarregamento :TCarregamentos;
  function getCarregamento(id :Integer) :TCarregamento;

  constructor Create; overload;
  constructor Create(params :TDadosAcesso); overload;
  destructor Destroy; override;
  
published

end;

implementation

  uses Variants, uConfigINI, Encriptacao;

{ TDao }

procedure TDao.AbreBanco;
begin
  Fconnection.DriverName := 'FB';
  Fconnection.Params.Values['Server'] := Fparams.Servidor;
  Fconnection.Params.Database := Fparams.Caminho;
  Fconnection.Params.UserName := Fparams.Usuario;
  Fconnection.Params.Password := Fparams.Senha; //Crypt(crDecriptar, Fparams.Senha, kCh);

  Fconnection.Connected := True;
end;

constructor TDao.Create;
begin
  if Self.Fparams.Caminho = '' then
  begin
    Fparams.Servidor :=  ConfigINI.AcessoBanco.Servidor;
    Fparams.Caminho  :=  ConfigINI.AcessoBanco.Caminho;
    Fparams.Usuario  :=  ConfigINI.AcessoBanco.Usuario;
    Fparams.Senha    :=  ConfigINI.AcessoBanco.Senha;
  end;
  

  Fconnection := TFDConnection.Create(nil);
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);
  FDPhysFBDriverLink.VendorLib := 'FBCLIENT.DLL';
  Fquery := TFDQuery.Create(nil);
  Fquery.Connection := Fconnection;
  AbreBanco;
end;

constructor TDao.Create(params: TDadosAcesso);
begin
  Fparams := params;
  Self.Create();
end;

destructor TDao.Destroy;
begin
  FechaBanco;
  FreeAndNil(Fquery);
  FreeAndNil(Fconnection);
  inherited;
end;

procedure TDao.FechaBanco;
begin
  Fconnection.Connected := False;
end;

function TDao.getCarregamento(id: Integer): TCarregamento;
begin
  Fquery.SQL.Text := Format( 'SELECT LOCAL_CARREGAMENTO, DATA_CARREGAMENTO, PRODUTO_CARREGADO FROM CADASTRO_CARREGAMENTO WHERE CODIGO = %d', [id]);
  Fquery.Open;

  Result    := TCarregamento.Create( Fquery.FieldByName('LOCAL_CARREGAMENTO').AsString
                                   , Fquery.FieldByName('DATA_CARREGAMENTO').AsString
                                   , Fquery.FieldByName('PRODUTO_CARREGADO').AsString
                                       );
end;

function TDao.ListaCarregamento: TCarregamentos;
var I :Integer;
begin

  Fquery.SQL.Text := 'SELECT LOCAL_CARREGAMENTO, DATA_CARREGAMENTO, PRODUTO_CARREGADO FROM CADASTRO_CARREGAMENTO';
  Fquery.Open;

  SetLength(Result, Fquery.RecordCount );
  for I := 0 to Fquery.RecordCount-1 do
  begin
    Result[I] := TCarregamento.Create( Fquery.FieldByName('LOCAL_CARREGAMENTO').AsString
                                     , Fquery.FieldByName('DATA_CARREGAMENTO').AsString
                                     , Fquery.FieldByName('PRODUTO_CARREGADO').AsString

                                         );
    Fquery.Next;
  end;


end;

function TDao.Login(username, password: String): Boolean;
begin
  Result := False;
  Fquery.SQL.Text := Format('SELECT CODIGO FROM USUARIOS WHERE LOGIN = ''%s'' AND SENHA = ''%s'' ;',
                            [username, password]);
  Fquery.Open;

  if Fquery.Fields[0].AsInteger > 0 then
    Result := True;
end;

end.
