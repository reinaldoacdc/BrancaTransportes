unit uConfigINI;

interface

uses Classes, SysUtils, IniFiles;

type
  TConfigIni = Class;

  TConfigIniBase = Class(TObject)
    private
      FOwner :TConfigIni;
    public
      constructor Create(AOwner :TConfigIni);
      property Owner :TconfigIni read FOwner;
  end;

  TConfigIniAcessoBanco = class(TConfigIniBase)
    private
      function getPathDB: String;
      procedure setPathDB(const Value: String);
    function getUsername: String;
    procedure setUsername(const Value: String);
    function getPassword: String;
    procedure setPassword(const Value: String);
    function getServidor: String;
    procedure setServidor(const Value: String);
    function getURL_API: String;
    procedure setURL_API(const Value: String);
    public
    published
        property URL_API :String read getURL_API write setURL_API;
        property Servidor :String read getServidor write setServidor;
        property Caminho :String read getPathDB write setPathDB;
        property Usuario :String read getUsername write setUsername;
        { TODO : Encrypt get and setter }
        property Senha :String read getPassword write setPassword;
  end;


  TConfigIni = Class(TIniFile)
      private
        FAcessoBanco :TConfigIniAcessoBanco;
    function getAcessoBanco: TConfigIniAcessoBanco;
      public
      published
        property AcessoBanco :TConfigIniAcessoBanco read getAcessoBanco;
  end;

var ConfigINI :TConfigIni;


implementation

uses System.IOUtils;

{ TConfigIniBase }

constructor TConfigIniBase.Create(AOwner: TConfigIni);
begin
  FOwner := AOwner;
end;

{ TConfigIniAcessoBanco }


function TConfigIniAcessoBanco.getPassword: String;
begin
  Result := Owner.ReadString('AcessoBanco', 'Password', '');
end;

function TConfigIniAcessoBanco.getPathDB: String;
begin
  Result := Owner.ReadString('AcessoBanco', 'PathDB', '');
end;

function TConfigIniAcessoBanco.getServidor: String;
begin
  Result := Owner.ReadString('AcessoBanco', 'Servidor', '');
end;

function TConfigIniAcessoBanco.getURL_API: String;
begin
  Result := Owner.ReadString('AcessoBanco', 'URL_API', '');
end;

function TConfigIniAcessoBanco.getUsername: String;
begin
  Result := Owner.ReadString('AcessoBanco', 'Username', '');
end;

procedure TConfigIniAcessoBanco.setPassword(const Value: String);
begin
  Owner.WriteString('AcessoBanco', 'Password', Value);
end;

procedure TConfigIniAcessoBanco.setPathDB(const Value: String);
begin
  Owner.WriteString('AcessoBanco', 'PathDB', Value);
end;

procedure TConfigIniAcessoBanco.setServidor(const Value: String);
begin
  Owner.WriteString('AcessoBanco', 'Servidor', Value);
end;

procedure TConfigIniAcessoBanco.setURL_API(const Value: String);
begin
  Owner.WriteString('AcessoBanco', 'URL_API', Value);
end;

procedure TConfigIniAcessoBanco.setUsername(const Value: String);
begin
  Owner.WriteString('AcessoBanco', 'Username', Value);
end;

{ TConfigIni }

function TConfigIni.getAcessoBanco: TConfigIniAcessoBanco;
begin
  Result := TConfigIniAcessoBanco.Create(Self);
end;

initialization
{$IFDEF Android}
  ConfigINI := TConfigINI.Create(System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim + 'config.ini');

{$ELSE}
  ConfigINI := TConfigINI.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
{$ENDIF}

finalization
  FreeAndNil(ConfigINI);

end.
