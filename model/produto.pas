unit produto;

interface

uses System.Classes;

type

  TProduto = class
  private
    FvalorVenda: double;
    Fdescricao: string;
    Fid: integer;
    procedure Setdescricao(const Value: string);
    procedure SetvalorVenda(const Value: double);
    procedure Setid(const Value: integer);
  public
    constructor Create;
    destructor Destroy(); Override;
    property id: integer read Fid write Setid;
    property descricao: string read Fdescricao write Setdescricao;
    property valorVenda : double read FvalorVenda write SetvalorVenda;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  inherited
end;

destructor TProduto.Destroy;
begin
  inherited Destroy;
end;

procedure TProduto.Setdescricao(const Value: string);
begin
  Fdescricao := Value;
end;

procedure TProduto.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TProduto.SetvalorVenda(const Value: double);
begin
  FvalorVenda := Value;
end;

end.
