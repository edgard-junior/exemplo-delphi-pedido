unit cliente;

interface

uses System.Classes;

type

  TCliente = class
  private
    Fnome: string;
    Fcidade: string;
    Fid: integer;
    Fuf: string;
    procedure Setcidade(const Value: string);
    procedure Setnome(const Value: string);
    procedure Setid(const Value: integer);
    procedure Setuf(const Value: string);
  public
    constructor Create;
    destructor Destroy(); Override;
    property id : integer read Fid write Setid;
    property nome: string read Fnome write Setnome;
    property cidade : string read Fcidade write Setcidade;
    property uf : string read Fuf write Setuf;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited;
end;

destructor TCliente.Destroy;
begin
  inherited Destroy;
end;

procedure TCliente.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TCliente.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TCliente.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TCliente.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
