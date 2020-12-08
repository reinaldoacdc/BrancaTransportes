unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.StdCtrls, FMX.ListBox, FMX.Layouts, SubjectStand, FrameStand, FMX.Objects,
  System.Actions, FMX.ActnList;

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
    FrameStand2: TFrameStand;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    procedure FormShow(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure ListBoxItem6Click(Sender: TObject);
    procedure FrameStand2BeforeShow(const ASender: TSubjectStand;
      const ASubjectInfo: TSubjectInfo);
    procedure FormCreate(Sender: TObject);
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
  uDespesaExtra, Frame.ListaCarregamento;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FrameStand2.CommonActions.Add('Close*',
    procedure (AInfo: TSubjectInfo)
    begin
      AInfo.Hide();
    end
  );
end;

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

procedure TFormMain.FrameStand2BeforeShow(const ASender: TSubjectStand;
  const ASubjectInfo: TSubjectInfo);
var
  LContentBackground: TRectangle;
  LTenPercent: Single;
begin
  LTenPercent := 0;
  if ASubjectInfo.Parent is TCustomForm then
    LTenPercent := TCustomForm(ASubjectInfo.Parent).Width / 10
  else if ASubjectInfo.Parent is TControl then
    LTenPercent := TControl(ASubjectInfo.Parent).Width / 10;

  LContentBackground := ASubjectInfo.Stand.FindStyleResource('content_background') as TRectangle;

  if Assigned(LContentBackground) then
    LContentBackground.Margins.Rect := TRectF.Create(LTenPercent, LTenPercent
    , LTenPercent, LTenPercent);

end;

procedure TFormMain.ListBoxItem1Click(Sender: TObject);
var
  LFrameInfo: TFrameInfo<TFrameListaCarregamento>;
begin
  LoadFrame<TFrameListaCarregamento>;

  FrameStand1.HideAndCloseAll();
  FrameStand2.HideAndCloseAll();
  LFrameInfo := FrameStand2.New<TFrameListaCarregamento>;
  LFrameInfo.Show;
  MultiView1.HideMaster;
//
//  if not LoginSucessfull then
//    LoadFrame<TFrameLogin>;
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
