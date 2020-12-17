unit Controller.Carregamento;

interface

uses Horse, System.JSON, REST.Json, Model.Entity.CADASTRO_CARREGAMENTO;

procedure Registry(App : THorse);
procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Encriptacao, uDAO, System.SysUtils, Model.DaoGeneric;

procedure Registry(App : THorse);
begin
  App.Get('/login', Login);

  App.Get('/carregamentos', Get);
  App.Get('/carregamento/:id', GetID);
  App.Post('/carregamento', Insert);
  App.Put('/carregamento/', Update);
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
  FDAO : iDAOGeneric<TCADASTRO_CARREGAMENTO>;
begin
  FDAO := TDAOGeneric<TCADASTRO_CARREGAMENTO>.New;
  Res.Send<TJSonArray>(FDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TCADASTRO_CARREGAMENTO>;
begin
  FDAO := TDAOGeneric<TCADASTRO_CARREGAMENTO>.New;
  Res.Send<TJSONObject>(FDAO.Find(Req.Params.Items['id']));
end;


procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TCADASTRO_CARREGAMENTO>;
  Json :TJSONObject;
  json_str :String;
  carga :TCADASTRO_CARREGAMENTO;
begin
  FDAO := TDAOGeneric<TCADASTRO_CARREGAMENTO>.New;
  carga := Req.Body<TCADASTRO_CARREGAMENTO>;

  //carga := TJson.JsonToObject(Req.Body<TCADASTRO_CARREGAMENTO>);


  //json_str := TJson.ObjectToJsonString (carga, [TJsonOption. ] );
  json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(carga.ToString), 0) as TJSONObject;
  //json.Parse(BytesOf(carga.ToString), 0);  //TJson.ObjectToJsonObject(carga);  //carga.ToJSONObject;

  WriteLn('--');
  WriteLn('carga: - ' + carga.ToString);
  WriteLn('--');
  WriteLn('json: - ' + json.ToString);
  try
    FDAO.Insert( json );

  except on E :Exception do
    Writeln(E.Message);
  end;
  Res.Send<TJSONObject>( json );
end;


procedure uPDATE(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TCADASTRO_CARREGAMENTO>;
  Json :TJSONObject;
  json_str :String;
  carga :TCADASTRO_CARREGAMENTO;
begin
  FDAO := TDAOGeneric<TCADASTRO_CARREGAMENTO>.New;
  carga := Req.Body<TCADASTRO_CARREGAMENTO>;

  //carga := TJson.JsonToObject(Req.Body<TCADASTRO_CARREGAMENTO>);


  //json_str := TJson.ObjectToJsonString (carga, [TJsonOption. ] );
  json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(carga.ToString), 0) as TJSONObject;
  //json.Parse(BytesOf(carga.ToString), 0);  //TJson.ObjectToJsonObject(carga);  //carga.ToJSONObject;

  WriteLn('--');
  WriteLn('carga: - ' + carga.ToString);
  WriteLn('--');
  WriteLn('json: - ' + json.ToString);
  try
    FDAO.Update( json );

  except on E :Exception do
    Writeln(E.Message);
  end;
  Res.Send<TJSONObject>( json );
end;

end.
