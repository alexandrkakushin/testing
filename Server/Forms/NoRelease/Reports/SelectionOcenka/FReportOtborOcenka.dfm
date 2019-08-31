object OtborOcenka: TOtborOcenka
  Left = 456
  Top = 490
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = #1054#1090#1073#1086#1088' '#1087#1086' '#1086#1094#1077#1085#1082#1072#1084
  ClientHeight = 305
  ClientWidth = 385
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
  object tb_selection: TTabControl
    Left = 0
    Top = 0
    Width = 385
    Height = 305
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      '5'
      '4'
      '3'
      '2'
      #1053)
    TabIndex = 0
    OnChange = tb_selectionChange
    object ListResults: TListView
      Left = 4
      Top = 24
      Width = 377
      Height = 277
      Align = alClient
      Columns = <
        item
          Caption = #8470
        end
        item
          Caption = #1057#1090#1091#1076#1077#1085#1090
          Width = 250
        end
        item
          Alignment = taCenter
          Caption = #1055#1088#1086#1094#1077#1085#1090
          Width = 70
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
