program ServerBrancaTransportes;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse, Horse.Jhonson, System.JSON;

begin
  THorse.Use(Jhonson);



  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);


  THorse.Get('/login',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LBody: TJSONObject;
      user, password :String;

    begin
      LBody := TJSONObject.Create;
      user := Req.Query.ExtractPair('user').Value;
      password := Req.Query.ExtractPair('password').Value;


      LBody.AddPair(TJSONPair.Create('body', Req.Body));
      LBody.AddPair(TJSONPair.Create('access', user ));
      Res.Send<TJSONObject>(LBody);
    end);




  THorse.Listen(9000);
end.
