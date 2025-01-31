unit dataBaseController;

interface

uses System.Classes, IniFiles, System.SysUtils, FireDAC.Comp.Client, vcl.Forms, database,
    Dialogs;

type

  TDataBaseController = class
     class function getDataBase : TDataBase;
     class procedure connectionDataBase(var connection : TFDConnection);
  end;

implementation

{ TDataBaseController }

class procedure TDataBaseController.connectionDataBase(var connection: TFDConnection);
var DataBase : TDataBase;
begin
  Try
    DataBase := getDataBase;
    if DataBase <> nil then
    begin
      with connection do
      begin
        Params.Clear;
        Params.Add('DriverID=MySQL');
        Params.Add('Server=' + DataBase.server);
        Params.Add('Database=' + DataBase.dataBase);
        Params.Add('User_Name=' + DataBase.userName);
        Params.Add('Password=' + DataBase.password);
        Params.Add('Port=' + DataBase.port);

        Try
          Connected := True; // Tenta conectar
        except
          showmessage('Conex�o com o banco de dados n�o estabelecida. O sistema ser� encerrado.');
          application.terminate;
        End;
      end;
    end;
  Finally
    DataBase.Destroy;
  End;
end;

class function TDataBaseController.getDataBase : TDataBase;
var Ini: TiniFile;
  fileName : string;
begin
  result := nil;
  fileName := ExtractFilePath(Application.ExeName)+'database.INI';

  if not FileExists(fileName) then
    raise Exception.Create('Arquivo de configura��o n�o encontrado!');

  Ini := TiniFile.Create(fileName);
  Try
    result := TDataBase.Create;
    result.dataBase := Ini.ReadString('DATABASE', 'DATABASE', '');
    result.userName := Ini.ReadString('DATABASE', 'USER_NAME', '');
    result.server := Ini.ReadString('DATABASE', 'SERVER', '');
    result.port := Ini.ReadString('DATABASE', 'PORT', '');
    result.password := Ini.ReadString('DATABASE', 'PASSWORD', '');
    result.fileNameLib := Ini.ReadString('DATABASE', 'FILENAMELIB', '');
  Finally
    FreeAndNil(Ini);
  End;
end;

end.
