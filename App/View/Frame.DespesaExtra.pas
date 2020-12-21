unit Frame.DespesaExtra;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.Layouts;

type
  TFrameDespesasExtras = class(TFrame)
    ListBox: TListBox;
    itemFornecedor: TListBoxItem;
    FORNECEDOR: TEdit;
    itemValor: TListBoxItem;
    VALOR: TEdit;
    SpeedButton2: TSpeedButton;
    itemServico: TListBoxItem;
    Edit1: TEdit;
    itemLocal: TListBoxItem;
    LOCAL: TEdit;
    itemKM: TListBoxItem;
    KM: TEdit;
    itemCidade: TListBoxItem;
    CIDADE: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
