object Folder: TFolder
  Left = 568
  Top = 248
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080
  ClientHeight = 291
  ClientWidth = 248
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
  object Shell_folder: TShellTreeView
    Left = 8
    Top = 8
    Width = 233
    Height = 241
    ObjectTypes = [otFolders]
    Root = 'rfMyComputer'
    UseShellImages = True
    AutoRefresh = True
    Indent = 19
    ParentColor = False
    RightClickSelect = True
    ShowRoot = False
    TabOrder = 0
  end
  object btn_ok: TBitBtn
    Left = 24
    Top = 256
    Width = 91
    Height = 25
    TabOrder = 1
    OnClick = btn_okClick
    Kind = bkOK
  end
  object btn_cancel: TBitBtn
    Left = 128
    Top = 256
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btn_cancelClick
    Kind = bkCancel
  end
end
