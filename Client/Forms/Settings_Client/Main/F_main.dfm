object fmMain: TfmMain
  Left = 190
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' "'#1058#1077#1089#1090'-'#1050#1083#1080#1077#1085#1090'"'
  ClientHeight = 190
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcSettings: TPageControl
    Left = 8
    Top = 8
    Width = 284
    Height = 121
    ActivePage = tsConnect
    TabOrder = 0
    object tsConnect: TTabSheet
      Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077
      object leHost: TLabeledEdit
        Left = 16
        Top = 40
        Width = 249
        Height = 21
        EditLabel.Width = 153
        EditLabel.Height = 13
        EditLabel.Caption = 'IP-'#1072#1076#1088#1077#1089' '#1080#1083#1080' '#1080#1084#1103' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072
        TabOrder = 0
      end
    end
  end
  object btnOK: TBitBtn
    Left = 104
    Top = 136
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 200
    Top = 136
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnConnect: TBitBtn
    Left = 8
    Top = 136
    Width = 89
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 3
    OnClick = btnConnectClick
  end
  object pbFind: TProgressBar
    Left = 0
    Top = 173
    Width = 302
    Height = 17
    Align = alBottom
    TabOrder = 4
  end
  object XPManifest: TXPManifest
    Left = 240
    Top = 40
  end
end
