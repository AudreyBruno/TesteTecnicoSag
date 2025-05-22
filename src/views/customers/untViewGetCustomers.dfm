object frmViewGetCustomers: TfrmViewGetCustomers
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 441
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object DBGrid: TDBGrid
    Left = 0
    Top = 55
    Width = 772
    Height = 366
    Align = alClient
    BorderStyle = bsNone
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 55
    Align = alTop
    BevelEdges = []
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      772
      55)
    object Label1: TLabel
      Left = 25
      Top = 5
      Width = 75
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Buscar Cliente'
    end
    object edtSearch: TEdit
      Left = 25
      Top = 19
      Width = 274
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edtSearchChange
    end
    object btnDelete: TButton
      AlignWithMargins = True
      Left = 693
      Top = 8
      Width = 75
      Height = 39
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 4
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnRegister: TButton
      AlignWithMargins = True
      Left = 535
      Top = 8
      Width = 75
      Height = 39
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 4
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Cadastrar'
      TabOrder = 2
      OnClick = btnRegisterClick
    end
    object btnAlter: TButton
      AlignWithMargins = True
      Left = 614
      Top = 8
      Width = 75
      Height = 39
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 4
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Alterar'
      TabOrder = 3
      OnClick = btnAlterClick
    end
  end
  object pnTotal: TPanel
    Left = 0
    Top = 421
    Width = 772
    Height = 20
    Align = alBottom
    BevelEdges = []
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 2
    object lbTotal: TLabel
      AlignWithMargins = True
      Left = 617
      Top = 0
      Width = 145
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Registros localizados: 00000'
      ExplicitHeight = 15
    end
  end
  object DataSource: TDataSource
    Left = 596
    Top = 272
  end
end
