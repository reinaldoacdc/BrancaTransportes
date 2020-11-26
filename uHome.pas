unit uHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.MultiView;

type
  TfrmHome = class(TForm)
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    FramedVertScrollBox1: TFramedVertScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
  private
    FrameParceiros :TFrame;
    FrameInstitucional :TFrame;
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.fmx}

uses uLogin, uParceiros, uInstitucional;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  FrameParceiros := TfrmParceiros.Create(self);
  FrameInstitucional := TfrmInstitucional.Create(self);
end;

procedure TfrmHome.ListBoxItem2Click(Sender: TObject);
begin
  FrameInstitucional.Parent := nil;
  FrameParceiros.Parent := FramedVertScrollBox1;
end;

procedure TfrmHome.ListBoxItem3Click(Sender: TObject);
begin
  FrameParceiros.Parent := nil;
  FrameInstitucional.Parent := FramedVertScrollBox1;
end;

end.
