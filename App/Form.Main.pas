unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.StdCtrls, FMX.ListBox, FMX.Layouts, SubjectStand, FrameStand, FMX.Objects,
  System.Actions, FMX.ActnList, Data.DB, Datasnap.DBClient;

type
  TFormMain = class(TForm)
    MultiView1: TMultiView;
    ImageList1: TImageList;
    ListBox1: TListBox;
    btnCarregamentos: TListBoxItem;
    btnInsitucional: TListBoxItem;
    btnParceiros: TListBoxItem;
    btnDespesas: TListBoxItem;
    btnDespesaExtra: TListBoxItem;
    btnConfiguracao: TListBoxItem;
    FrameStand1: TFrameStand;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    FrameStand2: TFrameStand;
    ActionList1: TActionList;
    StyleBook1: TStyleBook;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1ID: TIntegerField;
    ClientDataSet1LOCAL: TStringField;
    ClientDataSet1PRODUTO: TStringField;
    ClientDataSet1DATA: TDateField;
    ClientDataSet1LOCAL_CARREGAMENTO: TStringField;
    ClientDataSet1PRODUTO_CARREGADO: TStringField;
    ClientDataSet1CODIGO: TIntegerField;
    btnMenu: TListBoxItem;
    btnSincronizar: TListBoxItem;
    Layout2: TLayout;
    Label1: TLabel;
    USUARIO: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCarregamentosClick(Sender: TObject);
    procedure btnInsitucionalClick(Sender: TObject);
    procedure btnParceirosClick(Sender: TObject);
    procedure btnDespesasClick(Sender: TObject);
    procedure btnDespesaExtraClick(Sender: TObject);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure FrameStand2BeforeShow(const ASender: TSubjectStand;
      const ASubjectInfo: TSubjectInfo);
    procedure FormCreate(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure MultiView1StartShowing(Sender: TObject);
  private
    FloginSucessfull: Boolean;
    FidCarregamentoSelecionado: Integer;
    FframeSelecionado: String;

    procedure LoadDatasetModal(ClientdataSet :TClientDataSet);

    procedure ListarCdsCarregamentos;
  public
    procedure LoadFrame<T :TFrame>;
    procedure LoadListatem(Tela :String);
  published
    property LoginSucessfull :Boolean read FloginSucessfull write FloginSucessfull default False;
    property IdCarregamentoSelecionado :Integer read FidCarregamentoSelecionado write FidCarregamentoSelecionado default 0;
    property FrameSelecionado :String read FframeSelecionado write FframeSelecionado;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses Frame.Menu, uInstitucional, uParceiros, Frame.Login, Frame.Despesa,
  Frame.DespesaExtra, Frame.ListaCarregamento, Frames.Dataset, Controller.API,
  Frame.Carregamento, Frame.Configuracao, UdmMain, Frame.Sincronismo,
  uConfigINI;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FrameStand2.CommonActions.Add('Close*',
    procedure (AInfo: TSubjectInfo)
    begin
      AInfo.Hide();
    end
  );
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  if ConfigINI.AcessoBanco.OperadorNome = '' then
    LoadFrame<TFrameLogin>
  else
    LoadFrame<TFrameMenu>;
end;

procedure TFormMain.LoadDatasetModal(ClientdataSet: TClientDataSet);
var   LFrameInfo: TFrameInfo<TDatasetFrame>;
begin
  FrameStand1.HideAndCloseAll();
  FrameStand2.HideAndCloseAll();
  LFrameInfo := FrameStand2.New<TDatasetFrame>;


  LFrameInfo.Frame.DataSet :=  ClientDataSet;
  LFrameInfo.Frame.ItemTextField := 'LOCAL_CARREGAMENTO';
  LFrameInfo.Frame.DetailField := 'PRODUTO_CARREGADO';


  LFrameInfo.Show;
  MultiView1.HideMaster;

end;

procedure TFormMain.LoadFrame<T>;
var
  LFrameInfo: TFrameInfo<T>;
begin
  FrameStand1.HideAndCloseAll();
  LFrameInfo := FrameStand1.New<T>(Layout1);
  LFrameInfo.Show;
  MultiView1.HideMaster;
end;

procedure TFormMain.LoadListatem(Tela :String);
begin
  Self.FrameSelecionado := Tela;

  ListarCdsCarregamentos;
  LoadDatasetModal(ClientDataSet1);
end;

procedure TFormMain.MultiView1StartShowing(Sender: TObject);
begin
  USUARIO.Text := ConfigINI.AcessoBanco.OperadorNome;
end;

procedure TFormMain.FrameStand2BeforeShow(const ASender: TSubjectStand;
  const ASubjectInfo: TSubjectInfo);
var
  LContentBackground: TRectangle;
  LTenPercent: Single;
begin
  LTenPercent := 0;
  if ASubjectInfo.Parent is TCustomForm then
    LTenPercent := TCustomForm(ASubjectInfo.Parent).Width / 10
  else if ASubjectInfo.Parent is TControl then
    LTenPercent := TControl(ASubjectInfo.Parent).Width / 10;

  LContentBackground := ASubjectInfo.Stand.FindStyleResource('content_background') as TRectangle;

  if Assigned(LContentBackground) then
    LContentBackground.Margins.Rect := TRectF.Create(LTenPercent, LTenPercent
    , LTenPercent, LTenPercent);

end;

procedure TFormMain.btnCarregamentosClick(Sender: TObject);
begin
  LoadListatem('CARREGAMENTO');
end;

procedure TFormMain.ListarCdsCarregamentos;
begin
   if not (ClientDataSet1.Active) then
    ClientDataSet1.CreateDataSet
  else
    ClientDataSet1.EmptyDataSet;

  //objAPI.ListaCarregamentos;

  DmMain.tbCarregamento.Open;
  DmMain.tbCarregamento.First;
  WHILE NOT DmMain.tbCarregamento.Eof do
  begin
    ClientDataSet1.Insert;
    ClientDataSet1ID.AsInteger := DmMain.tbCarregamentoCODIGO.AsInteger;
    ClientDataSet1CODIGO.AsInteger := DmMain.tbCarregamentoCODIGO.AsInteger;
    ClientDataSet1LOCAL_CARREGAMENTO.AsString := DmMain.tbCarregamentoLOCAL_CARREGAMENTO.AsString;
    ClientDataSet1PRODUTO_CARREGADO.AsString := DmMain.tbCarregamentoPRODUTO_CARREGADO.AsString;
    ClientDataSet1.Post;

    DmMain.tbCarregamento.Next;
  end;
end;

procedure TFormMain.btnInsitucionalClick(Sender: TObject);
begin
  LoadFrame<TFrameInstitucional>;
end;

procedure TFormMain.btnMenuClick(Sender: TObject);
begin
  LoadFrame<TFrameMenu>;
end;

procedure TFormMain.btnParceirosClick(Sender: TObject);
begin
  LoadFrame<TFrameParceiros>;
end;

procedure TFormMain.btnSincronizarClick(Sender: TObject);
begin
  LoadFrame<TFrameSincronismo>;
end;

procedure TFormMain.btnDespesasClick(Sender: TObject);
begin
  LoadFrame<TFrameDespesas>;
end;

procedure TFormMain.btnDespesaExtraClick(Sender: TObject);
begin
  LoadFrame<TFrameDespesasExtras>;
end;

procedure TFormMain.btnConfiguracaoClick(Sender: TObject);
begin
  LoadFrame<TFrameConfiguracoes>;
end;

end.
