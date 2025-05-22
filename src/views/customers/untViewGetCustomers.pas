unit untViewGetCustomers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, untViewRegistrationCustomers, classCustomers,
  FireDAC.Comp.Client, DataModule.Main;

type
  TfrmViewGetCustomers = class(TForm)
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    pnTop: TPanel;
    Label1: TLabel;
    edtSearch: TEdit;
    btnDelete: TButton;
    btnRegister: TButton;
    btnAlter: TButton;
    pnTotal: TPanel;
    lbTotal: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnAlterClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure getData;
    procedure OpenForm(AModo: string; AId: integer);
  public
  end;

var
  frmViewGetCustomers: TfrmViewGetCustomers;

implementation

{$R *.dfm}

procedure TfrmViewGetCustomers.OpenForm(AModo: string; AId: integer);
begin
  if not Assigned(frmViewRegistrationCustomers) then
    Application.CreateForm(TfrmViewRegistrationCustomers,
      frmViewRegistrationCustomers);

  frmViewRegistrationCustomers.modo := AModo;
  frmViewRegistrationCustomers.ID := AId;

  if frmViewRegistrationCustomers.ShowModal = mrOk then
    getData;
end;

procedure TfrmViewGetCustomers.DBGridDblClick(Sender: TObject);
begin
  OpenForm('A', DataSource.DataSet.FieldByName('ID').AsInteger);
end;

procedure TfrmViewGetCustomers.edtSearchChange(Sender: TObject);
begin
  getData;
end;

procedure TfrmViewGetCustomers.FormShow(Sender: TObject);
begin
  getData;
end;

procedure TfrmViewGetCustomers.getData;
var
  cust: TCustomers;
  qry: TFDQuery;
  erro: string;
begin
  try
    cust := TCustomers.Create(DMMain.FDConn);
    cust.NOME := edtSearch.Text;
    qry := cust.getCustomers(erro);

    if erro <> '' then
    begin
      ShowMessage(erro);
      exit;
    end;

    DataSource.DataSet := qry;

    if qry.IsEmpty then
      lbTotal.Caption := 'Nenhum registro encontrado.'
    else
      lbTotal.Caption := Format('Registros localizados: %.6d',
        [qry.RecordCount]);

  finally
    cust.Free;
  end;
end;

procedure TfrmViewGetCustomers.btnAlterClick(Sender: TObject);
begin
  if DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum cliente selecionado');
    exit;
  end;

  OpenForm('A', DataSource.DataSet.FieldByName('ID').AsInteger);
end;

procedure TfrmViewGetCustomers.btnDeleteClick(Sender: TObject);
var
  cust: TCustomers;
  erro: string;
begin
  if DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Nenhum cliente selecionado');
    exit;
  end;

  if MessageDlg('Tem certeza que deseja excluir este cliente?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    try
      cust := TCustomers.Create(DMMain.FDConn);
      cust.ID := DataSource.DataSet.FieldByName('ID').AsInteger;

      if not cust.deleteById(erro) then
      begin
        ShowMessage(erro);
        exit;
      end;

      ShowMessage('Cliente excluído com sucesso!');
      getData;
    finally
      cust.Free;
    end;
  end;
end;

procedure TfrmViewGetCustomers.btnRegisterClick(Sender: TObject);
begin
  OpenForm('I', 0);
end;

end.
