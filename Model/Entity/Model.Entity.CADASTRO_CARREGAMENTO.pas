unit Model.Entity.CADASTRO_CARREGAMENTO;

interface

uses
 System.Generics.Collections, System.Classes, Rest.Json, System.JSON, SimpleAttributes;

type
  [Tabela('CADASTRO_CARREGAMENTO')]
  TCADASTRO_CARREGAMENTO = class
  private
    FCODIGO: integer;
    FDATA_CARREGAMENTO: TDate;
    FLOCAL_CARREGAMENTO: string;
    FPESO_LIQ_CARGA: Double;
    FFRETE_TONELADA: Double;
    FTOTAL_FRETE: Double;
    FKM_INICIO: Double;
    FKM_CHEGADA: Double;
    FTOTAL_KM_RODADOS: Double;
    FPRODUTO_CARREGADO: string;

  public
    constructor Create;
    destructor Destroy; override;

  published
{verificar os atributos do campo de chave primária}
{Exemplo: [Campo('NOME_CAMPO'), PK, AutoInc] }
    [Campo('CODIGO'), PK]
    property CODIGO: integer read FCODIGO write FCODIGO;
    [Campo('DATA_CARREGAMENTO')]
    property DATA_CARREGAMENTO: TDate read FDATA_CARREGAMENTO write FDATA_CARREGAMENTO;
    [Campo('LOCAL_CARREGAMENTO')]
    property LOCAL_CARREGAMENTO: string read FLOCAL_CARREGAMENTO write FLOCAL_CARREGAMENTO;
    [Campo('PESO_LIQ_CARGA')]
    property PESO_LIQ_CARGA: Double read FPESO_LIQ_CARGA write FPESO_LIQ_CARGA;
    [Campo('FRETE_TONELADA')]
    property FRETE_TONELADA: Double read FFRETE_TONELADA write FFRETE_TONELADA;
    [Campo('TOTAL_FRETE')]
    property TOTAL_FRETE: Double read FTOTAL_FRETE write FTOTAL_FRETE;
    [Campo('KM_INICIO')]
    property KM_INICIO: Double read FKM_INICIO write FKM_INICIO;
    [Campo('KM_CHEGADA')]
    property KM_CHEGADA: Double read FKM_CHEGADA write FKM_CHEGADA;
    [Campo('TOTAL_KM_RODADOS')]
    property TOTAL_KM_RODADOS: Double read FTOTAL_KM_RODADOS write FTOTAL_KM_RODADOS;
    [Campo('PRODUTO_CARREGADO')]
    property PRODUTO_CARREGADO: string read FPRODUTO_CARREGADO write FPRODUTO_CARREGADO;

    function ToJSONObject: TJsonObject;
    function ToJsonString: string;

  end;

implementation

constructor TCADASTRO_CARREGAMENTO.Create;
begin

end;

destructor TCADASTRO_CARREGAMENTO.Destroy;
begin

  inherited;
end;

function TCADASTRO_CARREGAMENTO.ToJSONObject: TJsonObject;
begin
  Result := TJson.ObjectToJsonObject(Self);
end;

function TCADASTRO_CARREGAMENTO.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.
