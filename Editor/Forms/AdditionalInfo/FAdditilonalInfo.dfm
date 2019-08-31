object fmAdditionalInfo: TfmAdditionalInfo
  Left = 562
  Top = 446
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'fmAdditionalInfo'
  ClientHeight = 307
  ClientWidth = 433
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
  object gbData: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 257
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1077' '#1076#1072#1085#1085#1099#1077
    TabOrder = 0
    object mData: TMemo
      Left = 2
      Top = 15
      Width = 413
      Height = 240
      Align = alClient
      BevelKind = bkFlat
      TabOrder = 0
    end
  end
  object btnOk: TBitBtn
    Left = 232
    Top = 272
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 336
    Top = 272
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
