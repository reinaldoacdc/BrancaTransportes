unit Frame.ListaCarregamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Data.DB, Datasnap.DBClient, FMX.Controls.Presentation;

type
  TFrameListaCarregamento = class(TFrame)
    ListView1: TListView;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1ID: TIntegerField;
    ClientDataSet1LOCAL: TStringField;
    ClientDataSet1PRODUTO: TStringField;
    ClientDataSet1DATA: TDateField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main;

procedure TFrameListaCarregamento.Button1Click(Sender: TObject);
begin
  if not (ClientDataSet1.Active) then
    ClientDataSet1.CreateDataSet;

  ClientDataSet1.Append;
  ClientDataSet1ID.AsInteger := 13;
  ClientDataSet1LOCAL.AsString := 'São Paulo';
  ClientDataSet1PRODUTO.AsString := 'Arroz';
  ClientDataSet1DATA.AsDateTime := Date;
  ClientDataSet1.Post;

  ClientDataSet1.Append;
  ClientDataSet1ID.AsInteger := 27;
  ClientDataSet1LOCAL.AsString := 'Rio';
  ClientDataSet1PRODUTO.AsString := 'Feijão';
  ClientDataSet1DATA.AsDateTime := Date()-10;
  ClientDataSet1.Post;

end;

procedure TFrameListaCarregamento.ListView1DblClick(Sender: TObject);
begin
  Self.Hide;
  FormMain.FrameStand2.HideAndCloseAll();
end;

end.
