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
    USUARIO: TLabel;
    Rectangle1: TRectangle;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    ScaledLayout1: TScaledLayout;
    ScrollBox2: TScrollBox;
    ScaledLayout2: TScaledLayout;
    GridLayout1: TGridLayout;
    Layout1: TLayout;
    btnNovoCarregamento: TRectangle;
    lblNovoCarregamento: TLabel;
    Layout3: TLayout;
    btnNovaDespesa: TRectangle;
    lblNovaDespesa: TLabel;
    Layout4: TLayout;
    btnNovaDespesaExtra: TRectangle;
    lblNovaDespesaExtra: TLabel;
    Layout5: TLayout;
    btnConfiguracoes: TRectangle;
    Label4: TLabel;
    procedure btnCarregamentosClick(Sender: TObject);
    procedure btnInsitucionalClick(Sender: TObject);
    procedure btnParceirosClick(Sender: TObject);
    procedure btnDespesasClick(Sender: TObject);
    procedure btnDespesaExtraClick(Sender: TObject);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure FrameStand2BeforeShow(const ASender: TSubjectStand;
      const ASubjectInfo: TSubjectInfo);
    procedure FormCreate(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure MultiView1StartShowing(Sender: TObject);
    procedure btnNovoCarregamentoClick(Sender: TObject);
    procedure btnNovaDespesaClick(Sender: TObject);
    procedure btnNovaDespesaExtraClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
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
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

uses uParceiros, Form.Login, Form.Despesa,
  Form.DespesaExtra, Frame.ListaCarregamento, Frames.Dataset, Controller.API,
  Form.Carregamento, Form.Configuracao, UdmMain, Form.Sincronismo,
  uConfigINI, Form.Institucional, Form.Parceiros;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FrameStand2.CommonActions.Add('Close*',
    procedure (AInfo: TSubjectInfo)
    begin
      AInfo.Hide();
    end
  );
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
  if not (Assigned(FormInstitucional)) then
    Application.CreateForm(TFormInstitucional, FormInstitucional);

  FormInstitucional.Show;
end;

procedure TFormMain.btnNovaDespesaClick(Sender: TObject);
begin
  if not (Assigned(FormDespesa)) then
    Application.CreateForm(TFormDespesa, FormDespesa);

  FormDespesa.Show;
end;

procedure TFormMain.btnNovaDespesaExtraClick(Sender: TObject);
begin
  if not (Assigned(FormDespesaExtra)) then
    Application.CreateForm(TFormDespesaExtra, FormDespesaExtra);
  FormDespesaExtra.Show;
end;

procedure TFormMain.btnNovoCarregamentoClick(Sender: TObject);
begin
  if ConfigINI.AcessoBanco.OperadorNome = '' then
  begin
    if not (Assigned(frmLogin)) then
      Application.CreateForm(TForm1, frmLogin);

    frmLogin.Show;
  end
  else
  begin
    if not (Assigned(FormCarregamento)) then
      Application.CreateForm(TFormCarregamento, FormCarregamento);
    FormCarregamento.Show;
  end;
end;

procedure TFormMain.btnParceirosClick(Sender: TObject);
begin
  if not (Assigned(FormParceiros)) then
    Application.CreateForm(TFormParceiros, FormParceiros);

  FormParceiros.Show;
end;

procedure TFormMain.btnSincronizarClick(Sender: TObject);
begin
  if not (Assigned(FormSincronismo)) then
    Application.CreateForm(TFormSincronismo, FormSincronismo);

  FormSincronismo.Show;
end;

procedure TFormMain.btnDespesasClick(Sender: TObject);
begin
  if not (Assigned(FormDespesa)) then
    Application.CreateForm(TFormDespesa, FormDespesa);

  FormDespesa.Show;
end;

procedure TFormMain.btnDespesaExtraClick(Sender: TObject);
begin
  if not (Assigned(FormDespesaExtra)) then
    Application.CreateForm(TFormDespesaExtra, FormDespesaExtra);
  FormDespesaExtra.Show;
end;

procedure TFormMain.btnConfiguracaoClick(Sender: TObject);
begin
  if not (Assigned(FormConfiguracao)) then
    Application.CreateForm(TFormConfiguracao, FormConfiguracao);
  FormConfiguracao.Show;
end;

procedure TFormMain.btnConfiguracoesClick(Sender: TObject);
begin
  if not (Assigned(FormConfiguracao)) then
    Application.CreateForm(TFormConfiguracao, FormConfiguracao);
  FormConfiguracao.Show;
end;

end.
