unit untServiceCep;

interface

uses
  System.SysUtils;

type
  TCepInfo = record
    Cep: string;
    Logradouro: string;
    Bairro: string;
    Localidade: string;
    Uf: string;
  end;

function getByCEP(const ACep: string): TCepInfo;
function FormatCEP(const Valor: string): string;

implementation

uses
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON;

function FormatCEP(const Valor: string): string;
begin
  if Length(Valor) = 8 then
    Result := Copy(Valor, 1, 5) + '-' + Copy(Valor, 6, 3)
  else
    Result := '';
end;

function getByCEP(const ACep: string): TCepInfo;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONObj: TJSONObject;
  JSONValue: TJSONValue;
begin
  Result := Default(TCepInfo);

  RESTClient := TRESTClient.Create('https://viacep.com.br/ws/' + ACep + '/json/');
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmGET;

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      JSONObj := TJSONObject.ParseJSONValue(RESTResponse.Content) as TJSONObject;
      try
        JSONValue := JSONObj.GetValue('erro');
        if (JSONValue <> nil) and (JSONValue.Value = 'true') then
          raise Exception.Create('CEP não encontrado.');

        Result.Cep := JSONObj.GetValue<string>('cep');
        Result.Logradouro := JSONObj.GetValue<string>('logradouro');
        Result.Bairro := JSONObj.GetValue<string>('bairro');
        Result.Localidade := JSONObj.GetValue<string>('localidade');
        Result.Uf := JSONObj.GetValue<string>('uf');
      finally
        JSONObj.Free;
      end;
    end
    else
      raise Exception.CreateFmt('Erro ao consultar o CEP. Status: %d', [RESTResponse.StatusCode]);
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

end.

