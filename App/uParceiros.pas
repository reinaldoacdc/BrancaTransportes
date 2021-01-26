unit uParceiros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Objects, FMX.Layouts;

type
  TFrameParceiros = class(TFrame)
    GridLayout1: TGridLayout;
    Image1: TImage;
    GridLayout2: TGridLayout;
    Image2: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
