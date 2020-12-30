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
    procedure KM_CHEGADAExit(Sender: TObject);
    procedure PESOExit(Sender: TObject);
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

uses Controller.API, Form.Main, Frame.Menu, Model.Entity.CADASTRO_CARREGAMENTO,
  UdmMain;

procedure TFrameCarregamento.Carregar;
var carregamento :TCADASTRO_CARREGAMENTO;
begin
  if Self.Id > 0 then
  begin
//    carregamento :=  objAPI.getCarregamento(Self.Id);
//
//    LOCAL.Text      := carregamento.LOCAL_CARREGAMENTO;
//    PRODUTO.Text    := carregamento.PRODUTO_CARREGADO;
//    DATA.Text       := DateToStr( carregamento.DATA_CARREGAMENTO );
//    FRETE.Text      := FloatToStr( carregamento.FRETE_TONELADA );
//    PESO.Text       := FloatToStr( carregamento.PESO_LIQ_CARGA );
//    KM_INICIO.Text  := FloatToStr( carregamento.KM_INICIO );
//    KM_CHEGADA.Text := FloatToStr( carregamento.KM_CHEGADA );

    DmMain.qrCarregamento.Close;
    DmMain.qrCarregamento.Params[0].Value := Self.Id;
    DmMain.qrCarregamento.Open;

    LOCAL.Text := Dmmain.qrCarregamentoLOCAL_CARREGAMENTO.AsString;
    PRODUTO.Text := DmMain.qrCarregamentoPRODUTO_CARREGADO.AsString;
    DATA.Date  := DmMain.qrCarregamentoDATA_CARREGAMENTO.AsDateTime;
    FRETE.Text := DmMain.qrCarregamentoFRETE_TONELADA.AsString;
    peso.Text := DmMain.qrCarregamentoPESO_LIQ_CARGA.AsString;
    KM_INICIO.Text := DmMain.qrCarregamentoKM_INICIO.AsString;
    KM_CHEGADA.Text := DmMain.qrCarregamentoKM_CHEGADA.AsString;


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

procedure TFrameCarregamento.KM_CHEGADAExit(Sender: TObject);
var valor :Double;
begin
  valor :=  StrToFloat(KM_CHEGADA.Text) - StrToFloat(KM_INICIO.Text);
  TOTAL_KM.Text := FloatToStr(valor);
end;

procedure TFrameCarregamento.PESOExit(Sender: TObject);
var valor :Double;
begin
  valor := StrToFloat( PESO.Text ) * StrToFloat(FRETE.Text) ;
  TOTAL_FRETE.Text := FloatToStr(valor);
end;

procedure TFrameCarregamento.Salvar;
var valor :Double;
//var carregamento :TCADASTRO_CARREGAMENTO;
begin
////
//  carregamento := TCADASTRO_CARREGAMENTO.Create;
//  carregamento.CODIGO := Self.Id;
//  carregamento.PRODUTO_CARREGADO := PRODUTO.Text;
//  carregamento.DATA_CARREGAMENTO := DATA.Date;
//  carregamento.LOCAL_CARREGAMENTO := LOCAL.Text;
//  carregamento.PESO_LIQ_CARGA := StrToFloat( PESO.Text );
//  carregamento.FRETE_TONELADA := StrToFloat( FRETE.Text );
//  carregamento.KM_INICIO :=  StrToFloat( KM_INICIO.Text );
//  carregamento.KM_CHEGADA := StrToFloat( KM_CHEGADA.Text );
//
//  carregamento.TOTAL_FRETE  := StrToFloat( TOTAL_FRETE.Text );
//  carregamento.TOTAL_KM_RODADOS     := StrToFloat(TOTAL_KM.Text);
//
//  if Self.Id = 0 then
//    objApi.postCarregamento(carregamento)
//  else
//    objApi.putCarregamento(carregamento);



  valor := StrToFloat( PESO.Text ) * StrToFloat(FRETE.Text) ;
  TOTAL_FRETE.Text := FloatToStr(valor);

  valor :=  StrToFloat(KM_CHEGADA.Text) - StrToFloat(KM_INICIO.Text);
  TOTAL_KM.Text := FloatToStr(valor);

  if not(DmMain.tbCarregamento.Active) then
    dmMain.tbCarregamento.Open;


  DMMAIN.tbCarregamento.Insert;

  DmMain.tbCarregamentoCODIGO.AsInteger := DmMain.Maximo('CADASTRO_CARREGAMENTO')+1;
  DMmAIN.tbCarregamentoDATA_CARREGAMENTO.AsDateTime := data.Date;
  DMmAIN.tbCarregamentoLOCAL_CARREGAMENTO.AsString  := LOCAL.Text;
  DmMain.tbCarregamentoPESO_LIQ_CARGA.AsFloat       := StrToFloat( PESO.Text );
  DmMain.tbCarregamentoFRETE_TONELADA.AsFloat       := StrToFloat( FRETE.Text );
  DmMain.tbCarregamentoTOTAL_FRETE.AsFloat          := StrToFloat( TOTAL_FRETE.Text );
  DmMain.tbCarregamentoKM_INICIO.AsFloat            := StrToFloat( KM_INICIO.Text );
  DmMain.tbCarregamentoKM_CHEGADA.AsFloat           := StrToFloat( KM_CHEGADA.Text );
  DmMain.tbCarregamentoTOTAL_KM_RODADOS.AsFloat     := StrToFloat(TOTAL_KM.Text);
  DmMain.tbCarregamentoPRODUTO_CARREGADO.AsString   := PRODUTO.Text;

  DMMAIN.tbCarregamento.Post;
  DmMain.FDConnection1.Commit;
end;

procedure TFrameCarregamento.SpeedButton1Click(Sender: TObject);
begin
  Salvar;
  FormMain.LoadFrame<TFrameMenu>;
end;

end.
