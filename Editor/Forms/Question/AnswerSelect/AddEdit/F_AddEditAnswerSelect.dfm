object fmAddEditAnswerSelect: TfmAddEditAnswerSelect
  Left = 436
  Top = 438
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074#1072#1088#1080#1072#1085#1090#1072' '#1086#1090#1074#1077#1090#1072
  ClientHeight = 188
  ClientWidth = 329
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
  object gbAddVariant: TGroupBox
    Left = 16
    Top = 16
    Width = 297
    Height = 121
    Caption = #1042#1072#1088#1080#1072#1085#1090' '#1086#1090#1074#1077#1090#1072
    TabOrder = 0
    object leVariantAnswer: TLabeledEdit
      Left = 24
      Top = 40
      Width = 249
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1077#1082#1089#1090
      TabOrder = 0
    end
    object chkbCorrect: TCheckBox
      Left = 24
      Top = 80
      Width = 129
      Height = 17
      Caption = #1055#1088#1072#1074#1080#1083#1100#1085#1099#1081
      TabOrder = 1
    end
  end
  object btnOK: TBitBtn
    Left = 128
    Top = 152
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 224
    Top = 152
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
