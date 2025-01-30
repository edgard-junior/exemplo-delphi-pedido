unit itemPedido;

interface

uses System.Classes;

type

  TItemPedido = class
  private
    Fproduto: integer;
    Fpedido: integer;
    FvalorUnitario: double;
    Fid: integer;
    FvalorTotal: double;
    Fquantidade: double;
    procedure Setid(const Value: integer);
    procedure Setpedido(const Value: integer);
    procedure Setproduto(const Value: integer);
    procedure Setquantidade(const Value: double);
    procedure SetvalorTotal(const Value: double);
    procedure SetvalorUnitario(const Value: double);
  public
    constructor Create;
    destructor Destroy(); Override;
    property id: integer read Fid write Setid;
    property pedido : integer read Fpedido write Setpedido;
    property produto : integer read Fproduto write Setproduto;
    property quantidade : double read Fquantidade write Setquantidade;
    property valorUnitario : double read FvalorUnitario write SetvalorUnitario;
    property valorTotal : double read FvalorTotal write SetvalorTotal;
  end;

implementation

{ TItemPedido }

constructor TItemPedido.Create;
begin
  inherited
end;

destructor TItemPedido.Destroy;
begin
  inherited Destroy;
end;

procedure TItemPedido.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TItemPedido.Setpedido(const Value: integer);
begin
  Fpedido := Value;
end;

procedure TItemPedido.Setproduto(const Value: integer);
begin
  Fproduto := Value;
end;

procedure TItemPedido.Setquantidade(const Value: double);
begin
  Fquantidade := Value;
end;

procedure TItemPedido.SetvalorTotal(const Value: double);
begin
  FvalorTotal := Value;
end;

procedure TItemPedido.SetvalorUnitario(const Value: double);
begin
  FvalorUnitario := Value;
end;

end.
