program ExemploPedido;

uses
  Vcl.Forms,
  cliente in 'model\cliente.pas',
  produto in 'model\produto.pas',
  pedido in 'model\pedido.pas',
  itemPedido in 'model\itemPedido.pas',
  database in 'model\database.pas',
  dataBaseController in 'controller\dataBaseController.pas',
  clienteController in 'controller\clienteController.pas',
  produtoController in 'controller\produtoController.pas',
  pedidoController in 'controller\pedidoController.pas',
  uPedido in 'view\uPedido.pas' {FrmPedido},
  utils_functions in 'utils\utils_functions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.Run;
end.
