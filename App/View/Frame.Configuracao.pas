unit Frame.Configuracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.Edit;

type
  TFrameConfiguracoes = class(TFrame)
    ImageList1: TImageList;
    Layout1: TLayout;
    Layout2: TLayout;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    URL_API: TEdit;
    Button1: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ItemIPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses uConfigINI, Form.Main, Frame.Menu;

procedure TFrameConfiguracoes.ItemIPClick(Sender: TObject);
begin
  URL_API.Text := ConfigINI.AcessoBanco.URL_API;
end;

procedure TFrameConfiguracoes.SpeedButton1Click(Sender: TObject);
begin
  ConfigINI.AcessoBanco.URL_API := URL_API.Text;
  ConfigINI.UpdateFile;
  FormMain.LoadFrame<TFrameMenu>;///
end;

end.
