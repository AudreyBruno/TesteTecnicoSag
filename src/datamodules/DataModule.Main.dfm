object DMMain: TDMMain
  OnCreate = DataModuleCreate
  Height = 255
  Width = 421
  object FDConn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Audrey\Projetos\TesteTecnicoSag\bin\Win32\Debug\DB.d' +
        'b'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnAfterConnect
    BeforeConnect = FDConnBeforeConnect
    Left = 56
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 248
    Top = 120
  end
end
