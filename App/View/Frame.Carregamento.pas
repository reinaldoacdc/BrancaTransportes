unit Frame.Carregamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FMX.Layouts;

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
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    Fid: Integer;
    procedure Carregar;
  public
    constructor Create(AOwner: TComponent); override;

  published
    property Id :Integer read Fid write Fid;
  end;

implementation

{$R *.fmx}

uses Controller.API, Model.Carregamento, Form.Main, uMenu;

procedure TFrameCarregamento.Carregar;
var carregamento :TCarregamento;
begin
  carregamento :=  objAPI.getCarregamento(Self.Id);

  LOCAL.Text := carregamento.Local;
  PRODUTO.Text := carregamento.Produto;
  DATA.Text := carregamento.Data;
  FRETE.Text := carregamento.Frete;
  PESO.Text := carregamento.Peso;
  KM_INICIO.Text := carregamento.KmInicio;
  KM_CHEGADA.Text := carregamento.KmFinal;
end;

constructor TFrameCarregamento.Create(AOwner: TComponent);
begin
  inherited;
  Self.Id := FormMain.IdCarregamentoSelecionado;
  Carregar;
end;

procedure TFrameCarregamento.SpeedButton1Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameMenu>;
end;

end.
