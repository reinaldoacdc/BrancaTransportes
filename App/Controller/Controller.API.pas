unit Controller.API;

interface

uses
 System.JSON, System.Net.HttpClientComponent;

type TApi = class(TObject)
private
  FNetHTTPClient :TNetHTTPClient;
  FNetHTTPRequest :TNetHTTPRequest;
  FJSonObject :TJSONObject;
protected

public

  function Login(username, password :String) :Boolean;
  procedure ListaCarregamentos;

  constructor Create; overload;
  destructor Destroy; override;

published

end;

var
  objAPI :TApi;

implementation

uses REST.Json, System.Classes, System.SysUtils, Form.Main, Model.Carregamento;

{ TApi }

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

procedure TApi.ListaCarregamentos;
var
  Url, JSonData   : String;
  JsonStream :TStream;
  item: TJSONObject;
  a: TJSONArray;
  jv: TJSONValue;
  idx, idy :Integer;
  ArrayElement: TJSonValue;
  LResult: TJSONArray;
  carga :TCarregamento;
begin

   if not (FormMain.ClientDataSet1.Active) then
    FormMain.ClientDataSet1.CreateDataSet
  else
    FormMain.ClientDataSet1.EmptyDataSet;



  Url := 'http://192.168.15.184:9000/carregamentos';
  JsonStream := FNetHTTPRequest.Get(Url).ContentStream;
  JSonData := FNetHTTPRequest.Get(Url).ContentAsString;

  FJSonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonData),0) as TJSONObject;
  try

    a := TJSONArray(FJSonObject.GetValue('result'));
    for idx := 0 to pred(a.size) do begin


      item := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(a.Items[idx].Value), 0)  as TJSONObject;

        FormMain.ClientDataSet1.Append;
        FormMain.ClientDataSet1ID.AsInteger := 13;
        FormMain.ClientDataSet1LOCAL.AsString   := item.Pairs[0].JsonValue.ToString;
        FormMain.ClientDataSet1PRODUTO.AsString := item.Pairs[2].JsonValue.ToString;
        FormMain.ClientDataSet1.Post;

    end;
  finally
    //FJSonObject.Free;
  end;
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
