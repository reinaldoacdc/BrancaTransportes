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
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
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
    procedure FormShow(Sender: TObject);
    procedure btnCarregamentosClick(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure ListBoxItem6Click(Sender: TObject);
    procedure FrameStand2BeforeShow(const ASender: TSubjectStand;
      const ASubjectInfo: TSubjectInfo);
    procedure FormCreate(Sender: TObject);
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
  uDespesaExtra, Frame.ListaCarregamento, Frames.Dataset, Controller.API,
  Frame.Carregamento;

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
  LoadFrame<TFrameMenu>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.LoadDatasetModal(ClientdataSet: TClientDataSet);
var   LFrameInfo: TFrameInfo<TDatasetFrame>;
begin
  FrameStand1.HideAndCloseAll();
  FrameStand2.HideAndCloseAll();
  LFrameInfo := FrameStand2.New<TDatasetFrame>;

  LFrameInfo.Frame.DataSet := ClientDataSet;
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

  objAPI.ListaCarregamentos;
end;

procedure TFormMain.ListBoxItem2Click(Sender: TObject);
begin
  LoadFrame<TFrameInstitucional>;
end;

procedure TFormMain.ListBoxItem3Click(Sender: TObject);
begin
  LoadFrame<TFrameParceiros>;
end;

procedure TFormMain.ListBoxItem4Click(Sender: TObject);
begin
  LoadFrame<TFrameDespesas>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.ListBoxItem5Click(Sender: TObject);
begin
  LoadFrame<TFrameDespesasExtras>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.ListBoxItem6Click(Sender: TObject);
begin
  LoadFrame<TFrameParceiros>;
end;

end.
