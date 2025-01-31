unit database;

interface

uses System.Classes;

type

  TDataBase = class
  private
    FfileNameLib: string;
    Fport: string;
    FdataBase: string;
    Fpassword: string;
    FuserName: string;
    Fserver: string;
    procedure SetdataBase(const Value: string);
    procedure SetfileNameLib(const Value: string);
    procedure Setpassword(const Value: string);
    procedure Setport(const Value: string);
    procedure Setserver(const Value: string);
    procedure SetuserName(const Value: string);
  public
    constructor Create;
    destructor Destroy(); Override;
    property dataBase :string read FdataBase write SetdataBase;
    property userName : string read FuserName write SetuserName;
    property server : string read Fserver write Setserver;
    property port : string read Fport write Setport;
    property password : string read Fpassword write Setpassword;
    property fileNameLib : string read FfileNameLib write SetfileNameLib;
  end;

implementation

{ TDataBase }

constructor TDataBase.Create;
begin
  inherited;
end;

destructor TDataBase.Destroy;
begin
  inherited;
end;

procedure TDataBase.SetdataBase(const Value: string);
begin
  FdataBase := Value;
end;

procedure TDataBase.SetfileNameLib(const Value: string);
begin
  FfileNameLib := Value;
end;

procedure TDataBase.Setpassword(const Value: string);
begin
  Fpassword := Value;
end;

procedure TDataBase.Setport(const Value: string);
begin
  Fport := Value;
end;

procedure TDataBase.Setserver(const Value: string);
begin
  Fserver := Value;
end;

procedure TDataBase.SetuserName(const Value: string);
begin
  FuserName := Value;
end;

end.
