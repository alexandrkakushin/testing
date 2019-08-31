object fmMoveStudent: TfmMoveStudent
  Left = 188
  Top = 113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1074#1086#1076' '#1074' '#1076#1088#1091#1075#1091#1102' '#1075#1088#1091#1087#1087#1091
  ClientHeight = 291
  ClientWidth = 258
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
  object gbMoveStudent: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 233
    Caption = #1055#1077#1088#1077#1074#1086#1076' '#1089#1090#1091#1076#1077#1085#1090#1072
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 91
      Height = 13
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1075#1088#1091#1087#1087#1072' - '
    end
    object lCurrentGroup: TLabel
      Left = 112
      Top = 32
      Width = 79
      Height = 13
      Caption = 'lCurrentGroup'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lstGroups: TListView
      Left = 16
      Top = 64
      Width = 209
      Height = 150
      BevelKind = bkFlat
      Columns = <
        item
          AutoSize = True
          Caption = #1057#1087#1080#1089#1086#1082' '#1075#1088#1091#1087#1087
        end>
      ColumnClick = False
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lstGroupsClick
    end
  end
  object btnOK: TBitBtn
    Left = 32
    Top = 256
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 136
    Top = 256
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
