unit produtoController;

interface

uses System.Classes, IniFiles, System.SysUtils, FireDAC.Comp.Client, vcl.Forms, produto;

type

  TProdutoController = class
    class function getProduto(id : integer; FDConn : TFDConnection) : TProduto;
  end;

implementation

{ TProdutoController }

class function TProdutoController.geTProduto(id : integer; FDConn: TFDConnection): TProduto;
var qProduto : TFDQuery;
begin
  result := nil;
  qProduto := TFDQuery.Create(nil);
  Try
    qProduto.Connection := FDConn;
    With qProduto do
    begin
      close;
      SQL.Text := 'SELECT ID, DESCRICAO, VALOR_VENDA FROM PRODUTOS WHERE ID = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      open;

      if fieldbyname('ID').AsInteger = 0 then
        raise Exception.Create('Produto n�o encontrado. Verifique');

      result := TProduto.Create;
      result.id := FieldByName('ID').AsInteger;
      result.descricao := FieldByName('DESCRICAO').AsString;
      result.valorVenda := FieldByName('VALOR_VENDA').AsFloat;
    end;
  Finally
    FreeAndNIl(qProduto);
  End;
end;

end.

