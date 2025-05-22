object frmViewRegistrationCustomers: TfrmViewRegistrationCustomers
  Left = 0
  Top = 0
  Caption = 'frmViewRegistrationCustomers'
  ClientHeight = 306
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnBotton: TPanel
    Left = 0
    Top = 251
    Width = 624
    Height = 55
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object btnSave: TButton
      AlignWithMargins = True
      Left = 466
      Top = 8
      Width = 75
      Height = 37
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 4
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 545
      Top = 8
      Width = 75
      Height = 37
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 4
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 251
    Align = alClient
    BevelEdges = []
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 114
      Top = 8
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 8
      Top = 53
      Width = 21
      Height = 15
      Caption = 'CPF'
    end
    object Label4: TLabel
      Left = 183
      Top = 53
      Width = 107
      Height = 15
      Caption = 'Data de Nascimento'
    end
    object Label5: TLabel
      Left = 8
      Top = 98
      Width = 34
      Height = 15
      Caption = 'E-mail'
    end
    object Label6: TLabel
      Left = 8
      Top = 143
      Width = 21
      Height = 15
      Caption = 'CEP'
    end
    object Label7: TLabel
      Left = 138
      Top = 143
      Width = 62
      Height = 15
      Caption = 'Logradouro'
    end
    object Label8: TLabel
      Left = 352
      Top = 143
      Width = 44
      Height = 15
      Caption = 'N'#250'mero'
    end
    object Label9: TLabel
      Left = 8
      Top = 188
      Width = 31
      Height = 15
      Caption = 'Bairro'
    end
    object Label10: TLabel
      Left = 183
      Top = 188
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object Label11: TLabel
      Left = 352
      Top = 188
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object edtCodigo: TEdit
      Left = 8
      Top = 24
      Width = 100
      Height = 23
      Color = clBtnFace
      Enabled = False
      TabOrder = 10
    end
    object edtNome: TEdit
      Left = 114
      Top = 24
      Width = 392
      Height = 23
      TabOrder = 0
    end
    object edtDateNascimento: TDateTimePicker
      Left = 183
      Top = 69
      Width = 107
      Height = 23
      Date = 45798.000000000000000000
      Time = 0.692595613429148200
      TabOrder = 2
    end
    object edtEmail: TEdit
      Left = 8
      Top = 114
      Width = 498
      Height = 23
      TabOrder = 3
    end
    object edtEnd: TEdit
      Left = 138
      Top = 159
      Width = 208
      Height = 23
      TabOrder = 5
    end
    object edtNumero: TEdit
      Left = 352
      Top = 159
      Width = 44
      Height = 23
      TabOrder = 6
    end
    object edtBairro: TEdit
      Left = 8
      Top = 204
      Width = 169
      Height = 23
      TabOrder = 7
    end
    object edtCidade: TEdit
      Left = 183
      Top = 204
      Width = 163
      Height = 23
      TabOrder = 8
    end
    object edtUf: TEdit
      Left = 352
      Top = 204
      Width = 44
      Height = 23
      TabOrder = 9
    end
    object edtMaskCep: TMaskEdit
      Left = 8
      Top = 159
      Width = 123
      Height = 23
      EditMask = '00000\-000;1;_'
      MaxLength = 9
      TabOrder = 4
      Text = '     -   '
      OnExit = edtMaskCepExit
    end
    object edtMaskCpf: TMaskEdit
      Left = 9
      Top = 69
      Width = 168
      Height = 23
      EditMask = '000\.000\.000\-00;1;_'
      MaxLength = 14
      TabOrder = 1
      Text = '   .   .   -  '
      OnExit = edtMaskCpfExit
    end
  end
end
