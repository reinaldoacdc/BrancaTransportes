program ServerBrancaTransportes;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  REST.Json,
  Horse,
  Horse.Jhonson,
  System.JSON,
  Encriptacao in 'Classes\Encriptacao.pas',
  uConfigINI in 'Classes\uConfigINI.pas',
  uDAO in 'Classes\uDAO.pas',
  Model.Carregamento in 'Model.Carregamento.pas';

begin
  THorse.Use(Jhonson);



  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      dao :TDao;
    begin

      try
        dao := TDao.Create;

        Res.Send('pong');
      finally
        dao.Free;
      end;

    end);


  THorse.Get('/login',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
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
    end);


  THorse.Get('/carregamentos',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
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
    end);


  THorse.Listen(9000);
end.
