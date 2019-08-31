object fmEnterPassword: TfmEnterPassword
  Left = 206
  Top = 441
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1103
  ClientHeight = 110
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbledtPass: TLabeledEdit
    Left = 16
    Top = 32
    Width = 233
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = lbledtPassKeyPress
  end
  object btnOk: TBitBtn
    Left = 40
    Top = 72
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 144
    Top = 72
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
