unit Form.Sincronismo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts,
  Model.Entity.CADASTRO_CARREGAMENTO; //Model.DaoGeneric, SimpleInterface;

type
  TFormSincronismo = class(TForm)
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
    ImageList1: TImageList;
    procedure btnSincronismoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    //Conn : iSimpleQuery;
    //DAOCarregamento : iSimpleDAO<TCADASTRO_CARREGAMENTO>;
  public
    { Public declarations }
  end;

var
  FormSincronismo: TFormSincronismo;

implementation

{$R *.fmx}

uses UdmMain, DataSet.Serialize, System.JSON, Controller.API;

//uses SimpleQueryFiredac, SimpleDAO, UdmMain, Controller.API;

procedure TFormSincronismo.btnSincronismoClick(Sender: TObject);
//var carregamento :TCADASTRO_CARREGAMENTO;
var LJSONObject: TJSONObject;
begin

  //
  DmMain.qrSincronismo.Close;
  DmMain.qrSincronismo.Open;

  ProgressCarregamento.Max := DmMain.qrSincronismo.RecordCount;
  ProgressCarregamento.Position.X := 0;

  while not DmMain.qrSincronismo.EOF do
  begin
    objAPI.postCarregamento2( DmMain.qrSincronismo.ToJSONObjectString() );

    ProgressCarregamento.Position.X := ProgressCarregamento.Position.X +1;
    DmMain.qrSincronismo.Next;
  end;

  //
  DmMain.qrSincronismoDespesa.Close;
  DmMain.qrSincronismoDespesa.Open;

  ProgressDespesas.Max := DmMain.qrSincronismoDespesa.RecordCount;
  ProgressDespesas.Position.X := 0;

  while not DmMain.qrSincronismoDespesa.EOF do
  begin
    objAPI.postDespesa2( DmMain.qrSincronismoDespesa.ToJSONObjectString() );

    ProgressDespesas.Position.X := ProgressDespesas.Position.X +1;
    DmMain.qrSincronismoDespesa.Next;
  end;


end;

procedure TFormSincronismo.FormCreate(Sender: TObject);
begin
//  Conn := TSimpleQueryFiredac.New(DmMain.FDConnection1);
//  DAOCarregamento := TSimpleDAO<TCADASTRO_CARREGAMENTO>
//                  .New(Conn)
end;

end.
