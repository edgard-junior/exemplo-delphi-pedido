program ExemploPedido;

uses
  Vcl.Forms,
  uPedido in 'uPedido.pas' {FrmPedido},
  cliente in 'model\cliente.pas',
  produto in 'model\produto.pas',
  pedido in 'model\pedido.pas',
  itemPedido in 'model\itemPedido.pas',
  database in 'model\database.pas',
  dataBaseController in 'controller\dataBaseController.pas',
  clienteController in 'controller\clienteController.pas',
  produtoController in 'controller\produtoController.pas',
  utils_functions in 'utils_functions.pas',
  pedidoController in 'controller\pedidoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.Run;
end.
