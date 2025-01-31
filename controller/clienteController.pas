unit clienteController;

interface

uses System.Classes, IniFiles, System.SysUtils, FireDAC.Comp.Client, vcl.Forms, cliente;

type

  TClienteController = class
    class function getCliente(id : integer; FDConn : TFDConnection) : TCliente;
  end;

implementation

{ TClienteController }

class function TClienteController.getCliente(id : integer; FDConn: TFDConnection): TCliente;
var qCliente : TFDQuery;
begin
  result := nil;
  qCliente := TFDQuery.Create(nil);
  Try
    qCliente.Connection := FDConn;
    With qCliente do
    begin
      close;
      SQL.Text := 'SELECT ID, NOME, CIDADE, UF FROM CLIENTES WHERE ID = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      open;

      if fieldbyname('ID').AsInteger = 0 then
        raise Exception.Create('Cliente n�o encontrado. Verifique');

      result := Tcliente.Create;
      result.id := FieldByName('ID').AsInteger;
      result.nome := FieldByName('NOME').AsString;
      result.cidade := FieldByName('CIDADE').AsString;
      result.uf := FieldByName('UF').AsString;
    end;
  Finally
    FreeAndNIl(qCliente);
  End;
end;

end.
