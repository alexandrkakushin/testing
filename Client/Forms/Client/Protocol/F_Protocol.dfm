object fmProtocol: TfmProtocol
  Left = 200
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1058#1077#1089#1090'-'#1082#1083#1080#1077#1085#1090' - ['#1055#1088#1086#1090#1086#1082#1086#1083' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103']'
  ClientHeight = 354
  ClientWidth = 477
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
  object lblGroup: TLabel
    Left = 112
    Top = 16
    Width = 44
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblFIO: TLabel
    Left = 112
    Top = 40
    Width = 78
    Height = 13
    Caption = #1058#1077#1089#1090#1080#1088#1091#1077#1084#1099#1081' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSubject: TLabel
    Left = 112
    Top = 64
    Width = 51
    Height = 13
    Caption = #1055#1088#1077#1076#1084#1077#1090' -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblTopic: TLabel
    Left = 112
    Top = 88
    Width = 36
    Height = 13
    Caption = #1058#1077#1084#1072' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 56
    Top = 16
    Width = 54
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 93
    Height = 13
    Caption = #1058#1077#1089#1090#1080#1088#1091#1077#1084#1099#1081' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 44
    Top = 64
    Width = 61
    Height = 13
    Caption = #1055#1088#1077#1076#1084#1077#1090' -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 64
    Top = 88
    Width = 44
    Height = 13
    Caption = #1058#1077#1084#1072' - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbDetail: TGroupBox
    Left = 16
    Top = 120
    Width = 449
    Height = 185
    Caption = #1055#1086#1076#1088#1086#1073#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 0
    object lstDetail: TListView
      Left = 2
      Top = 15
      Width = 445
      Height = 168
      Align = alClient
      BevelKind = bkSoft
      Columns = <
        item
          AutoSize = True
          Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1100
        end
        item
          AutoSize = True
          Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        end>
      FlatScrollBars = True
      FullDrag = True
      GridLines = True
      Items.Data = {
        130100000800000000000000FFFFFFFFFFFFFFFF00000000000000000FCAEEEB
        2DE2EE20E2EEEFF0EEF1EEE200000000FFFFFFFFFFFFFFFF0000000000000000
        0ACFF0E0E2E8EBFCEDFBF500000000FFFFFFFFFFFFFFFF00000000000000000C
        CDE5EFF0E0E2E8EBFCEDFBF500000000FFFFFFFFFFFFFFFF0000000000000000
        06CEF6E5EDEAE000000000FFFFFFFFFFFFFFFF000000000000000007CFF0EEF6
        E5EDF200000000FFFFFFFFFFFFFFFF000000000000000012D0E5E6E8EC20F2E5
        F1F2E8F0EEE2E0EDE8FF00000000FFFFFFFFFFFFFFFF000000000000000010CF
        EEF0FFE4EEEA20E2EEEFF0EEF1EEE200000000FFFFFFFFFFFFFFFF0000000000
        0000000FCFEEF0FFE4EEEA20EEF2E2E5F2EEE2}
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object btnOK: TBitBtn
    Left = 386
    Top = 321
    Width = 83
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = btnOKClick
  end
end
