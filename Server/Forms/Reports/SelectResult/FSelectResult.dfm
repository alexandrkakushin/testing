object fmSelectResult: TfmSelectResult
  Left = 222
  Top = 151
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
  ClientHeight = 227
  ClientWidth = 370
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
  object gbSelectResult: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 177
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1091#1078#1085#1099#1081' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 0
    object lstResults: TListView
      Left = 2
      Top = 15
      Width = 349
      Height = 160
      Align = alClient
      BevelKind = bkFlat
      Columns = <
        item
          Caption = #8470
        end
        item
          Alignment = taCenter
          AutoSize = True
          Caption = #1054#1094#1077#1085#1082#1072
        end
        item
          Alignment = taCenter
          AutoSize = True
          Caption = #1055#1088#1086#1094#1077#1085#1090
        end
        item
          Alignment = taCenter
          AutoSize = True
          Caption = #1044#1072#1090#1072
        end>
      ColumnClick = False
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = lstResultsSelectItem
    end
  end
  object btnOK: TBitBtn
    Left = 88
    Top = 192
    Width = 91
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 192
    Top = 192
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
