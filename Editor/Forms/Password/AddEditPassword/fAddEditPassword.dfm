object fmAddEditPassword: TfmAddEditPassword
  Left = 203
  Top = 240
  Width = 285
  Height = 191
  BorderIcons = [biSystemMenu]
  Caption = 'fmAddEditPassword'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbledtPass: TLabeledEdit
    Left = 16
    Top = 32
    Width = 241
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    PasswordChar = '*'
    TabOrder = 0
  end
  object lbledtPassCheck: TLabeledEdit
    Left = 16
    Top = 80
    Width = 241
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = lbledtPassCheckKeyPress
  end
  object btnOk: TBitBtn
    Left = 40
    Top = 120
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 144
    Top = 120
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
