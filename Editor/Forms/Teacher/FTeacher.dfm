object fmTeacher: TfmTeacher
  Left = 927
  Top = 142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
  ClientHeight = 354
  ClientWidth = 315
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
  object btnOk: TBitBtn
    Left = 112
    Top = 320
    Width = 91
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 216
    Top = 320
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object PCInfo: TPageControl
    Left = 8
    Top = 8
    Width = 297
    Height = 305
    ActivePage = tbsMain
    TabOrder = 3
    object tbsMain: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077
      object lbledtName: TLabeledEdit
        Left = 8
        Top = 24
        Width = 273
        Height = 21
        BevelKind = bkFlat
        EditLabel.Width = 96
        EditLabel.Height = 13
        EditLabel.Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082' '#1090#1077#1089#1090#1072
        TabOrder = 0
      end
      object lbledtOrganization: TLabeledEdit
        Left = 8
        Top = 72
        Width = 273
        Height = 21
        BevelKind = bkFlat
        EditLabel.Width = 67
        EditLabel.Height = 13
        EditLabel.Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        TabOrder = 1
      end
      object lbledtWWW: TLabeledEdit
        Left = 8
        Top = 120
        Width = 273
        Height = 21
        BevelKind = bkFlat
        EditLabel.Width = 189
        EditLabel.Height = 13
        EditLabel.Caption = #1048#1085#1090#1077#1088#1085#1077#1090'-'#1089#1072#1081#1090' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072' (WWW)'
        TabOrder = 2
      end
      object lbledtEMail: TLabeledEdit
        Left = 8
        Top = 168
        Width = 273
        Height = 21
        BevelKind = bkFlat
        EditLabel.Width = 211
        EditLabel.Height = 13
        EditLabel.Caption = #1069#1083#1077#1082#1090#1088#1086#1085#1085#1099#1081' '#1072#1076#1088#1077#1089' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072' (E-mail)'
        TabOrder = 3
      end
    end
    object tbsAdditional: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 122
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085#1099', '#1092#1072#1082#1089#1099' '#1080' '#1090'.'#1076'.'
      end
      object Label2: TLabel
        Left = 8
        Top = 96
        Width = 64
        Height = 13
        Caption = #1044#1086#1089#1090#1080#1078#1077#1085#1080#1103
      end
      object Label3: TLabel
        Left = 8
        Top = 184
        Width = 186
        Height = 13
        Caption = #1055#1088#1086#1095#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      end
      object mTelephone: TMemo
        Left = 8
        Top = 24
        Width = 273
        Height = 57
        BevelKind = bkFlat
        TabOrder = 0
      end
      object mAchievement: TMemo
        Left = 8
        Top = 112
        Width = 273
        Height = 65
        BevelKind = bkFlat
        TabOrder = 1
      end
      object mMiscInfo: TMemo
        Left = 8
        Top = 200
        Width = 273
        Height = 65
        BevelKind = bkFlat
        TabOrder = 2
      end
    end
  end
  object btnProfiles: TBitBtn
    Left = 8
    Top = 320
    Width = 89
    Height = 25
    Hint = #1042#1099#1073#1086#1088' '#1087#1088#1086#1092#1080#1083#1103' '#1089#1086#1079#1076#1072#1090#1077#1083#1103
    Caption = #1055#1088#1086#1092#1080#1083#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnProfilesClick
  end
end
