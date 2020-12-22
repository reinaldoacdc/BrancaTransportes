unit Frame.Carregamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FMX.Layouts, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.ImageList, FMX.ImgList;

type
  TFrameCarregamento = class(TFrame)
    PersonalInfoList: TListBox;
    ItemLocal: TListBoxItem;
    LOCAL: TEdit;
    ItemProduto: TListBoxItem;
    PRODUTO: TEdit;
    ItemData: TListBoxItem;
    DATA: TDateEdit;
    Layout1: TLayout;
    ListBox1: TListBox;
    ItemTotalFrete: TListBoxItem;
    TOTAL_FRETE: TEdit;
    ItemTotalKm: TListBoxItem;
    TOTAL_KM: TEdit;
    ItemPeso: TListBoxItem;
    PESO: TEdit;
    ItemFrete: TListBoxItem;
    FRETE: TEdit;
    ItemKmInicio: TListBoxItem;
    KM_INICIO: TEdit;
    ItemKmFinal: TListBoxItem;
    KM_CHEGADA: TEdit;
    Layout2: TLayout;
    ImageList1: TImageList;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure DATAExit(Sender: TObject);
  private
    Fid: Integer;
    procedure Carregar;
    procedure Salvar;
  public
    constructor Create(AOwner: TComponent); override;

  published
    property Id :Integer read Fid write Fid;
  end;

implementation

{$R *.fmx}

uses Controller.API, Form.Main, Frame.Menu, Model.Entity.CADASTRO_CARREGAMENTO;

procedure TFrameCarregamento.Carregar;
var carregamento :TCADASTRO_CARREGAMENTO;
begin
  if Self.Id > 0 then
  begin
    carregamento :=  objAPI.getCarregamento(Self.Id);

    LOCAL.Text      := carregamento.LOCAL_CARREGAMENTO;
    PRODUTO.Text    := carregamento.PRODUTO_CARREGADO;
    DATA.Text       := DateToStr( carregamento.DATA_CARREGAMENTO );
    FRETE.Text      := FloatToStr( carregamento.FRETE_TONELADA );
    PESO.Text       := FloatToStr( carregamento.PESO_LIQ_CARGA );
    KM_INICIO.Text  := FloatToStr( carregamento.KM_INICIO );
    KM_CHEGADA.Text := FloatToStr( carregamento.KM_CHEGADA );
  end;
end;

constructor TFrameCarregamento.Create(AOwner: TComponent);
begin
  inherited;
  Self.Id := FormMain.IdCarregamentoSelecionado;
  Carregar;
end;

procedure TFrameCarregamento.DATAExit(Sender: TObject);
begin
  FRETE.SetFocus;
end;

procedure TFrameCarregamento.Salvar;
var carregamento :TCADASTRO_CARREGAMENTO;
begin
//
  carregamento := TCADASTRO_CARREGAMENTO.Create;
  carregamento.CODIGO := Self.Id;
  carregamento.DATA_CARREGAMENTO := DATA.Date;
  carregamento.LOCAL_CARREGAMENTO := LOCAL.Text;
  carregamento.PESO_LIQ_CARGA := StrToFloat( PESO.Text );
  carregamento.FRETE_TONELADA := StrToFloat( FRETE.Text );
  //carregamento.TOTAL_FRETE  := StrToFloat( TOTAL_FRETE.Text );
  carregamento.KM_INICIO :=  StrToFloat( KM_INICIO.Text );
  carregamento.KM_CHEGADA := StrToFloat( KM_CHEGADA.Text );

  if Self.Id = 0 then
    objApi.postCarregamento(carregamento)
  else
    objApi.putCarregamento(carregamento);
end;

procedure TFrameCarregamento.SpeedButton1Click(Sender: TObject);
begin
  Salvar;
  FormMain.LoadFrame<TFrameMenu>;
end;

end.
