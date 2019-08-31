object fmAddEditStudent: TfmAddEditStudent
  Left = 1013
  Top = 485
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1089#1090#1091#1076#1077#1085#1090#1072
  ClientHeight = 288
  ClientWidth = 258
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
  object pnlGroup: TPanel
    Left = 8
    Top = 8
    Width = 241
    Height = 33
    BevelInner = bvLowered
    Caption = 'pnlGroup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object gbInfoStudent: TGroupBox
    Left = 8
    Top = 56
    Width = 241
    Height = 177
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1090#1091#1076#1077#1085#1090#1077
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 72
      Width = 79
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
    end
    object leName: TLabeledEdit
      Left = 16
      Top = 40
      Width = 209
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = #1060#1048#1054
      TabOrder = 0
      OnExit = leNameExit
    end
    object meDate: TMaskEdit
      Left = 16
      Top = 88
      Width = 208
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  .  .    '
      OnExit = meDateExit
    end
    object leNumber: TLabeledEdit
      Left = 16
      Top = 136
      Width = 209
      Height = 21
      EditLabel.Width = 124
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1095#1077#1090#1085#1086#1081' '#1082#1085#1080#1078#1082#1080
      TabOrder = 2
    end
  end
  object btnOK: TBitBtn
    Left = 32
    Top = 248
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 136
    Top = 248
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
