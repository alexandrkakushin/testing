object fmTime: TfmTime
  Left = 472
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
  ClientHeight = 195
  ClientWidth = 242
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
  object chkNoTime: TCheckBox
    Left = 16
    Top = 24
    Width = 129
    Height = 17
    Caption = #1041#1077#1079' '#1091#1095#1077#1090#1072' '#1074#1088#1077#1084#1077#1085#1080
    TabOrder = 0
    OnClick = chkNoTimeClick
  end
  object gbParametrs: TGroupBox
    Left = 8
    Top = 56
    Width = 225
    Height = 89
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1095#1077#1090#1072
    TabOrder = 1
    object lbledtTime: TLabeledEdit
      Left = 16
      Top = 40
      Width = 177
      Height = 21
      BevelKind = bkFlat
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083'-'#1074#1086' '#1084#1080#1085#1091#1090
      TabOrder = 0
      Text = '1'
      OnKeyPress = lbledtTimeKeyPress
    end
    object UpDown: TUpDown
      Left = 193
      Top = 40
      Width = 16
      Height = 21
      Associate = lbledtTime
      Min = 1
      Max = 300
      Position = 1
      TabOrder = 1
    end
  end
  object btnOk: TBitBtn
    Left = 24
    Top = 160
    Width = 91
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 128
    Top = 160
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
