unit Model.Carregamento;

interface

type
TCarregamento = class(TObject)
private
    Flocal: String;
    Fdata: String;
    Fproduto: String;
  { private declarations }
protected
  { protected declarations }
public
  constructor Create(local, data, produto :String); overload;

published
  property Local :String read Flocal write Flocal;
  property Data :String read Fdata write Fdata;
  property Produto :String read Fproduto write Fproduto;
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

end.
