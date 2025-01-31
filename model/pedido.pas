unit pedido;

interface

uses System.Classes;

type

  TPedido = class
  private
    Fcliente: integer;
    Fid: integer;
    FvalorTotal: double;
    Femissao: TDateTime;
    procedure Setcliente(const Value: integer);
    procedure Setemissao(const Value: TDateTime);
    procedure Setid(const Value: integer);
    procedure SetvalorTotal(const Value: double);
  public
    constructor Create;
    destructor Destroy(); Override;
    property id: integer read Fid write Setid;
    property emissao : TDateTime read Femissao write Setemissao;
    property cliente: integer read Fcliente write Setcliente;
    property valorTotal : double read FvalorTotal write SetvalorTotal;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  inherited
end;

destructor TPedido.Destroy;
begin
  inherited Destroy;
end;

procedure TPedido.Setcliente(const Value: integer);
begin
  Fcliente := Value;
end;

procedure TPedido.Setemissao(const Value: TDateTime);
begin
  Femissao := Value;
end;

procedure TPedido.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TPedido.SetvalorTotal(const Value: double);
begin
  FvalorTotal := Value;
end;

end.
