object fmAddEditFilter: TfmAddEditFilter
  Left = 507
  Top = 385
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'fmAddEditFilter'
  ClientHeight = 266
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
  object lFilter: TLabel
    Left = 8
    Top = 56
    Width = 40
    Height = 13
    Caption = #1060#1080#1083#1100#1090#1088
  end
  object leName: TLabeledEdit
    Left = 8
    Top = 24
    Width = 289
    Height = 21
    BevelKind = bkFlat
    EditLabel.Width = 96
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1083#1100#1090#1088#1072
    TabOrder = 0
  end
  object mFilter: TMemo
    Left = 8
    Top = 72
    Width = 289
    Height = 145
    BevelKind = bkFlat
    TabOrder = 1
  end
  object btnOK: TBitBtn
    Left = 56
    Top = 232
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 160
    Top = 232
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
