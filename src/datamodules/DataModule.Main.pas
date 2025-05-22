unit DataModule.Main;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, Data.DB, FireDAC.Comp.Client;

type
  TDMMain = class(TDataModule)
    FDConn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnAfterConnect(Sender: TObject);
    procedure FDConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMMain: TDMMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMMain.DataModuleCreate(Sender: TObject);
begin
  try
    FDConn.Connected := True;
  except
    on e: exception do
      raise exception.Create('Erro de conexão com o banco de dados: ' +
        e.Message);
  end;
end;

procedure TDMMain.FDConnAfterConnect(Sender: TObject);
begin
  FDConn.ExecSQL('CREATE TABLE IF NOT EXISTS clientes(' +
                  'id              INTEGER       PRIMARY KEY AUTOINCREMENT,' +
                  'nome            VARCHAR (100) NOT NULL,' +
                  'cpf             VARCHAR (11)  NOT NULL UNIQUE,' +
                  'data_nascimento DATE          NOT NULL,' +
                  'email           VARCHAR (100),' +
                  'logradouro      VARCHAR (100),' +
                  'numero          VARCHAR (10),' +
                  'bairro          VARCHAR (50),' +
                  'cidade          VARCHAR (50),' +
                  'uf              CHAR (2),' +
                  'cep             CHAR (8))');
end;

procedure TDMMain.FDConnBeforeConnect(Sender: TObject);
begin
  FDConn.DriverName := 'SQLite';
  FDConn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\DB.db';
end;

end.
