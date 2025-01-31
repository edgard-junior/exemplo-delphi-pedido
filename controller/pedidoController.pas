unit pedidoController;

interface

uses System.Classes, IniFiles, System.SysUtils, FireDAC.Comp.Client, vcl.Forms, produto, pedido, FireDAC.Comp.DataSet;

type

  TPedidoController = class
    class procedure salvaPedido(cliente: integer; produtos : TFDMemTable; FDConn : TFDConnection);
    class procedure deletaPedido(id : integer; FDConn : TFDConnection);
    class function getPedido(id : integer; FDConn : TFDConnection) : TPedido;
    class function getItemsPedido(id : integer; FDConn : TFDConnection) : TFDMemTable;
  end;

implementation

{ TPedidoController }

class procedure TPedidoController.deletaPedido(id: integer; FDConn: TFDConnection);
var qDelete : TFDQuery;
begin
  qDelete := TFDQuery.Create(nil);
  Try
    qDelete.Connection := FDConn;
    With qDelete do
    begin
      close;
      SQL.Text := 'SELECT ID FROM PEDIDO WHERE ID = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      open;

      if fieldBYname('ID').AsInteger = 0 then
        raise Exception.Create('Pedido n�o localizado');

      close;
      SQL.Text := 'DELETE FROM PEDIDO WHERE ID = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      ExecSQL;
    end;
  Finally
    FreeAndNIl(qDelete);
  End;
end;

class function TPedidoController.getPedido(id: integer; FDConn: TFDConnection): TPedido;
var qPedido : TFDQuery;
begin
  result := nil;
  qPedido := TFDQuery.Create(nil);
  Try
    qPedido.Connection := FDConn;
    With qPedido do
    begin
      close;
      SQL.Text := 'SELECT ID, CLIENTE, VALOR_TOTAL, DATA_EMISSAO FROM PEDIDOS WHERE ID = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      open;

      if fieldbyname('ID').AsInteger = 0 then
        raise Exception.Create('Pedido n�o encontrado. Verifique');

      result := TPedido.Create;
      result.id := FieldByName('ID').AsInteger;
      result.cliente := FieldByName('CLIENTE').AsInteger;
      result.emissao := FieldByName('DATA_EMISSAO').AsDatetime;
      result.valorTotal := FieldByName('VALOR_TOTAL').AsFloat;
    end;
  Finally
    FreeAndNIl(qPedido);
  End;
end;

class procedure TPedidoController.salvaPedido(cliente: integer; produtos: TFDMemTable; FDConn: TFDConnection);
var qPedido, qItemPedido : TFDQuery;
begin
  qPedido := TFDQuery.Create(nil);
  qItemPedido := TFDQuery.Create(nil);
  try
    qItemPedido.Connection := FDConn;
    qItemPedido.SQL.Text := 'INSERT INTO ITEM_PEDIDO (PRODUTO, PEDIDO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) '+
                            'VALUES (:PRODUTO, :PEDIDO, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL)';

    qPedido.Connection := FDConn;
    qPedido.SQL.Text := 'INSERT INTO PEDIDOS (CLIENTE,DATA_EMISSAO,VALOR_TOTAL) VALUES (:CLIENTE, :DATA_EMISSAO, :VALOR_TOTAL) ';
    qPedido.Params.ParamByName('CLIENTE').AsInteger := cliente;
    qPedido.Params.ParamByName('DATA_EMISSAO').AsDate := Date;
    qPedido.Params.ParamByName('VALOR_TOTAL').AsFloat := produtos.Aggregates[0].Value;
    qPedido.ExecSQL;

    qPedido.SQL.Text := 'SELECT LAST_INSERT_ID() AS ID';
    qPedido.Open;

    if qPedido.FieldByName('ID').AsInteger > 0 then
    Begin
      produtos.First;
      while not produtos.Eof do
      begin
        qItemPedido.Close;
        qItemPedido.Params.ParamByName('PRODUTO').AsInteger := produtos.FieldByName('ID').AsInteger;
        qItemPedido.Params.ParamByName('PEDIDO').AsInteger := qPedido.FieldByName('ID').AsInteger;
        qItemPedido.Params.ParamByName('QUANTIDADE').AsFloat := produtos.FieldByName('QUANTIDADE').AsFloat;
        qItemPedido.Params.ParamByName('VALOR_UNITARIO').AsFloat := produtos.FieldByName('VALOR_UNITARIO').AsFloat;
        qItemPedido.Params.ParamByName('VALOR_TOTAL').AsFloat := produtos.FieldByName('VALOR_TOTAL').AsFloat;
        qItemPedido.ExecSQL;

        produtos.Next;
      end;
    End;

  finally
    FreeAndNil(qPedido);
    FreeAndNil(qItemPedido);
  end;
end;

class function TPedidoController.getItemsPedido(id : integer; FDConn: TFDConnection) : TFDMemTable;
var qItemPedido : TFDQuery;
begin
  qItemPedido := TFDQuery.Create(nil);
  Try
    qItemPedido.Connection := FDConn;
    With qItemPedido do
    begin
      close;
      SQL.Text := 'SELECT I.PRODUTO, I.QUANTIDADE, I.VALOR_UNITARIO, P.DESCRICAO, I.VALOR_TOTAL FROM ITEM_PEDIDO I '+
                  'LEFT JOIN PRODUTOS P ON P.ID = I.PRODUTO WHERE I.PEDIDO = :ID ';
      Params.ParamByName('ID').AsInteger := id;
      open;

      result := TFDMemTable.Create(nil);
      result.Close;
      result.CopyDataSet(qItemPedido, [coStructure, coAppend]);
      result.Open;
    end;
  Finally
    FreeAndNIl(qItemPedido);
  End;
end;

end.
