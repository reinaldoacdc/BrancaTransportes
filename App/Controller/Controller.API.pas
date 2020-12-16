unit Controller.API;

interface

uses Model.Carregamento,
 System.JSON, System.Net.HttpClientComponent;

type TApi = class(TObject)
private
  FNetHTTPClient :TNetHTTPClient;
  FNetHTTPRequest :TNetHTTPRequest;
  FJSonObject :TJSONObject;
protected

public

  function Login(username, password :String) :Boolean;


  function ListaCarregamentos :TCarregamentos;

  function getCarregamento(id :Integer) :TCarregamento;


  constructor Create; overload;
  destructor Destroy; override;

published

end;

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

function TApi.getCarregamento(id: Integer): TCarregamento;
var
  Url, JSonData   : String;
  item: TJSONObject;
  a: TJSONArray;
  idx :Integer;
  carga :TCarregamento;
begin
  Url := Format('http://192.168.15.184:9000/carregamento?id=%d', [id]);
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;

  FJSonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonData),0) as TJSONObject;

  Result := Tjson.JsonToObject<TCarregamento>(FJSonObject);
end;

function TApi.ListaCarregamentos :TCarregamentos;
var
  Url, JSonData   : String;
  item: TJSONObject;
  a: TJSONArray;
  idx :Integer;
  carga :TCarregamento;
begin
  Url := 'http://192.168.15.184:9000/carregamentos';
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;

  JsonToDataset(FormMain.ClientDataSet1, JSonData);

//  FJSonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonData),0) as TJSONObject;
//
//  a := TJSONArray(FJSonObject.GetValue('result'));
//  SetLength(Result, a.Count );
//  for idx := 0 to pred(a.size) do begin
//    item := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(a.Items[idx].Value), 0)  as TJSONObject;
//    carga := Tjson.JsonToObject<TCarregamento>(item);
//    Result[idx] := carga;
//  end;

end;

function TApi.Login(username, password: String): Boolean;
var
  Url, JSonData   : String;
begin
  Url := Format('http://192.168.15.184:9000/login?user=%s&password=%s', [username, password]);
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;
  FJSonObject := TJSonObject.ParseJSONValue(JSonData) as TJSonObject;

  Result := StrToBool(FJSonObject.GetValue('access').Value);
end;

initialization
  objAPI := TApi.Create;

finalization
  objAPI.Free;

end.
