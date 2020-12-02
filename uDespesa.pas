unit uDespesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListBox,
  FMX.Layouts;

type
  TFrame2 = class(TFrame)
    PersonalInfoList: TListBox;
    Address: TListBoxItem;
    infoAddress: TEdit;
    Phone: TListBoxItem;
    infoTelephone: TEdit;
    Email: TListBoxItem;
    infoEmail: TEdit;
    BirthDate: TListBoxItem;
    infoDate: TDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
