object fmFolder: TfmFolder
  Left = 442
  Top = 322
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1092#1072#1081#1083#1072
  ClientHeight = 395
  ClientWidth = 355
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
  object btnOK: TBitBtn
    Left = 80
    Top = 360
    Width = 89
    Height = 25
    Caption = #1054#1050
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 184
    Top = 360
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbFolder: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 345
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1072#1087#1082#1091
    TabOrder = 2
    object stvFolder: TShellTreeView
      Left = 2
      Top = 15
      Width = 333
      Height = 328
      ObjectTypes = [otFolders]
      Root = 'rfDesktop'
      UseShellImages = True
      Align = alClient
      AutoRefresh = True
      Indent = 19
      ParentColor = False
      RightClickSelect = True
      ShowRoot = False
      TabOrder = 0
    end
  end
end
