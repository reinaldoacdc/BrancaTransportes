unit UdmMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDmMain = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    tbCarregamento: TFDQuery;
    tbCarregamentoCODIGO: TIntegerField;
    tbCarregamentoDATA_CARREGAMENTO: TDateField;
    tbCarregamentoPESO_LIQ_CARGA: TBCDField;
    tbCarregamentoFRETE_TONELADA: TBCDField;
    tbCarregamentoTOTAL_FRETE: TBCDField;
    tbCarregamentoKM_INICIO: TBCDField;
    tbCarregamentoKM_CHEGADA: TBCDField;
    tbCarregamentoTOTAL_KM_RODADOS: TBCDField;
    FDQuery1: TFDQuery;
    qrCarregamento: TFDQuery;
    qrCarregamentoCODIGO: TIntegerField;
    qrCarregamentoDATA_CARREGAMENTO: TDateField;
    qrCarregamentoLOCAL_CARREGAMENTO: TWideStringField;
    qrCarregamentoPESO_LIQ_CARGA: TBCDField;
    qrCarregamentoFRETE_TONELADA: TBCDField;
    qrCarregamentoTOTAL_FRETE: TBCDField;
    qrCarregamentoKM_INICIO: TBCDField;
    qrCarregamentoKM_CHEGADA: TBCDField;
    qrCarregamentoTOTAL_KM_RODADOS: TBCDField;
    qrCarregamentoPRODUTO_CARREGADO: TWideStringField;
    tbDespesa: TFDQuery;
    tbDespesaCODIGO: TIntegerField;
    tbDespesaDATA_ABASTECIMENTO: TDateField;
    tbDespesaKM_ULTIMO_ABASTECIMENTO: TBCDField;
    tbDespesaKM_ABASTECIMENTO: TBCDField;
    tbDespesaTOTAL_LITROS: TBCDField;
    tbDespesaVALOR_LITROS: TBCDField;
    tbDespesaVALOR_TOTAL: TBCDField;
    tbDespesaKM_RODADOS: TBCDField;
    tbDespesaMEDIA: TBCDField;
    tbDespesaIMAGEM_COMPROVANTE: TBlobField;
    tbDespesaExtra: TFDQuery;
    tbDespesaExtraCODIGO: TIntegerField;
    tbDespesaExtraFORNECEDOR: TStringField;
    tbDespesaExtraVALOR: TBCDField;
    tbDespesaExtraDESCRICAO_SERVICO: TStringField;
    tbDespesaExtraLOCAL: TStringField;
    tbDespesaExtraKM_MANUTENCAO: TBCDField;
    tbDespesaExtraCIDADE_MANUTECAO: TStringField;
    tbDespesaExtraIMAGEM_COMPROVANTE: TBlobField;
    qrSincronismo: TFDQuery;
    qrSincronismoSINCRONIZZADO: TStringField;
    qrSincronismoCODIGO: TIntegerField;
    tbCarregamentoLOCAL_CARREGAMENTO: TStringField;
    tbCarregamentoPRODUTO_CARREGADO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function Maximo(tabela :String) :Integer;
  end;

var
  DmMain: TDmMain;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uConfigINI, System.IOUtils;

{$R *.dfm}

procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := False;

  FDConnection1.Params.DriverID := 'SQLite';
  {$IFDEF ANDROID}
  FDConnection1.Params.Database := TPath.Combine(TPath.GetDocumentsPath, 'DADOS.db');
  {$ELSE}
  FDConnection1.Params.Database := ConfigINI.AcessoBanco.Caminho;
  {$ENDIF}
  FDConnection1.Connected;
end;

function TDmMain.Maximo(tabela: String): Integer;
begin
  FDquery1.Close;
  Fdquery1.SQL.Text := Format('SELECT coalesce(MAX(CODIGO), 0) AS VALOR FROM %s', [tabela]);
  Fdquery1.Open;

  Result := FDQuery1.FieldByName('VALOR').AsInteger;
end;

end.
