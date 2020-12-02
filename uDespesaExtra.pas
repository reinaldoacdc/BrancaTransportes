unit uDespesaExtra;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.Layouts;

type
  TFrame3 = class(TFrame)
    EducationList: TListBox;
    Institution: TListBoxItem;
    edInstitution: TEdit;
    City: TListBoxItem;
    edCity: TEdit;
    SpeedButton2: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
