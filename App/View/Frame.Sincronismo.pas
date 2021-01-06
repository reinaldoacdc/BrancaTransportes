unit Frame.Sincronismo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.ImageList, FMX.ImgList;

type
  TFrameSincronismo = class(TFrame)
    ImageList1: TImageList;
    Layout1: TLayout;
    btnSincronismo: TSpeedButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Layout2: TLayout;
    lblProgress: TLabel;
    procedure btnSincronismoClick(Sender: TObject);
  private
    procedure Enviar;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameSincronismo.btnSincronismoClick(Sender: TObject);
begin
  ProgressBar1.Value :=  0;
  Enviar;
end;

procedure TFrameSincronismo.Enviar;
begin

  ProgressBar1.Value := 50;
  Sleep(500);
  Progressbar1.Value := 100;

end;

end.
