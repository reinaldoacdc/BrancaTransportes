unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.StdCtrls, FMX.ListBox, FMX.Layouts, SubjectStand, FrameStand;

type
  TFormMain = class(TForm)
    MultiView1: TMultiView;
    ImageList1: TImageList;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    FrameStand1: TFrameStand;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure ListBoxItem6Click(Sender: TObject);
  private
    FloginSucessfull: Boolean;

  public
    procedure LoadFrame<T :TFrame>;
    property LoginSucessfull :Boolean read FloginSucessfull write FloginSucessfull default False;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses uMenu, uCarregamento, uInstitucional, uParceiros, Frame.Login, uDespesa,
  uDespesaExtra;

procedure TFormMain.FormShow(Sender: TObject);
begin
  LoadFrame<TFrameMenu>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.LoadFrame<T>;
var
  LFrameInfo: TFrameInfo<T>;
begin
  FrameStand1.HideAndCloseAll();
  LFrameInfo := FrameStand1.New<T>(Layout1);
  LFrameInfo.Show;
  MultiView1.HideMaster;
end;

procedure TFormMain.ListBoxItem1Click(Sender: TObject);
begin
  LoadFrame<TFrameCarregamento>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.ListBoxItem2Click(Sender: TObject);
begin
  LoadFrame<TFrameInstitucional>;
end;

procedure TFormMain.ListBoxItem3Click(Sender: TObject);
begin
  LoadFrame<TFrameParceiros>;
end;

procedure TFormMain.ListBoxItem4Click(Sender: TObject);
begin
  LoadFrame<TFrameDespesas>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.ListBoxItem5Click(Sender: TObject);
begin
  LoadFrame<TFrameDespesasExtras>;
  if not LoginSucessfull then
    LoadFrame<TFrameLogin>;
end;

procedure TFormMain.ListBoxItem6Click(Sender: TObject);
begin
  LoadFrame<TFrameParceiros>;
end;

end.
