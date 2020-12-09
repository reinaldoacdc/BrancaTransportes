unit uCarregamento;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
