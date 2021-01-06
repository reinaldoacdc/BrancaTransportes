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
    Layout3: TLayout;
    ProgressCarregamento: TProgressBar;
    Label2: TLabel;
    Layout4: TLayout;
    Label3: TLabel;
    ProgressDespesas: TProgressBar;
    Layout2: TLayout;
    Label4: TLabel;
    ProgressDespesasExtra: TProgressBar;
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
  Enviar;
end;

procedure TFrameSincronismo.Enviar;
begin

end;

end.
