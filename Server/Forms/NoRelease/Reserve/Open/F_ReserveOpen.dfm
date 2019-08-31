object ReserveOpen: TReserveOpen
  Left = 455
  Top = 335
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1080#1079' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
  ClientHeight = 195
  ClientWidth = 324
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
  object gb_groups: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 137
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1099' '#1076#1083#1103' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103
    TabOrder = 0
    object Check_groups: TCheckListBox
      Left = 2
      Top = 15
      Width = 301
      Height = 120
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object btn_ok: TBitBtn
    Left = 112
    Top = 160
    Width = 97
    Height = 25
    TabOrder = 1
    OnClick = btn_okClick
    Kind = bkOK
  end
  object btn_cancel: TBitBtn
    Left = 216
    Top = 160
    Width = 97
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
  object dtn_select_all: TBitBtn
    Left = 8
    Top = 160
    Width = 97
    Height = 25
    Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
    TabOrder = 3
    OnClick = dtn_select_allClick
  end
  object SaveDlg: TSaveDialog
    DefaultExt = 'BAK'
    Filter = '*.bak|*.bak;'
    Left = 16
    Top = 40
  end
end
