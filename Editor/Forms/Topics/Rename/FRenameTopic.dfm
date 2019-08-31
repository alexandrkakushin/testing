object fmRenameTopic: TfmRenameTopic
  Left = 516
  Top = 374
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1077#1084#1099
  ClientHeight = 147
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 105
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1077#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' - '
  end
  object lCurrentName: TLabel
    Left = 128
    Top = 24
    Width = 77
    Height = 13
    Caption = 'lCurrentName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbledtNewName: TLabeledEdit
    Left = 16
    Top = 72
    Width = 273
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 126
    EditLabel.Height = 13
    EditLabel.Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
    TabOrder = 0
    OnExit = lbledtNewNameExit
  end
  object btnOk: TBitBtn
    Left = 56
    Top = 112
    Width = 91
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 160
    Top = 112
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
