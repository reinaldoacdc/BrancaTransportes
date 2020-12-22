
unit Model.Entity.CADASTRO_DESPESAS;

interface

uses
  System.Generics.Collections, System.Classes, Rest.Json, System.JSON, SimpleAttributes;

type
  [Tabela('CADASTRO_DESPESAS')]
  TCADASTRO_DESPESAS = class
  private
    FCODIGO: integer;
    FDATA_ABASTECIMENTO: TDate;
    FKM_ULTIMO_ABASTECIMENTO: real;
    FKM_ABASTECIMENTO: real;
    FTOTAL_LITROS: real;
    FVALOR_LITROS: real;
    FVALOR_TOTAL: real;
    FKM_RODADOS: real;
    FMEDIA: real;
    FIMAGEM_COMPROVANTE: string;   {TBlobField}

  public
    constructor Create;
    destructor Destroy; override;

  published
{verificar os atributos do campo de chave primária}
{Exemplo: [Campo('NOME_CAMPO'), PK, AutoInc] }
    [Campo('CODIGO'), PK, AutoInc]
    property CODIGO: integer read FCODIGO write FCODIGO;
    [Campo('DATA_ABASTECIMENTO')]
    property DATA_ABASTECIMENTO: TDate read FDATA_ABASTECIMENTO write FDATA_ABASTECIMENTO;
    [Campo('KM_ULTIMO_ABASTECIMENTO')]
    property KM_ULTIMO_ABASTECIMENTO: real read FKM_ULTIMO_ABASTECIMENTO write FKM_ULTIMO_ABASTECIMENTO;
    [Campo('KM_ABASTECIMENTO')]
    property KM_ABASTECIMENTO: real read FKM_ABASTECIMENTO write FKM_ABASTECIMENTO;
    [Campo('TOTAL_LITROS')]
    property TOTAL_LITROS: real read FTOTAL_LITROS write FTOTAL_LITROS;
    [Campo('VALOR_LITROS')]
    property VALOR_LITROS: real read FVALOR_LITROS write FVALOR_LITROS;
    [Campo('VALOR_TOTAL')]
    property VALOR_TOTAL: real read FVALOR_TOTAL write FVALOR_TOTAL;
    [Campo('KM_RODADOS')]
    property KM_RODADOS: real read FKM_RODADOS write FKM_RODADOS;
    [Campo('MEDIA')]
    property MEDIA: real read FMEDIA write FMEDIA;
    //[Campo('IMAGEM_COMPROVANTE')]
    //property IMAGEM_COMPROVANTE: string read FIMAGEM_COMPROVANTE write FIMAGEM_COMPROVANTE;

    function ToJSONObject: TJsonObject;
    function ToJsonString: string;

  end;

implementation

constructor TCADASTRO_DESPESAS.Create;
begin

end;

destructor TCADASTRO_DESPESAS.Destroy;
begin

  inherited;
end;

function TCADASTRO_DESPESAS.ToJSONObject: TJsonObject;
begin
  Result := TJson.ObjectToJsonObject(Self);
end;

function TCADASTRO_DESPESAS.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.
