unit Controller.Carregamento;

interface

uses Horse, System.JSON, REST.Json
  , Model.Carregamento;

procedure Registry(App : THorse);
procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Encriptacao, uDAO, System.SysUtils;

procedure Registry(App : THorse);
begin
  App.Get('/login', Login);

  App.Get('/carregamentos', Get);
  App.Get('/carregamento/:id', GetID);
//  App.Post('/produto', Insert);
//  App.Put('/produto/:id', Update);
//  App.Delete('/produto/:id', Delete);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LBody: TJSONObject;

  user, password, teste, senha :String;
  access :Boolean;
  dao :TDao;
begin
  LBody := TJSONObject.Create;
  user := Req.Query.ExtractPair('user').Value;
  password := Crypt('C', Req.Query.ExtractPair('password').Value);


  dao := TDao.Create;
  try
    access := dao.Login(user, password);

    LBody.AddPair(TJSONPair.Create('body', Req.Body));
    LBody.AddPair(TJSONPair.Create('access', BoolToStr(access, True) ));
    Res.Send<TJSONObject>(LBody);
  finally
    dao.Free;
  end;

end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LBody: TJSONObject;
  LArray :TJSONArray;
  dao :TDao;
  lista :TCarregamentos;
  I: Integer;
begin
  LBody := TJSONObject.Create;
  LArray := TJSONArray.Create;

  dao := TDao.Create;
  try
    lista := dao.ListaCarregamento;

    for I := 0 to Length(lista)-1 do
    begin
     LArray.Add( TJson.ObjectToJsonString(lista[I]) );
    end;

    LBody.AddPair(TJSONPair.Create('result', LArray));
    Res.Send<TJSONObject>(LBody);
  finally
    dao.Free;
  end;

end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LBody: TJSONObject;
  dao :TDao;
  id :Integer;
  carga :TCarregamento;
begin
  id := StrToInt( Req.Query.ExtractPair('id').Value );
  LBody := TJSONObject.Create;
  dao := TDao.Create;
  try
    carga := dao.getCarregamento(id);
    Lbody := TJson.ObjectToJsonObject(carga);
    Res.Send<TJSONObject>(LBody);
  finally
    dao.Free;
  end;

end;

end.
