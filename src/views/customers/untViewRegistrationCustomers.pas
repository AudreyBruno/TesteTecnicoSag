unit untViewRegistrationCustomers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Comp.Client, classCustomers, DataModule.Main,
  untCpfCnpjValidator, untServiceCep, Vcl.Mask;

type
  TfrmViewRegistrationCustomers = class(TForm)
    pnBotton: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    pnMain: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtDateNascimento: TDateTimePicker;
    edtEmail: TEdit;
    edtEnd: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUf: TEdit;
    edtMaskCep: TMaskEdit;
    edtMaskCpf: TMaskEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtMaskCepExit(Sender: TObject);
    procedure edtMaskCpfExit(Sender: TObject);
  private
    FID: Integer;
    procedure LoadFields;
    procedure ClearFields;
  public
    modo: string;
    property ID: Integer read FID write FID;
  end;

var
  frmViewRegistrationCustomers: TfrmViewRegistrationCustomers;

implementation

{$R *.dfm}

procedure TfrmViewRegistrationCustomers.LoadFields;
var
  cust: TCustomers;
  erro: string;
  qry: TFDQuery;
begin
  try
    cust := TCustomers.Create(DMMain.FDConn);
    cust.ID := ID;
    qry := cust.getById(erro);

    edtCodigo.Text := IntToStr(ID);

    edtNome.Text := qry.FieldByName('NOME').AsString;
    edtMaskCpf.Text := FormatCPF(qry.FieldByName('CPF').AsString);
    edtDateNascimento.Date := qry.FieldByName('DATA_NASCIMENTO').AsDateTime;
    edtEmail.Text := qry.FieldByName('EMAIL').AsString;
    edtEnd.Text := qry.FieldByName('LOGRADOURO').AsString;
    edtNumero.Text := qry.FieldByName('NUMERO').AsString;
    edtBairro.Text := qry.FieldByName('BAIRRO').AsString;
    edtCidade.Text := qry.FieldByName('CIDADE').AsString;
    edtUf.Text := qry.FieldByName('UF').AsString;
    edtMaskCep.Text := FormatCEP(qry.FieldByName('CEP').AsString);
  finally
    cust.Free;
    qry.Free;
  end;
end;

procedure TfrmViewRegistrationCustomers.edtMaskCpfExit(Sender: TObject);
begin
  edtMaskCpf.Text := FormatCPF(edtMaskCpf.Text);
end;

procedure TfrmViewRegistrationCustomers.edtMaskCepExit(Sender: TObject);
var
  DadosCep: TCepInfo;
begin
  if edtMaskCep.Text = '' then
  begin
    ShowMessage('CEP inválido!');
    Exit;
  end;

  try
    DadosCep := getByCEP(edtMaskCep.Text);

    edtMaskCep.Text := DadosCep.Cep;
    edtEnd.Text := DadosCep.Logradouro;
    edtBairro.Text := DadosCep.Bairro;
    edtCidade.Text := DadosCep.Localidade;
    edtUf.Text := DadosCep.Uf;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TfrmViewRegistrationCustomers.ClearFields;
begin
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtMaskCpf.Text := '';
  edtDateNascimento.Date := Date;
  edtEmail.Text := '';
  edtEnd.Text := '';
  edtNumero.Text := '';
  edtBairro.Text := '';
  edtCidade.Text := '';
  edtUf.Text := '';
  edtMaskCep.Text := '';
end;

procedure TfrmViewRegistrationCustomers.FormShow(Sender: TObject);
begin
  if modo = 'I' then
    ClearFields
  else
    LoadFields;
end;

procedure TfrmViewRegistrationCustomers.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TfrmViewRegistrationCustomers.btnSaveClick(Sender: TObject);
var
  cust: TCustomers;
  erro: string;
begin
  try
    cust := TCustomers.Create(DMMain.FDConn);
    cust.NOME := edtNome.Text;
    cust.CPF := OnlyNumbers(edtMaskCpf.Text);
    cust.DATA_NASCIMENTO := edtDateNascimento.Date;
    cust.EMAIL := edtEmail.Text;
    cust.Logradouro := edtEnd.Text;
    cust.NUMERO := edtNumero.Text;
    cust.Bairro := edtBairro.Text;
    cust.CIDADE := edtCidade.Text;
    cust.Uf := edtUf.Text;
    cust.Cep := OnlyNumbers(edtMaskCep.Text);

    if modo = 'I' then
      cust.insert(erro)
    else
    begin
      cust.ID := ID;
      cust.updateById(erro);
    end;

    if erro <> '' then
    begin
      ShowMessage(erro);
      Exit;
    end;

    ModalResult := mrOk;
  finally
    cust.Free;
  end;
end;

end.
