unit Model.Carregamento;

interface

type
TCarregamento = class(TObject)
private
    Flocal: String;
    Fdata: String;
    Fproduto: String;
    Ffrete: String;
    Fpeso: String;
    FkmInicio: String;
    FkmFinal: String;
  { private declarations }
protected
  { protected declarations }
public
  constructor Create(local, data, produto :String); overload;
  constructor Create(local, data, produto, frete, peso, kmIni, kmFim :String); overload;

published
  property Local :String read Flocal write Flocal;
  property Data :String read Fdata write Fdata;
  property Produto :String read Fproduto write Fproduto;
  property Frete :String read Ffrete write Ffrete;
  property Peso :String read Fpeso write Fpeso;
  property KmInicio :String read FkmInicio write FkmInicio;
  property KmFinal :String read FkmFinal write FkmFinal;
end;

type TCarregamentos = array of TCarregamento;

implementation

{ TCarregamento }

constructor TCarregamento.Create(local, data, produto :String);
begin
  Flocal := local;
  Fdata := data;
  Fproduto := produto;
end;

constructor TCarregamento.Create(local, data, produto, frete, peso, kmIni,
  kmFim: String);
begin
  Flocal := local;
  Fdata := data;
  Fproduto := produto;

  Ffrete := frete;
  Fpeso := peso;
  FkmInicio := kmIni;
  FkmFinal := kmFim;
end;

end.
