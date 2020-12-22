unit Controller.Despesa;

interface

uses Horse, System.JSON, REST.Json, Model.Entity.CADASTRO_DESPESAS;

procedure Registry(App : THorse);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses System.SysUtils, Model.DaoGeneric;

procedure Registry(App : THorse);
begin

  App.Post('/despesa', Insert);
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDAO : iDAOGeneric<TCADASTRO_DESPESAS>;
  Json :TJSONObject;
  json_str :String;
  carga :TCADASTRO_DESPESAS;
begin
  FDAO := TDAOGeneric<TCADASTRO_DESPESAS>.New;
  carga := Req.Body<TCADASTRO_DESPESAS>;

  //carga := TJson.JsonToObject(Req.Body<TCADASTRO_CARREGAMENTO>);


  //json_str := TJson.ObjectToJsonString (carga, [TJsonOption. ] );
  json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(carga.ToString), 0) as TJSONObject;
  //json.Parse(BytesOf(carga.ToString), 0);  //TJson.ObjectToJsonObject(carga);  //carga.ToJSONObject;

  WriteLn('--');
  //WriteLn('carga: - ' + carga.ToString);
  //WriteLn('--');
  //WriteLn('json: - ' + json.ToString);
  try
    FDAO.Insert( carga );

  except on E :Exception do
    Writeln(E.Message);
  end;
  Res.Send<TJSONObject>( json );
end;

end.
