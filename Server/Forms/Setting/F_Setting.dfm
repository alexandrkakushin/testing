object fmSetting: TfmSetting
  Left = 452
  Top = 278
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 113
  ClientWidth = 359
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
  object btnOK: TBitBtn
    Left = 168
    Top = 80
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 0
  end
  object btnCancel: TBitBtn
    Left = 264
    Top = 80
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbAccess: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 65
    Caption = #1044#1086#1089#1090#1091#1087' '#1082' '#1089#1077#1088#1074#1077#1088#1091
    TabOrder = 2
    object chkAccess: TCheckBox
      Left = 16
      Top = 24
      Width = 321
      Height = 17
      Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1086#1073#1097#1080#1081' '#1076#1086#1089#1090#1091#1087' '#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      TabOrder = 0
    end
  end
end
