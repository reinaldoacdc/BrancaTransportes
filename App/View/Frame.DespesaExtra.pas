unit Frame.DespesaExtra;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.Layouts,
  System.ImageList, FMX.ImgList;

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
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Form.Main, Frame.Menu;

procedure TFrameDespesasExtras.SpeedButton1Click(Sender: TObject);
begin
  FormMain.LoadFrame<TFrameMenu>;
end;

end.
