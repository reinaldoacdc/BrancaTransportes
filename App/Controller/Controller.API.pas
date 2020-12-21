unit Controller.API;

interface

uses Model.Entity.CADASTRO_CARREGAMENTO,
 System.JSON, System.Net.HttpClientComponent;

type TApi = class(TObject)
private
  FNetHTTPClient :TNetHTTPClient;
  FNetHTTPRequest :TNetHTTPRequest;
  FJSonObject :TJSONObject;
protected

public

  function Login(username, password :String) :Boolean;


  function ListaCarregamentos :TCADASTRO_CARREGAMENTO;
  function getCarregamento(id :Integer) :TCADASTRO_CARREGAMENTO;
  procedure postCarregamento(carregamento :TCADASTRO_CARREGAMENTO);
  procedure putCarregamento(carregamento :TCADASTRO_CARREGAMENTO);


  constructor Create; overload;
  destructor Destroy; override;

published

end;

const
  { TODO : Configurações - Base URL }
  BASE_URL = 'http://192.168.0.192:9000/';

var
  objAPI :TApi;

implementation

uses REST.Json, System.Classes, System.SysUtils, Form.Main,  Data.DB,
     REST.Response.Adapter;

{ TApi }

procedure JsonToDataset(aDataset : TDataSet; aJSON : string);
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

constructor TApi.Create;
begin
  inherited;
  FNetHTTPClient  := TNetHTTPClient.Create(nil);
  FNetHTTPRequest := TNetHTTPRequest.Create(nil);
  FNetHTTPRequest.Client := FNetHTTPClient;
end;

destructor TApi.Destroy;
begin
  FNetHTTPRequest.Free;
  inherited;
end;

function TApi.getCarregamento(id: Integer): TCADASTRO_CARREGAMENTO;
var
  Url, JSonData   : String;
begin
  Url := Format(BASE_URL + 'carregamento/%d', [id]);
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;

  FJSonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonData),0) as TJSONObject;

  Result := Tjson.JsonToObject<TCADASTRO_CARREGAMENTO>(FJSonObject);
end;

function TApi.ListaCarregamentos :TCADASTRO_CARREGAMENTO;
var
  Url, JSonData   : String;
begin
  Url := BASE_URL + 'carregamentos';
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;

  JsonToDataset(FormMain.ClientDataSet1, JSonData);
end;

function TApi.Login(username, password: String): Boolean;
var
  Url, JSonData   : String;
begin
  Url := Format(BASE_URL + 'login?user=%s&password=%s', [username, password]);
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;
  FJSonObject := TJSonObject.ParseJSONValue(JSonData) as TJSonObject;

  Result := StrToBool(FJSonObject.GetValue('access').Value);
end;

procedure TApi.postCarregamento(carregamento: TCADASTRO_CARREGAMENTO);
var
  Url, JSonData   : String;
begin
  Url := BASE_URL + 'carregamento';
  FNetHTTPClient.ContentType := 'application/json; charset=UTF-8';
  FNetHTTPRequest.Post( Url, TStringStream.Create(carregamento.ToJsonString)  );
end;

procedure TApi.putCarregamento(carregamento: TCADASTRO_CARREGAMENTO);
var
  Url, JSonData   : String;
begin
  Url := BASE_URL + 'carregamento';
  FNetHTTPClient.ContentType := 'application/json; charset=UTF-8';
  FNetHTTPRequest.Put( Url, TStringStream.Create(carregamento.ToJsonString)  );
end;

initialization
  objAPI := TApi.Create;

finalization
  objAPI.Free;

end.
