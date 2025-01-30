unit uPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, cliente, produto;

type
  TFrmPedido = class(TForm)
    FDConn: TFDConnection;
    dspItem: TDataSource;
    FDQuery1: TFDQuery;
    GroupBox1: TGroupBox;
    Pnl_Titulo: TPanel;
    cmdConsultar: TBitBtn;
    cmdExcluir: TBitBtn;
    edtCliente: TEdit;
    edtNome: TEdit;
    Label1: TLabel;
    edtCidade: TEdit;
    Label2: TLabel;
    edtUF: TEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    edtProduto: TEdit;
    edtDescricao: TEdit;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    edtValorTotal: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    tblItem: TFDMemTable;
    cmdGravar: TBitBtn;
    FDTransaction: TFDTransaction;
    Label13: TLabel;
    Panel12: TPanel;
    lblValorTotalPedido: TLabel;
    spbtnInserir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure getEntidade(Sender : TObject);
    procedure calcularTotalProduto();
    procedure edtValorUnitarioExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure limpaDadosCliente();
    procedure limpaDadosProduto();
    procedure tblItemAfterOpen(DataSet: TDataSet);
    procedure alteraProduto;
    procedure habilitaAlteracaoProduto(habilitar : boolean);
    procedure habilitaOperacoes;
    procedure cmdGravarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdExcluirClick(Sender: TObject);
    procedure carregaDadosPedido(pedido : integer);
    procedure addProduto(id : integer; descricao : string; quantidade, valorUnitario, valorTotal : double);
    procedure spbtnInserirClick(Sender: TObject);
  private
    { Private declarations }
    vCliente : TCliente;
    vProduto : TProduto;
  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;

implementation

{$R *.dfm}

uses itemPedido, pedido, dataBaseController, clienteController,
  produtoController, utils_functions, pedidoController;

procedure TFrmPedido.addProduto(id: integer; descricao: string; quantidade, valorUnitario, valorTotal: double);
begin
  tblItem.Append;
  tblItem.FieldByName('ID').Asinteger := id; 
  tblItem.FieldByName('DESCRICAO_PRODUTO').AsString := descricao;
  tblItem.FieldByName('QUANTIDADE').asFloat := quantidade; 
  tblItem.FieldByName('VALOR_UNITARIO').asFloat := valorUnitario;
  tblItem.FieldByName('VALOR_TOTAL').asFloat := valorTotal; 
  tblItem.Post;
end;

procedure TFrmPedido.alteraProduto;
begin
  edtProduto.Text := tblItem.FieldByName('ID').AsString;
  edtProduto.OnExit(edtProduto);
  edtQuantidade.Text := tblItem.FieldByName('QUANTIDADE').AsString;
  edtValorUnitario.Text := tblItem.FieldByName('VALOR_UNITARIO').AsString;
  edtValorUnitario.OnExit(edtValorUnitario);
  tblItem.Delete;
  habilitaAlteracaoProduto(false);
end;

procedure TFrmPedido.calcularTotalProduto();
begin
  edtQuantidade.Text := FloatToStr(StrToFloatDef(edtQuantidade.Text,1));
  edtValorUnitario.Text := FormatFloat('0.00',StrToFloat(edtValorUnitario.Text));
  edtValorTotal.Text := FormatFloat('##,###,##0.00',StrToFloatDef(edtQuantidade.Text,1) * StrToFloatDef(edtValorUnitario.Text,0));
end;

procedure TFrmPedido.carregaDadosPedido(pedido : integer);
var vPedido : TPedido;
  tblItemPedido : TFDMemTable;
begin
  vPedido := TPedidoController.getPedido(pedido,FDConn);
  if vPedido <> nil then
  begin
    edtCliente.Text := intToStr(vPedido.cliente);
    edtCliente.OnExit(edtCliente);
  end;

  tblItemPedido := TPedidoController.getItemsPedido(pedido,FDConn);
  tblItemPedido.First;
  while not tblItemPedido.Eof do
  begin
    addProduto(tblItemPedido.FieldByName('PRODUTO').AsInteger,
               tblItemPedido.FieldByName('DESCRICAO').AsString,
               tblItemPedido.FieldByName('QUANTIDADE').asfloat,
               tblItemPedido.FieldByName('VALOR_UNITARIO').asfloat,
               tblItemPedido.FieldByName('VALOR_TOTAL').asfloat);
    tblItemPedido.Next;
  end;
  lblValorTotalPedido.Caption := FormatFloat('##,###,##0.00',tblItem.Aggregates[0].Value);
end;

procedure TFrmPedido.cmdExcluirClick(Sender: TObject);
var pedido : integer;
begin
  Try
    pedido := StrToint(InputBox('Pedido', 'Digite o código do pedido:', ''));
    if (sender = cmdExcluir) and (MessageDlg('Deseja realmente excluir o pedido '+intToStr(pedido)+ '?',mtconfirmation, [mbno, mbyes], 0) = mryes) then
      TPedidoController.deletaPedido(pedido,FDConn)
    else if sender = cmdConsultar then
      carregaDadosPedido(pedido);
  Except
    showmessage('Pedido inválido');
  End;
end;

procedure TFrmPedido.cmdGravarClick(Sender: TObject);
begin
  TEditPadrao.validarEdit('Cliente',edtCliente);
  if (tblItem.State = dsInactive) or (tblItem.RecordCount = 0) then
  begin
    MessageDlg('Nenhum produto foi lançado.', mtwarning, [mbok], 0);
    exit;
  end;

  Try
    FDTransaction.StartTransaction;

    TPedidoController.salvaPedido(StrToint(edtCliente.Text),tblItem,FDConn);

    FDTransaction.Commit;
    limpaDadosCliente;
    limpaDadosProduto;
    tblItem.EmptyDataSet;
    lblValorTotalPedido.Caption := '0,00';
    edtCliente.SetFocus;

    showmessage('Pedido gravado com sucesso');
  Except
    on e :exception do
    begin
      FDTransaction.Rollback;
      MessageDlg('Ocorreram erros ao gravar o pedido. '+ e.Message, mterror, [mbok], 0)
    end;
  End;
end;

procedure TFrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (tblItem.State = dsInactive) or (tblItem.RecordCount = 0) then exit;

  if key = 13 then
    alteraProduto
  else if key = 46 then
    if MessageDlg('Deseja realmente excluir o produto '+ tblItem.FieldByName('DESCRICAO_PRODUTO').AsString, mtConfirmation, [mbno, mbyes], mrno) = mryes then
      tblItem.Delete;
end;

procedure TFrmPedido.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  TEditPadrao.IntegerEdit(Sender,key);
end;

procedure TFrmPedido.edtValorUnitarioExit(Sender: TObject);
begin
  calcularTotalProduto();
end;

procedure TFrmPedido.FormCreate(Sender: TObject);
var valorTotalPedido: TFDAggregate;
begin
  tblItem.FieldDefs.Add('ID', ftInteger);
  tblItem.FieldDefs.Add('DESCRICAO_PRODUTO', ftString, 100);
  tblItem.FieldDefs.Add('QUANTIDADE', ftFloat);
  tblItem.FieldDefs.Add('VALOR_UNITARIO', ftFloat);
  tblItem.FieldDefs.Add('VALOR_TOTAL', ftFloat);

  tblItem.CreateDataSet;
  tblItem.AggregatesActive := True;
  tblItem.Open;
  tblItem.EmptyDataSet;
  spbtnInserir.Caption := '';

  valorTotalPedido := tblItem.Aggregates.Add as TFDAggregate;
  valorTotalPedido.Name := 'TotalPedido';
  valorTotalPedido.Expression := 'SUM(VALOR_TOTAL)';
  valorTotalPedido.Active := True;
end;

procedure TFrmPedido.FormShow(Sender: TObject);
begin
  TDataBaseController.connectionDataBase(FDConn);
  if FDConn.Connected = false then
    application.Terminate;

  FDTransaction.Connection := FDConn;
  FDTransaction.Options.Isolation := xiReadCommitted;
end;

procedure TFrmPedido.getEntidade(Sender: TObject);
begin
  if sender = edtCliente then
  begin
    if edtCliente.Text <> '' then
    begin
      vCliente := TClienteController.getCliente(StrToInt(edtCliente.Text),FDConn);
      if vCliente <> nil then
      begin
        edtNome.Text := vCliente.nome;
        edtCidade.Text := vCliente.cidade;
        edtUF.Text := vCliente.uf;
      end;
      vCliente.Free;
    end
    else
      limpaDadosCliente;

    habilitaOperacoes;
  end
  Else if sender = edtProduto then
  begin
    if edtProduto.Text <> '' then
    begin
      vProduto := TProdutoController.getProduto(StrToInt(edtProduto.Text),FDConn);
      if vProduto <> nil then
      begin
        edtDescricao.Text := vProduto.descricao;
        edtValorUnitario.Text := FormatFloat('0.00', vProduto.valorVenda);
        calcularTotalProduto();
      end;
      vProduto.Free;
    end
    else
      limpaDadosProduto;
  end;
end;

procedure TFrmPedido.habilitaAlteracaoProduto(habilitar: boolean);
begin
  edtProduto.Enabled := habilitar;
  edtQuantidade.Enabled := habilitar;
end;

procedure TFrmPedido.habilitaOperacoes;
begin
  cmdConsultar.enabled := edtCliente.Text ='';
  cmdExcluir.Enabled := cmdConsultar.enabled;
end;

procedure TFrmPedido.limpaDadosCliente;
begin
  edtCliente.Clear;
  edtNome.Clear;
  edtCidade.clear;
  edtUf.Clear;
  habilitaOperacoes;
end;

procedure TFrmPedido.limpaDadosProduto;
begin
  edtProduto.Clear;
  edtQuantidade.Clear;
  edtValorunitario.Text := '0,00';
  edtValorTotal.Text := '0,00';
  edtDescricao.Clear;
end;

procedure TFrmPedido.spbtnInserirClick(Sender: TObject);
begin
  TEditPadrao.validarEdit('Produto',edtProduto);
  TEditPadrao.validarEdit('Quantidade',edtQuantidade);
  TEditPadrao.validarEdit('Valor unitário',edtValorUnitario);

  addProduto(strToint(edtProduto.Text),
            edtDescricao.Text,
            StrToFloat(edtQuantidade.Text),
            StrToFloat(edtValorUnitario.Text),
            StrToFloat(StringReplace(edtValorTotal.Text,'.','',[])));

  habilitaAlteracaoProduto(true);
  limpaDadosProduto;
  edtProduto.SetFocus;
  lblValorTotalPedido.Caption := FormatFloat('##,###,##0.00',tblItem.Aggregates[0].Value);
end;

procedure TFrmPedido.tblItemAfterOpen(DataSet: TDataSet);
begin
  TFloatField(tblItem.FieldByName('VALOR_TOTAL')).DisplayFormat := '##,###,##0.00';
  TFloatField(tblItem.FieldByName('VALOR_UNITARIO')).DisplayFormat := '##,###,##0.00';
end;

end.
