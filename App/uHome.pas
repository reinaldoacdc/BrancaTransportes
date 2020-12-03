unit uHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Ani;

type
  TfrmHome = class(TForm)
    ImageList1: TImageList;
    FramedVertScrollBox1: TFramedVertScrollBox;
    PanelBottom: TPanel;
    GridPanelLayout1: TGridPanelLayout;
    btnTable: TSpeedButton;
    ColorAnimation4: TColorAnimation;
    btnLabel: TSpeedButton;
    ColorAnimation6: TColorAnimation;
    animateBottom: TFloatAnimation;
    btnCart: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTableClick(Sender: TObject);
    procedure btnLabelClick(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
  private
    FrameParceiros :TFrame;
    FrameInstitucional :TFrame;
    FrameCarregamentos :TFrame;
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.fmx}

uses uParceiros, uInstitucional, uCarregamentos;

procedure TfrmHome.btnCartClick(Sender: TObject);
begin
  FrameParceiros.Parent := nil;
  FrameInstitucional.Parent := nil;
  FrameCarregamentos.Parent := FramedVertScrollBox1;
end;

procedure TfrmHome.btnLabelClick(Sender: TObject);
begin
  FrameParceiros.Parent := nil;
  FrameCarregamentos.Parent := nil;
  FrameInstitucional.Parent := FramedVertScrollBox1;
end;

procedure TfrmHome.btnTableClick(Sender: TObject);
begin
  FrameInstitucional.Parent := nil;
  FrameCarregamentos.Parent := nil;
  FrameParceiros.Parent := FramedVertScrollBox1;
end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  FrameParceiros := TFrameParceiros.Create(self);
  FrameInstitucional := TFrameInstitucional.Create(self);
  FrameCarregamentos := TfrmCarregamentos.Create(self);
end;

end.
