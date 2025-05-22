unit classCustomers;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics,
  untCpfCnpjValidator, System.RegularExpressions;

type
  TCustomers = class
  private
    FConn: TFDConnection;
    FID: Integer;
    FNOME: string;
    FCPF: string;
    FDATA_NASCIMENTO: TDate;
    FEMAIL: string;
    FLOGRADOURO: string;
    FNUMERO: string;
    FBAIRRO: string;
    FCIDADE: string;
    FUF: string;
    FCEP: string;
    function ValidateFields(out Erro: string): Boolean;
  public
    constructor Create(conn: TFDConnection);

    property ID: Integer read FID write FID;
    property NOME: string read FNOME write FNOME;
    property CPF: string read FCPF write FCPF;
    property DATA_NASCIMENTO: TDate read FDATA_NASCIMENTO
      write FDATA_NASCIMENTO;
    property EMAIL: string read FEMAIL write FEMAIL;
    property LOGRADOURO: string read FLOGRADOURO write FLOGRADOURO;
    property NUMERO: string read FNUMERO write FNUMERO;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property CIDADE: string read FCIDADE write FCIDADE;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;

    function getCustomers(out Erro: string): TFDQuery;
    function getById(out Erro: string): TFDQuery;
    function insert(out Erro: string): Boolean;
    function updateById(out Erro: string): Boolean;
    function deleteById(out Erro: string): Boolean;
  end;

implementation

{ TCustomers }

function TCustomers.ValidateFields(out Erro: string): Boolean;
begin
  Result := False;

  if Trim(NOME) = '' then
  begin
    Erro := 'Nome não pode estar vazio!';
    Exit;
  end;

  if Trim(CPF) = '' then
  begin
    Erro := 'CPF não pode estar vazio!';
    Exit;
  end;

  if not isCPF(CPF) then
  begin
    Erro := 'CPF inválido!';
    Exit;
  end;

  if Trim(EMAIL) = '' then
  begin
    Erro := 'E-mail não pode estar vazio!!';
    Exit;
  end;

  if not TRegEx.IsMatch(EMAIL,
    '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') then
  begin
    Erro := 'E-mail inválido!';
    Exit;
  end;

  if Trim(LOGRADOURO) = '' then
  begin
    Erro := 'Logradouro não pode estar vazio!';
    Exit;
  end;

  if Trim(NUMERO) = '' then
  begin
    Erro := 'Número não pode estar vazio!';
    Exit;
  end;

  if Trim(BAIRRO) = '' then
  begin
    Erro := 'Bairro não pode estar vazio!';
    Exit;
  end;

  if Trim(CIDADE) = '' then
  begin
    Erro := 'Cidade não pode estar vazia!';
    Exit;
  end;

  if Trim(UF) = '' then
  begin
    Erro := 'UF não pode estar vazio!';
    Exit;
  end;

  if Trim(CEP) = '' then
  begin
    Erro := 'CEP não pode estar vazio!';
    Exit;
  end;

  Result := True;
end;

constructor TCustomers.Create(conn: TFDConnection);
begin
  FConn := conn;
end;

function TCustomers.deleteById(out Erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FConn;

    qry.sql.Text := 'DELETE FROM clientes WHERE id = :id';
    qry.ParamByName('id').Value := ID;
    qry.ExecSQL;

    Result := True;
    Erro := '';
  except
    on ex: exception do
    begin
      Result := False;
      Erro := 'Erro ao excluir cliente: ' + ex.Message;
    end;
  end;
end;

function TCustomers.getById(out Erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FConn;

    qry.sql.Text := 'SELECT * FROM clientes WHERE id = :id';
    qry.ParamByName('id').Value := ID;
    qry.Open;

    Result := qry;
    Erro := '';

  except
    on ex: exception do
    begin
      Result := nil;
      Erro := 'Erro ao consultar cliente: ' + ex.Message;
    end;
  end;
end;

function TCustomers.getCustomers(out Erro: string): TFDQuery;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FConn;

    qry.sql.Text := 'SELECT * FROM clientes WHERE nome LIKE :nome';
    qry.ParamByName('nome').Value := '%' + NOME + '%';
    qry.Open;

    Result := qry;
    Erro := '';

  except
    on ex: exception do
    begin
      Result := nil;
      Erro := 'Erro ao consultar clientes: ' + ex.Message;
    end;
  end;
end;

function TCustomers.insert(out Erro: string): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  Erro := '';

  if not ValidateFields(Erro) then
    Exit;

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;
    qry.sql.Text :=
      'INSERT INTO CLIENTES (NOME, CPF, DATA_NASCIMENTO, EMAIL, LOGRADOURO,' +
      ' NUMERO, BAIRRO, CIDADE, UF, CEP) VALUES (:NOME, :CPF,' +
      ' :DATA_NASCIMENTO, :EMAIL, :LOGRADOURO, :NUMERO, :BAIRRO,' +
      ' :CIDADE, :UF, :CEP)';
    qry.ParamByName('NOME').AsString := NOME;
    qry.ParamByName('CPF').AsString := CPF;
    qry.ParamByName('DATA_NASCIMENTO').AsDate := DATA_NASCIMENTO;
    qry.ParamByName('EMAIL').AsString := EMAIL;
    qry.ParamByName('LOGRADOURO').AsString := LOGRADOURO;
    qry.ParamByName('NUMERO').AsString := NUMERO;
    qry.ParamByName('BAIRRO').AsString := BAIRRO;
    qry.ParamByName('CIDADE').AsString := CIDADE;
    qry.ParamByName('UF').AsString := UF;
    qry.ParamByName('CEP').AsString := CEP;

    qry.ExecSQL;
    Result := True;
  except
    on E: exception do
      Erro := 'Erro ao inserir cliente: ' + E.Message;
  end;

  qry.Free;
end;

function TCustomers.updateById(out Erro: string): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  Erro := '';

  if not ValidateFields(Erro) then
    Exit;

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;

    qry.sql.Text := 'UPDATE CLIENTES SET NOME = :NOME, CPF = :CPF, ' +
      'DATA_NASCIMENTO = :DATA_NASCIMENTO, EMAIL = :EMAIL, ' +
      'LOGRADOURO = :LOGRADOURO, NUMERO = :NUMERO, BAIRRO = :BAIRRO, ' +
      'CIDADE = :CIDADE, UF = :UF, CEP = :CEP WHERE ID = :ID';
    qry.ParamByName('ID').AsInteger := ID;
    qry.ParamByName('NOME').AsString := NOME;
    qry.ParamByName('CPF').AsString := CPF;
    qry.ParamByName('DATA_NASCIMENTO').AsDate := DATA_NASCIMENTO;
    qry.ParamByName('EMAIL').AsString := EMAIL;
    qry.ParamByName('LOGRADOURO').AsString := LOGRADOURO;
    qry.ParamByName('NUMERO').AsString := NUMERO;
    qry.ParamByName('BAIRRO').AsString := BAIRRO;
    qry.ParamByName('CIDADE').AsString := CIDADE;
    qry.ParamByName('UF').AsString := UF;
    qry.ParamByName('CEP').AsString := CEP;

    qry.ExecSQL;
    Result := True;
  except
    on E: exception do
      Erro := 'Erro ao inserir cliente: ' + E.Message;
  end;

  qry.Free;
end;

end.
