object fmMoveQuestion: TfmMoveQuestion
  Left = 196
  Top = 218
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1074#1086#1087#1088#1086#1089#1072
  ClientHeight = 176
  ClientWidth = 269
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
  object gbTopics: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 129
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1077#1084#1091
    TabOrder = 0
    object lstTopics: TListBox
      Left = 2
      Top = 15
      Width = 245
      Height = 112
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object btnOk: TBitBtn
    Left = 40
    Top = 144
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 136
    Top = 144
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
