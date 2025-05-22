program TesteTecnicoSag;

uses
  Vcl.Forms,
  untViewGetCustomers in 'src\views\customers\untViewGetCustomers.pas' {frmViewGetCustomers},
  DataModule.Main in 'src\datamodules\DataModule.Main.pas' {DMMain: TDataModule},
  classCustomers in 'src\classes\classCustomers.pas',
  untViewRegistrationCustomers in 'src\views\customers\untViewRegistrationCustomers.pas' {frmViewRegistrationCustomers},
  untCpfCnpjValidator in 'src\utils\untCpfCnpjValidator.pas',
  untServiceCep in 'src\utils\untServiceCep.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMMain, DMMain);
  Application.CreateForm(TfrmViewGetCustomers, frmViewGetCustomers);
  Application.CreateForm(TfrmViewRegistrationCustomers, frmViewRegistrationCustomers);
  Application.Run;
end.
