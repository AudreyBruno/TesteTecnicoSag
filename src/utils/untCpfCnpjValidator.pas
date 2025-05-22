unit untCpfCnpjValidator;

interface

uses
  SysUtils;

function isCPF(const value: string): Boolean;
function isCNPJ(const value: string): Boolean;
function FormatCPF(const Input: string): string;
function OnlyNumbers(const value: string): string;

implementation

function OnlyNumbers(const value: string): string;
var
  c: Char;
begin
  Result := '';
  for c in value do
    if c in ['0' .. '9'] then
      Result := Result + c;
end;

function FormatCPF(const Input: string): string;
var
  Numbers: string;
  I: Integer;
begin
  for I := 1 to Length(Input) do
    if Input[I] in ['0' .. '9'] then
      Numbers := Numbers + Input[I];

  case Length(Numbers) of
    1 .. 3:
      Result := Numbers;
    4 .. 6:
      Result := Copy(Numbers, 1, 3) + '.' + Copy(Numbers, 4);
    7 .. 9:
      Result := Copy(Numbers, 1, 3) + '.' + Copy(Numbers, 4, 3) + '.' +
        Copy(Numbers, 7);
    10 .. 11:
      Result := Copy(Numbers, 1, 3) + '.' + Copy(Numbers, 4, 3) + '.' +
        Copy(Numbers, 7, 3) + '-' + Copy(Numbers, 10);
  else
    Result := Copy(Numbers, 1, 11);
  end;
end;

function isCPF(const value: string): Boolean;
const
  InvalidCPFs: array [0 .. 9] of string = ('00000000000', '11111111111',
    '22222222222', '33333333333', '44444444444', '55555555555', '66666666666',
    '77777777777', '88888888888', '99999999999');
var
  dig10, dig11: string;
  s, i, r, peso: integer;
  CPF: string;
begin
  CPF := OnlyNumbers(value);

  Result := (Length(CPF) = 11);
  if not Result then
    Exit;

  for i := Low(InvalidCPFs) to High(InvalidCPFs) do
  begin
    if CPF = InvalidCPFs[i] then
    begin
      Result := False;
      Exit;
    end;
  end;

  s := 0;
  peso := 10;
  for i := 1 to 9 do
  begin
    s := s + (StrToInt(CPF[i]) * peso);
    peso := peso - 1;
  end;

  r := 11 - (s mod 11);
  if ((r = 10) or (r = 11)) then
    dig10 := '0'
  else
    str(r: 1, dig10);

  s := 0;
  peso := 11;
  for i := 1 to 10 do
  begin
    s := s + (StrToInt(CPF[i]) * peso);
    peso := peso - 1;
  end;

  r := 11 - (s mod 11);
  if ((r = 10) or (r = 11)) then
    dig11 := '0'
  else
    str(r: 1, dig11);

  if ((dig10 = CPF[10]) and (dig11 = CPF[11])) then
    Result := True
  else
    Result := False;
end;

function isCNPJ(const value: string): Boolean;
const
  InvalidCNPJs: array [0 .. 9] of string = ('00000000000000', '11111111111111',
    '22222222222222', '33333333333333', '44444444444444', '55555555555555',
    '66666666666666', '77777777777777', '88888888888888', '99999999999999');
var
  dig13, dig14: string;
  sm, i, r, peso: integer;
  CNPJ: string;
begin
  CNPJ := OnlyNumbers(value);

  Result := (Length(CNPJ) = 14);
  if not Result then
    Exit;

  for i := Low(InvalidCNPJs) to High(InvalidCNPJs) do
  begin
    if CNPJ = InvalidCNPJs[i] then
    begin
      isCNPJ := False;
      Exit;
    end;
  end;

  sm := 0;
  peso := 2;
  for i := 12 downto 1 do
  begin
    sm := sm + (StrToInt(CNPJ[i]) * peso);
    peso := peso + 1;
    if (peso = 10) then
      peso := 2;
  end;

  r := sm mod 11;
  if ((r = 0) or (r = 1)) then
    dig13 := '0'
  else
    str((11 - r): 1, dig13);

  sm := 0;
  peso := 2;
  for i := 13 downto 1 do
  begin
    sm := sm + (StrToInt(CNPJ[i]) * peso);
    peso := peso + 1;
    if (peso = 10) then
      peso := 2;
  end;
  r := sm mod 11;
  if ((r = 0) or (r = 1)) then
    dig14 := '0'
  else
    str((11 - r): 1, dig14);

  if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14])) then
    isCNPJ := True
  else
    isCNPJ := False;
end;

end.
