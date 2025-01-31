unit utils_functions;

interface

uses System.Classes, Messages, vcl.Forms, dialogs, vcl.controls, system.SysUtils, Vcl.StdCtrls, Windows,
FireDAC.Comp.Client;

type
  TEditPadrao = class
    class procedure IntegerEdit(Sender: TObject; var Key: Char);
    class procedure FloatEdit(Sender: TObject; var Key: Char);
    class procedure NextOrder(Sender: TObject);
    class function GetFormulario(Sender: TObject) : TForm;
    class function validarEdit(campo: string; edt: TEdit): boolean;
  end;

implementation

{ TEditPadrao }

class procedure TEditPadrao.FloatEdit(Sender: TObject; var Key: Char);
var
  campo : string;
begin
  case Key of
    #13: TEditPadrao.NextOrder(Sender as TWinControl);
  else if not(Key in [#1, #3, #8, #24, #26, '0' .. '9']) then
      Key := #0;
  end;

  try
    if (Trim(TEdit(Sender).Text) <> '') and (key in ['0'..'9']) then
    begin
      campo := TEdit(Sender).Text;
      campo := FloatToStr(StrToFloat(campo));
      if Pos('E',upperCase(campo)) > 0 then
        StrToint(campo);
    end;
  Except
    Key := #0;
    showmessage('Valor inv�lido');
  end;
end;

class procedure TEditPadrao.IntegerEdit(Sender: TObject; var Key: Char);
begin
  Try
    case Key of
      #13: TEditPadrao.NextOrder(Sender as TWinControl);
    else if not(Key in [#3, #8, #24, #26, '0' .. '9']) then
         Key := #0;
    end;
    if (Trim(TEdit(Sender).Text) <> '') and (key in ['0'..'9']) then
      StrToInt(TEdit(Sender).Text);
  Except
    Key := #0;
    showmessage('Valor inv�lido');
  End;
end;

class function TEditPadrao.getFormulario(Sender: TObject): TForm;
var
  tmp : TWinControl;
begin
  Try
    Result := nil;
    tmp := TWinControl(Sender);
    while (tmp <> nil) and (not (tmp is TForm)) do
      tmp := tmp.Parent;
    if tmp is TForm then
      Result := TForm(tmp);
  Except
  End;
end;

class procedure TEditPadrao.NextOrder(Sender: TObject);
  Var Form : Tform;
begin
  Form := TEditPadrao.getFormulario(Sender);
  if Form.Visible then
    SendMessage( Form.handle , WM_NEXTDLGCTL, 0, 0 );
end;

class function TEditPadrao.validarEdit(campo: string; edt: TEdit): boolean;
begin
  result := true;
  if edt <> nil then
  begin
    if StrToFloatDef(edt.Text, 0) <= 0 then
    begin
      MessageDlg(campo + #13 + '. Valor inv�lido para o campo ' + campo + '. Verifique.', mtWarning,[mbok], 0);
      edt.SetFocus;
      result := false;
      abort;
    end;
  end;
end;

end.
