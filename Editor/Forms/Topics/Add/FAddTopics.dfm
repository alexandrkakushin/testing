object fmAddTopics: TfmAddTopics
  Left = 470
  Top = 312
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1090#1077#1084#1099
  ClientHeight = 356
  ClientWidth = 345
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TBitBtn
    Left = 128
    Top = 320
    Width = 91
    Height = 25
    Caption = #1054#1050
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 232
    Top = 320
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pcAddTopics: TPageControl
    Left = 8
    Top = 8
    Width = 329
    Height = 305
    ActivePage = tsMain
    TabOrder = 2
    object tsMain: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077
      object lbledtName: TLabeledEdit
        Left = 24
        Top = 72
        Width = 273
        Height = 21
        BevelKind = bkFlat
        EditLabel.Width = 50
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        TabOrder = 0
        OnExit = lbledtNameExit
      end
      object rgMode: TRadioGroup
        Left = 24
        Top = 144
        Width = 273
        Height = 49
        Caption = #1056#1077#1078#1080#1084' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1046#1077#1089#1090#1082#1080#1081
          #1052#1103#1075#1082#1080#1081)
        TabOrder = 1
      end
    end
    object tsAdditional: TTabSheet
      Caption = #1055#1086#1088#1103#1076#1086#1082
      ImageIndex = 1
      object rgOrderQuestions: TRadioGroup
        Left = 24
        Top = 48
        Width = 273
        Height = 49
        Caption = #1055#1086#1088#1103#1076#1086#1082' '#1074#1086#1087#1088#1086#1089#1086#1074
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1055#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1099#1081
          #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081)
        TabOrder = 0
      end
      object rgOrderAnswer: TRadioGroup
        Left = 24
        Top = 144
        Width = 273
        Height = 49
        Caption = #1055#1086#1088#1103#1076#1086#1082' '#1086#1090#1074#1077#1090#1086#1074
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1055#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1099#1081
          #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081)
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1054#1087#1080#1089#1072#1085#1080#1103
      ImageIndex = 2
      object gnPurpose: TGroupBox
        Left = 8
        Top = 96
        Width = 305
        Height = 81
        Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
        TabOrder = 0
        object lPurpose: TLabel
          Left = 88
          Top = 16
          Width = 168
          Height = 26
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1076#1083#1103' '#1090#1077#1089#1090#1080#1088#1091#1077#1084#1099#1093' '#1086' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1080' '#1076#1072#1085#1085#1086#1081' '#1090#1077#1084#1099
          WordWrap = True
        end
        object imgPurpose: TImage
          Left = 16
          Top = 24
          Width = 41
          Height = 41
          Transparent = True
        end
        object btnPurpose: TButton
          Left = 208
          Top = 48
          Width = 91
          Height = 25
          Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
          TabOrder = 0
          OnClick = btnWriteAdditionalInfo
        end
      end
      object gbInstructon: TGroupBox
        Left = 8
        Top = 184
        Width = 305
        Height = 81
        Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
        TabOrder = 1
        object lInstruction: TLabel
          Left = 88
          Top = 16
          Width = 133
          Height = 13
          Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072
        end
        object imgInstruction: TImage
          Left = 16
          Top = 24
          Width = 41
          Height = 41
          Transparent = True
        end
        object btnInstruction: TButton
          Tag = 1
          Left = 208
          Top = 48
          Width = 91
          Height = 25
          Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
          TabOrder = 0
          OnClick = btnWriteAdditionalInfo
        end
      end
      object gbDeveloper: TGroupBox
        Left = 8
        Top = 8
        Width = 305
        Height = 81
        Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
        TabOrder = 2
        object lDeveloper: TLabel
          Left = 88
          Top = 16
          Width = 178
          Height = 13
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077' '#1090#1077#1084#1099
        end
        object imgDeveloper: TImage
          Left = 16
          Top = 24
          Width = 41
          Height = 41
          Transparent = True
        end
        object btnDeveloper: TButton
          Left = 208
          Top = 48
          Width = 91
          Height = 25
          Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
          TabOrder = 0
          OnClick = btnDeveloperClick
        end
      end
    end
    object tsSetting: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 3
      object gbTime: TGroupBox
        Left = 8
        Top = 8
        Width = 305
        Height = 81
        Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
        TabOrder = 0
        object lTime: TLabel
          Left = 88
          Top = 16
          Width = 202
          Height = 13
          Caption = #1055#1086#1079#1074#1086#1083#1103#1077#1090' '#1086#1075#1088#1072#1085#1080#1095#1080#1090#1100' '#1090#1077#1089#1090' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
        end
        object imgTime: TImage
          Left = 16
          Top = 24
          Width = 41
          Height = 41
          Transparent = True
        end
        object btnTime: TButton
          Left = 208
          Top = 48
          Width = 91
          Height = 25
          Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
          TabOrder = 0
          OnClick = btnTimeClick
        end
      end
      object gbProcent: TGroupBox
        Left = 8
        Top = 96
        Width = 305
        Height = 81
        Caption = #1050#1088#1080#1090#1077#1088#1080#1080' '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1094#1077#1085#1086#1082
        TabOrder = 1
        object lProcent: TLabel
          Left = 88
          Top = 16
          Width = 189
          Height = 26
          Caption = #1044#1072#1085#1085#1072#1103' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1100' '#1076#1077#1083#1072#1077#1090' '#1073#1086#1083#1077#1077' '#1075#1080#1073#1082#1086#1081' '#1089#1080#1089#1090#1077#1084#1091' '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1094#1077#1085#1086#1082
          WordWrap = True
        end
        object imgProcent: TImage
          Left = 16
          Top = 24
          Width = 41
          Height = 41
          Transparent = True
        end
        object btnProcent: TButton
          Left = 208
          Top = 48
          Width = 91
          Height = 25
          Caption = #1050#1088#1080#1090#1077#1088#1080#1080
          TabOrder = 0
          OnClick = btnProcentClick
        end
      end
    end
  end
end
