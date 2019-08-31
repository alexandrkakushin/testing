object fmEditTypeOpen: TfmEditTypeOpen
  Left = 490
  Top = 488
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1092#1086#1088#1084#1072#1090#1086#1074' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 250
  ClientWidth = 267
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
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 91
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1092#1086#1088#1084#1072#1090#1086#1074
  end
  object pTypeOpen: TPanel
    Left = 8
    Top = 8
    Width = 249
    Height = 33
    BevelInner = bvLowered
    BevelOuter = bvSpace
    Caption = 'pTypeOpen'
    TabOrder = 0
  end
  object mFiles: TMemo
    Left = 8
    Top = 72
    Width = 249
    Height = 129
    Lines.Strings = (
      'mFiles')
    TabOrder = 1
  end
  object btnOK: TBitBtn
    Left = 40
    Top = 216
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 136
    Top = 216
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
