unit Form.Sincronismo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts;

type
  TFormSincronismo = class(TForm)
    Layout1: TLayout;
    btnSincronismo: TSpeedButton;
    Label1: TLabel;
    Layout3: TLayout;
    ProgressCarregamento: TProgressBar;
    Label2: TLabel;
    Layout4: TLayout;
    Label3: TLabel;
    ProgressDespesas: TProgressBar;
    Layout2: TLayout;
    Label4: TLabel;
    ProgressDespesasExtra: TProgressBar;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSincronismo: TFormSincronismo;

implementation

{$R *.fmx}

end.
