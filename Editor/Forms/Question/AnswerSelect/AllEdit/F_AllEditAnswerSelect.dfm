object fmAllEditAnswerSelect: TfmAllEditAnswerSelect
  Left = 466
  Top = 355
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1074#1072#1088#1080#1072#1085#1090#1086#1074
  ClientHeight = 223
  ClientWidth = 307
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
  object GbAnswer: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 169
    Caption = #1042#1072#1088#1080#1072#1085#1090#1099' '#1086#1090#1074#1077#1090#1086#1074
    TabOrder = 0
    object mListAnswers: TMemo
      Left = 2
      Top = 15
      Width = 285
      Height = 152
      Align = alClient
      BevelKind = bkFlat
      TabOrder = 0
    end
  end
  object btnOk: TBitBtn
    Left = 56
    Top = 184
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 160
    Top = 184
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
