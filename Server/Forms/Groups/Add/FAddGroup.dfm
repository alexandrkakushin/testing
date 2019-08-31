object fmAddGroup: TfmAddGroup
  Left = 487
  Top = 352
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
  ClientHeight = 106
  ClientWidth = 251
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
  object leName: TLabeledEdit
    Left = 16
    Top = 32
    Width = 217
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 89
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    TabOrder = 0
  end
  object btnOK: TBitBtn
    Left = 32
    Top = 72
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 128
    Top = 72
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
