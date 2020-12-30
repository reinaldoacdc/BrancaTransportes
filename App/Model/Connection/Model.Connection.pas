unit Model.Connection;

interface

uses
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  System.Generics.Collections;

var
  FDriver : TFDPhysFBDriverLink;
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(Index : Integer);

implementation

uses System.IOUtils, uConfigINI;

function Connected : Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);

  FConnList.Items[Result].LoginPrompt := False;
  FConnList.Items[Result].Params.DriverID := 'SQLite';
  {$IFDEF Android}
  FConnList.Items[Result].Params.Database := TPath.Combine(TPath.GetDocumentsPath, 'DADOS.s3db');
  {$ELSE}
  FConnList.Items[Result].Params.Database := ConfigINI.AcessoBanco.Caminho;
  FConnList.Items[Result].Params.UserName := ConfigINI.AcessoBanco.Usuario;
  FConnList.Items[Result].Params.Password := ConfigINI.AcessoBanco.Senha;
  {$ENDIF}
  FConnList.Items[Result].Connected;
end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
  FConnList.TrimExcess;
end;

end.
