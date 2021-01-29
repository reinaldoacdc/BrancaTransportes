unit Form.Carregamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Layouts, FMX.DateTimeCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox;

type
  TFormCarregamento = class(TForm)
    PersonalInfoList: TListBox;
    ItemLocal: TListBoxItem;
    LOCAL: TEdit;
    ItemProduto: TListBoxItem;
    PRODUTO: TEdit;
    ItemData: TListBoxItem;
    DATA: TDateEdit;
    ItemFrete: TListBoxItem;
    FRETE: TEdit;
    ItemPeso: TListBoxItem;
    PESO: TEdit;
    ItemKmInicio: TListBoxItem;
    KM_INICIO: TEdit;
    ItemKmFinal: TListBoxItem;
    KM_CHEGADA: TEdit;
    Layout1: TLayout;
    ListBox1: TListBox;
    ItemTotalKm: TListBoxItem;
    TOTAL_KM: TEdit;
    ItemTotalFrete: TListBoxItem;
    TOTAL_FRETE: TEdit;
    Layout2: TLayout;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    procedure SpeedButton2Click(Sender: TObject);
    procedure KM_CHEGADAExit(Sender: TObject);
    procedure PESOExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Fid: Integer;
    procedure Carregar;
    procedure Salvar;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Id :Integer read Fid write Fid;
  end;

var
  FormCarregamento: TFormCarregamento;

implementation

{$R *.fmx}

uses Controller.API, Form.Main, Model.Entity.CADASTRO_CARREGAMENTO,
  UdmMain;

{ TFormCarregamento }

procedure TFormCarregamento.Carregar;
begin
  if Self.Id > 0 then
  begin
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

constructor TFormCarregamento.Create(AOwner: TComponent);
begin
  inherited;
  Self.Id := FormMain.IdCarregamentoSelecionado;
  Carregar;
end;

procedure TFormCarregamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormCarregamento.KM_CHEGADAExit(Sender: TObject);
var valor :Double;
begin
  valor :=  StrToFloat(KM_CHEGADA.Text) - StrToFloat(KM_INICIO.Text);
  TOTAL_KM.Text := FloatToStr(valor);
end;

procedure TFormCarregamento.PESOExit(Sender: TObject);
var valor :Double;
begin
  valor := StrToFloat( PESO.Text ) * StrToFloat(FRETE.Text) ;
  TOTAL_FRETE.Text := FloatToStr(valor);
end;

procedure TFormCarregamento.Salvar;
var valor :Double;
begin
  valor := StrToFloat( PESO.Text ) * StrToFloat(FRETE.Text) ;
  TOTAL_FRETE.Text := FloatToStr(valor);

  valor :=  StrToFloat(KM_CHEGADA.Text) - StrToFloat(KM_INICIO.Text);
  TOTAL_KM.Text := FloatToStr(valor);

  if not(DmMain.tbCarregamento.Active) then
    dmMain.tbCarregamento.Open;


  DMMAIN.tbCarregamento.Insert;

  DmMain.tbCarregamentoCODIGO.AsInteger := DmMain.Maximo('CADASTRO_CARREGAMENTO')+1;
  //DmMain.tbCarregamentoSINCRONIZZADO.AsString       := 'N';
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

procedure TFormCarregamento.SpeedButton2Click(Sender: TObject);
begin
  Salvar;
  Self.Close;
end;

end.
