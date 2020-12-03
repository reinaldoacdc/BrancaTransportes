unit uCarregamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts, FMX.ScrollBox,
  FMX.Memo, FMX.ListBox, FMX.DateTimeCtrls, FMX.Edit, System.Actions,
  FMX.ActnList, FMX.Gestures;

type
  TfrmCarregamentos = class(TFrame)
    ToolBar1: TToolBar;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Layout1: TLayout;
    VertScrollBox1: TVertScrollBox;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    PersonalInfoList: TListBox;
    Address: TListBoxItem;
    infoAddress: TEdit;
    Phone: TListBoxItem;
    infoTelephone: TEdit;
    Email: TListBoxItem;
    infoEmail: TEdit;
    BirthDate: TListBoxItem;
    infoDate: TDateEdit;
    TabItem3: TTabItem;
    EducationList: TListBox;
    Institution: TListBoxItem;
    edInstitution: TEdit;
    City: TListBoxItem;
    edCity: TEdit;
    TabItem4: TTabItem;
    WorkList: TListBox;
    Employer: TListBoxItem;
    weEmpName: TEdit;
    EmployerCity: TListBoxItem;
    weCity: TEdit;
    CurrentJob: TListBoxItem;
    weOccupiedJob: TEdit;
    TabItem5: TTabItem;
    Memo1: TMemo;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    PreviousTabAction: TPreviousTabAction;
    NextTabAction: TNextTabAction;
    TitleAction: TControlAction;
    ListBox1: TListBox;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem15: TListBoxItem;
    ListBoxItem16: TListBoxItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Concluir: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
