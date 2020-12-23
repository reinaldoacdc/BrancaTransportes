unit Frame.Configuracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.Edit;

type
  TFrameConfiguracoes = class(TFrame)
    GridPanelLayout1: TGridPanelLayout;
    ListBox1: TListBox;
    ItemIP: TListBoxItem;
    URL_API: TEdit;
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

uses uConfigINI, Form.Main, Frame.Menu;

procedure TFrameConfiguracoes.SpeedButton1Click(Sender: TObject);
begin
  ConfigINI.AcessoBanco.URL_API := URL_API.Text;
  FormMain.LoadFrame<TFrameMenu>;
end;

end.
